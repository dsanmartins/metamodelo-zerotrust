# types.k — Metamodelo KCL para ZT-from-ASRs → Scenarios → Tactics (+ evaluación)

# ====== Núcleo de requisitos y calidad ======
schema ASR:
    id: str
    name: str
    description?: str
    qa_ref: str                # ASR → QA (cada ASR especifica 1 QA)

schema QualityAttribute:
    id: str                    # p.ej., QA.AUDIT
    name: str                  # Auditability, Integrity, Availability, Confidentiality
    description?: str
    source?: str               # ISO/IEC 25010 u otro

# ====== Principios Zero Trust y su impacto (SIG) ======
schema ZTPrinciple:
    id: str                    # p.ej., ZT.CMON
    name: str                  # ContinuousMonitoring, LeastPrivilege, etc.
    reference?: str            # NIST 800-207
    description?: str

schema Influence:               # arista del SIG: principio → QA con polaridad
    principle_ref: str          # ZTPrinciple.id
    qa_ref: str                 # QualityAttribute.id
    polarity: str               # "+", "++", "-", "--"
    rationale?: str

# ====== Escenarios (hojas UT) y prioridad ======
schema Priority:
    importance?: int
    difficulty?: int
    if importance != None:
        assert 1 <= importance <= 5
    if difficulty != None:
        assert 1 <= difficulty <= 5

schema Scenario:
    id: str
    qa_ref: str
    principles_ref: [str]        # principios ZT que orientan el escenario
    goal: str
    context?: str
    actors?: [str]
    resources?: [str]
    response: str
    keywords?: [str]             # keywords para búsqueda de tácticas
    priority?: Priority

# ====== Catálogo y selección de tácticas ======
schema SecurityTactic:
    id: str
    name: str
    category?: str               # audit, integrity, access-control, availability, …
    description?: str
    addresses: [str]             # QA.id que la táctica satisface/protege
    implements_principles?: [str]# principios ZT que materializa

schema TacticCatalog:
    tactics: [SecurityTactic]

schema TacticCandidate:          # resultado de la búsqueda por keywords/matching
    tactic_ref: str              # SecurityTactic.id
    scenario_ref: str            # Scenario.id
    matched_keywords: [str]
    score?: float                # opcional (similaridad / heurística)
    discarded?: bool
    discard_reason?: str

schema TacticDecision:           # ensamblaje final de tácticas por escenario
    scenario_ref: str
    selected_tactics: [str]      # lista de SecurityTactic.id
    rationale?: str              # justificación (alineamiento, complejidad, objetivos)

# ====== Evidencia y trazabilidad ======
schema TraceLink:
    from: str                    # "ASR.*", "Scenario.*", "Decision.*", etc.
    to: str                      # "Scenario.*", "Tactic.*", "Artifact.*"
    justification?: str

# ====== Evaluación/Experimento (métricas IR) ======
schema MetricDef:
    id: str                      # PRECISION, RECALL, ACCURACY
    name: str
    formula?: str

schema GroundTruth:
    scenario_ref: str
    correct_tactics: [str]       # SecurityTactic.id validadas por expertos

schema Subject:
    id: str
    seniority: str               # "junior" | "senior"
    experience_years?: int
    prior_tactics_knowledge?: bool

schema SubjectRun:               # decisiones por sujeto en el experimento
    subject_ref: str
    scenario_ref: str
    selected_tactics: [str]      # lo que eligió el sujeto

schema Measurement:              # valores numéricos por sujeto
    subject_ref: str
    metric_ref: str              # MetricDef.id
    value: float

schema Hypothesis:
    id: str                      # H00/H01, H10/H11, H20/H21
    name: str
    metric_ref: str
    direction: str               # "improves" | "does_not_improve"
    alpha?: float

schema TestResult:
    hypothesis_ref: str
    test_name: str               # Mann–Whitney, etc.
    U?: float
    p_value: float
    significant: bool

