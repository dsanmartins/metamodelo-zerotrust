scenario_list = [
  {
    id: "SA.1",
    qa_ref: "QA.AUDIT",
    principles_ref: ["ZT.CMON", "ZT.EV"],
    goal: "End-to-end traceability for payment events.",
    context: "University payments platform in a multi-tenant environment.",
    actors: ["EndUser", "PaymentService", "MonitoringSubsystem"],
    resources: ["ImmutableLogStore", "KMS", "LoggingPipeline"],
    response: "Produce immutable logs for all relevant events; ensure verifiable evidence.",
    keywords: ["audit", "traceability", "payments"],
    priority: { importance: 5, difficulty: 3 }
  },
  {
    id: "SA.2",
    qa_ref: "QA.INTEGRITY",
    principles_ref: ["ZT.EV", "ZT.CPA"],
    goal: "Prevent and detect unauthorized data changes in transit.",
    context: "Microservices exchanging sensitive academic records.",
    actors: ["RecordService", "Gateway", "Verifier"],
    resources: ["ServiceMesh", "PKI", "WAF"],
    response: "Authenticate services and sign/verify messages.",
    keywords: ["integrity", "mTLS", "signing"],
    priority: { importance: 5, difficulty: 4 }
  },
  {
    id: "SA.3",
    qa_ref: "QA.AVAIL",
    principles_ref: ["ZT.AB", "ZT.MS"],
    goal: "Maintain service availability under malicious traffic.",
    context: "Public APIs exposed to the Internet.",
    actors: ["APIConsumer", "APIGateway", "ObservabilityStack"],
    resources: ["Gateway", "Autoscaling", "Segmentation"],
    response: "Isolate blast radius and keep critical services responsive.",
    keywords: ["availability", "segmentation", "resilience"],
    priority: { importance: 5, difficulty: 4 }
  },
  {
    id: "SA.4",
    qa_ref: "QA.CONF",
    principles_ref: ["ZT.LP", "ZT.EV", "ZT.SI"],
    goal: "Control access to confidential research data.",
    context: "Analytics workloads over sensitive datasets.",
    actors: ["Researcher", "IDP", "DataService"],
    resources: ["IAM", "KMS", "OPA"],
    response: "Strongly authenticate and enforce least privilege policies.",
    keywords: ["confidentiality", "MFA", "ABAC", "OPA"],
    priority: { importance: 5, difficulty: 3 }
  }
]
