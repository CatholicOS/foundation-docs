# Governance-as-Code for Catholic Technology Deployment

|                   |                                                                                                                           |
| :---------------- | :------------------------------------------------------------------------------------------------------------------------ |
| **Document type** | Research memo                                                                                                             |
| **Status**        | Working draft — U.S.A. C-DART 1 discussion                                                                                |
| **Relationship**  | Supplementary research underlying [CDCF Project Vetting Criteria v0.2](../project-governance/project-vetting-criteria.md) |

---

## Table of Contents

1. [The Core Argument](#the-core-argument)
2. [What Governance-as-Code Is](#what-governance-as-code-is)
3. [Why Catholic Institutions Need It](#why-catholic-institutions-need-it)
4. [The Three-Layer Stack](#the-three-layer-stack)
5. [The Gate Decision as Primary Artifact](#the-gate-decision-as-primary-artifact)
6. [Application to AI Deployment](#application-to-ai-deployment)
7. [Application to Standards Compliance](#application-to-standards-compliance)
8. [Honest Assessment of Institutional Readiness](#honest-assessment-of-institutional-readiness)
9. [What Catholic Institutions Can Do Now](#what-catholic-institutions-can-do-now)
10. [Relationship to the CDCF](#relationship-to-the-cdcf)
11. [Bibliography](#bibliography)

---

## The Core Argument

Technology governance in Catholic institutions currently lives in PDFs and committee meetings. When a diocese, school, or Catholic hospital deploys a technology system — whether an
AI tool, a parish management platform, a data-sharing integration, or a liturgical software project — the governance process typically produces a document that says the system is
approved. That document exists separately from the system it governs. It cannot prevent a non-compliant deployment. It cannot be automatically validated. It can only react after
something goes wrong.

Governance-as-code is the practice of turning those policy documents into machine-executable specifications wired directly into deployment pipelines. The governance becomes part of
the infrastructure. This shift is already occurring in regulated enterprise environments. The question for Catholic institutions is whether they participate in shaping what those
specifications encode, or whether they inherit secular governance schemas designed without reference to Catholic moral theology, canonical authority, or the Church's preferential
concern for the vulnerable.

The principle applies across two dimensions of the CDCF's mission. For **technology deployments**, governance-as-code enforces the vetting criteria as hard gates before any project
reaches production. For **standards compliance**, governance-as-code verifies that projects conform to CDCF data standards — the shared identifiers and representations for
liturgical celebrations, Magisterial documents, Scripture editions, and canonical structures — automatically and continuously.

---

## What Governance-as-Code Is

In a governance-as-code architecture, policy requirements are expressed as version-controlled schemas (typically JSON or YAML) that define exactly what a technology system must
demonstrate before it can reach production. When a developer attempts to deploy a project, the deployment pipeline calls those schemas as hard gates.

The gate logic is deterministic. Pass all gates and the project deploys. Fail any gate and it does not. Every decision, pass or fail, is logged in an immutable audit trail that
regulators, diocesan authorities, or institutional leadership can examine after the fact.

The schemas themselves define the governance criteria: what evidence of testing is required, what data domains the system is permitted to touch, what level of human oversight it
operates under, who the named accountable person is, what conditions require escalation to a higher authority, and — for projects in domains covered by CDCF standards — whether the
project's data representations conform to the canonical schemas. These are the same questions the CDCF Vetting Criteria ask. Governance-as-code is the technical architecture that
makes those questions into enforceable gates rather than advisory checklists.

This is distinct from using AI to govern technology. The gate decision in a governance-as-code architecture is deterministic: a schema either passes or it does not, based on
explicit criteria defined in advance by human authorities. AI can assist with evidence synthesis and risk surfacing within the pipeline, but the gate logic itself remains under
human-defined, machine-enforced control.

A structural concern across all technology governance is the compliance gap between regulatory intent and deployment practice. Current governance frameworks share three recurring
gaps: scope ambiguity in defining covered systems, point-in-time compliance requirements that fail to address systems that evolve after initial approval, and information
asymmetries between regulators and deploying institutions.[^1] Governance-as-code directly addresses all three: schema definitions establish scope with precision,
version-controlled schemas evolve with the system they govern, and immutable audit trails close the information gap.

The Commission of the Bishops' Conferences of the European Union (COMECE) affirms that evaluating technology from an ethical perspective "requires internal control principles and
risk assessment in addition to legislation."[^2] Governance-as-code is the direct instantiation of those mandated internal control principles, translating ethical evaluation from a
periodic review activity into a continuous, enforceable infrastructure requirement.

---

## Why Catholic Institutions Need It

The fragmentation problem documented in the companion memo on [Catholic digital governance at scale](./fragmented-catholic-digital-governance.md) is fundamentally a governance
encoding problem — across both technology deployment and digital infrastructure.

**Technology deployment.** Each diocese is expressing its Catholic technology governance values in a different format, at a different level of specificity, for different audiences.
Orange wrote a council charter. Biloxi wrote a decree. Arlington wrote school policy. None of those instruments are machine-readable. None of them can be automatically validated
against. A vendor can acknowledge all three documents and deploy a non-compliant system anyway, because the documents have no technical enforcement mechanism.

**Standards compliance.** The same problem applies to digital standards. Even when shared canonical identifiers exist for liturgical celebrations, Magisterial documents, or
Scripture editions, a project can claim compliance without being verified. Without machine-enforceable schemas defining what conformance to a CDCF standard looks like, standards
adoption depends on voluntary discipline rather than architectural enforcement.

Governance-as-code changes both structural relationships. A shared canonical governance schema — a baseline set of machine-executable policies encoding the principles of _Antiqua
et Nova_,[^3] the USCCB principles,[^4] the Ethical and Religious Directives, and the CDCF data standards into version-controlled, reusable specifications — would let any diocese
adopt the shared baseline and extend it with local requirements. Subsidiarity is preserved because local authority still governs local decisions. Solidarity is achieved because
every institution operating on the shared baseline is interoperable.

A vendor serving Catholic schools would face one canonical schema with optional diocesan extensions rather than dozens of incompatible checklists. A Catholic hospital system
operating across diocesan lines could deploy uniformly because the governance infrastructure is compatible across jurisdictions. A liturgical software project could verify its
conformance to CDCF calendar identifiers as part of every build. The governance becomes as portable as the tools it governs.

The _Rome Call for AI Ethics_ demands that principles and values be instilled into a framework that "acts as a point of reference for digital ethics, guiding our actions and
promoting the use of technology to benefit humanity."[^5] The governance platform layer of this architecture directly answers that call, creating a shared, tangible reference point
for digital ethics that is enforceable across Catholic institutional boundaries rather than aspirational.

---

## The Three-Layer Stack

A mature governance-as-code architecture for Catholic technology deployment operates across three layers, each serving a distinct institutional function.

| Layer                   | Function                                                                                                                                                                                                                                                            | Primary Users                            | CDCF Role                              |
| :---------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | :--------------------------------------- | :------------------------------------- |
| **Infrastructure**      | CI/CD pipeline hooks, Kubernetes admission controllers, deployment gate logic, standards validation checks. Where schemas execute as hard gates and audit trails are generated.                                                                                     | Developers and DevOps teams              | Contributes schema specifications      |
| **Governance Platform** | Schema library: version-controlled policy specifications, risk classification logic, canonical Catholic governance baseline, CDCF standards conformance schemas. Where Catholic moral theology and canonical requirements are encoded as machine-readable criteria. | Diocesan IT offices and governance leads | Stewards the shared canonical baseline |
| **Application**         | Institutional-facing tools: onboarding workflows, risk dashboards, standards compliance reports, audit artifacts for diocesan leadership and external regulators.                                                                                                   | Parish and school administrators         | Provides templates and tooling         |

These three layers correspond directly to the three levels of institutional capacity Catholic organizations actually have. A small parish or school operates primarily at the
application layer, using governance tools without needing to understand the infrastructure underneath. A diocesan IT office operates at the governance platform layer, adopting and
extending canonical schemas for local context. A large Catholic health system or university operates at the infrastructure layer, embedding governance gates into its own CI/CD
pipelines.

---

## The Gate Decision as Primary Artifact

The most significant design principle in this framework is that the gate decision itself, the go, conditional-go, no-go, or defer determination, is treated as a first-class
artifact rather than a byproduct of the review process.

A gate decision artifact captures the specific evidence assembled, the confidence levels assigned, the gaps identified, the named human decision owner, the rationale for the
outcome, and the conditions under which the decision was made. It is immutable once recorded. It is the document that answers the regulator's question, the bishop's question, and
the affected person's question: why was this system deployed, under whose authority, and on what basis.

This design directly reflects the canonical standard established in Canon 1609, which requires that deliberative processes produce written conclusions with reasons in law and in
fact, and that the capacity for review and appeal be preserved.[^6] A gate decision artifact is the technical implementation of that canonical requirement.

The immutability of the audit trail also serves a specifically Catholic institutional concern. The USCCB warns that technology can be misused to "undermine the dignity of persons
and respect for the truth" through the manipulation of information.[^4] An immutable gate decision record ensures that if a deployed system behaves contrary to its governance
specification, institutional accountability is clear, traceable, and preserved for review. The practical consequence of ungoverned audit trails is documented in enterprise
deployments: when a production system retrieves a superseded policy document with no captured provenance, the organization cannot reconstruct what the system saw or why, turning
incident response into forensic guesswork rather than evidence-based accountability.[^7]

The four decision states carry distinct implications.

| Decision State     | Meaning                                                                         | Documentation Requirement                                                                |
| :----------------- | :------------------------------------------------------------------------------ | :--------------------------------------------------------------------------------------- |
| **Go**             | All governance criteria satisfied; deployment authorized                        | Full criteria evidence recorded                                                          |
| **Conditional-go** | Deployment authorized subject to specific conditions within a defined timeframe | Conditions and timeline specified; typically used when independent validation is pending |
| **No-go**          | One or more criteria fell short; deployment blocked                             | Specific criteria and evidence gaps documented                                           |
| **Defer**          | Escalation to higher authority required before proceeding                       | Authority identified and reason specified                                                |

---

## Application to AI Deployment

AI deployment is the domain where governance-as-code is most urgent and most technically mature.

Researchers studying multi-agent system failures have identified 14 distinct failure modes across three categories (system design issues, inter-agent misalignment, and task
verification breakdowns) underscoring the structural importance of deterministic gate logic rather than agent-mediated compliance review.[^8] Empirical survey data from 306 AI
practitioners across 26 domains confirms that reliability remains the top deployment challenge, with 68 percent of production agents executing ten or fewer steps before human
intervention is required.[^9] These findings argue for governance architectures in which human-defined, machine-enforced gates are the primary control mechanism rather than agent
judgment.

The regulatory pressure compounds the urgency. The EU AI Act, with key obligations for high-risk AI systems taking effect in 2026, creates structural demand for auditable
deployment governance in high-risk AI categories.[^10] Catholic healthcare, education, and social services operate squarely in those categories.

| Framework                  | Jurisdiction      | Key Gap                                                |
| :------------------------- | :---------------- | :----------------------------------------------------- |
| California SB 53           | U.S. (California) | Scope ambiguity for covered systems                    |
| New York RAISE Act         | U.S. (New York)   | Point-in-time compliance, no post-approval tracking    |
| U.S. AIREA                 | Federal           | Information asymmetry between regulators and deployers |
| EU AI Act GPAI obligations | European Union    | All three gaps present at scale                        |

An AI-specific governance-as-code implementation encodes the AI domain extensions from the CDCF Vetting Criteria — training data disclosure, subgroup performance analysis,
canonical boundary conditions — as machine-enforceable schemas within the shared canonical baseline. This distinct from using AI to govern AI: the gate logic remains deterministic,
and an AI-governed pipeline would require governance of its own, creating a regress that deterministic schema enforcement avoids.

---

## Application to Standards Compliance

The governance-as-code architecture extends naturally to CDCF data standards compliance.

When the CDCF defines canonical identifiers for liturgical celebrations (CLEDR), Magisterial documents (CMDDR), or Roman Missal editions (CRMETDR), those standards can be
expressed as machine-readable validation schemas. A liturgical software project that claims conformance to CLEDR can have that claim verified automatically in its build pipeline.
A catechetical platform that references Magisterial documents can validate its identifiers against the CMDDR schema at deployment time.

This shifts standards compliance from a documentation claim ("we follow CDCF standards") to an architectural fact ("our pipeline verifies CDCF standards on every build"). The
governance platform layer maintains the canonical schemas, and the infrastructure layer enforces them — the same architecture that governs deployment ethics also governs data
interoperability.

For Catholic institutions, this integration is significant. A project that passes both the vetting criteria gates and the standards conformance gates carries a level of assurance
that no policy document alone can provide: it has been validated against Catholic governance requirements and it interoperates with the shared digital infrastructure of the
Church, both verified by machine-enforceable evidence rather than self-attestation.

---

## Honest Assessment of Institutional Readiness

Full technical implementation of governance-as-code at the infrastructure layer is beyond the current capacity of most Catholic institutions, and overstating that capacity would
produce the kind of governance credibility gap this framework is designed to prevent. Most Catholic institutions, including well-resourced dioceses and health systems, currently
operate at the application layer at best. They have policy documents. Some have review committees. Very few have version-controlled governance schemas. None, to the knowledge of
this research, have canonical Catholic governance schemas embedded as hard gates in CI/CD deployment pipelines.

That gap is the opportunity, and it is the reason the CDCF Vetting Criteria are structured as they are. Criterion 6 requires a written, reviewable governance specification and
architectural compatibility with future enforcement. Full infrastructure-layer implementation is aspirational at the incubation stage. The governance specification written today
becomes the schema encoded tomorrow. The criteria are designed to build institutional capacity progressively, meeting institutions at their current maturity rather than requiring
capabilities still to be developed.

A critique raised in C-DART 1 session discussions is worth acknowledging directly: healthcare governance in Catholic institutions is primarily a legal and regulatory problem rather
than an engineering problem. HIPAA, FDA, CMS, and state law set the floor. That critique is accurate, and this framework accepts it. Governance-as-code operates as the technical
layer that makes compliance with those frameworks auditable, reproducible, and interoperable across Catholic institutional boundaries. The distinction between replacing regulation
and making compliance technically enforceable is the distinction that makes this approach credible rather than overreaching.

---

## What Catholic Institutions Can Do Now

Given the honest assessment of current institutional readiness, the near-term contribution of this research is a written evaluation standard that functions as the precursor to a
production CI/CD governance pipeline rather than the pipeline itself.

The CDCF Vetting Criteria represent that evaluation standard. Criterion 6 asks submitters to specify decision authority levels, escalation conditions, human review triggers, and
appeal processes in a written, reviewable document. That specification is the first step toward a machine-executable schema. An institution that has written a rigorous governance
specification for one project has done most of the intellectual work required to encode that specification as a reusable governance schema.

The CDCF is positioned to maintain the canonical schema library that individual institutions extend rather than build independently. That is the solidarity layer described in the
fragmentation memo: a shared baseline that preserves local authority while making Catholic technology governance interoperable at scale.

Three concrete actions follow from this research for Catholic institutions at any level of technical maturity.

1. **Require written governance specifications** for every technology project under evaluation. The specification format in Criterion 6 of the CDCF Vetting Criteria provides a
   starting template.
2. **Version-control those specifications.** Even a Word document in a shared drive with a version number and a named owner is a meaningful step toward governance-as-code
   discipline.
3. **Evaluate technology projects for schema compatibility:** does the project's architecture support governance gate integration and standards validation, or does it require
   overriding governance controls to function?

---

## Relationship to the CDCF

Governance-as-code serves as the enforcement architecture for both pillars of the CDCF's mission.

**Project vetting.** Criterion 6 of the [CDCF Project Vetting Criteria](../project-governance/project-vetting-criteria.md) is the direct operational expression of this research.
It requires a deployment governance specification as a condition of incubation acceptance, with the four-state decision model (go, conditional-go, no-go, defer) as the structural
framework for that specification. Criterion 8 extends the principle to the deployment architecture of the projects themselves, requiring that projects be deployable at the
appropriate level of ecclesial authority without overriding their core governance design. Together, Criteria 6 and 8 establish the governance specification requirements that
position Catholic institutions to adopt fuller governance-as-code implementation as institutional capacity develops.

**Standards compliance.** The [CDCF Standards program](../standards/overview.md) defines the canonical identifiers and data representations that Catholic software projects should
adopt. Governance-as-code provides the enforcement mechanism: standards expressed as machine-readable schemas can be validated automatically, shifting compliance from
self-attestation to architectural verification.

---

## Bibliography

[^1]:
    Joe Kwon and Stephen Casper, "Internal Deployment Gaps in AI Regulation," arXiv:2601.08005, submitted January 12, 2026, revised February 14, 2026,
    https://arxiv.org/abs/2601.08005.

[^2]:
    Commission of the Bishops' Conferences of the European Union (COMECE), "Statement on the EU Artificial Intelligence Act," COMECE, 2024,
    https://church.mt/comece-on-the-artificial-intelligence-act-it-does-justice-to-the-ethical-foundations-of-the-eu/.

[^3]:
    Dicastery for the Doctrine of the Faith and Dicastery for Culture and Education, _Antiqua et Nova: Note on the Relationship Between Artificial Intelligence and Human
    Intelligence_ (Vatican City: Dicastery for the Doctrine of the Faith, January 28, 2025),
    https://www.vatican.va/roman_curia/congregations/cfaith/documents/rc_ddf_doc_20250128_antiqua-et-nova_en.html.

[^4]:
    United States Conference of Catholic Bishops, _Joint Letter on Artificial Intelligence Principles and Priorities_, June 9, 2025,
    https://www.usccb.org/resources/joint-letter-artificial-intelligence-principles-and-priorities.

[^5]:
    Pope Francis, "Address at the Signing of the Rome Call for AI Ethics," Vatican City, February 28, 2020,
    https://www.vatican.va/content/francesco/en/speeches/2020/february/documents/papa-francesco_20200228_eticaartificiale.html.

[^6]:
    _Code of Canon Law_, Canon 1609 (Vatican City: Libreria Editrice Vaticana, 1983),
    https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib7-cann1501-1670_en.html.

[^7]: Rick Hamilton, "Data Governance for AI Must Be Executable," _hamiltonandboss.com_ (Substack), 2025, https://substack.com/@rickwritesai/p-189861656.

[^8]:
    Mert Cemri, Melissa Z. Pan, Yapei Yang, Aditya Agrawal, Tatsunori Hashimoto, Diyi Yang, Qian Yang, and Percy Liang, "Why Do Multi-Agent LLM Systems Fail?" arXiv:2503.13657,
    submitted March 17, 2025, https://arxiv.org/abs/2503.13657.

[^9]:
    Melissa Z. Pan, Mert Cemri, Lingjiao Chen, Matei Zaharia, James Zou, and Percy Liang, "Measuring Agents in Production," arXiv:2512.04123, submitted December 2, 2025, revised
    February 3, 2026, https://arxiv.org/abs/2512.04123.

[^10]:
    European Parliament and Council of the European Union, _Regulation (EU) 2024/1689 of the European Parliament and of the Council Laying Down Harmonised Rules on Artificial
    Intelligence (Artificial Intelligence Act)_, Official Journal of the European Union, August 12, 2024, https://artificialintelligenceact.eu.
