# CDCF Foundation Governance Frameworks

[![Status](https://img.shields.io/badge/status-working%20draft-yellow?style=flat-square)](https://github.com/mj3b/governance-frameworks)
[![License](https://img.shields.io/badge/license-Apache%202.0-blue?style=flat-square)](./LICENSE)
[![Version](https://img.shields.io/badge/version-v0.1-lightgrey?style=flat-square)](https://github.com/CatholicOS/foundation-docs)
[![CDCF](https://img.shields.io/badge/foundation-Catholic%20Digital%20Commons-8B0000?style=flat-square)](https://catholicdigitalcommons.org)
[![Grounded in](https://img.shields.io/badge/grounded%20in-Catholic%20Tradition-gold?style=flat-square)](https://www.vatican.va)

> _"Before accepting a project as incubating, the CDCF must determine whether its scope meets the requirements for a CDCF Project — respectful of human dignity, conducive to human
> flourishing, and of potential service to the Church at a wide level."_
>
> — Father John Romano D'Orazio, Vice Chair and Lead Developer, CDCF

A working repository for governance documentation supporting the **Catholic Digital Commons Foundation (CDCF)** vetting and project management processes.

---

> 🏛️ **Catholic Digital Commons Foundation** · Serving the universal Church through open, governed, and mission-aligned technology infrastructure.

---

## What This Repository Is

This repository holds the policy frameworks, evaluation criteria, and research documentation that inform how the CDCF reviews, incubates, and graduates technology projects. It is
modeled on established foundation governance (such as the Apache Software Foundation) but is uniquely grounded in Catholic Social Teaching and Canon Law.

The documentation is organized into a unified project governance framework (with domain-specific extensions for AI integrated inline), supplementary research memos, and standards
for canonical data interoperability.

---

## Document Stack

### Project Governance

The core frameworks for any project seeking CDCF endorsement.

| Document                                                                        | Type       | Description                                                                                    |
| :------------------------------------------------------------------------------ | :--------- | :--------------------------------------------------------------------------------------------- |
| [project-vetting-criteria.md](./project-governance/project-vetting-criteria.md) | **Policy** | The foundational 8 criteria for any CDCF project, with AI domain extensions integrated inline. |
| [lifecycle.md](./project-governance/lifecycle.md)                               | Procedure  | Definition of the stages from proposal through incubation, graduation, and retirement.         |
| [committees.md](./project-governance/committees.md)                             | Structure  | Governance bodies: Board of Directors, TCSC, and PMCs.                                         |
| [project-types.md](./project-governance/project-types.md)                       | Policy     | Distinction between Foundation Projects and Community Projects.                                |
| [definitions.md](./project-governance/definitions.md)                           | Glossary   | Shared vocabulary for CDCF governance and vetting.                                             |

---

### Research

Supplementary research memos informing the design of the vetting criteria.

| Document                                                                                                        | Type          | Description                                                                                                          |
| :-------------------------------------------------------------------------------------------------------------- | :------------ | :------------------------------------------------------------------------------------------------------------------- |
| [fragmented-catholic-digital-governance.md](./research/fragmented-catholic-digital-governance.md)               | Research memo | The urgency of shared digital governance standards.                                                                  |
| [governance-as-code-catholic-technology.md](./research/governance-as-code-catholic-technology.md)               | Research memo | Machine-enforceable deployment governance architecture.                                                              |
| [trusted-data-infrastructure-catholic-ministry.md](./research/trusted-data-infrastructure-catholic-ministry.md) | Research memo | Trusted data infrastructure for Catholic ministry.                                                                   |
| [identifier-durability-opaque-canonical-iris.md](./research/identifier-durability-opaque-canonical-iris.md)     | Research memo | Position paper: opaque canonical IRIs with human-readable affordances — public comment on the CDCF URI-scheme draft. |

---

## The Two-Gate Framework

Every technology project submitted to the CDCF passes through two evaluation gates.

| Gate       | Stage                       | What It Evaluates                                                                                                                               |
| :--------- | :-------------------------- | :---------------------------------------------------------------------------------------------------------------------------------------------- |
| **Gate 1** | Incubation Acceptance       | Mission alignment · Human accountability architecture · Transparency · Validation · Impact on vulnerable populations · Governance specification |
| **Gate 2** | Graduation to Active Status | Documentation for independent deployment · Data stewardship · Maintenance and subsidiarity compatibility                                        |

---

### Standards

Shared standards enable Catholic software projects to be interoperable and rooted in Catholic tradition. Standards committees — composed of ecclesial authorities, academic experts,
Catholic university CS departments, and practitioners — define canonical identifiers and data representations for the realities of Catholic life.

| Document                                   | Type       | Description                                                                                              |
| :----------------------------------------- | :--------- | :------------------------------------------------------------------------------------------------------- |
| [overview.md](./standards/overview.md)     | **Policy** | Why standards matter, current and future standards, and the relationship between standards and projects. |
| [committees.md](./standards/committees.md) | Procedure  | Composition, formation, working process, and governance principles for standards committees.             |

#### Proposed standards (committees to be formed)

| Standard    | Repository                                                  | Domain                                            |
| :---------- | :---------------------------------------------------------- | :------------------------------------------------ |
| **CMDDR**   | [CatholicOS/cmddr](https://github.com/CatholicOS/cmddr)     | Canonical identifiers for Magisterial documents   |
| **CRMETDR** | [CatholicOS/crmetdr](https://github.com/CatholicOS/crmetdr) | Canonical identifiers for Roman Missal editions   |
| **CLEDR**   | [CatholicOS/cledr](https://github.com/CatholicOS/cledr)     | Canonical identifiers for liturgical celebrations |

---

## Magisterial Grounding

| Source                                                                                             | Issuing Body                                                                    | Year          |
| :------------------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------ | :------------ |
| _Antiqua et Nova: Note on the Relationship Between Artificial Intelligence and Human Intelligence_ | Dicastery for the Doctrine of the Faith and Dicastery for Culture and Education | January 2025  |
| _Joint Letter on Artificial Intelligence: Principles and Priorities_                               | United States Conference of Catholic Bishops                                    | June 2025     |
| Address on AI and Care for Our Common Home                                                         | Pope Leo XIV                                                                    | December 2025 |
| Address to the Builders AI Forum                                                                   | Pope Leo XIV                                                                    | November 2025 |
| _Rome Call for AI Ethics_                                                                          | Pontifical Academy of Life                                                      | 2020          |
| _Mensuram Bonam: Faith-Based Measures for Catholic Investors_                                      | Pontifical Academy of Social Sciences                                           | 2022          |
| Statement on the EU Artificial Intelligence Act                                                    | COMECE                                                                          | 2024          |
| _Inteligencia Artificial: Una mirada pastoral desde América Latina y el Caribe_                    | CELAM                                                                           | May 2025      |

---

## Status

All documents are working drafts under active development. Version numbers reflect public iteration. Contributions, challenges, and proposed revisions are welcome via pull request
or issue.

---

## Contributing

> 💡 **This repository is an open governance commons.** The standards here belong to the Catholic community. Every diocese, health system, school, and ministry that contributes
> makes them stronger.

Please open an issue before submitting a significant revision so the community can discuss the proposed change before it is incorporated.

---

<div align="center">

**Catholic Digital Commons Foundation**

[catholicdigitalcommons.org](https://catholicdigitalcommons.org) · [CatholicOS on GitHub](https://github.com/CatholicOS) · [Apache 2.0 License](./LICENSE)

_Serving the universal Church · Open by design · Governed by principle_

</div>
