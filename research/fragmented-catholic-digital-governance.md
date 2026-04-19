# Fragmented Catholic Digital Governance at Scale

|                   |                                                                                                                           |
| :---------------- | :------------------------------------------------------------------------------------------------------------------------ |
| **Document type** | Research memo                                                                                                             |
| **Status**        | Working draft — U.S.A. C-DART 1 discussion                                                                                |
| **Relationship**  | Supplementary research underlying [CDCF Project Vetting Criteria v0.2](../project-governance/project-vetting-criteria.md) |

---

## Table of Contents

1. [The Problem in One Sentence](#the-problem-in-one-sentence)
2. [Why Catholic Institutions Are Uniquely Exposed](#why-catholic-institutions-are-uniquely-exposed)
3. [What Fragmentation Looks Like in Practice](#what-fragmentation-looks-like-in-practice)
4. [Fragmentation Beyond AI: The Shared Digital Infrastructure of the Church](#fragmentation-beyond-ai-the-shared-digital-infrastructure-of-the-church)
5. [AI Governance Case Study: Three Dioceses Building in Isolation](#ai-governance-case-study-three-dioceses-building-in-isolation)
6. [The Acceleration Curve](#the-acceleration-curve)
7. [Subsidiarity Without Solidarity](#subsidiarity-without-solidarity)
8. [What a Shared Canonical Standard Provides](#what-a-shared-canonical-standard-provides)
9. [Relationship to the CDCF](#relationship-to-the-cdcf)
10. [Bibliography](#bibliography)

---

## The Problem in One Sentence

Catholic institutions serving tens of millions of people worldwide are digitizing, deploying technology, and building digital infrastructure independently, producing governance
regimes and data models that are incompatible with each other, cannot be jointly audited or exchanged, and will be structurally difficult to unify once entrenched vendor
relationships, diocesan contracts, and isolated implementations are in place.

---

## Why Catholic Institutions Are Uniquely Exposed

Catholic institutions occupy an unusual position in the technology governance landscape. They are simultaneously subject to civil regulation, diocesan canonical authority, and the
moral theology of the Magisterium. No secular institution faces that combination. A hospital system deploying an AI triage tool must satisfy HIPAA, the FDA's Software as a Medical
Device framework, its diocesan bishop's authority over pastoral matters, and Catholic Social Teaching's account of human dignity and the common good, all in a single deployment
decision. A developer building a liturgical calendar application must navigate the complexity of the Roman Rite across multiple editions, vernacular translations, proper calendars
for dioceses and religious orders, and the authoritative norms of the Congregation for Divine Worship — with no shared digital standard defining how any of those realities are
identified or represented in code.

This exposure operates across two distinct but related axes.

**Technology deployment.** The U.S. and China regulatory frameworks for AI are diverging in ways that compound institutional exposure. U.S. efforts emphasize system- and risk-based
regulation, while Chinese rules place relatively greater emphasis on content, security, and outputs.[^1] Catholic institutions operating internationally, and those receiving
federal funding domestically, face both frameworks without clarity on how to reconcile them with canonical requirements.

**Digital infrastructure.** The realities of Catholic life that technology must represent — the Liturgy, Sacred Scripture, the Magisterium, Canon Law, diocesan and parish
structures — belong to the universal Church. They are not local inventions. Yet the process of digitizing these realities has proceeded without coordination, producing dozens of
incompatible representations of the same shared patrimony. Every liturgical software project defines its own feast identifiers. Every Bible application references Scripture
editions differently. Every diocesan database uses its own parish numbering scheme. The fragmentation is not a failure of any individual project; it is the predictable consequence
of digitization proceeding without shared standards.

The result is that Catholic institutions are caught between competing regulatory logics for their technology deployments and incompatible data models for their shared digital
infrastructure, without a shared canonical protocol that could provide coherent guidance across either dimension.

---

## What Fragmentation Looks Like in Practice

### AI Tool Deployment

The fragmentation in AI governance is already producing concrete operational problems across the three primary institutional domains.

| Domain              | Scale                                      | Fragmentation Impact                                                                    |
| :------------------ | :----------------------------------------- | :-------------------------------------------------------------------------------------- |
| **Healthcare**      | CommonSpirit: 24 states, multiple dioceses | Same tool, same patients, same mission — blocked or reconfigured at every diocesan line |
| **Education**       | 5,905 Catholic schools nationally          | Vendors face dozens of incompatible standards or default to generic secular products    |
| **Social Services** | 168 Catholic Charities agencies            | Cannot share tools, compare outcomes, or build on each other's governance work          |

**Healthcare.** CommonSpirit Health operates in 24 states across multiple dioceses.[^2] A single AI-assisted triage or clinical decision support tool cannot be deployed uniformly
across that system because each diocese it operates in carries different consent requirements, different pastoral boundary definitions, and different data governance expectations
developed independently. The same tool, the same patients, the same mission, reconfigured or legally blocked every time it crosses a diocesan line.

**Education.** A vendor trying to serve all 5,905 Catholic schools in the United States[^3] faces dozens of incompatible responsible Catholic AI evaluation standards, each
developed by a different diocesan office operating without reference to the others. The vendor's options are to build bespoke configurations for every diocese, which is expensive
and unsustainable at scale, or to ignore Catholic-specific requirements entirely and deploy a generic secular product. The second outcome is precisely what Catholic governance
exists to prevent.

**Social services.** The 168 Catholic Charities agencies operating across the country[^4] cannot share AI tools, cannot compare program outcomes across jurisdictions, and cannot
build on each other's governance work, because the regulatory and canonical regimes they operate under are incompatible. An AI intake screening tool that passes muster in one
diocese may be blocked in a neighboring one under criteria that were never designed to be interoperable.

### Shared Digital Infrastructure

The same pattern of fragmentation is visible — and in some cases far more entrenched — in the digital representation of realities that belong to the universal Church.

| Domain                        | What Is Shared                                                      | What Is Fragmented                                                                  |
| :---------------------------- | :------------------------------------------------------------------ | :---------------------------------------------------------------------------------- |
| **Liturgy**                   | The Roman Rite, the General Roman Calendar, proper calendars        | Every app defines its own feast identifiers, calendar logic, and data structures    |
| **Sacred Scripture**          | The approved texts and editions of the Catholic Bible               | Every platform references editions, books, and verses in its own schema             |
| **Magisterial Documents**     | Encyclicals, apostolic constitutions, decrees of the Magisterium    | No shared digital identifiers for document types, issuers, or authority levels      |
| **Canonical Structures**      | Dioceses, parishes, religious institutes, ecclesial movements       | Every database uses its own numbering; no canonical digital directory exists         |
| **Sacramental Records**       | The Church's sacramental register system                            | Diocesan databases are mutually incompatible; no data exchange standard exists      |

These are not peripheral concerns. The Liturgy, the Bible, Canon Law, and the Magisterium constitute the shared patrimony of the universal Church. Their digitization is not
optional — it is already happening, in hundreds of independent projects worldwide. The question is whether that digitization proceeds under shared standards that preserve the
ecclesial unity of what is being represented, or whether the digital Church fragments into incompatible local implementations of universal realities.

---

## Fragmentation Beyond AI: The Shared Digital Infrastructure of the Church

The AI governance fragmentation documented above is urgent and visible, but it is a specific instance of a deeper structural problem. The realities of Catholic life that technology
must represent are shared across the entire Church. They require collaboration and coordination between Church institutions — assisted by specialized technologists — for the
processes of digitization, digital standardization, and distribution. When that collaboration does not exist, fragmentation is the inevitable result.

**Liturgical calendars.** Multiple independent implementations of the Roman Calendar exist (among them the LitCal API, RomCal, and ePrex), each defining its own identifiers for
liturgical celebrations, its own data structures for feast rankings and seasonal cycles, and its own approach to representing the proper calendars of dioceses and religious orders.
A parish using one liturgical software cannot exchange calendar data with a diocesan system built on another. The General Roman Calendar is universal; its digital representations
are not.

**Sacred Scripture editions.** The Catholic Church has approved numerous editions and translations of the Bible throughout its history, from the Vulgate through the Nova Vulgata to
dozens of vernacular translations. Every Catholic Bible application, every liturgical reading tool, and every catechetical platform that references Scripture has had to invent its
own way of identifying which edition it is working with. There is no shared registry of Catholic Bible editions, no standard identifier scheme, and no interoperability between
systems that reference the same texts.

**Magisterial documents.** The documents of the Magisterium — encyclicals, apostolic constitutions, motu proprii, conciliar decrees, dicastery instructions — are among the most
authoritative texts in Catholic life. Yet there is no shared digital scheme for identifying them by type, issuing authority, or magisterial weight. Every project that needs to
reference a Magisterial document must create its own classification from scratch.

**Canonical structures.** The Church's organizational structure — dioceses, eparchies, archdioceses, parishes, religious institutes, ecclesial movements — has no shared digital
directory with stable identifiers. Diocesan databases, national directories, and Vatican records each use their own numbering schemes. Historical entities that have been merged,
suppressed, or renamed compound the complexity. A researcher or developer seeking to build software that operates across diocesan boundaries has no canonical digital reference
point.

The common thread is that each of these domains represents a shared reality of the universal Church being digitized independently by dozens of actors, producing incompatible
representations that cannot interoperate. The governance problem is identical in structure to the AI fragmentation: subsidiarity without solidarity produces local solutions that
cannot serve the universal Church.

---

## AI Governance Case Study: Three Dioceses Building in Isolation

Three U.S. dioceses built formal AI governance structures between 2024 and 2026. Each represents a serious, good-faith effort. None was built with reference to the others, and the
three models are structurally incompatible.

| Diocese              | Year                  | Governance Model                                | Instrument                       |
| :------------------- | :-------------------- | :---------------------------------------------- | :------------------------------- |
| Diocese of Orange    | 2024                  | Standing council with quarterly review          | Living guidebook document        |
| Diocese of Biloxi    | Effective Jan 1, 2026 | Episcopal decree (binding canonical instrument) | Signed by Bishop Kihneman        |
| Diocese of Arlington | June 2025             | Educator-led working group                      | School-specific policy framework |

**Diocese of Orange (2024).**[^5] Established a standing Diocesan AI Council composed of the Vicar General, IT Director, HR, Communications, and parish pastors. The Council
maintains a living document guidebook and meets quarterly to review AI developments across diocesan operations, ministry, and education.

**Diocese of Biloxi (effective January 1, 2026).**[^6] Issued an Episcopal Decree signed by Bishop Kihneman, a binding canonical instrument applying to all clergy, religious, lay
employees, and volunteers across the diocese. This appears to be the first formal episcopal AI decree in the United States.

**Diocese of Arlington (June 2025).**[^7] Formed a 14-person working group of Catholic school educators who developed an AI policy framework distributed to Catholic schools across
the diocese, presented at a regional conference in August 2025.

Three governance models with no shared evaluation standards, no common definition of what constitutes a permissible AI application, and no coordination mechanism. A vendor
evaluated favorably under Orange's council process has no assurance of meeting Biloxi's episcopal requirements or Arlington's school-specific framework.

This case study illustrates the AI-specific instance of the broader pattern: when institutions with shared mission and shared canonical obligations build governance structures
independently, the result is incompatibility at the exact boundaries where interoperability matters most.

---

## The Acceleration Curve

The fragmentation problem is active and accelerating across both dimensions.

**AI deployment** in enterprise and institutional contexts moved from prototype to viral adoption in approximately 60 days in several documented cases in 2024 and 2025.[^8]
Catholic institutions are operating on a 12–18 month lag behind commercial deployment curves, which means the governance window is narrow and closing. Every month that passes
without a shared canonical governance process, another diocese builds something incompatible. Vendors begin designing products to the fragmented landscape rather than to a unified
Catholic standard. Contracts get signed. Systems get deployed. Technical debt accumulates.

**Digital infrastructure** fragmentation operates on a longer but equally consequential timeline. Every liturgical software project that launches with its own identifier scheme,
every diocesan database that defines its own parish numbering, every Bible application that invents its own edition references — each one deepens the fragmentation. Unlike AI
tools, which can be replaced, data models and identifier schemes become load-bearing infrastructure that downstream systems depend on. Migrating from a fragmented identifier
scheme to a shared standard is orders of magnitude more difficult than adopting a shared standard before the fragmented one takes root.

What begins as a coordination gap becomes a structural feature of Catholic digital governance that will require decades to unwind.

---

## Subsidiarity Without Solidarity

The fragmentation is the predictable outcome of subsidiarity operating without a solidarity layer, produced by good-faith institutional actors working independently rather than by
governance failure.

_Antiqua et Nova_ (§42) affirms that the responsibility for managing AI wisely "pertains to every level of society, guided by the principle of subsidiarity."[^9] Dioceses building
their own governance structures — whether for AI tools or for local technology projects — are doing exactly what subsidiarity asks them to do. The problem is that subsidiarity
without a shared canonical foundation produces incompatible local standards that cannot serve institutions like CommonSpirit or the Catholic Charities network, which operate across
diocesan lines, nor the universal Church, whose shared patrimony requires shared digital representations.

Catholic Social Teaching is precise on this point. _Mensuram Bonam_ articulates that subsidiarity is considerably more than simple delegation, which often allows larger bodies to
retain power and ultimate control. Authentic subsidiarity "distributes roles and power horizontally, creating mutual accountability from all levels towards the common good."[^10]
Fragmented diocesan governance models and incompatible digital implementations are therefore not simply a failure of coordination; they represent a failure to execute the horizontal
mutual accountability that subsidiarity itself requires. The CDCF is designed to fulfill that requirement: preserving local authority while establishing the mutual accountability
that isolated local action cannot provide.

The Magisterium has provided rich doctrinal grounding for why human dignity, moral agency, and genuine human control over technology matter (_Antiqua et Nova_ is precise and
substantial on these points).[^9] Operational protocols that translate those principles into shared canonical governance processes and shared digital standards remain to be
developed. A diocese receiving a vendor proposal for its schools or hospitals has principle-level guidance and no procedural framework for acting on it. A developer building
liturgical software has the texts of the Roman Rite and no shared digital standard for representing them.

The USCCB's joint letter on AI principles warns explicitly that automated decision-making systems used in employment screening, healthcare, public benefit screening, and related
domains "can reinforce existing biases or introduce a utilitarian approach devoid of necessary human considerations, with potentially devastating consequences."[^11] The letter
affirms the importance of ethical principles and reasonable policy, and it, too, stops short of a shared operational standard.

The gap between principle and protocol is the specific problem this research addresses. Subsidiarity requires that local institutions govern themselves. Solidarity requires that
they do so within a framework coherent enough to serve the universal Church. Shared vetting standards and shared digital standards preserve diocesan authority while providing the
solidarity layer that makes local authority coherent at scale.

---

## What a Shared Canonical Standard Provides

Shared standards — for technology governance and for the digital representation of Catholic realities — resolve the fragmentation problem at the points where it is most tractable.

**For technology deployment,** a shared vetting standard resolves fragmentation at the evaluation stage, before tools are deployed. Rather than requiring every diocese to develop
its own evaluation methodology from scratch, a shared standard provides a common baseline that any diocese can adopt, adapt for local context, and apply consistently. Vendors
evaluated against the shared standard have assurance of meeting Catholic institutional requirements across diocesan lines. Institutions operating across multiple dioceses,
including health systems, Catholic Charities networks, and school systems, can deploy tools under a single governance framework rather than reconfiguring for every jurisdiction.

**For shared digital infrastructure,** canonical data standards resolve fragmentation at the representation layer, before incompatible implementations become entrenched. A shared
identifier scheme for liturgical celebrations means that any liturgical software project can exchange data with any other. A shared registry of Catholic Bible editions means that
Scripture references are portable across applications. A shared digital directory of dioceses and parishes means that systems built in different jurisdictions can interoperate by
default. Each standard reduces the cost of building Catholic software, eliminates redundant effort, and ensures that the digital representation of the Church's shared patrimony
reflects the ecclesial unity of what it represents.

Both categories of standard also function as market safeguards. Pope Leo XIV has demanded that technology governance ensure technology "truly serves the common good, and is not
just used to accumulate wealth and power in the hands of a few."[^12] A fragmented landscape — whether of diocesan AI policies or of incompatible liturgical data models — is
precisely the condition that allows vendors to exploit incompatible standards, accumulating data and market position at the expense of local ministries. Shared canonical standards
close that opening.

_Antiqua et Nova_ further establishes that "greater autonomy heightens each person's responsibility across various aspects of communal life."[^9] Catholic institutions exercise
immense autonomy worldwide. That autonomy carries a correspondingly serious responsibility to demonstrate that their capacities are used in the service of others. Shared standards
are the operational proof that Catholic institutions recognize and act on that responsibility.

---

## Relationship to the CDCF

The research documented here provides the empirical foundation for two complementary CDCF programs.

**The [CDCF Project Vetting Criteria](../project-governance/project-vetting-criteria.md)** represent the operational response to technology deployment fragmentation. The eight
criteria, organized across two evaluation gates, establish a shared baseline for what "vetted" means for technology projects submitted to the Catholic Digital Commons Foundation.
The criteria are designed to be adoptable by any diocese, health system, or Catholic institution regardless of which local governance model they operate under, whether standing
council, episcopal decree, educator working group, or other.

**The [CDCF Standards program](../standards/overview.md)** represents the operational response to digital infrastructure fragmentation. By establishing shared, canonical
identifiers and data representations for the entities and realities of Catholic life — beginning with liturgical celebrations, Magisterial documents, and Roman Missal editions —
the standards program provides the solidarity layer that allows independent software projects to interoperate. Standards committees, composed of ecclesial authorities, academic
experts, Catholic university computer science departments, and practitioners, ensure that the digital representations faithfully reflect the Church's own understanding of its
structures, rites, and traditions.

Together, the vetting criteria and the standards program address the two dimensions of fragmentation documented in this memo: governance of the tools Catholic institutions deploy,
and interoperability of the digital infrastructure those tools operate on.

---

## Bibliography

[^1]:
    Oliver Guest and Kevin Wei, _Bridging the Artificial Intelligence Governance Gap: The United States' and China's Divergent Approaches to Governing General-Purpose Artificial
    Intelligence_, Perspective PE-A3703-1 (Santa Monica, CA: RAND Corporation, December 2024), https://www.rand.org/pubs/perspectives/PEA3703-1.html.

[^2]:
    CommonSpirit Health, _Audited Consolidated Financial Statements as of and for the Years Ended June 30, 2024 and 2023_ (Chicago: CommonSpirit Health, 2024),
    https://www.commonspirit.org/content/dam/shared/en/pdfs/investor-resources/2024-CommonSpirit-Health-Annual-Report.SECURED.pdf.

[^3]:
    National Catholic Educational Association, _United States Catholic Elementary and Secondary Schools 2023–2024: The Annual Statistical Report on Schools, Enrollment and
    Staffing_ (Arlington, VA: NCEA, 2024), https://www.ncea.org/NCEA/NCEA/Who_We_Are/About_Catholic_Schools/Catholic_School_Data/Catholic_School_Data.aspx.

[^4]:
    Catholic Charities USA, _Pathways Forward: 2024 Annual Report_ (Alexandria, VA: Catholic Charities USA, 2025),
    https://www.catholiccharitiesusa.org/publications/2024-annual-report/.

[^5]: Diocese of Orange, "Diocesan AI Council," Roman Catholic Diocese of Orange, 2024, https://www.rcbo.org/ministry/artificial-intelligence-ai-council/.

[^6]: Diocese of Biloxi, Episcopal Decree on Artificial Intelligence, signed by Bishop Louis F. Kihneman III, effective January 1, 2026, https://biloxidiocese.org/officials.

[^7]:
    "Catholic Schools Take Initiative in AI Challenge," _Catholic Herald_, June 2025,
    https://www.catholicherald.com/article/local/catholic-schools-take-initiative-in-ai-challenge/. The policy framework referenced was developed by a 14-person educator working
    group convened by the Diocese of Arlington and presented at a regional conference in August 2025.

[^8]:
    Ian Mitch, Matthew J. Malone, Karen Schwindt, Gregory Smith, Wesley Hurd, Henry Alexander Bradley, and James Gimbi, _Governance Approaches to Securing Frontier AI_, Research
    Report RR-A4159-1 (Santa Monica, CA: RAND Corporation, 2025), https://www.rand.org/pubs/research_reports/RRA4159-1.html.

[^9]:
    Dicastery for the Doctrine of the Faith and Dicastery for Culture and Education, _Antiqua et Nova: Note on the Relationship Between Artificial Intelligence and Human
    Intelligence_ (Vatican City: Dicastery for the Doctrine of the Faith, January 28, 2025),
    https://www.vatican.va/roman_curia/congregations/cfaith/documents/rc_ddf_doc_20250128_antiqua-et-nova_en.html.

[^10]:
    Pontifical Academy of Social Sciences, _Mensuram Bonam: Faith-Based Measures for Catholic Investors_ (Vatican City: Pontifical Academy of Social Sciences, 2022),
    https://www.vatican.va/roman_curia/pontifical_academies/acdscien/documents/mensuram-bonam_en.html.

[^11]:
    United States Conference of Catholic Bishops, _Joint Letter on Artificial Intelligence Principles and Priorities_, June 9, 2025,
    https://www.usccb.org/resources/joint-letter-artificial-intelligence-principles-and-priorities.

[^12]:
    Pope Leo XIV, "Message to Participants in the Builders AI Forum 2025," Vatican City, November 3, 2025,
    https://www.vatican.va/content/leo-xiv/en/messages/pont-messages/2025/documents/20251103-messaggio-builders-aiforum.html.
