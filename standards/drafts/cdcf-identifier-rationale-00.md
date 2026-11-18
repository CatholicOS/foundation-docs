# Ontology IRIs and Canonical Identifiers
## A Design Rationale for CDCF Datasets

| Field | Value |
|---|---|
| Document ID | `draft-cdcf-identifier-rationale-00` |
| Status | Committee discussion paper |
| Purpose | Align the committee on *why* CDCF mints both ontology IRIs and canonical IDs, and *when* each should be opaque or transparent |
| Relates to | `draft-cdcf-catholic-uri-scheme-02`; `draft-cdcf-liturgical-events-00` |
| License | CC-BY 4.0 |

---

## 1. Purpose

A live disagreement in the committee runs roughly: *opaque, flat, randomly-generated IRIs are sufficient and would end all argument about how to form identifiers.* A competing position holds that mnemonic identifiers (`en-US`, not `uni:/x/Q7f2a9`) are the right middle ground between human and machine consumption.

This paper argues that the disagreement is real but has been conducted on the wrong axis. "Opaque vs mnemonic" is not one decision; it is several independent decisions that have been collapsed into one. Once separated, most of the apparent conflict dissolves, and the residue resolves cleanly along the distinction between **things** (Popes, published Missals, canonically-erected dioceses) and **concepts** (theological notions whose boundaries develop). The recommendation is not to choose opaque *or* transparent globally, but to mint **both an ontology IRI and a canonical ID per entity**, and to decide transparency **per dataset** using criteria this paper sets out.

---

## 2. The Debate Conflates Four Orthogonal Axes

An identifier design involves at least four independent choices. They are genuinely independent: fixing one does not fix the others.

| Axis | Question | Poles | Governs |
|---|---|---|---|
| **A — Grammar** | Is the string's shape formally specified? | ABNF-validated ↔ ad hoc | Well-formedness checking |
| **B — Transparency** | Does the string carry human-legible meaning? | Transparent/mnemonic ↔ opaque | Human & tooling ergonomics |
| **C — Structure** | Does the string encode hierarchy? | Hierarchical/path ↔ flat | Namespacing, enumeration |
| **D — Consumption** | Do machines parse the string to recover meaning? | Parsed ↔ opaque-to-reasoners | Coupling, correctness |

The proposal that identifiers be flat, opaque, and randomly generated is a specific point in this space: opaque on B, flat on C, and — implicitly — it assumes that opacity on B is *required* to get correctness on D. That last inference is the crux, and it is mistaken. The opaque-identifier analysis raised in the discussion correctly observes that a UUID is *both* flat (C) and opaque (B), and that the two are independent. It is right about that independence, and the same independence extends to all four axes:

- **A is orthogonal to everything.** `id = "Q" 1*DIGIT` is a perfectly good ABNF grammar for opaque Wikidata-style IDs. Adopting ABNF does not commit you to transparency, and choosing opacity does not free you from needing a grammar. **You want a grammar either way.** So the ABNF work in the URI-scheme draft is not in tension with the opaque-ID proposal at all — it applies to it.
- **B is orthogonal to D.** This is the decisive point. In RDF/OWL an IRI is a *rigid designator*: a reasoner must treat it as an opaque atom and must not parse it to recover meaning. That is a real and correct discipline. But "reasoners treat IRIs as opaque" (a rule about D, *consumption*) does not entail "IRIs must be randomly generated" (a rule about B, *minting*). `en-US` is a rigid designator that a reasoner treats as opaque *and* a human reads at a glance. The two facts coexist without contradiction. Transparency is an affordance for the humans and tooling that *handle* the string; opacity-to-reasoners is a discipline for the software that *reasons over* it. **You get both at once.**

Those who hold that the identifiers should be opaque are therefore right about D — and are using that correctness to argue for B, where it does not reach.

---

## 3. Two Artifacts, Two Jobs — and Why the "Opaque Is Best Practice" Advice Answers a Different Question

CDCF is not minting one identifier per entity. It is minting two artifacts that do two different jobs:

1. **The ontology IRI** — the entity's identity *inside the graph*, consumed by reasoners. Its governing requirement is stability and opacity-to-reasoners (axis D). Whether its characters are legible (axis B) is, to the reasoner, irrelevant.
2. **The canonical ID** — the string that appears *in the wild*: in a footnote, a citation, a URL, an MCP tool argument, a content author's markup, a config file. Its governing requirement is that a human and ordinary tooling can read, write, quote, and verify it without a lookup round-trip.

