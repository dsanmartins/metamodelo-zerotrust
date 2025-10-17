# 🧩 Proyecto: Inyección de Seguridad Basada en Metamodelo Zero Trust

## 🌐 Dominio propuesto
**Plataforma universitaria de pagos y gestión de datos de investigación**

Este sistema (SaaS interno) gestiona transacciones financieras de estudiantes y administra datos de investigación de docentes y alumnos.  
Combina **operaciones financieras** (pagos, reembolsos) con **datos sensibles** (PII, resultados de investigación), lo que introduce riesgos operativos, regulatorios y reputacionales.

El dominio es representativo de los escenarios SA.1–SA.4 del metamodelo:
- **SA.1**: Trazabilidad de pagos (Auditabilidad)
- **SA.2**: Integridad de datos en tránsito
- **SA.3**: Disponibilidad ante tráfico malicioso
- **SA.4**: Confidencialidad en acceso a datos sensibles

---

## 🔐 Amenazas y motivación
### Principales amenazas
- Manipulación o pérdida de integridad de transacciones (fraude interno o MITM).
- Exfiltración de datos confidenciales (investigación, PII).
- Ataques de denegación de servicio o escalamiento lateral.
- Falta de trazabilidad que impide investigación forense o cumplimiento normativo.

### Motivación para añadir seguridad
1. **Mitigar riesgo operativo**: reducir probabilidad e impacto de fraude, pérdida de datos o reputación.
2. **Cumplimiento**: satisfacer normativas sobre protección de datos y auditoría.
3. **Confianza institucional**: investigadores y estudiantes esperan protección y transparencia.
4. **Resiliencia del servicio**: mantener continuidad y disponibilidad ante ataques.

---

## 🎯 Objetivos de seguridad (ASR → QA)
| Quality Attribute | ASR asociado | Objetivo |
|--------------------|--------------|-----------|
| **Auditability (QA.AUDIT)** | *ASR.1* | Generar registros inmutables de pagos. |
| **Integrity (QA.INTEGRITY)** | *ASR.2* | Detectar y prevenir modificaciones no autorizadas. |
| **Availability (QA.AVAIL)** | *ASR.3* | Mantener servicio bajo carga o ataques maliciosos. |
| **Confidentiality (QA.CONF)** | *ASR.4* | Controlar acceso a información sensible. |

Estos objetivos derivan directamente del **metamodelo KCL**, que relaciona **QualityAttributes**, **ASRs**, **Scenarios** y **Tactics**.

---

## ⚙️ Justificación técnica de las tácticas
| Táctica | QA asociado | Justificación |
|----------|--------------|----------------|
| **MaintainAuditTrail (TAC.AUDITTRAIL)** | QA.AUDIT | Permite reconstrucción forense y cumplimiento mediante logs inmutables. |
| **NonRepudiation (TAC.NONREP)** | QA.INTEGRITY, QA.AUDIT | Proporciona evidencia criptográfica de autoría en operaciones críticas. |
| **MutualTLS (TAC.MTLS)** | QA.INTEGRITY | Garantiza autenticación y cifrado extremo a extremo entre servicios. |
| **AccessControlPolicy / OPA (TAC.AC, TAC.OPA)** | QA.CONF, QA.AUDIT | Implementa autorización basada en políticas (ABAC/OPA) y auditoría de decisiones. |
| **MFA (TAC.MFA)** | QA.CONF | Asegura autenticación fuerte para usuarios con acceso a datos confidenciales. |
| **NetworkSegmentation (TAC.SEG)** | QA.AVAIL | Limita el movimiento lateral de amenazas y mejora resiliencia del sistema. |
| **ContinuousPostureMonitoring (TAC.CPAMON)** | QA.INTEGRITY, QA.AVAIL | Detecta desviaciones de configuración o vulnerabilidades emergentes. |

---

## 💰 Beneficio

**Beneficios:**
- Reducción de fraude y exposición de datos.
- Evidencia forense en caso de incidente.
- Cumplimiento normativo y auditorías más simples.
- Mayor disponibilidad y confianza institucional.

**Costos:**
- Implementación (middleware, OPA, PKI, MFA).
- Operación (gestión de claves y alertas).
- Posible impacto menor en la experiencia de usuario (MFA).

**Conclusión:**  
Las tácticas propuestas son *proporcionales al riesgo* del dominio financiero–académico.  
El retorno se materializa en **reducción de riesgo residual** y **menor costo de incidentes**.

---

## 📏 Métricas de evaluación

| Métrica | Indicador |
|----------|------------|
| **Cobertura de auditoría** | % de endpoints con logging inmutable. |
| **MTTD / MTTR** | Tiempos promedio de detección y respuesta ante incidentes. |
| **Autenticación fuerte** | % de accesos críticos protegidos por MFA. |
| **Disponibilidad** | SLA antes/después de aplicar controles de segmentación. |
| **Evaluaciones OPA** | % de decisiones de acceso auditadas y registradas. |

---

## 🧩 Flujo de implementación

(types.k) → (model.yaml) → (python_rules.yaml) → (inject_security.py) → Código Seguro

