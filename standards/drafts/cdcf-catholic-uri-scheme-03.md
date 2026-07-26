# CDCF DRAFT PROPOSAL — REVISION 03

## Catholic Digital Commons Foundation URI Scheme

`draft-cdcf-catholic-uri-scheme-03`

| | |
|---|---|
| **Document ID:** | `draft-cdcf-catholic-uri-scheme-03` |
| **Supersedes:** | `draft-cdcf-catholic-uri-scheme-02` |
| **Status:** | Draft Proposal — Public Comment |
| **Date:** | July 2026 |
| **Version:** | 0.4.0 |
| **Issuing Body:** | Catholic Digital Commons Foundation (CDCF) |
| **Comment Period:** | 60 days from date of publication |
| **License:** | CC-BY 4.0 International |
| **Repository:** | github.com/CatholicOS/cdcf-uri-scheme |
| **Relates to:** | `draft-cdcf-identifier-rationale-00`; `crmedr`, `cecdr`, `ciclsaldr` (CatholicOS sibling registries) |

---

## Revision History

This document supersedes `draft-cdcf-catholic-uri-scheme-02` (version 0.3.0). This is a **breaking-change release**: it introduces new required vocabulary and a new field shape on every resolution response. All changes introduced in this revision are marked **[REV-03]** and documented in **Appendix F (Change Rationale v0.4.0)**.

| Version | Date | Summary of Changes |
|---|---|---|
| 0.1.0 | June 2026 | Initial draft published for public comment. |
| 0.2.0 | June 2026 | Theological/canonical review: authority taxonomy corrected; relationship types added; licenseStatus field; authentic interpretations; documentType field; doctrinal development note; Eastern churches; papal disambiguation; 3 new open issues. |
| 0.3.0 | June 2026 | Software architecture review: ABNF grammar (Appendix D); cdcf:rel/ resolution defined; cdcf:book/ domain formalised; licenseStatus replaced with licenses object; response depth levels added (§5.6); @context specification added (§5.3); error response schema (§5.5); caching and resilience spec (§5.7–5.8); person path grammar fixed; issuer-slug unified to pope-{name}-{roman}; bulk resolution noted; change notification feed noted; duplicate documentType row removed; sub-spec versioning defined (§7.5). |
| **0.4.0** | **July 2026** | **Identifier-architecture review** (`draft-cdcf-identifier-rationale-00`): adopts the two-artifact model (ontology IRI + canonical notation) via a new `notations` field (§3.6, §5.9); opens `cdcf:concept/` to an opaque-IRI option (§4.5); replaces the closed `inst-type` enumeration with a small set of supertypes plus a `circumscriptionType` field (§4.7); formalizes cross-references to sibling CatholicOS registries `circ:`, `icl:`, `mr:` (§4.9); adds `cdcf:rel/exact-match` and `cdcf:rel/close-match` in place of blanket `owl:sameAs` (§4.8.2); formalizes `mr:` as a tenth `cdcf:` domain (Appendix D). |

> **Reviewer Note**
>
> Version 0.4.0 addresses four gaps identified in the identifier-architecture review: (1) the specification minted only one string per entity, conflating graph identity and public citation, where the recommendation is that CDCF carry both; (2) `cdcf:concept/` had no opacity option despite being the one domain where opacity is defensible; (3) `inst-type` was a closed enumeration that could not accommodate CECDR's or CICLSALDR's actual scope; (4) sibling CatholicOS registries (`crmedr`, `cecdr`, `ciclsaldr`) had minted their own prefixes with no declared relationship to `cdcf:`, in tension with the §7.5 sub-specification rule. Theological and canonical content, and all software-architecture content from 0.3.0 not listed above, are unchanged.

---

# Abstract

This document defines the cdcf: URI scheme — a system of stable, globally unique, dereferenceable identifiers for canonical Catholic entities including Scripture, Magisterial documents, Catechism paragraphs, Canon Law, theological concepts, saints, popes, ecclesiastical institutions, and — new in this revision — Roman Martyrology eulogies referenced from sibling registries.

The scheme is designed to serve as the foundational reference layer for interoperable Catholic digital infrastructure. It draws on established internet standards (URI syntax per RFC 3986, content negotiation per RFC 7231, Linked Data principles per W3C, ABNF grammar per RFC 5234, and SKOS/ADMS vocabulary for citation-layer identifiers per W3C) while respecting the theological authority structures of the Catholic Church.

This is a Draft Proposal published for public comment. The comment period closes 60 days from the date of publication.

# 1. Introduction

## 1.1 The Problem of Catholic Data Fragmentation

Catholic digital projects — Bible apps, catechetical platforms, canonical law databases, theological reasoning engines — currently lack any shared reference system. A magisterial document cited in one application cannot be reliably matched to the same document in another.

- Siloed digitization: each project independently digitizes the same texts, introducing independent errors that cannot be corrected centrally.
- Vendor lock-in: data held in proprietary formats cannot be consumed by other applications, placing governance of Church data outside Church institutions.

## 1.2 Purpose of This Specification

1. A canonical identifier for every major category of Catholic entity
2. A resolution protocol returning structured, machine-readable data on dereferencing
3. A formal path grammar ensuring machine-parseable, unambiguous identifiers
4. A governance model for identifier assignment and long-term stability

## 1.3 Design Principles

- Stability: once assigned, an identifier must never be reassigned or broken
- Readability: identifiers should be interpretable by humans without a lookup
- Dereferenceability: every identifier resolves to a structured data response
- Openness: the scheme is an open standard, not proprietary to any vendor
- Theological fidelity: metadata respects Catholic authority hierarchies as defined by the Magisterium
- Backwards compatibility: no published identifier may be invalidated by future revisions
- Machine-parseability: all identifier paths conform to the ABNF grammar in Appendix D

# 2. Terminology

The key words MUST, MUST NOT, REQUIRED, SHALL, SHOULD, RECOMMENDED, and OPTIONAL are to be interpreted per RFC 2119. ABNF notation is per RFC 5234.

| Term | Definition |
|---|---|
| Canonical Entity | A Catholic object of theological, juridical, or historical significance with a defined authoritative source |
| Canonical Identifier | A globally unique, stable URI assigned to a canonical entity under this specification |
| Ontology IRI | **[REV-03]** The `cdcf:` URI's role as a reasoner-facing, opaque-to-reasoners atom used for graph identity. See §3.6. |
| Canonical Notation | **[REV-03]** A typed citation string carried in the `notations` array, distinct from the ontology IRI, intended for human citation and interchange with sibling registries. See §3.6. |
| Dereferencing | The act of resolving a URI to its data resource via an HTTP request |
| Response Depth | A request parameter controlling how much related data is inlined in a resolution response (summary vs. full) |
| licenses object | A structured metadata object mapping each content field in a resolution response to its applicable licenseStatus value |
| Assent of Faith | The unconditional assent (assensus fidei) required for truths proposed as divinely revealed |
| Definitive Assent | The firm assent (assensus definitivus) required for truths definitively proposed but not explicitly revealed |
| Religious Submission | Obsequium religiosum — submission of intellect and will owed to authentic but non-definitive magisterial teaching (LG §25) |
| DS Number | Denzinger-Schönmetzer reference number — established scholarly ID for magisterial texts |
| OSIS Code | Open Scripture Information Standard book abbreviation, used for Scripture book references |
| Sui iuris Church | One of the 24 autonomous Catholic churches (1 Latin, 23 Eastern) in full communion with the Bishop of Rome |

# 3. URI Syntax and Structure

## 3.1 Base URI

The authoritative base URI for all cdcf: identifiers is:

> `https://id.catholiccommons.org/`

The prefix `cdcf:` is a shorthand notation. Example:

> `cdcf:verse/jn/3/16` → `https://id.catholiccommons.org/verse/jn/3/16`

## 3.2 General Structure

> `cdcf:{domain}/{path}`

Where `{domain}` is one of the **ten** defined domains (Section 4; nine as of 0.3.0, plus `mr` formalized in this revision — see §4.9 and Appendix D) and `{path}` conforms to the domain-specific ABNF production rules in Appendix D.

## 3.3 Syntax Rules

