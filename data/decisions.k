decision_list = [
  # SA.1 — final set
  {
    scenario_ref: "SA.1",
    selected_tactics: ["TAC.AUDITTRAIL", "TAC.NONREP", "TAC.OPA"],
    rationale: "Traceability requires immutable logs and signed events; central policy improves audit evidence."
  },

  # SA.2 — final set
  {
    scenario_ref: "SA.2",
    selected_tactics: ["TAC.MTLS", "TAC.NONREP"],
    rationale: "mTLS authenticates services; signatures ensure message integrity and non-repudiation."
  },

  # SA.3 — final set
  {
    scenario_ref: "SA.3",
    selected_tactics: ["TAC.SEG", "TAC.CPAMON"],
    rationale: "Segmentation contains incidents; continuous posture monitoring maintains resilience."
  },

  # SA.4 — final set
  {
    scenario_ref: "SA.4",
    selected_tactics: ["TAC.MFA", "TAC.AC", "TAC.OPA"],
    rationale: "Strong identity + least privilege enforced as code protects confidential datasets."
  }
]