# ====== Modelo raíz ======
schema Model:
    # 1) Catálogos y requisitos
    qas: [QualityAttribute] = []
    asrs: [ASR] = []
    principles: [ZTPrinciple] = []
    influences?: [Influence] = []         # principio → QA (+/–)
    # 2) Escenarios
    scenarios: [Scenario]
    # 3) Búsqueda/decisión de tácticas
    catalog: TacticCatalog
    candidates?: [TacticCandidate] = []
    decisions?: [TacticDecision] = []
    # 4) Evidencia
    traces?: [TraceLink] = []
    # 5) Evaluación
    metrics?: [MetricDef] = []
    ground_truth?: [GroundTruth] = []
    subjects?: [Subject] = []
    runs?: [SubjectRun] = []
    measurements?: [Measurement] = []
    hypotheses?: [Hypothesis] = []
    test_results?: [TestResult] = []

    # ====== Reglas de consistencia (asociaciones) ======
    qa_ids = [q.id for q in qas]
    prin_ids = [p.id for p in principles]
    scn_ids = [s.id for s in scenarios]
    tac_ids = [t.id for t in catalog.tactics]
    pol_vals = ["+", "++", "-", "--"]

    # ASR → QA (cada ASR debe apuntar a un QA válido)
    invalid_asrs = [a.id for a in asrs if not (a.qa_ref in qa_ids)]
    assert len(invalid_asrs) == 0

    # Influence: principle_ref y qa_ref válidos + polaridad válida
    invalid_influences = [
        i for i in (influences or [])
        if not ( (i.principle_ref in prin_ids) and (i.qa_ref in qa_ids) and (i.polarity in pol_vals) )
    ]
    assert len(invalid_influences) == 0

    # Scenario → QA válido
    invalid_scn_qa = [s.id for s in scenarios if not (s.qa_ref in qa_ids)]
    assert len(invalid_scn_qa) == 0

    # Scenario → todos sus principles_ref válidos
    invalid_scn_principles = [
        s.id for s in scenarios
        if len([pid for pid in s.principles_ref if not (pid in prin_ids)]) > 0
    ]
    assert len(invalid_scn_principles) == 0

    # Catálogo: addresses (QAs) y implements_principles (principles) válidos
    invalid_tactics_addresses = [
        t.id for t in catalog.tactics
        if len([qid for qid in (t.addresses or []) if not (qid in qa_ids)]) > 0
    ]
    assert len(invalid_tactics_addresses) == 0

    invalid_tactics_principles = [
        t.id for t in catalog.tactics
        if len([pid for pid in (t.implements_principles or []) if not (pid in prin_ids)]) > 0
    ]
    assert len(invalid_tactics_principles) == 0

    # Candidates: tactic_ref y scenario_ref válidos
    invalid_candidates = [
        c for c in (candidates or [])
        if not ( (c.tactic_ref in tac_ids) and (c.scenario_ref in scn_ids) )
    ]
    assert len(invalid_candidates) == 0

    # Decisions: scenario_ref válido y todas las selected_tactics válidas
    invalid_decisions = [
        d for d in (decisions or [])
        if not ( (d.scenario_ref in scn_ids) and (len([tid for tid in d.selected_tactics if not (tid in tac_ids)]) == 0) )
    ]
    assert len(invalid_decisions) == 0

    # Cobertura: cada escenario debe terminar con ≥1 táctica seleccionada
    decided_scenarios = [
        d.scenario_ref for d in (decisions or []) if len(d.selected_tactics) > 0
    ]
    missing_decision = [s.id for s in scenarios if not (s.id in decided_scenarios)]
    assert len(missing_decision) == 0

    # GroundTruth: escenario y tácticas válidos
    invalid_gt = [
        gt for gt in (ground_truth or [])
        if not ( (gt.scenario_ref in scn_ids) and (len([tid for tid in gt.correct_tactics if not (tid in tac_ids)]) == 0) )
    ]
    assert len(invalid_gt) == 0

    # --- Subjects & Runs (validaciones seguras) ---
    subj_ids = [x.id for x in subjects]
    runs_list = runs

    # 1) Each run must reference a valid subject
    invalid_runs_subject = [r for r in runs_list if not (r.subject_ref in subj_ids)]
    assert len(invalid_runs_subject) == 0

    # 2) Each run must reference a valid scenario
    invalid_runs_scenario = [r for r in runs_list if not (r.scenario_ref in scn_ids)]
    assert len(invalid_runs_scenario) == 0

    # 3) Each run must reference valid tactics
    invalid_runs_tactics = [
        r for r in runs_list
        if len([tid for tid in r.selected_tactics if not (tid in tac_ids)]) > 0
    ]
    assert len(invalid_runs_tactics) == 0

    # 1) Cada run debe tener un sujeto válido
    invalid_runs_subject = [r for r in runs_list if not (r.subject_ref in subj_ids)]
    assert len(invalid_runs_subject) == 0

    # 2) Cada run debe referir a un escenario válido
    invalid_runs_scenario = [r for r in runs_list if not (r.scenario_ref in scn_ids)]
    assert len(invalid_runs_scenario) == 0

    # 3) Todas las tácticas seleccionadas en cada run deben existir
    invalid_runs_tactics = [
        r for r in runs_list
        if len([tid for tid in r.selected_tactics if not (tid in tac_ids)]) > 0
    ]
    assert len(invalid_runs_tactics) == 0

    # Métricas y mediciones
    metric_ids = [m.id for m in (metrics or [])]
    invalid_measurements = [
        m for m in (measurements or [])
        if not ( (m.subject_ref in subj_ids) and (m.metric_ref in metric_ids) )
    ]
    assert len(invalid_measurements) == 0

    # Hipótesis y resultados de test
    hyp_ids = [h.id for h in (hypotheses or [])]
    invalid_tests = [t for t in (test_results or []) if not (t.hypothesis_ref in hyp_ids)]
    assert len(invalid_tests) == 0