1. All characters MUST be lower-case ASCII
2. Words within a path segment MUST be separated by hyphens (-)
3. Path segments MUST be separated by forward slashes (/)
4. No trailing slashes
5. No query strings in canonical identifiers (query parameters are permitted on API endpoints, which are distinct from canonical identifiers)
6. No version numbers or dates in identifier paths, except where the date is intrinsic to the entity identity (e.g., authentic interpretations of canons are dated acts; martyrology eulogies are anchored to a calendar date per §4.9)
7. Identifiers MUST NOT exceed 256 characters
8. All identifier paths MUST conform to the ABNF grammar in Appendix D

## 3.4 Stability Guarantee

Any identifier published in a CDCF stable release MUST remain resolvable and MUST NOT be reassigned. Deprecated identifiers MUST return HTTP 301 with a Location header pointing to the successor. The successor MUST be a new URI. Both the original and successor identifiers MUST remain resolvable indefinitely.

## 3.5 Licenses Object

Every resolution response MUST include a licenses object. This replaces the scalar licenseStatus field present in version 0.2.0. A scalar field was insufficient for composite resources whose constituent parts carry different copyright statuses (e.g., a Latin text that is public domain alongside an English translation that is proprietary).

The licenses object maps each content-bearing field in the response to its applicable licenseStatus value. Fields not listed inherit the value of the root key ("*").

```json
"licenses": {
  "*": "public-domain",
  "text.en-RSVCE": "proprietary-licensed",
  "text.en-NABRE": "proprietary-licensed"
}
```

Permitted licenseStatus values:

| licenseStatus value | Meaning |
|---|---|
| public-domain | No copyright restrictions; free use and redistribution |
| cc-by | Creative Commons Attribution; attribution required |
| cc-by-nc | Creative Commons Attribution Non-Commercial |
| proprietary-licensed | CDCF holds a distribution licence; contact CDCF for terms |
| rights-holder-contact-required | No CDCF licence; contact the rights holder directly before redistribution |

CDCF does not claim to own content it does not hold rights to. The licenses object is informational, not a grant of rights.

## 3.6 The Two-Artifact Model [NEW — REV-03]

Every canonical entity under this specification has exactly **two** identifying artifacts, not one:

1. **The ontology IRI** — the `cdcf:` URI defined by the domain grammars in Appendix D. Its governing requirement is stability and opacity-to-reasoners. A reasoner or triple store MUST treat it as an atomic identifier and MUST NOT parse it to recover meaning, regardless of whether its characters happen to be human-legible.
2. **The canonical notation** — a typed string, carried in the resolution response's `notations` array (§5.9), intended for citation, hand-authoring, and interchange. A notation MAY equal the final path segment of the ontology IRI (the common case for "thing" domains — Scripture, Magisterium, Canon Law, Persons) or MAY be an entirely separate registry-native identifier (the case for sibling registries, §4.9).

This is not redundancy for its own sake. For domains where the two already coincide (verse, book, ccc, canon, magisterium, person), implementations MAY omit an explicit `notations` entry and treat the IRI's final segment as the default notation. The array becomes load-bearing only where the two genuinely diverge — `concept/` (§4.5) and sibling-registry entities (§4.9).

### 3.6.1 Non-Normative Note: Why Not `owl:sameAs` Everywhere