The circulated case for opacity is sound — **for the job it is describing, which is application-internal database keys.** Its three rationales are worth taking at face value and then locating precisely:

- *"Security & privacy: users cannot enumerate or guess other IDs."* This is a virtue for private application data (customer records, session tokens). For a **public reference standard it is inverted**: CDCF *wants* its identifiers to be discoverable, guessable, and enumerable. `cdcf:verse/jn/3/16` being predictable from `cdcf:verse/jn/3/17` is the entire point of a citation scheme. Un-guessability is an anti-feature here.
- *"Decoupling: an ID with `NY` baked in breaks when the customer moves to `CA`."* This is the drift argument, and it is real (§7). But it is a claim about volatile *business state*, not about identity. A Pope who has reigned does not "move to CA."
- *"Database flexibility: flat opaque keys let you reorganize storage without migrating IDs."* A storage-layer concern. CDCF's canonical IDs are not storage keys; they are public citations whose whole value is that they *don't* change under reorganization.

So that case is not wrong; it is answering "how should I key rows in my application's database?" — where flat + opaque is indeed best practice. CDCF's question is "how should the world cite a Catholic entity for the next century?" These have different, in places opposite, force profiles. Conflating them is the single most common error in identifier debates.

Crucially, the two artifacts are **not a dilemma**. The Semantic Web already provides the vocabulary to carry both on one entity (§8): an opaque-if-you-like IRI for identity, plus a transparent canonical ID attached as a typed `skos:notation`, plus `owl:sameAs` links outward. Choosing one does not cost you the other.

---

## 4. What the Field Actually Does

The abstract argument can run forever. The empirical record is clearer: mature ontologies and standards have already made these choices at scale, and they did **not** converge on one answer. They converged on a *rule* for choosing.

### 4.1 Real ontologies

| System | IRI style | Why |
|---|---|---|
| **Wikidata** | Opaque (`wd:Q42` = Douglas Adams; `wdt:P31` = "instance of") | A queried database with a search UI; IDs are supplied by tooling, never hand-typed. Its own users pay for this daily: raw SPARQL/dumps are unreadable without constant label lookups. |
| **Gene Ontology / OBO Foundry** | Opaque numeric (`GO:0008150` = biological_process) | **Deliberate policy.** Biological categories are reclassified, merged, and split as science advances; semantics-free IDs immunize the identifier against that churn. |
| **Getty (TGN/ULAN/AAT), VIAF, GeoNames** | Opaque numeric with rich labels | Authority files behind resolvers; used for reconciliation, not citation. |
| **Schema.org** | Transparent (`schema:Person`, `schema:birthDate`) | An *authoring* vocabulary embedded by hand in web-page markup — the same surface CDCF's citations live on. |
| **FOAF, Dublin Core, SKOS** | Transparent (`foaf:knows`, `dc:creator`, `skos:broader`) | Human-written interchange vocabularies. |
| **DBpedia** | Transparent, derived (`dbr:Pope_Francis`, from the article title) | Legible, but *drift-prone*: article renames break the mnemonic — a live illustration of the risk (§7). |

The pattern is not "the sophisticated people chose opacity." It is: **opacity clusters where a resolver always mediates and where referents are fluid; transparency clusters where the string is authored and quoted by hand and referents are fixed.**

### 4.2 Real canonical-ID standards

| Standard | Style | Notes |
|---|---|---|
| **BCP 47 language tags** | Transparent (`en-US`, `zh-Hant-TW`) | Composed by ABNF from ISO 639/15924/3166 + UN M.49. The i18n stack — HTML `lang`, HTTP `Accept-Language`, CLDR — runs on these *because they are authored by hand*. Nobody writes `lang="Q1860"`. |
| **Unicode / ISO 10646** | *Both, layered* | The code point `U+0041` is opaque; the character name `LATIN CAPITAL LETTER A` is transparent **and frozen forever** by Unicode's name-stability policy. Even Unicode does not put semantics *in the number* — it maps the number to an immutable descriptive name in a registry. |
| **OSIS book codes** | Transparent (`Gen`, `Jn`, `Rev`) | Already reused by the URI-scheme draft — the right instinct. |
| **Canon numbers, CCC paragraphs, Denzinger (DS)** | Transparent-numeric | The number *is* the authoritative, centuries-stable citation. Discarding it for a UUID would be perverse. |
| **DOI, ORCID** | Opaque behind a resolver | Work precisely because a resolver is *always* interposed; the raw DOI is not meant to be read. |

