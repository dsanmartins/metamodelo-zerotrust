#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Inyector simple (basado en texto) para aplicar tácticas del modelo Zero Trust
sobre el proyecto FastAPI de system_code/app/main.py.

Estructura esperada:
  SecurityMetamodel/
  ├─ model.yaml
  ├─ rules/python_rules.yaml
  └─ system_code/app/main.py
"""

from pathlib import Path
import yaml
import re
import sys

# --- Rutas según tu proyecto ---
ROOT = Path(__file__).resolve().parent
MODEL_PATH = ROOT / "model.yaml"
RULES_PATH = ROOT / "rules" / "python_rules.yaml"
TARGET_DEFAULT = ROOT / "system_code" / "app" / "main.py"


# -------------------- utilidades de edición --------------------
def ensure_imports(file_path: Path, imports: list[str]) -> None:
    """Inserta imports al comienzo si no existen (idempotente)."""
    text = file_path.read_text(encoding="utf-8")
    changed = False
    for imp in imports:
        if imp and imp not in text:
            text = imp + "\n" + text
            changed = True
    if changed:
        file_path.write_text(text, encoding="utf-8")


def add_decorator_above(file_path: Path, func_name: str, decorator: str) -> None:
    """Añade un decorador arriba de una función concreta (idempotente)."""
    text = file_path.read_text(encoding="utf-8")
    lines = text.splitlines()
    for i, line in enumerate(lines):
        if re.match(rf"\s*def\s+{re.escape(func_name)}\b", line):
            # si ya está decorada con ese decorador, salir
            if i > 0 and decorator.strip() in lines[i - 1]:
                return
            lines.insert(i, decorator)
            file_path.write_text("\n".join(lines), encoding="utf-8")
            return


def add_decorator_to_all_functions(file_path: Path, decorator: str) -> None:
    """Añade un decorador a todas las funciones (naive / idempotente)."""
    text = file_path.read_text(encoding="utf-8")
    out = []
    for line in text.splitlines():
        if re.match(r"\s*def\s+\w+\b", line):
            # evita duplicar si ya hay el mismo decorador justo arriba
            if out and out[-1].strip() == decorator.strip():
                out.append(line)
            else:
                out.append(decorator)
                out.append(line)
        else:
            out.append(line)
    file_path.write_text("\n".join(out), encoding="utf-8")


def insert_call_at_start(file_path: Path, func_name: str, call_line: str) -> None:
    """
    Inserta una llamada como primera línea "real" de la función (idempotente).
    Respeta líneas en blanco iniciales tras el 'def'.
    """
    text = file_path.read_text(encoding="utf-8")
    lines = text.splitlines()
    for i, line in enumerate(lines):
        if re.match(rf"\s*def\s+{re.escape(func_name)}\b", line):
            # buscar la primera línea no vacía posterior
            j = i + 1
            while j < len(lines) and lines[j].strip() == "":
                j += 1
            # detectar indentación
            indent = ""
            if j < len(lines):
                m = re.match(r"(\s*)", lines[j])
                indent = m.group(1) if m else ""
            call = indent + call_line
            if call_line in "\n".join(lines):
                return
            lines.insert(j, call)
            file_path.write_text("\n".join(lines), encoding="utf-8")
            return


def insert_call_for_all_functions(file_path: Path, call_line: str) -> None:
    """Inserta la llamada en el comienzo de todas las funciones (naive / idempotente)."""
    text = file_path.read_text(encoding="utf-8")
    lines = text.splitlines()
    i = 0
    changed = False
    while i < len(lines):
        if re.match(r"\s*def\s+\w+\b", lines[i]):
            # saltar líneas en blanco
            j = i + 1
            while j < len(lines) and lines[j].strip() == "":
                j += 1
            indent = ""
            if j < len(lines):
                m = re.match(r"(\s*)", lines[j])
                indent = m.group(1) if m else ""
            call = indent + call_line
            if call_line not in "\n".join(lines):
                lines.insert(j, call)
                changed = True
                i = j + 1
            else:
                i = j
        i += 1
    if changed:
        file_path.write_text("\n".join(lines), encoding="utf-8")


# -------------------- carga de modelo y reglas --------------------
def load_model():
    if not MODEL_PATH.exists():
        print(f"[ERROR] No se encontró el modelo: {MODEL_PATH}")
        print("Ejecuta antes: kcl run data/main_model.k -o model.yaml")
        sys.exit(1)
    with open(MODEL_PATH, "r", encoding="utf-8") as f:
        return yaml.safe_load(f)["model"]


def load_rules():
    if not RULES_PATH.exists():
        print(f"[ERROR] No se encontró el archivo de reglas: {RULES_PATH}")
        sys.exit(1)
    with open(RULES_PATH, "r", encoding="utf-8") as f:
        y = yaml.safe_load(f)
        return y.get("rules", {})


# -------------------- motor principal --------------------
def main():
    model = load_model()
    rules = load_rules()

    # tácticas seleccionadas por decisiones del modelo
    selected: set[str] = set()
    for d in model.get("decisions", []):
        for tid in d.get("selected_tactics", []):
            selected.add(tid)

    print("[INFO] Tácticas seleccionadas en el modelo:", ", ".join(sorted(selected)) or "—")

    # aplicar reglas
    for tid in sorted(selected):
        rule = rules.get(tid)
        if not rule:
            print(f"[WARN] No hay regla para {tid}")
            continue

        inject = rule.get("inject", {})
        match = rule.get("match", {})

        file_pattern = match.get("file_pattern", "system_code/app/main.py")
        # si viene relativo, resolver respecto a la raíz
        target_path = ROOT / file_pattern
        if not target_path.exists():
            # fallback al destino por defecto
            target_path = TARGET_DEFAULT

        if not target_path.exists():
            print(f"[WARN] Archivo destino no encontrado para {tid}: {target_path}")
            continue

        # imports
        imports = []
        if "import" in inject:
            imports.append(inject["import"])
        if imports:
            ensure_imports(target_path, imports)

        # decoradores
        if "decorator" in inject:
            fnames = match.get("function_names")
            if fnames:
                for fn in fnames:
                    add_decorator_above(target_path, fn, inject["decorator"])
            else:
                # aplicar a todas las funciones (p.ej., OPA global)
                add_decorator_to_all_functions(target_path, inject["decorator"])

        # llamadas dentro de funciones
        if "call" in inject:
            fnames = match.get("function_names")
            if fnames:
                for fn in fnames:
                    insert_call_at_start(target_path, fn, inject["call"])
            else:
                insert_call_for_all_functions(target_path, inject["call"])

        # notas / scheduler (solo informativo en esta versión)
        if "scheduler" in inject:
            print(f"[HINT] ({tid}) Scheduler sugerido → {inject['scheduler']}")
        if "note" in inject:
            print(f"[HINT] ({tid}) Acción manual sugerida → {inject['note']}")

        print(f"[OK] Regla aplicada: {tid} → {target_path.relative_to(ROOT)}")

    print("\n[FIN] Inyección completada. Revisa los cambios en system_code/app/main.py")


if __name__ == "__main__":
    main()
