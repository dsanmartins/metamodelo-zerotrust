influence_list = [
  # Continuous Monitoring
  {
    principle_ref: "ZT.CMON",
    qa_ref: "QA.AUDIT",
    polarity: "++",
    rationale: "Continuous monitoring directly reinforces auditability by ensuring visibility and event recording."
  },
  {
    principle_ref: "ZT.CMON",
    qa_ref: "QA.AVAIL",
    polarity: "+",
    rationale: "Monitoring supports early anomaly detection that helps maintain system availability."
  },

  # Least Privilege
  {
    principle_ref: "ZT.LP",
    qa_ref: "QA.CONF",
    polarity: "++",
    rationale: "Limiting access reduces the exposure of confidential information."
  },
  {
    principle_ref: "ZT.LP",
    qa_ref: "QA.AVAIL",
    polarity: "+",
    rationale: "Minimizing access can improve availability by reducing attack surfaces."
  },
  {
    principle_ref: "ZT.LP",
    qa_ref: "QA.INTEGRITY",
    polarity: "+",
    rationale: "Restricting permissions lowers the risk of unintended data modification."
  },

  # Explicit Verification
  {
    principle_ref: "ZT.EV",
    qa_ref: "QA.CONF",
    polarity: "++",
    rationale: "Continuous identity and context verification directly protects confidentiality."
  },
  {
    principle_ref: "ZT.EV",
    qa_ref: "QA.INTEGRITY",
    polarity: "++",
    rationale: "Explicit verification ensures that only trusted entities modify data."
  },
  {
    principle_ref: "ZT.EV",
    qa_ref: "QA.AUDIT",
    polarity: "+",
    rationale: "Verification provides traceable evidence useful for auditing."
  },

  # Assume Breach
  {
    principle_ref: "ZT.AB",
    qa_ref: "QA.AVAIL",
    polarity: "++",
    rationale: "Designing under the assumption of compromise drives architectural resilience and system continuity."
  },
  {
    principle_ref: "ZT.AB",
    qa_ref: "QA.CONF",
    polarity: "+",
    rationale: "Containment strategies under 'assume breach' indirectly enhance confidentiality."
  },

  # Micro-Segmentation
  {
    principle_ref: "ZT.MS",
    qa_ref: "QA.AVAIL",
    polarity: "++",
    rationale: "Segmentation prevents lateral movement, maintaining service availability."
  },
  {
    principle_ref: "ZT.MS",
    qa_ref: "QA.CONF",
    polarity: "+",
    rationale: "Segmentation confines access to authorized segments, reducing exposure of sensitive data."
  },

  # Continuous Posture Assessment
  {
    principle_ref: "ZT.CPA",
    qa_ref: "QA.INTEGRITY",
    polarity: "++",
    rationale: "Continuous posture assessment ensures system components maintain trusted configurations."
  },
  {
    principle_ref: "ZT.CPA",
    qa_ref: "QA.AUDIT",
    polarity: "+",
    rationale: "Posture assessment contributes to auditability by generating verifiable compliance evidence."
  },

  # Strong Identity
  {
    principle_ref: "ZT.SI",
    qa_ref: "QA.CONF",
    polarity: "++",
    rationale: "Strong, phishing-resistant identities directly ensure confidentiality of protected assets."
  },
  {
    principle_ref: "ZT.SI",
    qa_ref: "QA.AUDIT",
    polarity: "+",
    rationale: "Strong identity provides reliable attribution of actions, supporting audit trails."
  }
]