Mature identifier systems that separate graph identity from citation form (BCP 47's registry-plus-grammar model, Unicode's stability policy, Getty/VIAF's authority-record-plus-notation pattern) do not assert blanket identity between the two layers. A notation is not the IRI; a close external match is not an exact one. §4.8.2 and §4.9 define two relationship types — `cdcf:rel/exact-match` and `cdcf:rel/close-match` — that carry this distinction into the cross-reference graph, rather than relying on `owl:sameAs`, whose reasoner-merge semantics are inappropriate wherever two linked resources are similar but not strictly identical.

# 4. Identifier Domains

The cdcf: namespace is divided into ten domains as of this revision (nine as of 0.3.0, plus `mr`, formalized in §4.9). Domains revised or added in version 0.4.0 are marked **[REV-03]**; domains revised in 0.3.0 remain marked **[REV-02]** for historical continuity.

## 4.1 Scripture (cdcf:verse/) and Books (cdcf:book/)

Version 0.2.0 referenced cdcf:book/ in the resolution example but did not define it. Version 0.3.0 formally introduced cdcf:book/ as a sibling of cdcf:verse/ within the Scripture domain. A book identifier is the parent entity of all verse identifiers within that book.

### 4.1.1 Book Identifiers (cdcf:book/)

> `cdcf:book/{osis-book}`

| URI | Refers To / Description |
|---|---|
| cdcf:book/jn | The Gospel of John |
| cdcf:book/gen | Genesis |
| cdcf:book/ps | Psalms (Vulgate numbering as canonical) |
| cdcf:book/1macc | 1 Maccabees (deuterocanonical) |

### 4.1.2 Verse Identifiers (cdcf:verse/)

> `cdcf:verse/{osis-book}/{chapter}/{verse}`
> `cdcf:verse/{osis-book}/{chapter}/{start-verse}-{end-verse}` — verse range
> `cdcf:verse/{osis-book}/{chapter}` — whole chapter

| URI | Refers To / Description |
|---|---|
| cdcf:verse/jn/3/16 | John 3:16 |
| cdcf:verse/rom/8/28-30 | Romans 8:28–30 |
| cdcf:verse/ps/22 | Psalm 22 (Vulgate numbering, canonical) |
| cdcf:verse/mt/26/26-28 | Matthew 26:26–28 |

Note: Identifiers MUST use Vulgate Psalm numbering as canonical. The resolution response MUST include a psalmNumberingMap field with the Hebrew/Protestant equivalent where they differ. See Open Issue 1 (Section 10).

## 4.2 Magisterial Documents (cdcf:magisterium/)

> `cdcf:magisterium/{issuer-slug}/{document-slug}`
> `cdcf:magisterium/{issuer-slug}/{document-slug}/{section-type}/{section-id}`

Issuer slug convention: Version 0.2.0 used inconsistent conventions (e.g., leo13 in the magisterium domain vs. pope-leo-xiii in the person domain for the same pontiff). Version 0.3.0 unifies all papal slugs to the form pope-{name}-{roman-numeral} across both domains. A magisterialIssuedBy field in the resolution response carries the canonical cdcf:person/ identifier of the issuing authority, making the link machine-derivable.

| Domain | Issuer Slug Form | Example |
|---|---|---|
| cdcf:magisterium/ | pope-{name}-{roman} | cdcf:magisterium/pope-leo-xiii/rerum-novarum |
| cdcf:magisterium/ | pope-{name}-{roman} | cdcf:magisterium/pope-pius-ix/ineffabilis-deus |
| cdcf:magisterium/ | {council-slug} | cdcf:magisterium/trent/decree-justification |
| cdcf:magisterium/ | {dicastery-slug} | cdcf:magisterium/ddf/fiducia-supplicans |
| cdcf:person/ | pope-{name}-{roman} | cdcf:person/pope-leo-xiii |

### 4.2.1 Document Type Field

Every magisterial document resolution response MUST include a documentType field.

| documentType value | Latin Term | Description / Binding Weight |
|---|---|---|
| dogmatic-constitution | Constitutio dogmatica | Ecumenical council; defines doctrine or condemns error; assent of faith required |
| apostolic-constitution | Constitutio apostolica | Highest papal legislative act; used for dogma definition and major law |
| solemn-definition | Definitio sollemnis | Ex cathedra papal definition; highest authority; assent of faith required |
| encyclical | Litterae encyclicae | Circular letter on faith, morals, discipline; authentic magisterial teaching |
| apostolic-exhortation | Adhortatio apostolica | Post-synodal or devotional; pastoral; not definitional |
| declaration | Declaratio | Formal declaration clarifying doctrine or discipline |
| instruction | Instructio | Practical guidance for implementing magisterial teaching; dicastery-issued |
| council-decree | Decretum conciliare | Conciliar decree; weight depends on papal confirmation |
| response-authentic | Responsio authentica | Authentic interpretation by Dicastery for Legislative Texts; force of law |

### 4.2.2 Papal Approval Field

The resolution response MUST include a papalApproval field:

- ex-cathedra — solemn definition by the pope personally
- in-forma-specifica — papal approval incorporating the document as the pope's own act
- in-forma-communi — papal approval of the dicastery's competence but not the document's specific content
- dicastery-only — issued by a dicastery without explicit papal approval
- conciliar — promulgated by ecumenical council confirmed by the pope

> **Example: Fiducia Supplicans (2023)**
> `cdcf:magisterium/ddf/fiducia-supplicans`: documentType=declaration, papalApproval=in-forma-communi, authorityLevel=authentic-doctrine.

## 4.3 Catechism (cdcf:ccc/)

Resolution responses for CCC text MUST carry `licenses: { "text.*": "proprietary-licensed" }` as copyright in all modern translations is held by Libreria Editrice Vaticana and/or the relevant bishops' conference.

> `cdcf:ccc/{paragraph}`
> `cdcf:ccc/{start}-{end}`

| URI | Refers To / Description |
|---|---|
| cdcf:ccc/1324 | CCC §1324 — The Eucharist as source and summit |
| cdcf:ccc/891 | CCC §891 — Papal infallibility |
| cdcf:ccc/1730-1748 | CCC §§1730–1748 — Human freedom section |

## 4.4 Canon Law (cdcf:canon/)

> `cdcf:canon/{code}/{canon}`
> `cdcf:canon/{code}/{canon}/{para}`
> `cdcf:canon/{code}/{canon}/authentic-interpretation/{date}`

| URI | Refers To / Description |
|---|---|
| cdcf:canon/cic1983/1024 | CIC 1983, Canon 1024 |
| cdcf:canon/cic1983/844/1 | CIC 1983, Canon 844 §1 |
| cdcf:canon/cic1983/230/authentic-interpretation/1994-11-11 | Auth. interp. of Canon 230, 11 Nov 1994 |
| cdcf:canon/cceo/7 | CCEO, Canon 7 |
| cdcf:canon/cic1917/1023 | CIC 1917, Canon 1023 (historical) |

The ABNF grammar in Appendix D makes the three path forms unambiguous: a canon paragraph is always numeric; authentic-interpretation is a fixed keyword; dates follow ISO 8601. No heuristic parsing is required.

## 4.5 Theological Concepts (cdcf:concept/) [REVISED — REV-03]

> **Limitation: Doctrinal Development**
> This domain treats each concept as a single stable entity. Doctrinal concepts develop over time (cf. Newman, *Essay on the Development of Christian Doctrine*; Dei Verbum §8). The doctrinalHistory field (an ordered array of cdcf:magisterium/ references) surfaces this development without resolving the formal question of how to represent it. A dedicated doctrinal-development specification is planned.

Version 0.3.0 and earlier defined this domain as a plain mnemonic slug with no opacity option, despite the callout above acknowledging that concept boundaries are a live theological question rather than a settled fact — precisely the case in which opacity is defensible (cf. Gene Ontology/OBO Foundry precedent, and §3.6). Version 0.4.0 opens the grammar to accept **either** form:

> `cdcf:concept/{slug}` — mnemonic form (unchanged from 0.3.0)
> `cdcf:concept/{opaque-id}` — **[NEW]** opaque form, e.g. `cdcf:concept/C0000418`

New concept entries SHOULD mint an opaque primary IRI and carry the existing mnemonic form as a `skos:notation`-typed entry in `notations` (§5.9). Concepts already assigned a mnemonic IRI under 0.3.0 are **not** required to migrate (§1.3, backwards compatibility); the opaque form is available for new entries and RECOMMENDED wherever the committee expects the concept's boundary to be revised. A `supersededNotation` field MAY record a notation retired after a boundary revision.

| URI | Refers To / Description | Notation (§5.9) |
|---|---|---|
| cdcf:concept/C0000418 | Real change of substance in the Eucharist | transubstantiation |
| cdcf:concept/hypostatic-union | Union of divine and human natures in Christ (legacy mnemonic form) | — |
| cdcf:concept/purgatory | State of purification after death | — |
| cdcf:concept/natural-law | Moral law knowable by unaided reason | — |
| cdcf:concept/filioque | Procession of the Holy Spirit from Father and Son | — |
| cdcf:concept/original-sin | Sin of Adam and its transmission to all humanity | — |

Resolution response MUST include: canonical definition (from CCC or proximate magisterium), doctrinalHistory array, authorityLevel, notations array (§5.9), and suiIurisChurch where the concept has distinct elaboration in an Eastern tradition.

## 4.6 Persons (cdcf:person/)

Version 0.3.0 corrects the path grammar for works. The four-segment pattern in version 0.2.0 was broken by its own Summa Theologiae example, which required five segments. The path now uses a variable-depth segment for works.

> `cdcf:person/{person-slug}`
> `cdcf:person/{person-slug}/{work-slug}`
> `cdcf:person/{person-slug}/{work-slug}/{path-segment}+` — one or more sub-divisions

The `{path-segment}+` production allows arbitrary depth to accommodate works with three or more levels of internal structure (e.g., Summa Theologiae: part / question / article; Scriptum super Sententiis: book / distinction / question / article). See Appendix D for the ABNF production.

### 4.6.1 Papal Name Disambiguation

All papal identifiers MUST include an ordinal suffix, even for names held by only one pope, to guarantee forward stability.

| URI | Refers To / Description |
|---|---|
| cdcf:person/pope-francis-i | Pope Francis (Jorge Mario Bergoglio) |
| cdcf:person/pope-john-paul-ii | Pope John Paul II (Karol Wojtyła) |
| cdcf:person/pope-benedict-xvi | Pope Benedict XVI (Joseph Ratzinger) |
| cdcf:person/pope-leo-xiii | Pope Leo XIII (Vincenzo Gioacchino Pecci) |
| cdcf:person/thomas-aquinas | Thomas Aquinas |
| cdcf:person/thomas-aquinas/summa-theologiae | Summa Theologiae |
| cdcf:person/thomas-aquinas/summa-theologiae/iii/q75/a1 | ST III, Q.75, A.1 (variable-depth path) |

## 4.7 Institutions (cdcf:institution/) [REVISED — REV-03]

> `cdcf:institution/{supertype}/{slug}`

Version 0.3.0's `inst-type` was a closed seven-item enumeration (`diocese`, `conference`, `council`, `order`, `dicastery`, `seminary`, `eastern-church`) that could not represent CECDR's actual scope (eparchies, exarchates, territorial prelatures, apostolic vicariates, military and personal ordinariates, personal prelatures, missions sui iuris) or CICLSALDR's institute/family distinction. Version 0.4.0 replaces the closed enum with a small, stable set of **supertypes**, moving canon-law-specific detail into a response field rather than the URI path:

| Supertype | Covers | Subtype field |
|---|---|---|
| circumscription | Dioceses, archdioceses, eparchies, archeparchies, exarchates, territorial prelatures/abbacies, apostolic vicariates/prefectures/administrations, military and personal ordinariates, personal prelatures, missions sui iuris | `circumscriptionType` (open string, e.g. "diocese", "eparchy", "territorial-prelature") |
| institute | Individual institutes of consecrated life and societies of apostolic life | — |
| family | Religious-family groupings under Praenotanda n. 38 (e.g. the Franciscan family) | — |
| conference | Bishops' conferences | *(unchanged)* |
| council | Ecumenical and particular councils | *(unchanged)* |
| dicastery | Roman Curia dicasteries | *(unchanged)* |
| seminary | Seminaries | *(unchanged)* |
| eastern-church | Whole sui iuris Churches (distinct from individual eparchies, which fall under circumscription) | — |

The `order` supertype from 0.3.0 is retired in favor of the `institute`/`family` split. Existing `cdcf:institution/order/{slug}` identifiers continue to resolve per §1.3 (backwards compatibility); their responses carry a `successor` field pointing to the equivalent `cdcf:institution/institute/{slug}`.

Examples:

```
cdcf:institution/circumscription/us-boston          (circumscriptionType: "diocese")
cdcf:institution/circumscription/al-shkodre-pult     (circumscriptionType: "eparchy")
cdcf:institution/institute/ofmcap
cdcf:institution/family/franciscan
cdcf:institution/eastern-church/maronite             (unchanged — whole Church, not an eparchy)
```

Per §4.9, `us-boston`, `ofmcap`, and `franciscan` are the same slugs CECDR and CICLSALDR use in `circ:us-boston`, `icl:ofmcap`, and `icl:familia-franciscana` respectively (with the `familia-` prefix dropped, since the supertype segment already disambiguates institute from family).

### 4.7.1 Eastern Catholic Churches

The Catholic Church comprises 24 sui iuris churches. Each MUST be representable without privileging the Latin Church as the default. Eastern Church identifiers use the eastern-church supertype.

> `cdcf:institution/eastern-church/{slug}`

| URI | Refers To / Description |
|---|---|
| cdcf:institution/eastern-church/maronite | Maronite Catholic Church (Antiochene rite) |
| cdcf:institution/eastern-church/coptic-catholic | Coptic Catholic Church (Alexandrian rite) |
| cdcf:institution/eastern-church/melkite | Melkite Greek Catholic Church (Byzantine/Antiochene) |
| cdcf:institution/eastern-church/chaldean | Chaldean Catholic Church (East Syriac rite) |
| cdcf:institution/eastern-church/ukrainian-greek-catholic | Ukrainian Greek Catholic Church (Byzantine rite) |
| cdcf:institution/council/trent | Council of Trent (1545–1563) |
| cdcf:institution/dicastery/ddf | Dicastery for the Doctrine of the Faith |
| cdcf:institution/conference/usccb | United States Conference of Catholic Bishops |

## 4.8 Relationship Types (cdcf:rel/)

The cdcf:rel/ domain defines a controlled vocabulary of relationship types for cross-reference graph edges. This was introduced in version 0.2.0 but left the question of what dereferencing a cdcf:rel/ identifier returns unanswered. Version 0.3.0 resolved this; version 0.4.0 adds two relationship types for cross-registry alignment (§4.8.2, §4.9).

### 4.8.1 Resolution of cdcf:rel/ Identifiers

cdcf:rel/ identifiers are dereferenceable. When resolved, they return an OWL ObjectProperty declaration. The resolution response for `Accept: application/ld+json` is a JSON-LD `@type: owl:ObjectProperty` document. The response for `Accept: application/rdf+xml` returns the OWL declaration for import into an ontology. The response for `Accept: text/html` returns a human-readable description.

Example: `GET https://id.catholiccommons.org/rel/magisterial-proof-text` with `Accept: application/ld+json` returns:

```json
{
  "@context": {
    "owl": "http://www.w3.org/2002/07/owl#",
    "cdcf": "https://id.catholiccommons.org/"
  },
  "@id": "cdcf:rel/magisterial-proof-text",
  "@type": "owl:ObjectProperty",
  "rdfs:label": "magisterial proof text",
  "rdfs:comment": "The subject is cited by the Magisterium as a scriptural foundation for the object doctrine or concept.",
  "rdfs:domain": "cdcf:BibleVerse",
  "rdfs:range": "cdcf:Concept"
}
```

### 4.8.2 Relationship Type Vocabulary

| cdcf:rel/ value | OWL Domain | OWL Range | Description |
|---|---|---|---|
| magisterial-proof-text | BibleVerse | Concept | Cited by the Magisterium as scriptural foundation |
| patristic-interpretation | BibleVerse | Concept | Interpreted in this doctrinal sense by a Church Father |
| liturgical-use | BibleVerse | Concept | Used in liturgy expressing this doctrine |
| theological-argument | BibleVerse | Concept | Used in theological argument; not magisterial |
| typological-sense | BibleVerse | BibleVerse | OT type fulfilled in NT antitype |
| anagogical-sense | BibleVerse | Concept | Points toward eschatological realities |
| defines-concept | MagisterialDoc | Concept | Document formally defines this concept |
| supersedes | MagisterialDoc | MagisterialDoc | Later document formally abrogates earlier |
| interprets | MagisterialDoc | Canon | Authentic interpretation of a canon |
| contradicted-by | Any | Any | Scholarly annotation; not a doctrinal assertion |
| **exact-match** **[NEW — REV-03]** | Any | Any | Maps to `skos:exactMatch`. Strict identity between a `cdcf:` entity and an entity in a sibling or external registry. Use sparingly — see §3.6.1. |
| **close-match** **[NEW — REV-03]** | Any | Any | Maps to `skos:closeMatch`. Overlapping but non-identical referent (e.g. a GeoNames territorial point standing in for a diocese-as-institution). |

## 4.9 Sibling and External Registries [NEW — REV-03]

CatholicOS maintains sibling data repositories — CRMEDR (Roman Martyrology eulogies, `mr:`), CECDR (ecclesiastical circumscriptions, `circ:`), CICLSALDR (institutes of consecrated life, `icl:`) — that mint their own citation-layer prefixes for entities that also have `cdcf:` ontology IRIs. Version 0.4.0 formalizes their relationship to this specification:

- A sibling registry's identifier is carried as an entry in `notations` (§5.9), with `scheme` set to the registry's declared scheme URN (`cdcf:scheme/circ`, `cdcf:scheme/icl`, `cdcf:scheme/mr`).
- The sibling registry's own slug MUST be reused verbatim as the final path segment of the corresponding `cdcf:` IRI wherever one exists (e.g. `circ:us-boston` ↔ `cdcf:institution/circumscription/us-boston`). This is a MUST, not a convention: it is what makes the pairing machine-verifiable rather than merely coincidental.
- Cross-registry links that assert **strict identity** use `crossReferences` with `@type: "cdcf:rel/exact-match"` (§4.8.2). Links to **external, non-identical authority records** (Wikidata, GeoNames, VIAF) that model an overlapping but non-identical referent MUST use `@type: "cdcf:rel/close-match"` rather than an identity-asserting relation, to avoid the reasoner-merge hazard `owl:sameAs` creates between non-identical resources (§3.6.1). `cdcf:rel/exact-match` maps to `skos:exactMatch` in the JSON-LD `@context`; `cdcf:rel/close-match` maps to `skos:closeMatch`. Neither maps to `owl:sameAs`; a future sub-specification MAY define narrower conditions under which `owl:sameAs` is warranted.
- Sibling registries publishing under this section MUST declare a `compatibleWith` field in their own schema documents (§7.5, unchanged) naming the `cdcf-uri-scheme` version they target — `compatibleWith: "0.4.0"`.
- `mr:` is additionally formalized as a `cdcf:` domain in its own right (Appendix D §D.3, §D.5), including ABNF for the owner-segment composite form (`mr:cecdr/us-boston:0705-{slug}`, `mr:ciclsaldr/ofm:0824-{slug}`), previously prose-only in CRMEDR's documentation.

# 5. Resolution Protocol

## 5.1 HTTP Resolution

All cdcf: identifiers MUST be resolvable via HTTPS GET to the base URI. The resolution server MUST support content negotiation via the HTTP Accept header.

## 5.2 Content Negotiation

| Accept Header | Format | Use Case |
|---|---|---|
| text/html | HTML | Human-readable browser view |
| application/json | JSON | Application integration |
| application/ld+json | JSON-LD | Linked Data / semantic web |
| application/rdf+xml | RDF/XML | OWL ontology systems |
| text/turtle | Turtle RDF | SPARQL / triplestore import |

## 5.3 JSON-LD Context Specification

Version 0.2.0 referenced `https://id.catholiccommons.org/context/v1` in example responses without specifying the context document. Version 0.3.0 corrected this. Version 0.4.0 requires the context document to additionally declare the `skos:` and `adms:` prefixes used by the `notations` field (§5.9) and the two new relationship types (§4.8.2).

### 5.3.1 Context Document Requirements

- The context document at `https://id.catholiccommons.org/context/v1` MUST map all field names used in cdcf: resolution responses to their fully qualified IRIs
- The context document MUST be served with `Cache-Control: public, max-age=31536000, immutable` (one year; it is versioned and therefore stable)
- The context document MUST be embedded inline in resolution responses (the `@context` field MUST contain the expanded context object, not only the URL) when the request includes `Prefer: return=representation` or when the response is for a cdcf:rel/ identifier
- Context versions are immutable: v1 will never change. If a new field requires a different mapping, a v2 context MUST be published. Responses using v2 fields (including `notations`, `skos:exactMatch`, `skos:closeMatch`) MUST reference `context/v2` **[REV-03]**
- The context MUST declare the cdcf: prefix, all @type values, and all relationship predicates used in §4.8, and, as of v2, the `skos:` and `adms:` prefixes used in §5.9 **[REV-03]**

### 5.3.2 Context Availability

Consuming applications MUST NOT assume the context URL is always reachable at request time. Implementations SHOULD cache the context document locally. CDCF MUST publish the context document as a static file on its GitHub repository so that implementations can bundle it directly, eliminating the remote dependency.

## 5.4 Example Resolution Response

The following example shows the full response for `cdcf:verse/jn/6/53`, including the licenses object, inline `@context`, and typed relationship edges:

```json
{
  "@context": {
    "cdcf": "https://id.catholiccommons.org/",
    "owl": "http://www.w3.org/2002/07/owl#",
    "rdfs": "http://www.w3.org/2000/01/rdf-schema#"
  },
  "@id": "cdcf:verse/jn/6/53",
  "@type": "cdcf:BibleVerse",
  "book": "cdcf:book/jn",
  "chapter": 6, "verse": 53,
  "osisRef": "John.6.53",
  "licenses": {
    "*": "public-domain",
    "text.en-RSVCE": "proprietary-licensed",
    "text.en-NABRE": "proprietary-licensed"
  },
  "text": {
    "la-Vulgata": "Dixit ergo eis Iesus: Amen amen dico...",
    "en-DRC": "Then Jesus said to them: Amen, amen..."
  },
  "crossReferences": [
    { "@type": "cdcf:rel/magisterial-proof-text",
      "target": "cdcf:concept/real-presence",
      "citedIn": "cdcf:magisterium/trent/decree-eucharist/canon/1" },
    { "@type": "cdcf:rel/patristic-interpretation",
      "target": "cdcf:concept/real-presence",
      "citedIn": "cdcf:person/cyril-of-alexandria/commentary-on-john" }
  ]
}
```

See §5.9 for the `notations` field, illustrated there with a sibling-registry example.

## 5.5 HTTP Status Codes and Error Response Schema

Version 0.2.0 defined status codes only. Version 0.3.0 added a mandatory error response body schema for all 4xx responses.

| HTTP Code | Condition | Error Response Body Required |
|---|---|---|
| 200 | Success | Full resource representation |
| 301 | Deprecated; use Location header | `{ "error": "deprecated", "successor": "cdcf:...", "since": "YYYY-MM-DD" }` |
| 404 | Identifier not yet assigned | `{ "error": "not-found", "identifier": "...", "message": "...", "suggestion": null }` |
| 406 | Accept type not supported | `{ "error": "not-acceptable", "supported": [...] }` |
| 410 | Retired; no successor | `{ "error": "gone", "identifier": "...", "retiredOn": "YYYY-MM-DD" }` |

All error responses MUST be served with `Content-Type: application/json`. The message field in 404 responses SHOULD include human-readable detail (e.g., "Chapter 99 does not exist in the Gospel of John"). The suggestion field MAY carry an alternative identifier if a close match exists in the registry.

## 5.6 Response Depth

Version 0.2.0 did not define how much related data is inlined in responses. Response depth is controlled by the `Depth` request header (per the pattern of RFC 7240 Prefer header). Two depth levels are defined:

- `Depth: 0` (default) — summary: returns core metadata and identifier arrays only; no nested objects are inlined. `crossReferences` is an array of cdcf: URI strings.
- `Depth: 1` — full: returns core metadata with one level of related objects inlined. `crossReferences` is an array of objects with `@type`, `target`, and `citedIn` fields as shown in §5.4.

Depth values above 1 are reserved for future use. Implementations MUST treat unrecognised Depth values as `Depth: 0`. The default behaviour (no Depth header) is equivalent to `Depth: 0`.

> **Design Note: N+1 and Bulk Resolution**
> `Depth: 1` mitigates the most common N+1 request pattern. A bulk resolution endpoint (`POST /resolve` with an array of identifiers) is noted as a near-term implementation requirement and is planned for version 1.0.0 of the API specification. It is outside the scope of this identifier scheme document but is acknowledged here to prevent incompatible implementations.

## 5.7 Caching

The resolution server MUST set the following headers on all 200 responses for stable identifiers (those in a published CDCF release):

- `Cache-Control: public, max-age=31536000, immutable` — one year; stable identifiers do not change
- `ETag` — a hash of the response body, supporting conditional GET requests (If-None-Match)
- `Last-Modified` — the date of the last substantive change to the resource

Draft identifiers (identifiers in a draft release, not yet stable) MUST be served with `Cache-Control: public, max-age=86400` (one day).

## 5.8 Operational Resilience

The resolution server at `id.catholiccommons.org` is the single canonical hostname and MUST have a 99.9% monthly availability SLA. To meet this SLA and to provide geographic distribution, the following are REQUIRED by version 1.0.0:

1. At least two geographically distributed mirror servers hosting identical read-only replicas
2. A mirror discovery endpoint at `https://id.catholiccommons.org/.well-known/cdcf-mirrors` returning a JSON array of mirror base URIs
3. A change notification feed at `https://id.catholiccommons.org/changes` (Atom format, RFC 4287) publishing an entry for every identifier deprecation, addition, and correction
4. DNS records for `id.catholiccommons.org` MUST be protected with DNSSEC

Consuming applications SHOULD implement fallback logic: if the canonical hostname is unreachable, the application SHOULD attempt the first mirror from the most recently cached mirror list before failing. Because stable identifiers carry `max-age=31536000`, most production applications will serve responses from local cache without contacting the resolution server for most requests.

## 5.9 Notations Field [NEW — REV-03]

Every resolution response MUST include a `notations` array, per the two-artifact model of §3.6 (empty or containing only the IRI's own final segment where no divergent notation exists):

```json
"notations": [
  { "value": "transubstantiation", "scheme": "cdcf:mnemonic", "prefLabel": true }
]
```

- `value` — the notation string.
- `scheme` — a declared CDCF or sibling-registry scheme identifier (`cdcf:mnemonic` for a domain's own legacy slug form, or `cdcf:scheme/circ` / `cdcf:scheme/icl` / `cdcf:scheme/mr` for sibling registries, per §4.9).
- `prefLabel` — OPTIONAL boolean; true marks the notation as the preferred display form where more than one exists.

Example — `cdcf:institution/circumscription/us-boston` carrying its CECDR sibling notation:

```json
"notations": [
  { "value": "us-boston", "scheme": "cdcf:scheme/circ", "prefLabel": true }
]
```

# 6. Theological Authority Metadata

Unchanged from version 0.2.0. The three-level taxonomy follows the 1989 Profession of Faith and the 1998 CDF commentary.

> **Normative Sources**
> 1989 Profession of Faith (AAS 81, 1989, pp. 104-106); Ad Tuendam Fidem, John Paul II (1998); Commentary on Professio fidei, CDF/Card. Ratzinger (AAS 90, 1998, pp. 544-551); Donum Veritatis, CDF (1990); Lumen Gentium §25.

## 6.1 Three Levels of Assent

### Level 1 — Assent of Faith (credenda)

Truths contained in the Word of God and proposed by the Magisterium as divinely revealed. Require assent of theological faith. Binding under penalty of heresy if formally denied. Include both solemn definitions and truths proposed by the ordinary universal magisterium (LG §25). Both sub-types require the same assent of faith.

### Level 2 — Definitive Assent (tenenda)

Truths proposed definitively but not explicitly contained in divine revelation. Require definitive assent — firm and irrevocable but not an act of theological faith. Denial is error but not formal heresy.

### Level 3 — Religious Submission (sequenda)

Teachings of the authentic ordinary magisterium not proposed definitively. Require religious submission of intellect and will (obsequium religiosum). Largest category; includes most encyclicals and dicastery documents.

## 6.2 Authority Level Taxonomy

| cdcf:authority/ value | Assent Type | Notes |
|---|---|---|
| solemn-definition | Assent of faith | Ex cathedra papal definition; de fide definita |
| ordinary-universal | Assent of faith | Ordinary universal magisterium; de fide catholica; same assent as solemn-definition |
| definitive-doctrine | Definitive assent | Definitively tenenda; denial is error but not heresy |
| authentic-doctrine | Religious submission | Authentic ordinary magisterium; obsequium religiosum |
| pastoral-guidance | Respectful reception | Pastoral or prudential; no doctrinal definition |

# 7. Governance and Change Process

## 7.1 Identifier Assignment

New identifiers require: entity to be identified, proposed URI slug, justification for slug form, reference to at least one authoritative source, confirmation the identifier conforms to the ABNF grammar in Appendix D.

## 7.2 Change Process

1. Draft: proposal published on CDCF GitHub for public comment (minimum 30 days)
2. Last Call: final comment period (14 days) after revision
3. Published: ratified and versioned release

No change may invalidate a previously published stable identifier.

## 7.3 Theological and Canonical Review

Proposals touching doctrinal classifications, authority-level metadata, or concept definitions MUST receive review from at least one qualified theologian and one qualified canonist before entering Last Call.

## 7.4 Versioning

This specification follows semantic versioning (MAJOR.MINOR.PATCH). Version 1.0.0 will be declared when the specification has been implemented in at least two independent systems and has passed a 90-day stability review.

## 7.5 Sub-Specification Versioning

Future sub-specifications (particular law, Eastern liturgy, patristics, liturgical domain) will be published as separate documents under the naming convention:

> `draft-cdcf-{topic}-{nn}`

Examples: draft-cdcf-particular-law-00, draft-cdcf-eastern-liturgy-00, draft-cdcf-patristics-00. Sub-specifications MUST reference the main cdcf-uri-scheme version they are compatible with using a `compatibleWith` field in their header table. A sub-specification that introduces a new domain or modifies an existing domain's ABNF MUST be accompanied by a patch release of the main specification incorporating the grammar change. **[REV-03: CRMEDR, CECDR, and CICLSALDR are the first sibling registries to be brought into compliance with this section — see §4.9.]**

# 8. Security Considerations

- The resolution server MUST be served exclusively over HTTPS (TLS 1.2 minimum)
- The registry MUST be maintained under version control with a public audit log
- The resolution server MUST NOT accept write operations via the public endpoint
- Implementations MUST validate that responses originate from `id.catholiccommons.org` or a listed mirror
- DNS records MUST be protected with DNSSEC
- The JSON-LD context document MUST be served with Subresource Integrity (SRI) hashes published on the CDCF GitHub repository, so that implementations bundling the context locally can verify its integrity

# 9. Open Standards Alignment

- RFC 2119 — Requirement Levels
- RFC 3986 — URI Generic Syntax
- RFC 4287 — Atom Syndication Format (change notification feed)
- RFC 5234 — ABNF for Syntax Specifications
- RFC 7231 — HTTP/1.1 Semantics (content negotiation)
- RFC 7240 — Prefer Header for HTTP (response depth pattern)
- W3C JSON-LD 1.1 — resolution response format
- W3C OWL 2 — cdcf:rel/ property declarations
- **W3C SKOS — `skos:exactMatch` / `skos:closeMatch` cross-registry relationships (§4.8.2, §4.9) [NEW — REV-03]**
- ISO/IEC 21838-2 — Basic Formal Ontology (BFO)
- OSIS 2.1.1 — Scripture book codes

# 10. Open Issues for Public Comment

## Issues from Version 0.1.0 (unresolved)

1. Psalm numbering: Vulgate vs. Hebrew as primary? Should both be first-class?
2. Deuterocanonical books: Catholic canon as normative; Protestant versification as secondary mapping?
3. Amended magisterial documents: sub-identifiers or replacement documents for post-promulgation corrections?
4. Liturgical domain: dependencies requiring inclusion in version 1.0.0?
5. Multilingual slugs: should non-English document title forms be permitted?
6. Patristic works: is a dedicated patristics sub-specification needed?

## Issues from Version 0.2.0 (unresolved)

7. Dicastery approval: should a disputedApproval flag be included for papalApproval fields where the approval mode is contested?
8. Eastern theological concepts: separate identifiers for Eastern equivalents (theosis, epiclesis) or an easternEquivalents field on the Latin-rite identifier?
9. Particular law: cdcf:particular-law/ domain in version 1.0.0 or a standalone sub-specification?

## Issues from Version 0.3.0 (unresolved)

10. Bulk resolution API: the POST /resolve endpoint is noted in §5.6. Should its request/response schema be specified in this document or in a separate API specification?
11. Change notification scope: the Atom feed in §5.8 covers identifier changes. Should it also include changes to the cdcf:rel/ OWL declarations and the JSON-LD context? What is the feed retention policy?
12. ABNF stability: the grammar in Appendix D is normative. How should future domains that require new path patterns trigger a revision to the grammar? Should the ABNF be maintained in a separate machine-readable file in the repository?

## New Issues — Version 0.4.0 [REV-03]

13. `owl:sameAs` narrowing: §4.9 declines to map anything to `owl:sameAs` pending a future sub-specification defining narrower identity conditions. Should that sub-specification be drafted now, or should `owl:sameAs` simply remain unused indefinitely?
14. Notation scheme registry: `scheme` values in §5.9 (`cdcf:mnemonic`, `cdcf:scheme/circ`, etc.) are introduced ad hoc in this revision. Should CDCF maintain a formal, dereferenceable registry of notation scheme URNs, analogous to the IANA Language Subtag Registry?
15. `circumscriptionType` vocabulary: §4.7 leaves `circumscriptionType` an open string rather than a controlled vocabulary. Should it be closed to an enumerated list (diocese, archdiocese, eparchy, archeparchy, exarchate, territorial-prelature, territorial-abbacy, apostolic-vicariate, apostolic-prefecture, apostolic-administration, military-ordinariate, personal-ordinariate, personal-prelature, mission-sui-iuris), and if so, who maintains that list as new forms arise?
16. Retroactive concept migration: §4.5 does not require existing mnemonic concept IRIs to migrate to the opaque form. Should there be a threshold (e.g., a doctrinal-development sub-specification reaching Last Call) that triggers mandatory migration for a specific concept?

# 11. References

## 11.1 Normative References

- RFC 2119: Bradner, S. (1997)
- RFC 3986: URI Generic Syntax. Berners-Lee, T. et al. (2005)
- RFC 4287: Atom Syndication Format. Nottingham, M. & Sayre, R. (2005)
- RFC 5234: ABNF for Syntax Specifications. Crocker, D. & Overell, P. (2008)
- RFC 7231: HTTP/1.1 Semantics. Fielding, R. & Reschke, J. (2014)
- RFC 7240: Prefer Header for HTTP. Snell, J. (2014)
- W3C SKOS Reference. Miles, A. & Bechhofer, S. W3C Recommendation, 2009. **[NEW — REV-03]**
- Catechism of the Catholic Church, Second Edition (1997). Libreria Editrice Vaticana.
- Code of Canon Law (CIC 1983). Libreria Editrice Vaticana.
- Code of Canons of the Eastern Churches (CCEO 1990). Libreria Editrice Vaticana.
- ISO/IEC 21838-2:2021. Basic Formal Ontology (BFO).
- Ad Tuendam Fidem, John Paul II. AAS 90 (1998), pp. 457-461.
- Commentary on the Professio fidei, CDF/Card. Ratzinger. AAS 90 (1998), pp. 544-551.
- Donum Veritatis, CDF (1990). AAS 82, pp. 1550-1570.

## 11.2 Informative References

- Denzinger-Schönmetzer. Enchiridion Symbolorum. Freiburg: Herder, 1965.
- Newman, J.H. Essay on the Development of Christian Doctrine. London: Toovey, 1845.
- OSIS Specification v2.1.1. American Bible Society, 2014.
- W3C JSON-LD 1.1. Sporny, M. et al. W3C Recommendation, 2020.
- W3C OWL 2 Primer. Hitzler, P. et al. W3C Recommendation, 2012.
- BibleGet I/O API. Grasso, J. github.com/BibleGet-I-O.
- CatholicOS ontology-semantic-canon. D'Orazio, J. github.com/CatholicOS.
- CatholicOS crmedr, cecdr, ciclsaldr. github.com/CatholicOS. **[NEW — REV-03]**
- draft-cdcf-identifier-rationale-00. CDCF Identifier Architecture Committee. **[NEW — REV-03]**

# Appendix A. OSIS Book Code Reference (Selected)

| OSIS | Book | OSIS | Book | Canon |
|---|---|---|---|---|
| Gen | Genesis | Matt | Matthew | OT/NT |
| Exod | Exodus | Mark | Mark | OT/NT |
| Ps | Psalms | Luke | Luke | OT/NT |
| Prov | Proverbs | Jn | John | OT/NT |
| Isa | Isaiah | Rom | Romans | OT/NT |
| Dan | Daniel | 1Cor | 1 Corinthians | OT/NT |
| Tob | Tobit | Eph | Ephesians | Deuterocanon/NT |
| Sir | Sirach | Rev | Revelation | Deuterocanon/NT |
| 1Macc | 1 Maccabees | 2Macc | 2 Maccabees | Deuterocanon |

# Appendix B. Eastern Catholic Sui Iuris Churches (Complete List)

| cdcf: slug | Church | Rite / Tradition |
|---|---|---|
| eastern-church/maronite | Maronite Catholic Church | West Syriac (Antiochene) |
| eastern-church/melkite | Melkite Greek Catholic Church | Byzantine (Antiochene) |
| eastern-church/ukrainian-greek-catholic | Ukrainian Greek Catholic Church | Byzantine |
| eastern-church/chaldean | Chaldean Catholic Church | East Syriac |
| eastern-church/syro-malabar | Syro-Malabar Catholic Church | East Syriac |
| eastern-church/syriac-catholic | Syriac Catholic Church | West Syriac |
| eastern-church/coptic-catholic | Coptic Catholic Church | Alexandrian |
| eastern-church/ethiopian-catholic | Ethiopian Catholic Church | Alexandrian |
| eastern-church/armenian-catholic | Armenian Catholic Church | Armenian |
| eastern-church/ruthenian | Ruthenian Catholic Church | Byzantine |
| eastern-church/romanian-greek-catholic | Romanian Greek Catholic Church | Byzantine |
| eastern-church/melkite-jerusalem | Melkite (Jerusalem Patriarchate) | Byzantine |
| eastern-church/syro-malankara | Syro-Malankara Catholic Church | West Syriac |
| eastern-church/bulgarian-greek-catholic | Bulgarian Greek Catholic Church | Byzantine |

*Note: this list enumerates whole sui iuris Churches under the unchanged `eastern-church` supertype (§4.7). Individual eparchies and exarchates of these Churches are represented separately under `cdcf:institution/circumscription/` as of 0.4.0 — see §4.7.*

# Appendix C. Change Rationale (Version 0.2.0)

Carried forward from version 0.2.0 for continuity. See that document for full rationale on authority taxonomy, relationship types, licenseStatus, authentic interpretations, documentType, doctrinal development, Eastern churches, and papal disambiguation.

# Appendix D. Formal ABNF Grammar [REVISED — REV-03]

This appendix defines the normative ABNF grammar for all cdcf: identifier paths. All implementations MUST validate identifiers against these productions. The grammar follows RFC 5234 conventions. Productions changed or added in version 0.4.0 are marked **[REV-03]**.

> **Normative Status**
> This ABNF grammar is normative. Any cdcf: identifier that does not conform to these productions is invalid. Implementations MUST reject non-conforming identifiers. Future domains introduced by sub-specifications MUST extend this grammar via a patch release of this document.

## D.1 Core Productions

```
; Base character classes
ALPHA  = %x61-7A            ; a-z (lower-case only)
DIGIT  = %x30-39             ; 0-9
HYPHEN = %x2D                ; -
SLASH  = %x2F                ; /
COLON  = %x3A                ; :  [NEW — REV-03]

slug  = 1*(ALPHA / DIGIT / HYPHEN)   ; general-purpose slug
roman = 1*(%x69 / %x76 / %x78 / %x6C / %x63 / %x64 / %x6D)
        ; i v x l c d m (Roman numerals)

iso-date = 4DIGIT HYPHEN 2DIGIT HYPHEN 2DIGIT   ; YYYY-MM-DD
```

## D.2 Top-Level Production [REVISED — REV-03]

```
; A cdcf: identifier is a domain followed by a slash and a domain path
cdcf-id = domain SLASH domain-path

domain = "verse" / "book" / "magisterium" / "ccc" / "canon"
       / "concept" / "person" / "institution" / "rel"
       / "mr"                                          ; [NEW — REV-03]
```

## D.3 Domain Path Productions

```
; ── Scripture ────────────────────────────────────────────────────
domain-path =/ verse-path / book-path
book-path   = osis-book
verse-path  = osis-book SLASH chapter [SLASH verse-ref]
osis-book   = slug                     ; per OSIS 2.1.1 abbreviations
chapter     = 1*DIGIT
verse-ref   = 1*DIGIT [HYPHEN 1*DIGIT] ; single verse or range

; ── Magisterium ──────────────────────────────────────────────────
domain-path =/ magisterium-path
magisterium-path = issuer-slug SLASH doc-slug [SLASH section-type SLASH section-id]
issuer-slug  = slug     ; council, dicastery, or pope-{name}-{roman}
doc-slug     = slug
section-type = "chapter" / "canon" / "paragraph" / "article"
section-id   = 1*DIGIT

; ── Catechism ────────────────────────────────────────────────────
domain-path =/ ccc-path
ccc-path = para-num [HYPHEN para-num]
para-num = 1*DIGIT

; ── Canon Law ────────────────────────────────────────────────────
domain-path =/ canon-path
canon-path = code SLASH canon-num [SLASH canon-qualifier]
code = "cic1983" / "cic1917" / "cceo"
canon-num = 1*DIGIT
canon-qualifier = para-num                        ; paragraph number — always numeric
                / "authentic-interpretation" SLASH iso-date
                                                    ; fixed keyword + ISO date — unambiguous

; ── Theological Concepts ────────────────────────────────────────  [REVISED — REV-03]
domain-path  =/ concept-path
concept-path = slug / opaque-id
opaque-id    = "C" 1*7DIGIT
               ; e.g. C0000418. Slug form (legacy) and opaque form (new, RECOMMENDED
               ; for new entries) are both valid; see §4.5 and §3.6 for minting guidance.

; ── Persons ──────────────────────────────────────────────────────
domain-path =/ person-path
person-path  = person-slug [SLASH work-slug [SLASH 1*path-segment]]
person-slug  = slug
work-slug    = slug
path-segment = slug   ; one or more sub-division segments
; NOTE: 1*path-segment allows arbitrary depth for works with 3+ structural levels
; e.g., summa-theologiae/iii/q75/a1 = work / part / question / article

; ── Institutions ─────────────────────────────────────────────────  [REVISED — REV-03]
domain-path      =/ institution-path
institution-path = supertype SLASH slug

supertype = "circumscription" / "institute" / "family"
          / "conference" / "council" / "dicastery"
          / "seminary" / "eastern-church"
          / "order"     ; DEPRECATED — resolvable for backwards compatibility only;
                         ; MUST NOT be used for new identifiers (see §4.7)

; ── Relationship Types ───────────────────────────────────────────  [REVISED — REV-03]
domain-path =/ rel-path
rel-path = rel-slug
rel-slug = "magisterial-proof-text" / "patristic-interpretation"
         / "liturgical-use" / "theological-argument"
         / "typological-sense" / "anagogical-sense"
         / "defines-concept" / "supersedes" / "interprets"
         / "contradicted-by"
         / "exact-match" / "close-match"     ; [NEW — REV-03]
         ; cdcf:rel/exact-match → skos:exactMatch (strict identity; use sparingly, §3.6.1)
         ; cdcf:rel/close-match → skos:closeMatch (overlapping, non-identical referent)
```

## D.4 Grammar Validation Notes

- The canon-qualifier production makes `cdcf:canon/cic1983/844/1` (paragraph) and `cdcf:canon/cic1983/230/authentic-interpretation/1994-11-11` unambiguous: a paragraph qualifier is 1*DIGIT; an authentic interpretation begins with the fixed keyword "authentic-interpretation". No heuristic parsing is required.
- The person-path `1*path-segment` production allows Thomas Aquinas's Summa (three sub-levels: part/question/article) and other scholastic works of arbitrary structural depth, fixing the broken four-segment grammar of version 0.2.0.
- All slug productions are restricted to lower-case ASCII (ALPHA = %x61-7A). Upper-case characters are syntactically invalid in cdcf: identifiers.
- The iso-date production in canon-qualifier enforces ISO 8601 date format for authentic interpretations, ensuring consistent machine parsing across implementations.
- **[NEW — REV-03]** The concept-path opaque-id production and the institution-path supertype production are both additive: every identifier valid under 0.3.0's grammar remains valid under 0.4.0's. No published 0.3.0 identifier is invalidated by this revision, satisfying the backwards-compatibility principle of §1.3.
- **[NEW — REV-03]** The mr-path production (§D.5) is the first ABNF production for a sibling-registry domain under §7.5, and the reference for how future sibling registries should formalize their own grammars via patch release rather than prose description.

## D.5 Martyrology (cdcf:mr/) [NEW — REV-03, formalizes the `mr:` domain per §7.5]

```
domain-path =/ mr-path

mr-path = mr-owner-path / mr-universal-path

mr-universal-path = mmdd-date HYPHEN slug
                     ; e.g. mr:0731-ignatius-de-loyola

mr-owner-path = owner-registry SLASH owner-key COLON mmdd-date HYPHEN slug
                ; e.g. mr:cecdr/us-boston:0705-{slug}
                ; e.g. mr:ciclsaldr/ofm:0824-{slug}

owner-registry = "cecdr" / "ciclsaldr" / iso3166-alpha2
                 ; a bare ISO 3166-1 alpha-2 code denotes a national proprium
                 ; (no owner-key)

owner-key = slug   ; MUST equal the referenced entity's own registry slug
                    ; (the circ: or icl: slug, without that registry's prefix)

mmdd-date = 2DIGIT 2DIGIT
            ; month, day; "0229" permitted (leap-day identity decisions are
            ; per crmedr/docs/canonicalization-report.md)

iso3166-alpha2 = 2ALPHA   ; per ISO 3166-1 alpha-2
```

This production is normative for `mr:` as a `cdcf:`-recognized domain as of 0.4.0. CRMEDR (once it declares `compatibleWith: "0.4.0"`) is the reference implementation.

# Appendix E. Change Rationale (Version 0.3.0)

## E.1 ABNF Grammar Added (Appendix D)

Version 0.2.0 described path patterns in prose only. Prose descriptions are insufficient for implementation: different developers reading the same prose will produce different parsers, leading to identifier strings that are valid according to one implementation and invalid according to another. The ABNF grammar in Appendix D is the definitive machine-readable specification. It also resolves the canon-qualifier ambiguity (paragraph number vs. authentic-interpretation keyword) and the person path depth problem, both of which were defects in version 0.2.0.

## E.2 cdcf:rel/ Resolution Defined (§4.8.1)

Version 0.2.0 introduced cdcf:rel/ identifiers but did not specify what dereferencing them returns. This made them inconsistent with the dereferenceability principle in §1.3. Version 0.3.0 defines them as OWL ObjectProperty declarations, with domain and range typed to the appropriate cdcf: entity classes. This allows ontology systems to import the relationship vocabulary directly.

## E.3 Scalar licenseStatus Replaced with licenses Object (§3.5)

A single scalar field cannot represent the copyright status of composite resources, where a Latin text may be public domain but its English translation is proprietary. The licenses object maps each content field independently, with a wildcard (*) for fields not explicitly listed. This is backward-compatible in principle: a resource where all fields share the same status uses only the wildcard key.

## E.4 Response Depth Added (§5.6)

Without a defined response depth mechanism, implementations will diverge on how much related data to inline. This creates incompatibility between clients and servers built from the same specification. The Depth header follows the established pattern of RFC 7240 and provides the minimum necessary control (summary vs. full) without requiring a full query language at this stage.

## E.5 @context Specification Added (§5.3)

The JSON-LD @context URL is a load-bearing dependency: without a reachable and stable context document, JSON-LD responses become uninterpretable. Version 0.3.0 specifies the context document's requirements, its immutability guarantee, its caching headers, and the requirement that it be publishable as a bundleable static file. This eliminates the runtime dependency for implementations that bundle the context locally.

## E.6 Error Response Schema Added (§5.5)

Status codes alone do not give consuming applications enough information to handle errors gracefully. A 404 for an unassigned identifier is different from a 404 for a malformed path; a 301 with no body requires an additional GET to discover the successor. The error schema defined in §5.5 is minimal but sufficient for all defined error conditions.

## E.7 Caching and Resilience Specification Added (§5.7, §5.8)

The resolution server is the single point of failure for the entire infrastructure. Without defined caching headers, consuming applications will generate unnecessary traffic and be vulnerable to outages. The one-year max-age for stable identifiers means the vast majority of production traffic will be served from cache. The mirror discovery endpoint and Atom change feed are designed to be implementable with static file hosting and a simple feed generator, not requiring complex infrastructure.

## E.8 Issuer Slug Unified (§4.2)

Version 0.2.0 used different slug conventions for the same pope in the magisterium domain (leo13) versus the person domain (pope-leo-xiii). A consuming application could not link a document to its author without an external mapping table. Version 0.3.0 unifies to pope-{name}-{roman} across both domains. The magisterialIssuedBy field in magisterial document responses carries the canonical cdcf:person/ identifier, making the link machine-derivable.

## E.9 Duplicate documentType Row Removed (§4.2.1)

The version 0.2.0 documentType table contained two rows with the value dogmatic-constitution. A controlled vocabulary with duplicate keys is invalid for use in schema validators. The duplicate was a copy-paste error; it has been removed. The correct entry (Constitutio dogmatica — ecumenical council constitution) is retained.

## E.10 Sub-Specification Versioning Defined (§7.5)

Version 0.2.0 referenced future sub-specifications without defining how they would be named, versioned, or related to the main specification. This risked fragmentation. Section 7.5 defines the naming convention (draft-cdcf-{topic}-{nn}), the compatibleWith field, and the requirement that grammar-modifying sub-specifications trigger a patch release of the main document.

# Appendix F. Change Rationale (Version 0.4.0) [NEW — REV-03]

## F.1 Two-Artifact Model Adopted (§3.6, §5.9)

Version 0.3.0 minted a single string per entity, requiring it to serve simultaneously as reasoner-facing graph identity and human-facing citation. The identifier-architecture review (`draft-cdcf-identifier-rationale-00`) demonstrated these are independent requirements that mature standards (BCP 47, Unicode, Getty/VIAF) satisfy with two coordinated artifacts rather than one. Version 0.4.0 adds the `notations` field so both jobs can be served without forcing every domain to choose one style globally.

## F.2 Concept Opacity Option Added (§4.5)

`cdcf:concept/` was the one domain 0.3.0 left fully transparent despite its own "Limitation: Doctrinal Development" note acknowledging that concept boundaries are a live theological question, unlike the settled "things" domains. This is precisely the case the identifier rationale identifies as where opacity is defensible (cf. Gene Ontology/OBO Foundry precedent). The grammar now accepts an opaque form without breaking any existing mnemonic identifier.

## F.3 Institution Supertypes Replace Closed Enum (§4.7, Appendix D §D.4)

The 0.3.0 `inst-type` enumeration could not represent CECDR's actual scope (eparchies, exarchates, territorial prelatures, apostolic vicariates, ordinariates, personal prelatures, missions sui iuris) or CICLSALDR's institute/family distinction, both of which are load-bearing for Praenotanda n. 38 proprium ownership. Rather than re-enumerating an ever-growing list of canonical forms in ABNF, the path grammar now carries a small set of stable supertypes, with canon-law-specific detail moved to a response field (`circumscriptionType`) that can grow without a further grammar patch.

## F.4 Sibling Registry Cross-References Formalized (§4.9, Appendix D §D.5)

CRMEDR, CECDR, and CICLSALDR had each minted an independent top-level prefix (`mr:`, `circ:`, `icl:`) with no declared relationship to `cdcf:`, in tension with §7.5's requirement that any sub-specification introducing a new domain be accompanied by a patch release of the main specification. Version 0.4.0 brings all three into compliance: `circ:` and `icl:` are formalized as notation schemes attached to `cdcf:institution/circumscription/` and `cdcf:institution/institute|family/` respectively (§4.9), and `mr:` is formalized as a `cdcf:` domain in its own right (Appendix D §D.5), including ABNF for the previously prose-only owner-segment composite form.

## F.5 `cdcf:rel/exact-match` and `close-match` Added, in Place of Blanket `owl:sameAs` (§4.8.2, §4.9)

The identifier rationale's own recommendation used `owl:sameAs` and `skos:exactMatch` somewhat interchangeably. `owl:sameAs` asserts unqualified logical identity and causes reasoners to merge all properties of both resources — a known hazard when the linked resources are close but not identical (e.g. a GeoNames territorial point standing in for a diocese-as-institution). Version 0.4.0 introduces two relationship types mapped respectively to `skos:exactMatch` and `skos:closeMatch`, and does not map anything to `owl:sameAs`; a narrower future sub-specification may reintroduce it under conditions where full identity is actually warranted.

*— End of Draft 0.4.0 —*
