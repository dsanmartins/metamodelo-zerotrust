catalog = {
  tactics: [
    {
      id: "TAC.AUDITTRAIL",
      name: "MaintainAuditTrail",
      category: "audit",
      description: "Generate tamper-evident, immutable logs for critical events.",
      addresses: ["QA.AUDIT"],
      implements_principles: ["ZT.CMON", "ZT.EV"]
    },
    {
      id: "TAC.NONREP",
      name: "NonRepudiation",
      category: "integrity",
      description: "Digitally sign events/transactions to prevent denial of authorship.",
      addresses: ["QA.INTEGRITY", "QA.AUDIT"],
      implements_principles: ["ZT.EV"]
    },
    {
      id: "TAC.MFA",
      name: "MultiFactorAuthentication",
      category: "access-control",
      description: "Require multiple independent factors for user access.",
      addresses: ["QA.CONF"],
      implements_principles: ["ZT.EV", "ZT.SI"]
    },
    {
      id: "TAC.AC",
      name: "AccessControlPolicy",
      category: "access-control",
      description: "Enforce ABAC/RBAC policies to minimize permissions.",
      addresses: ["QA.CONF", "QA.AVAIL"],
      implements_principles: ["ZT.LP", "ZT.EV"]
    },
    {
      id: "TAC.SEG",
      name: "NetworkSegmentation",
      category: "availability",
      description: "Segment networks and workloads to contain incidents.",
      addresses: ["QA.AVAIL", "QA.CONF"],
      implements_principles: ["ZT.MS", "ZT.AB"]
    },
    {
      id: "TAC.ATREST",
      name: "EncryptionAtRest",
      category: "confidentiality",
      description: "Encrypt data at rest with managed keys.",
      addresses: ["QA.CONF", "QA.INTEGRITY"],
      implements_principles: ["ZT.EV"]
    },
    {
      id: "TAC.MTLS",
      name: "MutualTLS",
      category: "integrity",
      description: "Use mTLS for service-to-service authentication and channel protection.",
      addresses: ["QA.INTEGRITY", "QA.CONF"],
      implements_principles: ["ZT.EV"]
    },
    {
      id: "TAC.OPA",
      name: "PolicyAsCodeOPA",
      category: "governance",
      description: "Centralize fine-grained authorization and compliance as code (Rego).",
      addresses: ["QA.AUDIT", "QA.CONF"],
      implements_principles: ["ZT.EV", "ZT.LP"]
    },
    {
      id: "TAC.CPAMON",
      name: "ContinuousPostureMonitoring",
      category: "monitoring",
      description: "Continuously verify device/workload posture and drift.",
      addresses: ["QA.AUDIT", "QA.INTEGRITY", "QA.AVAIL"],
      implements_principles: ["ZT.CMON", "ZT.CPA"]
    }
  ]
}