The observation that settles the `uni:/x/Q7f2a9` vs `en-US` example: **the entire internationalization ecosystem already chose `en-US`, in exactly CDCF's use case (hand-authored, quoted-in-the-wild identifiers), and has run on it for two decades.** The opaque-ID proposal is not "align with best practice"; it is "diverge from the closest and most successful precedent CDCF has."

---

## 5. The Unicode/BCP-47 Model, Precisely — CDCF's Template

The appeal to the Unicode Consortium points at the right model; it is worth stating its architecture precisely, because the precision *is* the design CDCF should copy. It is not one thing — it is a stack, and each layer answers one of our axes:

1. **Code lists (vocabulary).** ISO 639 (language), ISO 15924 (script), ISO 3166 (region) — flat registries of atomic, descriptive-yet-stable codes. *Axis B: transparent. Axis C: flat.*
2. **A grammar (syntax).** BCP 47 (RFC 5646) uses **ABNF** to compose those atoms into a tag. *Axis A.*
3. **A stability keeper (governance).** The IANA Language Subtag Registry snapshots the ISO code lists and adds `Added`, `Deprecated`, and `Preferred-Value` fields — the machinery that makes canonicalization declarative.
4. **A matching layer.** RFC 4647 defines fallback (`zh-Hant-TW` → `zh-Hant` → `zh`).

Note what this buys: the tag `zh-Hant-TW` is simultaneously **transparent** (a human reads it), **grammar-validated** (ABNF), **composed of stable registry atoms**, and **opaque to a matcher** (which treats it as a token to truncate, not a sentence to parse). All four axes, resolved independently, in one identifier. This is the existence proof that the committee's dilemma is false. CDCF's URI-scheme draft and CLEDR strawman already replicate layers 1–4; this paper's only addition is to name the model explicitly so the committee stops treating "transparent" and "machine-consumable" as opposed.

---

## 6. The Real Decision Criterion: Things vs Concepts

The strongest contribution to this debate has been the distinction between **things** and **concepts**, and it turns out to be *the* criterion the field is implicitly using.

- **Things** — entities with fixed extension and existing authoritative naming: Popes who have reigned, published editions of the Roman Missal, canonically-erected Latin-rite dioceses, the books of Scripture, promulgated magisterial documents. The Church has already done the canonical-naming work, often over centuries. Here **transparent identifiers are correct**, and the real-world evidence agrees: BCP 47, OSIS, ISO 3166, canon/CCC/DS numbering all chose transparent for well-defined things.
- **Concepts** — entities whose boundaries are genuinely contestable or develop over time: some theological notions, categories whose articulation shifts under doctrinal development. Here the drift and individuation risks are highest, and **opacity is defensible**. The evidence again agrees: the Gene Ontology and OBO Foundry — enormous, mature, sophisticated — chose *opaque numeric IDs precisely because their domain is nothing but concepts whose boundaries move.*

This is the reconciliation. The biomedical ontologists and the BCP 47 editors did not disagree; **they were identifying different kinds of referent.** Biology is almost entirely concepts, so it went opaque. Language, geography, and Scripture are things, so they went transparent. CDCF spans both kinds, so it should apply both rules — per dataset.

A necessary honesty check on "things": even things have a finite fringe of genuine edge cases. Papal numbering carries historical wrinkles (antipopes; the Stephen II/III ambiguity; the skipped John XX). Dioceses are erected, renamed, merged, and suppressed. But these are **finite, enumerable, and already adjudicated by the Church's own historical record** — a bounded list of known cases with authoritative answers — unlike a concept whose boundary is a *live* theological question. A small, closed set of documented exceptions is exactly what a registry with a deprecation policy is built to hold. It is not an argument for opacity.

---

## 7. The Drift Objection, and How Standards Actually Answer It

The one genuinely strong argument for opacity is **semantic drift**: a transparent identifier is a small promise about the world, and history can falsify it. Rename a diocese and `cdcf:institution/diocese/old-name` mildly lies. Opaque IDs never lie because they never asserted anything. This must be conceded plainly.

But it is answered — no standardized dataset is fossilized; they are revised — and the standards show *how* to revise without opacity. The instructive case is ISO 3166, because it contains both the failure and the fix.

ISO 3166's discipline: when a country's code is withdrawn, the two-letter code is **held in transitional reservation** (at least five years, often longer for the three-letter form), the retired code is **archived in ISO 3166-3** with a four-letter successor code recording what it became (Burma `BU` → Myanmar `MM`, archived as `BUMM`), and the numeric code is not reassigned casually. This is precisely the URI-scheme draft's §3.4 contract — never reassign, deprecate rather than delete, record the successor — and it lets descriptive codes survive geopolitical upheaval.

