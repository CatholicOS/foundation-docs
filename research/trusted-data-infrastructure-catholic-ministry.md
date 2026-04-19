# Trusted Data Infrastructure for Catholic Ministry

|                   |                                                                                                                           |
| :---------------- | :------------------------------------------------------------------------------------------------------------------------ |
| **Document type** | Research memo                                                                                                             |
| **Status**        | Working draft — U.S.A. C-DART 1 discussion                                                                                |
| **Relationship**  | Supplementary research underlying [CDCF Project Vetting Criteria v0.2](../project-governance/project-vetting-criteria.md) |

---

## Table of Contents

1. [The Core Argument](#the-core-argument)
2. [The Catholic Data Stewardship Challenge](#the-catholic-data-stewardship-challenge)
3. [Institutional Data: Scale and Sensitivity](#institutional-data-scale-and-sensitivity)
4. [Ecclesial Data: The Shared Patrimony of the Church](#ecclesial-data-the-shared-patrimony-of-the-church)
5. [Synthetic Data for AI Development](#synthetic-data-for-ai-development)
6. [What Catholic Institutions Could Build](#what-catholic-institutions-could-build)
7. [The Three-Layer Stack](#the-three-layer-stack)
8. [Three Tiers of Catholic Data](#three-tiers-of-catholic-data)
9. [The CDCF Role Across Data Tiers](#the-cdcf-role-across-data-tiers)
10. [Relationship to the CDCF](#relationship-to-the-cdcf)
11. [Bibliography](#bibliography)

---

## The Core Argument

Catholic institutions collectively hold one of the largest concentrations of data stewardship responsibilities in America — and one of the richest bodies of shared ecclesial data
in the world. These two data domains are distinct in character but face the same structural problem: the absence of shared infrastructure for governing, standardizing, and
exchanging them.

**Institutional data** — patient records, student files, case management data, parish engagement — is sensitive, personally identifiable, and legally protected. It serves the same
overlapping populations across healthcare, education, social services, and parish life in a way no secular institution can replicate. That cross-domain view is operationally
invaluable and almost entirely inaccessible for technology development, because the data is protected by HIPAA, FERPA, diocesan privacy norms, and the pastoral trust of the people
it concerns.

**Ecclesial data** — the Liturgy, Sacred Scripture, Magisterial documents, canonical structures — belongs to the universal Church. It is not private data but shared patrimony,
and its challenge is not privacy but standardization. Dozens of independent projects digitize these realities with incompatible identifiers, data models, and classification
schemes, producing fragmentation where the Church's own unity demands coherence.

Both data domains require trusted infrastructure: governance frameworks, validation standards, and interoperability protocols that allow Catholic institutions to steward their data
responsibly, exchange it where appropriate, and build technology that serves their missions. This memo addresses how that infrastructure can be developed, with particular attention
to the role of synthetic data in unlocking AI development from sensitive institutional datasets.

---

## The Catholic Data Stewardship Challenge

Catholic institutions face a dual data challenge that no other class of institution shares.

On one side, they hold massive quantities of sensitive institutional data across legally independent entities that cannot share it — even when serving the same populations and
pursuing the same mission. A family that receives care at a Catholic hospital, educates their children at a Catholic school, receives services from Catholic Charities, and
participates in parish life appears in four separate Catholic data systems. No secular institution has that cross-domain view of the same overlapping populations. That view is
precisely what makes Catholic institutional data uniquely valuable for technology development, and precisely what makes its governance obligations most serious.

On the other side, they collectively steward the digital representations of realities that belong to the universal Church — the Roman Calendar, the editions of Sacred Scripture,
the documents of the Magisterium, the organizational structure of dioceses and parishes — but with no shared standards for how those realities are identified and represented in
code. Every liturgical software project, every Bible application, every diocesan database has had to invent its own data model for the same shared patrimony.

The first challenge requires privacy-preserving infrastructure. The second requires standardization infrastructure. Both require the same institutional response: shared governance
frameworks developed collaboratively by Church institutions with the assistance of specialized technologists.

---

## Institutional Data: Scale and Sensitivity

The scale of Catholic institutional data stewardship in the United States is substantial.

| Domain                         | Scale                                                                                | Data Type                                                            | Legal Protection                       |
| :----------------------------- | :----------------------------------------------------------------------------------- | :------------------------------------------------------------------- | :------------------------------------- |
| **Healthcare**                 | 650 hospitals · 2,200+ facilities · 1 in 7 U.S. patients · 19M emergency visits/year | EHR, clinical outcomes, demographic data                             | HIPAA                                  |
| **Education**                  | 5,905 schools · 1.68M students · 150,000+ staff                                      | Academic performance, behavioral, family, sacramental records        | FERPA                                  |
| **Social Services & Parishes** | 168 agencies · 28M meals · 295,000 emergency housing placements                      | Immigration, counseling, housing, case management, parish engagement | Diocesan privacy norms, pastoral trust |

**Catholic healthcare** is the largest group of nonprofit healthcare providers in the United States: 650 hospitals and more than 2,200 total facilities caring for one in seven
American patients daily, with approximately 19 million emergency visits and 5.6 million hospital admissions annually.[^1] The three largest Catholic health systems (CommonSpirit
Health, Ascension, and Trinity Health) collectively operate more than 370 hospitals with combined revenues exceeding $90 billion.[^1] [^2] This data is protected by HIPAA and is
largely inaccessible for cross-institutional technology development without extended IRB processes and data sharing agreements that rarely scale.

**Catholic education** enrolls 1.68 million students across 5,905 schools with more than 150,000 professional staff.[^3] These FERPA-protected records include academic performance,
behavioral data, family information, and, uniquely, sacramental records. The accelerating trend toward diocesan centralized management, which has grown from 2.4 percent of
elementary schools in 1990 to 18 percent in 2023, creates both opportunity and risk: centralization enables system-wide analytics but concentrates sensitive data in ways that
amplify governance obligations.[^3]

**Catholic social services and parishes** encompass 168 Catholic Charities agencies that served more than 28 million meals and provided emergency housing to 295,000 people in 2024,
while responding to 52 disasters.[^4] Their data includes immigration records, counseling records, housing data, and case management information for some of America's most
vulnerable populations. Thousands of parishes hold additional data on the same families across giving patterns, sacramental participation, and community engagement.

---

## Ecclesial Data: The Shared Patrimony of the Church

A distinct category of data stewardship concerns the digital representation of realities that belong to the universal Church and are not private data but shared patrimony.

| Domain                    | What Must Be Represented                                                                         | Current State                                                                |
| :------------------------ | :----------------------------------------------------------------------------------------------- | :--------------------------------------------------------------------------- |
| **Liturgy**               | The General Roman Calendar, proper calendars, feast rankings, seasonal cycles                    | Multiple independent implementations with incompatible identifiers           |
| **Sacred Scripture**      | Approved editions and translations from the Vulgate through modern vernaculars                   | No shared registry of editions; every application invents its own references |
| **Magisterial Documents** | Encyclicals, apostolic constitutions, conciliar decrees, dicastery instructions                  | No standard identifier scheme for type, issuer, or authority level           |
| **Canonical Structures**  | Dioceses, eparchies, parishes, religious institutes, including historical entities                | Every database uses its own numbering; no canonical digital directory exists  |
| **Sacramental Records**   | Baptism, confirmation, marriage, ordination records maintained across diocesan register systems   | Diocesan databases are mutually incompatible; no data exchange standard      |

This data does not face privacy constraints — the General Roman Calendar is public, the texts of Sacred Scripture are published, the documents of the Magisterium are freely
available. What it faces is a standardization deficit. The Church's own understanding of its structures, rites, and traditions has no authoritative digital expression that software
projects can build on. Every project that needs to reference a liturgical celebration, a Bible edition, or a Magisterial document must create its own classification from scratch.

The consequence is the fragmentation documented in the companion memo on [Catholic digital governance at scale](./fragmented-catholic-digital-governance.md): dozens of independent
projects digitizing the same shared realities in ways that cannot interoperate, cannot be jointly validated, and cannot serve the universal Church's need for coherent digital
infrastructure.

Trusted data infrastructure for ecclesial data means shared, canonical standards — developed by ecclesial authorities, academic experts, and specialized technologists working
together — that give the Church's shared patrimony a single, authoritative digital representation.

---

## Synthetic Data for AI Development

For sensitive institutional data, a specific technical solution has crossed the production threshold: trusted synthetic data.

Synthetic data is algorithmically generated data that mirrors the statistical properties, distributions, and relationships of a real dataset without containing any actual records
from real individuals. A synthetic patient cohort drawn from a hospital system's electronic health records preserves the clinical patterns, demographic distributions, comorbidity
relationships, and outcome rates of the real population while containing zero real patients. No individual record can be traced back to a real person because no individual record
from a real person was used to generate it.

The distinction between synthetic data and anonymized data is consequential. Anonymized datasets remove or mask identifying fields, but the underlying records still correspond to
real individuals, and re-identification attacks have demonstrated that anonymization alone provides insufficient protection for sensitive populations. Synthetic data generates new
records from learned distributions. Re-identification risk is dramatically reduced when datasets are fully synthetic, because synthetic records carry no real-world counterparts,
but privacy still requires careful design and independent testing before the data can be trusted for consequential use.

Quality validation is the critical governance requirement. A synthetic dataset is valuable for AI training only if it accurately preserves the statistical properties of the source
data. Validation frameworks measure fidelity (the degree to which synthetic distributions match real distributions) and privacy (the degree to which synthetic records resist
membership inference attacks). Both dimensions require rigorous, independent validation before synthetic data can be trusted for consequential AI development.

### The market signal

Two market signals establish that synthetic data has crossed from experimental to production-grade infrastructure.

| Signal                        | Organization                   | Year         | Significance                                                                                                                  |
| :---------------------------- | :----------------------------- | :----------- | :---------------------------------------------------------------------------------------------------------------------------- |
| NVIDIA acquires Gretel        | NVIDIA / Gretel                | 2025         | $320M+ acquisition positions synthetic data generation as foundational enterprise AI infrastructure, not a niche privacy tool |
| VA deploys MDClone nationally | Veterans Health Administration | 2020–present | Demonstrates production-scale synthetic health data under federal regulatory oversight                                        |

NVIDIA acquired Gretel, the leading synthetic data generation platform, for more than $320 million in 2025.[^5] NVIDIA's acquisition thesis was explicit: synthetic data is
essential infrastructure for AI development in regulated industries where real data is legally inaccessible or practically unavailable at the scale AI training requires.

The U.S. Department of Veterans Affairs, through the Veterans Health Administration, has deployed MDClone as a synthetic data engine to support multiple clinical and research use
cases.[^6] The VHA deployment demonstrated that synthetic data generation can operate at national health system scale under federal regulatory oversight, with validated fidelity
sufficient to support clinical AI development and outcomes research.

These signals matter for Catholic institutions because they establish that the technology is production-ready and that the regulatory and governance questions, while real, are
solvable.

---

## What Catholic Institutions Could Build

Trusted data infrastructure — both standardized ecclesial data and synthetic institutional data — would unlock technology development that is currently structurally impossible.

### From synthetic institutional data

| Use Case                  | Data Source                                       | Applications Unlocked                                                                       |
| :------------------------ | :------------------------------------------------ | :------------------------------------------------------------------------------------------ |
| **Healthcare**            | Synthetic EHR cohorts across 650 hospitals        | Diagnostic AI, clinical operations, multi-system population research                        |
| **Education**             | Synthetic student records across 5,905 schools    | Early-warning systems, retention models, system-wide benchmarking                           |
| **Social Services**       | Synthetic case data across 168 Charities agencies | Program effectiveness, homelessness prediction, neighborhood vulnerability modeling         |
| **Research Partnerships** | Cross-institutional synthetic cohorts             | NIH studies, public health research, minority population outcomes                           |

Synthetic EHR cohorts across 650 hospitals would enable diagnostic AI development, clinical operations optimization, and multi-system research on population patterns without
triggering PHI sharing workflows or extended IRB delays.[^1] Catholic hospitals disproportionately serve underrepresented and underserved populations that commercial AI training
datasets consistently underrepresent. Synthetic student records across 5,905 schools would allow diocesan education offices to build early-warning systems for at-risk students and
system-wide performance benchmarking without real student data ever leaving its source system.[^3] Synthetic case management data across 168 Catholic Charities agencies would
enable program effectiveness analysis and cross-agency learning without exposing individual client identities.[^4]

The combination of social services data with parish community data creates a neighborhood-level picture of human need that has no secular equivalent. This use case is a direct
technical execution of the Church's Preferential Option for the Poor: technology systems built on this infrastructure would see and serve the marginalized without exploiting their
data, ensuring that the most vulnerable populations benefit from technology development rather than being rendered invisible by datasets that consistently underrepresent them.

A governance obligation follows from each of these use cases. The USCCB's principles are direct: automated decision-making systems used in healthcare, education, and social
services can reinforce existing biases or introduce a utilitarian approach that displaces necessary human considerations.[^7] The USCCB further teaches that technology should
"supplement what human beings do, not replace them or their moral judgments."[^7] Models trained on Catholic synthetic data must be designed to supplement the judgment of doctors,
teachers, and social workers, and the CDCF certification criteria for applications using synthetic data should require that human professionals retain ultimate decision-making
authority.

U.S. Catholic institutions also serve large populations of Latin American descent, particularly in healthcare and social services. The Latin American and Caribbean Episcopal
Council has called for AI applications to be critically evaluated in particular local contexts to determine whether they advance human dignity and the common good in practice.[^8]
The federated synthetic data framework provides exactly the mechanism needed to safely develop and evaluate technology serving these specific demographic communities.

### From standardized ecclesial data

| Use Case                       | Data Source                                       | Applications Unlocked                                                                      |
| :----------------------------- | :------------------------------------------------ | :----------------------------------------------------------------------------------------- |
| **Liturgical Software**        | Shared CLEDR identifiers for all celebrations     | Interoperable calendar apps, lectionary tools, liturgical planning systems                  |
| **Scripture Applications**     | Shared registry of Catholic Bible editions        | Cross-reference tools, liturgical reading integration, catechetical platforms               |
| **Magisterial Research**       | Shared CMDDR identifiers for Church documents     | Citation tools, teaching authority databases, theological research platforms                |
| **Diocesan Administration**    | Shared identifiers for canonical structures       | Cross-diocesan directories, national reporting, historical research                        |

When Catholic software projects build on shared canonical identifiers rather than inventing their own, interoperability becomes the default rather than the exception. A liturgical
calendar app can exchange data with a parish management system. A catechetical platform can reference the same Magisterial documents as a theological research tool. A diocesan
database can interoperate with a national directory. Each shared standard eliminates redundant effort and ensures that the digital representation of the Church's patrimony reflects
the ecclesial unity of what it represents.

---

## The Three-Layer Stack

Trusted data infrastructure for Catholic ministry operates across three layers that correspond to institutional capacity levels.

| Layer                   | Function                                                                                                                                                                    | Primary Users                                        | CDCF Role                                                       |
| :---------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :--------------------------------------------------- | :-------------------------------------------------------------- |
| **Infrastructure**      | Synthetic data generators, standards validation engines, PHI/PII-sensitive pipeline controls. Handles technical generation, validation, and standards conformance checking. | Large health systems and university research centers | Contributes validation and conformance specifications           |
| **Governance Platform** | Catholic-specific governance framework encoding quality validation standards, data stewardship policies, CDCF standards schemas, and access-control patterns.               | Diocesan governance offices and data stewards        | Stewards validation standards, certification criteria, schemas |
| **Application**         | Ready-made tools: diocesan education dashboards, Charities program evaluation tools, liturgical software using CDCF standard identifiers, parish data integrations.         | Diocesan offices, parishes, small agencies           | Provides certified application templates and standard schemas  |

---

## Three Tiers of Catholic Data

A critique raised in C-DART 1 session discussions warrants direct acknowledgment: data heterogeneity across legally independent Catholic institutions would make a pooled Catholic
data commons technically unsound. That critique is accurate — but it applies to one category of data, not all of them. The appropriate architecture depends on what kind of data is
being governed.

Catholic data falls into three distinct tiers, each requiring a different infrastructure model.

### Tier 1: Sensitive institutional data — federated, never pooled

Patient records, student files, case management data, parish giving records, and sacramental records pertaining to specific individuals are sensitive data protected by HIPAA,
FERPA, diocesan privacy norms, and pastoral trust. Catholic hospitals, schools, and Charities agencies operate under different legal entities, different regulatory frameworks, and
different diocesan governance structures. Their data schemas, data quality, and data governance norms are incompatible in ways that would produce noise rather than signal if
combined naively.

This data is never the subject of a data commons. The architectural response is federated synthetic data generation: each institution generates synthetic datasets locally from its
own source data, and only the synthetic datasets — containing no real individual records — move between institutions or become available for research and AI development. Each
institution retains full control over its source data.

### Tier 2: Local institutional data — locally governed, not a commons

Operational data specific to a diocese, school system, or agency — enrollment figures, staffing models, facility data, local program configurations — is not sensitive in the same
way as personal records, but it is specific to the institution that produces it. It falls under the governance of the local institution and is not a candidate for a data commons.

This data benefits from shared standards (so that diocesan systems can interoperate where needed) but remains locally owned and locally governed.

### Tier 3: Universal Church data — a genuine data commons

The Liturgy, the structure of Sacred Scripture, the documents of the Magisterium, Canon Law, the organizational structure of dioceses and parishes — these realities belong to the
universal Church. They are not the private data of any institution. They originate from the Church's universal authority and are shared across every diocese, parish, and Catholic
institution worldwide.

This data is the natural subject of a data commons. The shared baseline — the General Roman Calendar, the canonical books of the Bible, the classification of Magisterial
documents, the directory of dioceses — can be defined, maintained, and served centrally. It is not merely a matter of defining standards that independent projects implement
locally; the data itself can be served from a shared commons, because it represents universal realities that belong to no local institution individually.

Local adaptations exist within this tier: proper calendars for specific dioceses and religious orders, approved vernacular translations of Scripture and liturgical texts, diocesan
supplements to canonical structures. These adaptations fall under the governance of the local bishops' conference or diocese that published them, and many also fall under
copyright — which serves as a legitimate means of protecting both the authority of the local institution and the rights of the publisher charged by that institution with producing
the vernacular adaptation, to whom due compensation may be owed.

The architecture must respect both jurisdiction and copyright. Centrally serving local adaptations does not require that copyrighted material be published as open source. A hybrid
model accommodates both realities:

1. **Federated option.** The local institution serves its own adaptations locally, using CDCF standard schemas for interoperability. The data never leaves the institution's
   infrastructure. This is always available as the default.
2. **Centralized option by agreement.** Following an agreement with the local institution, the CDCF serves the adaptation centrally while protecting the copyrighted data
   according to any norms established by the rights holder — access controls, licensing terms, attribution requirements, or distribution restrictions as the local institution
   sees fit.

Both options operate on the same shared standards and schemas, so downstream software projects interoperate regardless of whether a given adaptation is served locally or
centrally. The distinction is operational (where the data is hosted and under what terms) rather than structural (how the data is represented).

This distinction matters because it determines what the CDCF can and should build. For Tier 1 data, the CDCF sets validation standards for synthetic data generation. For Tier 2
data, the CDCF defines interoperability standards. For Tier 3 data, the CDCF can go further: it can define the canonical standards, maintain the authoritative datasets, and serve
the shared baseline as operational infrastructure for the entire Catholic software ecosystem — with local adaptations served centrally where agreements permit, or federated where
they do not.

---

## The CDCF Role Across Data Tiers

The CDCF's bylaws charge it to "coordinate, develop, steward, and disseminate open-source software, data repositories, technical standards, and digital platforms," and its
manifesto describes a "builder commons" dedicated to aggregating, vetting, and communalizing resources for the Catholic Church's digital mission. The three-tier data model maps
directly onto that charter — with the CDCF's role escalating from standard-setting for sensitive data, through interoperability standards for local data, to operational data
stewardship for the shared patrimony of the universal Church.

| Data Tier                                  | CDCF Role                                                                                                                                        |
| :----------------------------------------- | :----------------------------------------------------------------------------------------------------------------------------------------------- |
| **Tier 1: Sensitive institutional data**   | Defines validation standards and certification criteria for synthetic data generation. Sets fidelity and privacy thresholds. Does not hold data. |
| **Tier 2: Local institutional data**       | Defines interoperability standards and schema conventions. Does not hold data.                                                                   |
| **Tier 3: Universal Church data**          | Defines canonical standards, maintains authoritative datasets, and serves the shared baseline with contributed local adaptations.                |

For Tier 1, the CDCF contributes governance expertise: fidelity and privacy thresholds a synthetic dataset must meet for certification, what a synthetic data generation process
must demonstrate to receive CDCF certification (paralleling the project vetting criteria), and schema conventions that allow synthetic datasets from different institutions to be
combined or compared for cross-institutional research. Shared standards prevent each institution from solving the same problem independently.

For Tier 2, the CDCF contributes interoperability standards: common schemas and conventions that allow locally governed systems to exchange data where needed, without requiring
those systems to pool their data or cede governance to a central authority.

For Tier 3, the CDCF's contribution is qualitatively different. The Foundation is positioned not only to define the canonical identifiers and data representations for the
realities of Catholic life — liturgical celebrations, Scripture editions, Magisterial documents, canonical structures — but to maintain and serve those datasets as operational
infrastructure. The General Roman Calendar, for example, is not merely a standard to be implemented locally; it is a shared dataset that can be served centrally, with local proper
calendars contributed by the dioceses and religious orders that govern them. The same applies to a registry of Catholic Bible editions, a classification of Magisterial documents,
or a directory of dioceses and parishes. The CDCF can serve the universal baseline and, by agreement with the local institutions that govern them, incorporate and serve the local
adaptations — fulfilling its chartered role as steward of data repositories and creating a genuine data commons for the shared patrimony of the Church.

---

## Relationship to the CDCF

The research documented here supports both pillars of the CDCF's mission.

**Project vetting.** Criterion 7 of the [CDCF Project Vetting Criteria](../project-governance/project-vetting-criteria.md) addresses data stewardship directly: a project that
handles data from Catholic institutions carries an obligation to those institutions and to the populations they serve, and the terms under which that data is used must be disclosed
and evaluated as part of the graduation review. Trusted synthetic data infrastructure is what makes responsible AI development possible at scale — an institution that deploys
validated synthetic data generation can develop AI tools for its own use and contribute to shared Catholic AI development without the legal exposure and governance burden that use
of real institutional data would require.

**Standards program.** The [CDCF Standards program](../standards/overview.md) addresses the ecclesial data standardization challenge directly. By establishing shared canonical
identifiers for liturgical celebrations (CLEDR), Magisterial documents (CMDDR), Roman Missal editions (CRMETDR), and future standards for dioceses, Scripture editions, and
canonical structures, the standards program creates the authoritative digital vocabulary that Catholic software projects need.

The three research memos (fragmentation, governance-as-code, and trusted data infrastructure) form an integrated argument. Fragmentation establishes why shared governance and
standards are urgent. Governance-as-code provides the enforcement architecture. Trusted data infrastructure provides the data foundation — both synthetic institutional data and
standardized ecclesial data — that allows Catholic institutions to develop technology worthy of that governance architecture.

---

## Bibliography

[^1]:
    Catholic Health Association of the United States, _Catholic Health Care in the United States_ (Washington, DC: Catholic Health Association, 2024),
    https://www.chausa.org/about/facts---statistics.

[^2]:
    CommonSpirit Health, _Audited Consolidated Financial Statements as of and for the Years Ended June 30, 2024 and 2023_ (Chicago: CommonSpirit Health, 2024),
    https://www.commonspirit.org/content/dam/shared/en/pdfs/investor-resources/2024-CommonSpirit-Health-Annual-Report.SECURED.pdf.

[^3]:
    National Catholic Educational Association, _United States Catholic Elementary and Secondary Schools 2023–2024: The Annual Statistical Report on Schools, Enrollment and
    Staffing_ (Arlington, VA: NCEA, 2024), https://www.ncea.org/NCEA/NCEA/Who_We_Are/About_Catholic_Schools/Catholic_School_Data/Catholic_School_Data.aspx.

[^4]:
    Catholic Charities USA, _Pathways Forward: 2024 Annual Report_ (Alexandria, VA: Catholic Charities USA, 2025),
    https://www.catholiccharitiesusa.org/publications/2024-annual-report/.

[^5]:
    Paresh Dave, "Nvidia Reportedly Acquires Synthetic Data Startup Gretel," _TechCrunch_, March 19, 2025,
    https://techcrunch.com/2025/03/19/nvidia-reportedly-acquires-synthetic-data-startup-gretel/. NVIDIA declined official comment; no corporate press release has been issued.

[^6]:
    U.S. Department of Veterans Affairs, Veterans Health Administration, "Synthetic Data to Improve Veteran Care," VA News, December 2020,
    https://news.va.gov/81908/synthetic-data-improve-veteran-care/.

[^7]:
    United States Conference of Catholic Bishops, _Joint Letter on Artificial Intelligence Principles and Priorities_, June 9, 2025,
    https://www.usccb.org/resources/joint-letter-artificial-intelligence-principles-and-priorities.

[^8]:
    Latin American and Caribbean Episcopal Council (CELAM), _Inteligencia Artificial: Una mirada pastoral desde América Latina y el Caribe_ (Bogotá: CELAM, May 2025),
    https://adn.celam.org/celam-presenta-documento-inedito-sobre-inteligencia-artificial-una-mirada-pastoral-desde-america-latina-y-el-caribe/.
