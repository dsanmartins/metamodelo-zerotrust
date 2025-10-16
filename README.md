# SecurityMetamodel – Zero Trust Design Metamodel

## 1) What is KCL?
**KCL (Kusion Configuration Language)** is a declarative language for **modeling, validating, and composing configurations**.  
It allows defining a **metamodel** (types + rules) and **validating instances** of that metamodel with declarative constraints (`assert`).  
The output can be exported as JSON/YAML for use in automation pipelines (e.g., generating IaC, policies, or documentation).

### Run the model
```bash
# From the project root
kcl run data/main_model.k -o model.yaml
```
This command loads the metamodel (`schemas/types.k`), integrates all instances from `data/`, validates consistency, and exports the validated model to `model.yaml`.

---

## 2) Metamodel (short overview)
The metamodel defines **how to design with Zero Trust** from **ASRs** to **Tactics**, through **Quality Attributes** and **Scenarios**.

| Entity | Meaning |
|---------|----------|
| **QualityAttribute (QA)** | Target quality goals (Auditability, Integrity, Availability, Confidentiality). |
| **ASR** | Architectural Security Requirement specifying a QA. |
| **ZTPrinciple** | High-level Zero Trust principle (Least Privilege, Assume Breach…). |
| **Influence** | Contribution (+/++) of a principle to a QA. |
| **Scenario** | Contextualization of QAs and principles into a design situation. |
| **SecurityTactic** | Implements principles and satisfies QAs. |
| **TacticCandidate** | Suggested tactics for a scenario. |
| **TacticDecision** | Final tactics selected to implement a scenario. |
| **TacticCatalog** | Reusable set of all available tactics. |

> Conceptual flow:  
> **ASR → QA ← Influence ← ZTPrinciple → Scenario → (Candidates) → Decision → SecurityTactic → QA**

---

## 3) Instance Overview (human-readable)

### 3.1 Quality Attributes (QAs)
| ID | Name | Description |
|----|------|--------------|
| QA.AUDIT | Auditability | Record and verify events |
| QA.INTEGRITY | Integrity | Prevent unauthorized modification |
| QA.AVAIL | Availability | Maintain operation under faults/attacks |
| QA.CONF | Confidentiality | Prevent unauthorized disclosure |

### 3.2 ASRs
| ID | Name | QA |
|----|------|----|
| ASR.1 | Immutable audit of financial operations | QA.AUDIT |
| ASR.2 | Detect unauthorized data changes | QA.INTEGRITY |
| ASR.3 | Sustain service under malicious traffic | QA.AVAIL |
| ASR.4 | Restrict access to confidential data | QA.CONF |

### 3.3 Zero Trust Principles
| ID | Name |
|----|------|
| ZT.CMON | Continuous Monitoring |
| ZT.LP | Least Privilege |
| ZT.EV | Explicit Verification |
| ZT.AB | Assume Breach |
| ZT.MS | Micro-Segmentation |
| ZT.CPA | Continuous Posture Assessment |
| ZT.SI | Strong Identity |

### 3.4 Influences (Principle → QA)
| Principle | QA | Polarity |
|------------|----|----------|
| ZT.CMON | QA.AUDIT | ++ |
| ZT.CMON | QA.AVAIL | + |
| ZT.LP | QA.CONF | ++ |
| ZT.LP | QA.AVAIL | + |
| ZT.LP | QA.INTEGRITY | + |
| ZT.EV | QA.CONF | ++ |
| ZT.EV | QA.INTEGRITY | ++ |
| ZT.EV | QA.AUDIT | + |
| ZT.AB | QA.AVAIL | ++ |
| ZT.AB | QA.CONF | + |
| ZT.MS | QA.AVAIL | ++ |
| ZT.MS | QA.CONF | + |
| ZT.CPA | QA.INTEGRITY | ++ |
| ZT.CPA | QA.AUDIT | + |
| ZT.SI | QA.CONF | ++ |
| ZT.SI | QA.AUDIT | + |

### 3.5 Scenarios
| ID | QA | Principles | Goal |
|----|----|-------------|------|
| SA.1 | QA.AUDIT | ZT.CMON, ZT.EV | Traceability for payment events |
| SA.2 | QA.INTEGRITY | ZT.EV, ZT.CPA | Detect unauthorized data changes |
| SA.3 | QA.AVAIL | ZT.AB, ZT.MS | Maintain service under attack |
| SA.4 | QA.CONF | ZT.LP, ZT.EV, ZT.SI | Control access to research data |

### 3.6 Tactic Catalog
| ID | Name | Addresses QAs | Implements Principles |
|----|------|---------------|------------------------|
| TAC.AUDITTRAIL | MaintainAuditTrail | QA.AUDIT | ZT.CMON, ZT.EV |
| TAC.NONREP | NonRepudiation | QA.INTEGRITY, QA.AUDIT | ZT.EV |
| TAC.MFA | MultiFactorAuthentication | QA.CONF | ZT.EV, ZT.SI |
| TAC.AC | AccessControlPolicy | QA.CONF, QA.AVAIL | ZT.LP, ZT.EV |
| TAC.SEG | NetworkSegmentation | QA.AVAIL, QA.CONF | ZT.MS, ZT.AB |
| TAC.ATREST | EncryptionAtRest | QA.CONF, QA.INTEGRITY | ZT.EV |
| TAC.MTLS | MutualTLS | QA.INTEGRITY, QA.CONF | ZT.EV |
| TAC.OPA | PolicyAsCodeOPA | QA.AUDIT, QA.CONF | ZT.EV, ZT.LP |
| TAC.CPAMON | ContinuousPostureMonitoring | QA.AUDIT, QA.INTEGRITY, QA.AVAIL | ZT.CMON, ZT.CPA |

### 3.7 Tactic Decisions
| Scenario | Selected Tactics | Rationale |
|-----------|------------------|------------|
| SA.1 | MaintainAuditTrail, NonRepudiation, OPA | Logs + signed events + policy evidence |
| SA.2 | MutualTLS, NonRepudiation | Service authentication + integrity |
| SA.3 | NetworkSegmentation, ContinuousPostureMonitoring | Containment + resilience |
| SA.4 | MFA, AccessControlPolicy, OPA | Strong identity + least privilege |

---

## 4) Project structure
```
SecurityMetamodel/
├── kcl.mod
├── schemas/
│   └── types.k
└── data/
    ├── main_model.k
    ├── quality_attributes.k
    ├── asrs.k
    ├── principles.k
    ├── influences.k
    ├── scenarios.k
    ├── catalog.k
    ├── candidates.k
    └── decisions.k
```
