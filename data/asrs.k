asr_list = [
  {
    id: "ASR.1",
    name: "Immutable audit of financial operations",
    description: "The system must generate immutable audit logs for all payment operations.",
    qa_ref: "QA.AUDIT"
  },
  {
    id: "ASR.2",
    name: "Detect unauthorized data changes",
    description: "The system must detect and prevent unauthorized modifications to sensitive records.",
    qa_ref: "QA.INTEGRITY"
  },
  {
    id: "ASR.3",
    name: "Sustain service under malicious traffic",
    description: "The platform must continue operating during hostile or anomalous traffic spikes.",
    qa_ref: "QA.AVAIL"
  },
  {
    id: "ASR.4",
    name: "Restrict access to confidential data",
    description: "Only strongly authenticated and authorized entities may access protected datasets.",
    qa_ref: "QA.CONF"
  }
]
