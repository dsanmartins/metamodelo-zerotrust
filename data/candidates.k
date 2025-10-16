candidate_list = [
  # SA.1 — Auditability
  {
    tactic_ref: "TAC.AUDITTRAIL",
    scenario_ref: "SA.1",
    matched_keywords: ["audit", "traceability"],
    score: 0.94
  },
  {
    tactic_ref: "TAC.NONREP",
    scenario_ref: "SA.1",
    matched_keywords: ["verifiable", "payments", "signature"],
    score: 0.88
  },
  {
    tactic_ref: "TAC.OPA",
    scenario_ref: "SA.1",
    matched_keywords: ["policy", "evidence"],
    score: 0.76
  },
  {
    tactic_ref: "TAC.CPAMON",
    scenario_ref: "SA.1",
    matched_keywords: ["continuous", "monitoring"],
    score: 0.71
  },

  # SA.2 — Integrity
  {
    tactic_ref: "TAC.MTLS",
    scenario_ref: "SA.2",
    matched_keywords: ["mTLS", "service-to-service"],
    score: 0.95
  },
  {
    tactic_ref: "TAC.NONREP",
    scenario_ref: "SA.2",
    matched_keywords: ["sign", "verify"],
    score: 0.89
  },
  {
    tactic_ref: "TAC.ATREST",
    scenario_ref: "SA.2",
    matched_keywords: ["encryption", "data"],
    score: 0.70
  },
  {
    tactic_ref: "TAC.CPAMON",
    scenario_ref: "SA.2",
    matched_keywords: ["posture", "drift"],
    score: 0.68
  },

  # SA.3 — Availability
  {
    tactic_ref: "TAC.SEG",
    scenario_ref: "SA.3",
    matched_keywords: ["segmentation", "blast-radius"],
    score: 0.92
  },
  {
    tactic_ref: "TAC.AC",
    scenario_ref: "SA.3",
    matched_keywords: ["policy", "abuse-control"],
    score: 0.72
  },
  {
    tactic_ref: "TAC.CPAMON",
    scenario_ref: "SA.3",
    matched_keywords: ["continuous", "monitoring"],
    score: 0.66
  },

  # SA.4 — Confidentiality
  {
    tactic_ref: "TAC.MFA",
    scenario_ref: "SA.4",
    matched_keywords: ["strong identity", "mfa"],
    score: 0.96
  },
  {
    tactic_ref: "TAC.AC",
    scenario_ref: "SA.4",
    matched_keywords: ["least privilege", "abac", "rbac"],
    score: 0.90
  },
  {
    tactic_ref: "TAC.OPA",
    scenario_ref: "SA.4",
    matched_keywords: ["policy-as-code", "opa"],
    score: 0.82
  },
  {
    tactic_ref: "TAC.ATREST",
    scenario_ref: "SA.4",
    matched_keywords: ["kms", "encryption"],
    score: 0.74
  }
]