The cautionary half is just as useful. `CS` was used for Czechoslovakia, then **reused** for Serbia and Montenegro after Yugoslavia was renamed. That single violation of the never-reassign rule caused lasting confusion — even ISO's own archival code for Serbia and Montenegro had to be changed from `CSHH` to `CSXX` to avoid colliding with Czechoslovakia. The lesson is not "descriptive codes are dangerous." It is **"reassignment is dangerous"** — and reassignment is a governance failure, available to opaque and transparent schemes alike. Drift is not solved by making identifiers meaningless; it is solved by never reusing them and always recording their succession. CDCF's spec already mandates exactly this.

In short: the drift objection is real, it is a maintenance burden transparency carries and opacity avoids, and it is nonetheless the *lesser* cost for a citation layer — because the standards prove it is a **solved** problem, while opacity's cost (a mandatory lookup for every human who ever reads the identifier) is permanent and unsolvable by design.

---

## 8. Recommendation: Coexistence via SKOS, Decided Per Dataset

CDCF should stop framing this as a choice and mint, for each entity, the following — the same shape the Getty and Library of Congress vocabularies use to satisfy both machine and human consumers at once:

- an **ontology IRI** — the rigid designator for the graph (may be opaque *or* transparent, per §6);
- a `skos:prefLabel` — the human display name, language-tagged;
- a `skos:notation` **carrying the ABNF-governed canonical ID**, datatyped to a declared CDCF scheme (this is the transparent citation string — and note that in RDF the canonical ID most naturally lives *as a typed notation on the concept*, not necessarily as the raw IRI);
- `owl:sameAs` / `skos:exactMatch` links to **Wikidata, VIAF, GeoNames** for cross-walk stability.

This gives the opaque-ID position what it correctly asks for, exactly where it earns its keep (an ontology-internal identity that no reasoner parses, plus external cross-references that never lie) and gives adopters legibility exactly where it earns its keep (the citation and interchange layer), with ABNF validating that layer — and it is the standard, boring, widely-deployed pattern, not a novel compromise.

### Per-dataset recommendation

| Dataset | Kind | Canonical ID (notation) | Notes |
|---|---|---|---|
| Bible books / verses | Thing | **Transparent** (OSIS) | Already decided; authoritative external scheme reused. |
| Roman Missal editions (CRMETDR) | Thing | **Transparent** | Published artifacts with fixed identity. |
| Popes (pontiffs DR) | Thing | **Transparent** (`pope-{name}-{roman}`) | Fringe cases (antipopes, numbering) are finite and adjudicated → registry entries, not a reason for opacity. |
| Latin-rite dioceses | Thing | **Transparent**, with strict deprecation | The dataset that changes most; ISO 3166's never-reassign discipline is the model. |
| Canon law / CCC | Thing | **Transparent-numeric** | The number is the authoritative citation. |
| Liturgical celebrations (CLEDR) | Thing (mostly) | **Transparent + compositional** | See CLEDR strawman; commemoration atoms are things. |
| Magisterial documents | Thing | **Transparent** | Promulgated artifacts. |
| Theological concepts (`concept/`) | **Concept** | **Opaque IRI + transparent notation** *defensible* | The one domain where the case for opacity has real force; individuation is a live question. Consider opaque primary IRI with a mnemonic `skos:notation` and a `Preferred-Value` discipline for boundary revisions. |

---

## 9. Bottom Line for the Committee

- **ABNF is not the thing under dispute.** It applies whether identifiers are opaque or transparent, and CDCF needs it either way.
- **"Reasoners treat IRIs as opaque" is true and does not imply "mint random IRIs."** Those are different axes.
- **Opacity does not "prevent disagreement"; it relocates it** — from visible slug choices to invisible individuation and minting-policy choices, which are the ones that actually matter for authoritative Catholic data and which governance, not string format, must settle.
- **The opaque-ID best practices commonly cited are correct for application databases and mis-aimed at a public citation standard,** whose requirements (discoverability, quotability, legibility, century-scale stability) are in places the opposite.
- **The field already chose the answer for our use case:** the entire i18n ecosystem cites `en-US`, not an opaque code, because those identifiers are authored and quoted by hand — exactly like CDCF's.
- **The right rule is the things/concepts rule,** empirically confirmed by OBO (concepts → opaque) versus BCP 47/OSIS (things → transparent). CDCF spans both, so it applies both — per dataset, per the table in §8 — and carries both an IRI and a canonical ID on every entity via SKOS, rather than choosing between them.
