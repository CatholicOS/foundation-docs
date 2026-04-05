# CDCF Standards: Overview

## Why standards matter

Catholic institutions worldwide develop software to serve the Church's mission — liturgical calendars, parish management systems, catechetical platforms, sacramental record-keeping tools, and much more. In the absence of shared standards, these projects operate in isolation: they define their own identifiers, structure their own data models, and make their own assumptions about how to represent the realities of Catholic life in code.

The result is fragmentation. A liturgical calendar app cannot exchange data with a parish management system. A diocesan database uses one set of identifiers for its parishes while a national directory uses another. The Roman Missal editions are referenced differently across every project that needs them.

**Standards solve this.** By establishing shared, canonical identifiers and data representations for the entities and realities of Catholic life, the CDCF enables:

- **Interoperability.** Catholic software projects can exchange data and work together, regardless of who built them or where they are deployed.
- **Quality assurance.** Adherence to CDCF standards signals that a project is rooted in Catholic tradition and has engaged seriously with the ecclesial realities it represents.
- **Reduced duplication.** Developers can build on a shared foundation rather than reinventing the same data models in isolation.
- **Ecclesial accuracy.** Standards developed with the participation of theologians, liturgists, canonists, and Church institutions ensure that software faithfully represents the Church's own understanding of its structures, rites, and traditions.

---

## Proposed standards

The CDCF has begun proposing standards in areas where the need for interoperability is most immediate. The following are **initial proposals** — preliminary work intended to seed the conversation and provide a starting point. Each proposal will require the formation of a dedicated [standards committee](./committees.md) to review, refine, and formally develop the standard through the full committee process.

| Standard | Repository | Status | Description |
|:---|:---|:---|:---|
| **CMDDR** — Common Magisterial Document Data Repository | [CatholicOS/cmddr](https://github.com/CatholicOS/cmddr) | Proposed | Canonical identifiers and classification for Magisterial documents of the Catholic Church (encyclicals, apostolic constitutions, motu proprii, etc.), including document type taxonomy, issuer identification, and magisterial authority level. |
| **CRMETDR** — Common Roman Missal Editio Typica Data Repository | [CatholicOS/crmetdr](https://github.com/CatholicOS/crmetdr) | Proposed | Canonical identifiers for every published edition of the Latin Roman Missal, from the first *Missale Romanum* of 1474 through the 2008 reimpressio emendata, including a scheme for identifying vernacular translations. |
| **CLEDR** — Common Liturgical Events Data Repository | [CatholicOS/cledr](https://github.com/CatholicOS/cledr) | Proposed | Canonical identifiers for liturgical celebrations (solemnities, feasts, memorials, etc.) in the Temporale and Sanctorale cycles, with cross-mappings to existing implementations (LitCal API, RomCal, ePrex). |

> **Note:** These repositories represent proposed work, not completed standards. No standards committee has yet been formed for any of these proposals. The repositories serve as a starting point for discussion and as an invitation for the Catholic community to participate in their development through the formal committee process.

---

## Future standards

The scope of standardisation needed is vast. The following are areas where the CDCF anticipates standards will be necessary, though work has not yet formally begun:

- **Dioceses and eparchies.** Standardised identifiers for all Catholic dioceses, eparchies, archdioceses, and other particular churches worldwide, including historical entities that have been merged, suppressed, or renamed.
- **Roman Martyrology entries.** Standardised identifiers for the entries of the *Martyrologium Romanum*, enabling interoperability among liturgical software, hagiographic databases, and catechetical platforms.
- **Roman Pontiffs.** Standardised identifiers for all Bishops of Rome, supporting historical research, document attribution, and liturgical references.
- **Catholic Bible editions.** Standardised identifiers for all Catholic editions of Sacred Scripture that have been published throughout history, including the *Vulgate*, the *Nova Vulgata*, and the many approved vernacular translations.
- **Liturgical texts and translations.** Standardised representations of approved liturgical texts across languages and rites.
- **Canonical structures.** Standardised identifiers for parishes, religious institutes, ecclesial movements, and other canonical entities.

Each of these areas will require its own standards committee with appropriate domain expertise. The list above is illustrative, not exhaustive — the Catholic community is invited to propose additional areas where standardisation would serve the common good.

---

## Relationship to CDCF project governance

CDCF standards and CDCF projects are distinct but complementary:

- **Standards** define shared data models, identifiers, and representations. They are reference specifications, not software.
- **Projects** are software implementations that may adopt and implement CDCF standards.

A project's adherence to relevant CDCF standards may be considered as part of the [vetting criteria](../project-governance/project-vetting-criteria.md) for Foundation Project status, particularly under Criterion 3 (Transparency of Scope and Operation) and Criterion 8 (Governance, Maintenance, and Subsidiarity Compatibility).
