# Identifier Durability and Opaque Canonical IRIs

|                   |                                                                                                                                                                                                                                                                   |
| :---------------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Document type** | Position paper — public comment                                                                                                                                                                                                                                   |
| **Status**        | Draft 1 — prepared for submission during the `draft-cdcf-catholic-uri-scheme-03` (v0.4.0) 60-day comment window                                                                                                                                                   |
| **Relationship**  | Responds to [draft-cdcf-identifier-rationale-00](../standards/drafts/cdcf-identifier-rationale-00.md) and [draft-cdcf-catholic-uri-scheme-03](../standards/drafts/cdcf-catholic-uri-scheme-03.md); informs the [CDCF Standards program](../standards/overview.md) |
| **License**       | CC BY 4.0                                                                                                                                                                                                                                                         |

---

## Table of Contents

1. [Executive Summary](#executive-summary)
2. [The Shared Premise](#the-shared-premise)
3. [What We Agree On](#what-we-agree-on)
4. [The Evidence: Transparency Produced Divergence, Not Convergence](#the-evidence-transparency-produced-divergence-not-convergence)
5. [The Steelmen — and Where Each Fails](#the-steelmen--and-where-each-fails)
6. [Where Does the Churn Land](#where-does-the-churn-land)
7. [Worked Example: Canonicalizing Levels of Authority](#worked-example-canonicalizing-levels-of-authority)
8. [The Proposal](#the-proposal)
9. [Universal Slugs Across Standards](#universal-slugs-across-standards)
10. [Costs We Accept — and Their Remedies](#costs-we-accept--and-their-remedies)
11. [Recommended Amendments to Draft 0.4.0](#recommended-amendments-to-draft-040)
12. [Bibliography](#bibliography)

---

## Executive Summary

**Goals — the ground we already share.** The ambition behind CDCF is not a Catholic filing system. It is one common taxonomy and ontology every Catholic can use; then one every
Christian can use; then one the Abrahamic traditions can share wherever they genuinely refer to the same thing; and ultimately a machine-readable articulation of what those
traditions hold to be true, usable by AI systems generally as alignment-with-human-values infrastructure. That ladder is why the identifier question matters at all: a scheme that
cannot survive the second rung will never reach the fourth.

**Problems — names and structures are exactly where traditions diverge.** The Church comprises 24 churches _sui iuris_, one Latin and 23 Eastern, and draft 0.4.0 already requires
that each "MUST be representable without privileging the Latin Church as the default" (§4.7.1). An identifier that hard-codes a Latin-rite taxonomy segment, or an English slug, or
an Italian one, quietly violates that requirement in every string it mints — and the problem sharpens as the ladder extends. To an Eastern Orthodox adopter, an identifier reading
`institution/circumscription/…` in Latin-derived English is not neutral infrastructure; it reads as _the Latin thing, not ours_. This is not speculative. Transparency has already
produced measurable divergence inside CDCF's and CatholicOS's own repositories: one verse now carries three committee-minted transparent identifiers in eight months, shipped
registry IDs have been renamed in place, and a calendar-date anchor baked into an identifier moved because the Latin and Italian editions of one book disagree about the date.

**Solutions — one opaque spine, one guaranteed affordance layer.** We propose that every canonical identifier CatholicOS mints — ontology and data registries alike — be an opaque
base62-encoded UUID of the shape `R…`, and that _all_ human readability move into a layer the standard guarantees rather than one the identifier improvises: every existing slug and
registry key preserved as a **permanent resolvable alias**, never deprecated and never reused; **multilingual labels** on every entity, so naming disputes are settled by _adding_ a
label rather than _changing_ an identifier; and a **rendering rule** requiring production surfaces to show a label beside every canonical ID. This is deliberately a _small delta_
to draft 0.4.0, not a rival document. Draft 0.4.0 already built the machinery — the two-artifact model (§3.6), the `notations` array (§5.9), the never-reassign stability guarantee
(§3.4), the `exact-match`/`close-match` relations (§4.8.2). We keep all of it and invert which artifact is primary.

---

## The Shared Premise

We begin where the committee itself began. Asked whether CDCF is meant to become the meta-level disambiguation layer for Catholic data — "kinda like what DOI does for published
URLs" — the answer was yes, with one refinement: `cdcf:` identifiers dereference to structured JSON-LD carrying typed relationships, so the model is "more like what Wikidata does
as an entity graph with typed statements."[^1] We accept that self-description completely; it is the strongest available framing of what CDCF is for. Three consequences follow.

**First, both named models mint opaquely and carry readability in metadata.** A DOI name is, in the DOI Handbook's own words, "an opaque string" or "dumb number" — "nothing at all
can or should be inferred from the number," and "the only secure way of knowing anything about the entity that a particular DOI name identifies is by looking at the metadata that
the Registrant of the DOI name declares."[^2] Wikidata's Q-numbers work the same way: `Q7186` is one identifier labelled _Marie Curie_ in English and French and _Maria
Skłodowska-Curie_ in Polish.[^3] Neither system is illegible in practice; both are illegible in the _string_ and legible in the _payload_.

**Second, the richer the resolution payload, the less semantic work the identifier string must do.** DOI resolves to a bare target URI and still succeeds. Draft 0.4.0 resolves to
JSON-LD with `notations`, `crossReferences`, `licenses`, `doctrinalHistory`, and typed authority metadata (§5.4, §5.9). CDCF has built a resolution layer far richer than DOI's,
which means the marginal legibility a transparent string buys is far smaller here than in the systems transparency's advocates usually cite. The payload has absorbed the job.

**Third, a disambiguation layer must be neutral among the names it arbitrates.** The purpose of such a layer is to adjudicate between competing names, spellings, languages, and
structural placements for one referent. A transparent identifier pre-commits to one side of exactly the disputes the layer exists to resolve — silently, in every citation, forever.
It is a strange arbiter that writes its verdict into its own name.

---

## What We Agree On

We want to be precise about how much of `draft-cdcf-identifier-rationale-00` we accept, because it is more than the disagreement.

**The four-axes framework is right, and we adopt it.** The rationale doc separates axis A (grammar), axis B (transparency), axis C (structure), and axis D (consumption), and
observes that fixing one does not fix the others (§2). That is correct and clarifying, and this paper argues inside that vocabulary. **We concede axis A entirely** — "you want a
grammar either way" is simply true, and under this proposal the ABNF work is not discarded but moves to the layer where hand-authored strings actually live, governing the notation
and alias vocabulary plus one trivial production for the canonical shape. **We concede axis D entirely** — a reasoner must treat an IRI as a rigid designator, and the doc is right
that opacity-to-reasoners does not entail opaque minting. Our case for opaque minting is independent of D; it rests on durability and neutrality, not reasoner correctness.

**Draft 0.4.0's two-artifact model is convergence, not conflict.** The most important thing in the 0.4.0 revision is §3.6: the recognition that graph identity and public citation
are two jobs, and that both can be carried on one entity. The `notations` array (§5.9), the scheme URNs, the never-reassign stability guarantee (§3.4), and the
`exact-match`/`close-match` relations that correctly refuse blanket `owl:sameAs` (§4.8.2, §3.6.1) are precisely the infrastructure an opaque-primary architecture needs. **This
proposal reuses all of it.** We ask the committee to build nothing it has not already specified — only to decide which artifact carries the stability guarantee.

**The slug schemes are the right vocabulary, in the wrong slot.** The registry slugs are careful, well-researched, and genuinely useful; they are exactly the alias vocabulary the
standard needs — and CatholicOS has already built the mechanism we propose to generalize, since CRMEDR ships `data/deprecated_ids.json` alongside `i18n/la.json`, `i18n/it.json`,
and `i18n/en.json`.[^4] Deprecation records plus multilingual labels beside an identifier is not an architecture we are importing; it is a pattern this organization built once
already, and our proposal is that it be applied universally rather than per-repo. **CSC.rdf's modeling instincts are right too, and we endorse them by name:** the Catholic Semantic
Canon ontology attaches the edition by property (`hasEdition`, with `John_1_14` pointing at `NovaVulgata`) rather than baking it into the base text unit's IRI, and models
vernacular renderings as first-class `Translation` artifacts linked by `hasTranslation`/`translationOf`.[^5] Both are what this paper proposes to make universal: volatile and
language-specific facts belong in properties, not identifiers.

The dispute, then, is narrow. It lives on axes B and C: whether the _primary_ minted string carries meaning, and whether it encodes hierarchy.

---

## The Evidence: Transparency Produced Divergence, Not Convergence

The rationale doc's strongest empirical claim is that transparency is the field's answer for hand-authored citation strings. Ours is narrower and closer to home: **inside this
committee's own work, transparency has produced divergence rather than convergence — and quickly.**

### Two entities, six spellings

| Entity                      | CSC.rdf fragment IRI | CSC.rdf `identifier`               | Third live spelling                             |
| :-------------------------- | :------------------- | :--------------------------------- | :---------------------------------------------- |
| **John 1:14**               | `csc:John_1_14`      | `urn:catholic:scripture:john:1:14` | `cdcf:verse/jn/1/14` (per 0.4.0 §4.1.2 grammar) |
| **Trent, Sess. XIII ch. 4** | `csc:Trent_S13_Ch4`  | `Trent-Session13-Ch4`              | `urn:catholic:council:trent:session13:chapter4` |

The first two spellings of each pair sit in one file, on adjacent entities, under `purl.org/cdcf/ontology/catholic-semantic-canon#`;[^5] the third Trent form is the
reference-linking example in the Rome working-session materials.[^6] That same file also carries `CCC-1376`, `ST-III-75-4`, and `CIC1983-915` — four shape conventions inside one
`identifier` property. None of this is carelessness; each spelling is locally reasonable. That is the point: transparent identifiers are locally reasonable in incompatible ways,
and no mechanical test detects the divergence. **One opaque canonical ID would have carried all six spellings as notations, and the divergence would have been visible as what it
is: six citation forms for two entities.**

### The recorded in-repo record

**CRMEDR** (Roman Martyrology eulogies) has already corrected shipped identifiers. A slug that captured an entry's introductory words rather than its subject was renamed
`mr:0323-itemcoronae-sanctonim-martyrum` → `mr:0323-domitius-et-socii`; a later commit transliterated the Polish `ł` across ten identifiers (`mr:0308-vincentius-kad-ubek` →
`mr:0308-vincentius-kadlubek` and nine siblings), stating the policy: "IDs are drafts pending committee review, so renamed in place with no deprecated-alias." Most instructive is
the moved anchor — `mr:1210-marcus-antonius-durando` became `mr:0610-marcus-antonius-durando`, because the Latin _editio altera_ 2004 places the blessed on June 10 while the
Italian (CEI) edition of the same book places him on December 10.[^4] The identifier hard-codes a fact that two editions of one work disagree about, so it must move whenever the
anchor edition is reconsidered.

**CLEDR**'s crosswalk records the same phenomenon across projects. On 26 January 2021 the Congregation for Divine Worship decreed that 29 July be designated the Memorial of Saints
Martha, Mary and Lazarus, replacing the celebration of Martha alone.[^7] CLEDR's row carries the Latin title _Sanctorum Marthæ, Mariæ et Lazari_ — and three irreconcilable keys:
litcal froze `StMartha` (now factually wrong), romcal renamed to the 56-character `martha_of_bethany_mary_of_bethany_and_lazarus_of_bethany`, and eprex kept `martha`.[^8] Three
projects, one decree, three divergent responses — and the row's source column still credits `missale_romanum_1970`, so the decree that caused the divergence appears nowhere in the
identifier layer.

**CECDR** (ecclesiastical circumscriptions) states a strip rule: generic type words such as "Diocese of" and "Diocesi di" are stripped, because "the _type_ is an attribute, not
part of the identity." Against 2,935 live IDs, 58 still contain `arcidiocesi-di-` and 31 military and personal ordinariates carry a type word slugged across at least ten languages
(`ordinariato militare`, `obispado castrense`, `diocese aux armees`, `ordynariat polowy`, `vojensky ordinariat`, and more) — 89 live identifiers at odds with the repository's own
rule. Separately, `circ:it-opus-dei` was renamed `circ:int-opus-dei` because "the personal prelature of the Holy Cross and Opus Dei is supranational, so tying it to Italy … was
wrong," and two homonymous Chinese sees are disambiguated by bare ordinals, `circ:cn-xinjiang-1` and `circ:cn-xinjiang-2`, both noted "qualifier pending committee review."[^9]

Three sibling registries add three more shapes of the same problem. **CLBDR** contradicts itself between front page and schema: `README.md` documents
`<book>_<territory-or-locale>_<year>` with the example `martyrologium_romanum_cei_2004`, while `docs/schema.md` specifies `<book-slug>_<year>_<bcp47>` — and the data follows the
schema (`martyrologium_romanum_2004_it_IT`), so the README's example identifier exists nowhere in the registry. **CICLSALDR** records that its own `icl:` prefix "reads as the
repository's shorthand, not as a canonical classification of every entry," because its scope includes societies of apostolic life, canonically distinct from consecrated life;
`icl:cm` (_Congregatio Missionis_, typed `society_of_apostolic_life`) is live proof. **CMDDR** renamed its own acronym — "Fix typo in project name from CLDDR to CMDDR" — before
minting a single identifier.[^10]

**Draft 0.4.0 itself** supplies two more. It retired the `order` supertype before reaching 1.0, leaving `cdcf:institution/order/{slug}` resolvable only via successor pointers
(§4.7). And §4.6.1 requires an ordinal on every papal identifier, producing `cdcf:person/pope-francis-i` — an ordinal the Church did not use: the Vatican listed the name simply as
_Francis_ in its first bulletin, and the press office's own gloss was that "it will become Francis I after we have a Francis II."[^11] The identifier asserts a fact about the
Church that the Church declined to assert. Meanwhile Open Issue 1 (Psalm numbering) and Open Issue 5 (multilingual slugs) have survived four revisions unresolved (§10) — both
disputes that exist _only because_ the identifier string must choose.

Every one of these is a governance-quality problem a diligent committee will keep solving. A committee member may fairly object that draft registries are _supposed_ to churn — that
is what a pre-1.0 registry is for. Two answers. First, litcal, romcal, and ePrex are not drafts; they are production systems, and the St Martha divergence happened in their
_shipped_ keys — a 2021 decree left `StMartha` frozen factually wrong in a production API while a sibling project renamed to a 56-character key — so the mechanism operates after
normativity, not only before it. Second, the churn's causes — multilingual naming, movable anchors, editorial judgment about which name is _the_ name — do not end at 1.0: popes
keep being elected, dioceses keep merging, decrees keep expanding memorials. Normativity freezes the identifiers, not the world. That is precisely the cost we ask the committee to
weigh: transparency's maintenance burden is not a one-time migration but a standing obligation, recurring whenever the world, an edition, a decree, or a translation policy changes.

---

## The Steelmen — and Where Each Fails

We are not neutral, but the transparent case deserves its full strength, because a proposal that defeats only weak versions of the opposition deserves to lose. Each steelman below
is followed by the failure mode we think it develops over time, a concrete mitigation from the affordance layer, and an invitation. If the transparent camp can name a remedy for
one of these failure modes that costs less than ours, that should decide the question.

### Steelman 1 — The BCP 47 / Unicode layered model

**At full strength.** The rationale doc's §5 is its best section. BCP 47 composes stable atomic registry codes by ABNF into `zh-Hant-TW`: a tag simultaneously transparent to a
human, grammar-validated, built from stable atoms, and opaque to a matcher. Unicode pairs an opaque code point `U+0041` with a name — `LATIN CAPITAL LETTER A` — frozen forever by
its stability policy. The i18n stack runs on these, in CDCF's exact use case: hand-authored, quoted-in-the-wild identifiers, for two decades. Nobody writes `lang="Q1860"`.

**Failure mode.** BCP 47's registry survives change only through alias machinery — which is our architecture, not theirs. RFC 5646 §3.1.6 and §3.1.7 define `Deprecated` and
`Preferred-Value` precisely so the registry can carry `iw` forever while canonicalizing it to `he`; the §3.4 stability guarantee is that `Subtag`, `Type`, and `Added` "MUST NOT be
changed" — the subtag is never removed, only redirected.[^12] That is an opaque-spine architecture wearing legible clothes. More decisively, language tags have a property no
Catholic entity has: they are written in the one alphabet definitionally neutral for their domain, and their referents are the naming authorities themselves. There is no
Latin-versus-Italian dispute about how to spell `en`. There is exactly such a dispute about `pope-{name}-{roman}`: Leo, or Leone, or León? CECDR's ten-language ordinariate slugs
are that dispute already lost, at scale.

**Mitigation and invitation.** Adopt the BCP 47 architecture in full, including the part that does the work. Under this proposal `Preferred-Value` is not approximated; it _is_ the
alias layer, and every competing spelling (`pope-leo-xiv`, `papa-leone-xiv`, `papa-leon-xiv`) becomes a permanent resolvable notation on one canonical ID, none privileged and none
wrong. We would welcome a proposal for how a transparent primary IRI carries three co-equal language forms without electing one.

### Steelman 2 — Code ergonomics

**At full strength.** `if (key == "immaculate-conception")` is readable in a diff, greppable in a log, and self-documenting in a stack trace. `if (key == "Rk8f3vQ2…")` is none of
those. Most humans who ever touch these identifiers are application developers, not ontologists, and their productivity is a real cost that ontological purity does not pay.

**Failure mode.** The legibility is real but bound in the wrong place: in a literal, at every call site. When the referent's boundary or preferred name changes, every call site is
stale in a way no compiler catches. The string was never checked against the record; it was trusted because it looked right.

**Mitigation and invitation.** Named constants bound to canonical IDs — `const IMMACULATE_CONCEPTION = "R…"` — which is how every codebase already handles hex colors, port numbers,
and country codes. That restores full call-site legibility while leaving exactly one authoritative binding to audit, and the rendering rule (§8, item 4) extends it to registry
source files, serializations, and generated code so a label always sits beside the ID. If the constant-binding overhead is too high for a particular consumer, we would like to see
that workflow, so the affordance layer can be shaped around it.

### Steelman 3 — Church-oversight verifiability

**At full strength.** Ecclesiastical review is a genuine requirement, and reviewers are theologians and canonists, not engineers. A bishop's delegate can read
`cdcf:magisterium/pope-leo-xiii/rerum-novarum` and confirm it is right. Nobody can review a page of base62.

**Failure mode.** Transparency converts review from _verification_ into _recognition_. The reviewer confirms the string looks correct; the string is not thereby checked against the
record. When a slug is subtly wrong — a garbled Latin incipit captured as a subject name, a date drawn from the wrong edition, an ordinal the Church never used — it passes review
precisely because it reads plausibly. Every recorded CRMEDR correction above was a plausible-reading slug that shipped.

**Mitigation and invitation.** The first half needs no tooling at all: under commitment 4 of the Proposal, the registry source file a canonist reviews _remains a plain text file_,
with the Latin label in the column adjacent to the ID. Nothing is taken away from text-file reviewers — the opaque ID is an added column, not a substitute — so recognition-style
review continues exactly as it does today, while verification-style review becomes possible on top of it. Verification against labels rendered _from_ canonical IDs is strictly
safer, because it checks the record rather than trusting the key. Under the rendering rule a review surface shows the canonical ID with its `skos:prefLabel` in the reviewer's own
language — Latin, Italian, English — resolved live from the registry, so a reviewer sees what the system actually believes rather than what a past minting decision asserted. We
would welcome the committee's review-workflow requirements as design input for that rule, which is the natural place to encode them.

### Steelman 4 — Things versus concepts

**At full strength.** The rationale doc's §6 is its most original contribution and genuinely explanatory: OBO Foundry and the Gene Ontology went opaque because biological
categories are reclassified as science advances, while BCP 47 and OSIS went transparent because languages and scriptural books are fixed.[^13] CDCF spans both, so it should apply
both rules per dataset. The residual fringe among things — antipopes, the Stephen II/III ambiguity, the skipped John XX — is finite, enumerable, and already adjudicated by the
Church's own historical record.

**Failure mode.** The criterion cross-cuts the doc's own evidence. Its §4.1 table lists **VIAF, Getty (TGN/ULAN/AAT), and GeoNames** as opaque — and those are authority files of
_things_: persons, places, named artifacts. It lists **schema.org, FOAF, Dublin Core, and SKOS** as transparent — and those are _concept_ vocabularies of classes and properties. If
things→transparent and concepts→opaque were the rule, those rows sit on the wrong side of it; and the row the doc itself flags as drift-prone is **DBpedia**, transparent
identifiers for things, derived from article titles, which break on rename (§4.1). The line the field actually draws is simpler, and it is the doc's own summary sentence in §4.1:
**opacity clusters where a resolver always mediates.** That describes CDCF exactly — draft 0.4.0 specifies a resolution server, mirror discovery, content negotiation, a change
feed, and one-year immutable caching (§5.1–§5.9). CDCF is not choosing whether to be resolver-mediated; it has already chosen.

**Mitigation and invitation.** Apply the resolver criterion, which CDCF satisfies, rather than the things/concepts criterion, which the doc's own evidence table does not support —
and keep the things/concepts insight where it is undeniably right: as the rule for which _notation scheme_ to feature. Scripture keeps OSIS, canons keep their numbers, CCC keeps
its paragraph numbers; this proposal never asks anyone to stop writing them, only that they be notations on a durable spine rather than the spine itself. If the committee believes
there is a closed class of entities whose canonical naming is genuinely finished, we would like to see it enumerated — our reading of the six registries is that every candidate
class has already recorded a rename.

### Steelman 5 — "Just take a vote on the language"

**At full strength.** Standards bodies decide contested questions by deliberation and vote all the time. Latin is the Church's own language and an obvious Schelling point.
Committees exist to make exactly these calls; declaring the question unanswerable is an abdication.

**Failure mode.** A vote produces a winner and a resentful minority — per identifier, permanently, and visibly in every citation string. That is a governance tax recurring with
every new entity and compounding with every tradition the standard hopes to serve. It is also empirically what has happened: Open Issue 5 has been open across four revisions,
CRMEDR mints Latin lemmas, CLEDR mints English snake_case, and CECDR's ordinariates ended up in ten languages without anyone ever deciding they should.

**Mitigation and invitation.** Multivalued labels produce no losers. `skos:prefLabel` is language-tagged; a Polish reader gets Polish and a Latin reader gets Latin, from one
record, with no election held. The precedent is trivially familiar: _honor_ and _honour_ are both correct, and no standard had to choose, because they are labels rather than keys.
If a vote is nonetheless preferred for a given domain, note that under this proposal it decides which notation carries `prefLabel: true` — a reversible, low-stakes call — rather
than which identifier the world cites for a century.

---

## Where Does the Churn Land

Strip away the vocabulary and one question remains. **Every identifier architecture must absorb world-change somewhere.** Editions get revised, dioceses are erected and merged, a
decree expands a memorial from one saint to three, a prelature turns out to be supranational, a committee decides `order` should have been `institute`. The choice is not whether to
absorb change but which layer takes the hit.

**Transparent-primary architectures absorb it in the canonical layer.** Every change becomes a deprecation, a successor pointer, a permanently stale citation in a document nobody
will revise. Draft 0.4.0 handles this correctly — §3.4 requires that both original and successor stay resolvable indefinitely — but "handles correctly" means "accumulates
forever," and the discipline it requires is perpetual institutional rigor, which even ISO failed at once: `CS` was used for Czechoslovakia and then reused for Serbia and
Montenegro, and ISO's own archival code for the latter had to be changed from `CSHH` to `CSXX` to stop the collision. ISO's success story is the other half of the same standard —
Burma → Myanmar archived as `BUMM`, withdrawn alpha-2 codes transitionally reserved for at least fifty years before any possible reuse.[^14] The rationale doc reads this correctly
(§7): reassignment is the danger, and it is a governance failure available to both camps.

**Opaque-primary architectures absorb it in the alias layer, which is built to age.** When a slug turns out to be wrong it is not corrected — it is _joined_.
`mr:1210-marcus-antonius-durando` and `mr:0610-marcus-antonius-durando` both resolve, forever, to one entity; the Latin edition and the CEI edition are each right about their own
book; nothing published ever breaks. `StMartha`, `martha`, and the 56-character romcal key all resolve to one celebration, and the 2021 decree becomes a property on the record
rather than a naming crisis in three projects. Aliases are supposed to pile up. Canonical identifiers are not.

And the cost asymmetry has inverted since this trade-off was last argued seriously. The rationale doc calls opacity's cost "permanent and unsolvable by design" — a mandatory lookup
for every human who reads the identifier (§7). That was true in 2005. Hover labels, IDE inlays, resolver-backed link previews, and agents that never hand-type an identifier have
collapsed the lookup cost toward zero, and CDCF's own resolution protocol is precisely the substrate those affordances run on. CatholicOS need not take this on faith: ontokit
already renders resolver-backed labels beside opaque `osc:` R-IDs today — its source-view hover resolves a full IRI to its label, and its `useIriLabels` hook label-joins API
responses.[^15] Drift costs move the other way: they rise with every integration, every downstream project, every new edition, and every tradition the standard reaches for.
**Legibility costs are falling toward zero; drift costs rise with adoption.** The transparent trade-off was right for 2005. We do not think it is right for a standard minted in
2026 to last a century.

---

## Worked Example: Canonicalizing Levels of Authority

The committee has an open question about how to canonicalize levels of authority.[^1] It is an ideal test of the architecture, because three formulations already coexist and they
are not 1:1 mappable.

| Source                         | Count | Values                                                                                                                                           |
| :----------------------------- | :---- | :----------------------------------------------------------------------------------------------------------------------------------------------- |
| Rome working-session materials | 6     | Primary Revelation · Universal Ordinary Magisterium · Papal Magisterium · Universal Theological Commentary · Local Magisterium · Private Opinion |
| CSC.rdf individuals            | 6     | `PrimaryRevelation` · `UniversalOrdinary` · `PapalMagisterium` · `CommentaryLevel` · `LocalOrdinary` · `NonMagisterial`                          |
| Draft 0.4.0 §6.2               | 5     | `solemn-definition` · `ordinary-universal` · `definitive-doctrine` · `authentic-doctrine` · `pastoral-guidance`                                  |

Two things are worth noticing. First, the Rome materials disagree with _themselves_ about ordering: the pyramid slide runs Primary Revelation, Universal Magisterium, Papal
Magisterium, Local Magisterium, Commentary, Private opinion — placing Local Magisterium above Commentary — while the authority-metadata table on a later slide places Universal
Theological Commentary above Local Magisterium.[^6] Second, the two six-value lists and the five-value list do not measure the same thing: the first two answer _who teaches_, and
draft 0.4.0's answers _what assent is owed_ (§6.1). Those axes correlate but do not align; the same document can sit high on one and lower on the other.

Harmonizing this is real theological work, and not this paper's to do — draft 0.4.0 §7.3 rightly requires theologian and canonist review for exactly these classifications. What we
can say is what the harmonization will do to the identifiers. It will rename levels, reorder them, split at least one, and possibly separate the two axes into two vocabularies. If
level-IDs are transparent strings, every one of those moves breaks every text already tagged: a corpus tagged `"UniversalOrdinary"` is stranded the moment the level is renamed or
its boundary redrawn, and the migration is a rewrite of the annotation layer rather than of a lookup table. If level-IDs are opaque, with today's names carried as labels and all
three existing vocabularies carried as notations, the theology can develop and the data survives — the record's label changes, the tagged corpus does not move, and the crosswalk
between the who-teaches and what-assent axes becomes a property rather than a renaming. That is the whole argument in one case. **The identifier architecture should let the
theology be revised. It should not require the theology to be finished first.**

---

## The Proposal

Five commitments. Nothing here replaces draft 0.4.0's machinery; each item names the 0.4.0 mechanism it rides on.

1. **Canonical identifiers are opaque, `R`-shaped, and org-wide.** Every canonical ID CatholicOS mints — ontology and every data registry — is a base62-encoded 128-bit UUID
   prefixed `R` (23 characters in practice; 122 random bits, so decentralized minting needs no counter and no central allocator, and the leading letter keeps it QName-safe for
   RDF/XML). This is not new for CDCF: it is the shape already shipping in `ontology-semantic-canon`, where `osc:RChKPk9K152BirrIYgAREsY` is _Clergy_, and the shape ontokit already
   mints.[^15] It is also FOLIO's shape — `folio.openlegalstandard.org/R7Ttdyo4FsvaupPKT35Qry0` is _Murder_.[^16]
2. **Every existing slug, key, and registry prefix becomes a permanent resolvable alias.** `mr:`, `circ:`, `icl:`, CLEDR keys, CLBDR edition IDs, litcal/romcal/eprex keys,
   `cdcf:verse/jn/1/14`, `cdcf:concept/C0000418` — all carried as 0.4.0 `notations` (§5.9) under declared scheme URNs, resolvable per §3.4, **never deprecated and never reused**.
   This is the IP/DNS model, and the analogy is worth stating plainly: nobody argues that an IP address should be human-readable, and nobody has to, because the domain name
   resolves to it. No adopter loses a working key. That is the adoption story.
3. **Every entity carries multilingual labels.** `skos:prefLabel` and `skos:altLabel`, language-tagged, on every entity in every registry. Naming disputes are resolved by **adding
   a label**, never by changing an identifier. CRMEDR's `i18n/{la,it,en}.json` is the existing precedent; this generalizes it.
4. **Production surfaces MUST render a label beside every canonical ID.** Registry source files carry a label column or comment beside each ID; serializations carry the label
   inline; UIs and generated code render it. This commitment is what makes opacity livable, and it belongs in the standard rather than in each implementer's good intentions.
5. **Structural and volatile facts live in properties, never in canonical identifiers.** Dates and calendar position (CRMEDR's `MMDD` anchor), country codes (CECDR's ISO 3166
   prefix), taxonomy supertypes (`circumscription`, `institute`, the retired `order`), edition years (CLBDR), chapter/verse hierarchy, ownership, and language are all already
   modeled as fields in 0.4.0 responses. Where a fact lives both in a field and in the identifier, the identifier is the copy that goes stale.

---

## Universal Slugs Across Standards

Draft 0.4.0 §4.9 already states the principle we want to generalize: a sibling registry's slug "MUST be reused verbatim as the final path segment of the corresponding `cdcf:` IRI …
This is a MUST, not a convention: it is what makes the pairing machine-verifiable rather than merely coincidental." That is exactly right, and it is the seed of something larger.
Lift it one level, from sibling registries to peer standards: when CatholicOS and another standard identify the same referent, they reuse the **same opaque local name** under their
own namespaces.

```text
https://ontology.catholicos.catholic/R7Ttdyo4FsvaupPKT35Qry0
https://folio.openlegalstandard.org/R7Ttdyo4FsvaupPKT35Qry0
```

Cross-standard identity becomes machine-verifiable by local-name equality — no mapping table, no crosswalk to maintain, no `sameAs` hazard. Each standard keeps its own namespace,
governance, labels, and resolution payload; only the local name is shared. **This is possible only because the shared name asserts nothing in anyone's language.** No tradition will
agree to share `god-the-son` across Jewish, Catholic, and Protestant standards — the string itself is a theological claim, and for two of the three it is the wrong one. But every
tradition can share `R7Ttdyo4FsvaupPKT35Qry0`, because it says nothing at all, and each standard attaches its own label, definition, and typed statements to it. Opacity is not
merely tolerable at the inter-tradition boundary; **it is the only thing that crosses it.** That is the interfaith-alignment benefit named in the goals ladder, and it is concrete
rather than aspirational: shape-compatibility with FOLIO today, and a mechanism that scales to machine-readable identifier work across the Abrahamic traditions tomorrow. The
alternative — a mapping table between every pair of standards, maintained by both parties in perpetuity — is the cost transparency imposes at exactly the boundary where the goals
ladder can least afford it.

---

## Costs We Accept — and Their Remedies

Opacity has real costs. We would rather name them than let them be discovered later.

| Cost                     | The problem, stated plainly                                                                                                 | Remedy                                                                                                                                   |
| :----------------------- | :-------------------------------------------------------------------------------------------------------------------------- | :--------------------------------------------------------------------------------------------------------------------------------------- |
| **Diff reviewability**   | A slug in a pull request is self-checking; a reviewer sees a wrong one. `Rk8f3vQ2…` is not self-checking and never will be. | Mandatory label columns in registry source files, so every diff line carries an ID **and** a human-readable label that reviews itself.   |
| **Silent wrong-paste**   | Paste the wrong opaque ID and nothing looks wrong. Paste the wrong slug and something usually does.                         | Lint rules validating every ID against the registry and asserting label/ID agreement in CI; label comments beside IDs in serializations. |
| **Debugging ergonomics** | A log line, stack trace, or SPARQL result full of base62 is harder to read than one full of slugs.                          | IDE inlays and resolver-backed hover labels; named constants bound to canonical IDs at call sites; label-joining helpers in tooling.     |
| **Onboarding friction**  | A newcomer reading raw data cannot orient without a lookup.                                                                 | The §5.9 `notations` array ships every canonical record with all its familiar slugs, so a newcomer's existing vocabulary still works.    |

None of these remedies is speculative — each exists in shipped systems, and two exist in CatholicOS repositories today. But we do not claim the list is complete. **We invite the
committee, and especially the transparent camp, to name costs we have missed and mitigations we have not thought of.** If a cost turns out to have no adequate remedy, that is a
finding worth having before adoption rather than after.

---

## Recommended Amendments to Draft 0.4.0

We offer these as amendments the committee can adopt into the existing text, not as a rival document. Draft 0.4.0's non-identifier machinery — the `licenses` object, authority
metadata, content negotiation, caching, resilience, and the governance process — is endorsed as written.

| §                    | Amendment                                                                                                                                                                                                                                                          |
| :------------------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **§3.6**             | Make the ontology IRI opaque for **every** domain, not only `concept/`. Each domain's current transparent path form becomes a **guaranteed** notation rather than an optional one. The two-artifact model is unchanged; only which artifact is primary.            |
| **§3.3, Appendix D** | Re-scope the ABNF grammars to govern the notation layer, where hand-authored strings live. Add one production for canonical IRIs: `canonical-id = "R" 20*24(ALPHA / DIGIT)` (base62, case-sensitive — this relaxes §3.3's lower-case rule for canonical IDs only). |
| **§4.5**             | Extend the opaque option from `concept/` to all domains, and recommend the `R` shape over sequential `C0000418` for new mints. Existing `C…` IDs are kept as permanent notations; **no forced migration** (§1.3 preserved).                                        |
| **§4.9**             | Extend the verbatim-slug MUST to **cross-standard** opaque local names: peer standards identifying the same referent SHOULD reuse the same local name under their own namespaces.                                                                                  |
| **§3.4**             | State explicitly that the stability guarantee applies to notations as permanent aliases: a published notation MUST remain resolvable and MUST NOT be reassigned, exactly as an IRI.                                                                                |
| **§5.9**             | Make `notations` load-bearing in every domain (withdrawing §3.6's permission to omit it for "thing" domains), and add `skos:prefLabel`/`altLabel` as a REQUIRED language-tagged field on every resolution response.                                                |
| **New §5.10**        | Add a production rendering rule: registry source files, serializations, UIs, and generated code MUST render a human-readable label adjacent to every canonical ID.                                                                                                 |
| **§10, new issue**   | Mint namespace: we recommend **one org-wide namespace** shared by the ontology and all registries. The host choice — `id.catholiccommons.org` (§3.1) versus `ontology.catholicos.catholic` (already live for `osc:`) — is a committee decision we do not presume.  |

Two notes on scope. This proposal executes no data migration; beyond the permanent-alias commitment, migration mechanics are committee work. And it proposes no theological
harmonization — §7.3 review remains the right gate for anything touching doctrinal classification.

---

## Bibliography

[^1]:
    Committee discussion, July 2026 (data-and-standards group), paraphrased without attribution. The exchange characterized CDCF as the meta-level disambiguation layer, "kinda like
    what DOI does for published URLs," refined as "more like what Wikidata does as an entity graph with typed statements," and raised the canonicalization of levels of authority.

[^2]:
    International DOI Foundation, _DOI Handbook_, §2.2 (Syntax of a DOI name) and §2.2.1 (General characteristics), https://www.doi.org/doi_handbook/2_Numbering.html. The quoted
    phrases "opaque string," "dumb number," and the metadata sentence are from those sections.

[^3]:
    Wikidata, "Help:Items," https://www.wikidata.org/wiki/Help:Items. Item `Q7186` is labelled _Marie Curie_ in English and French and _Maria Skłodowska-Curie_ in Polish; labels,
    descriptions, and aliases are per-language while the identifier is not.

[^4]:
    CatholicOS, _CRMEDR_, github.com/CatholicOS/crmedr: commit `afb5a70` ("Fix garbled/spurious registry IDs (rename/remove, not deprecate)"); commit `d6439bd` ("Fix ł-drop in
    canonical slugs: transliterate ł→l (10 Polish IDs)"), whose message states the quoted policy; `docs/canonicalization-report.md` (moved date anchor); and the alias/label
    precedent in `data/deprecated_ids.json` with `i18n/la.json`, `i18n/it.json`, `i18n/en.json`.

[^5]:
    _Catholic Semantic Canon_ ontology (CSC.rdf, v1.0.0), namespace `http://purl.org/cdcf/ontology/catholic-semantic-canon#`: individuals `John_1_14` and `Trent_S13_Ch4`;
    `identifier` values `urn:catholic:scripture:john:1:14`, `Trent-Session13-Ch4`, `CCC-1376`, `ST-III-75-4`, `CIC1983-915`; `hasEdition`/`Edition` and
    `hasTranslation`/`translationOf`/`Translation`. The base text unit's IRI is edition-neutral, though the vernacular `Translation` individual (`John_1_14_NABRE`) does concatenate
    its edition into its IRI.

[^6]:
    Rome working-session materials, "Why AI for the Church Needs a Hierarchy of Authority" (presentation deck, 2026). The pyramid slide and the authority-metadata table slide order
    Commentary and Local Magisterium differently; the reference-linking slide gives `urn:catholic:council:trent:session13:chapter4` as its example target.

[^7]:
    Congregation for Divine Worship and the Discipline of the Sacraments, _Decree on the Celebration of Saints Martha, Mary and Lazarus in the General Roman Calendar_, 26 January
    2021, https://www.vatican.va/roman_curia/congregations/ccdds/documents/rc_con_ccdds_doc_20210126_decreto-santi_en.html.

[^8]:
    CatholicOS, _CLEDR_, github.com/CatholicOS/cledr, `liturgical_events.md` — crosswalk row for _Sanctorum Marthæ, Mariæ et Lazari_, carrying `litcal_key: StMartha`,
    `romcal_key: martha_of_bethany_mary_of_bethany_and_lazarus_of_bethany`, `eprex_key: martha`, and source `missale_romanum_1970`.

[^9]:
    CatholicOS, _CECDR_, github.com/CatholicOS/cecdr. Strip rule and Xinjiang note: `docs/schema-proposal.md`. Counts measured against `data/circumscriptions.json` (2,935 IDs; 58
    containing `arcidiocesi-di-`; 31 ordinariates carrying a type word). Opus Dei rename and its quoted rationale: commit `5067fb8`.

[^10]:
    CatholicOS sibling registries, github.com/CatholicOS: _CLBDR_ (`README.md` line 21 against `docs/schema.md` and `data/editions.json`); _CICLSALDR_ (`docs/schema-proposal.md`
    prefix note; `data/institutes.json`, `icl:cm` typed `society_of_apostolic_life`); _CMDDR_ (commit `13d3de9`, "Fix typo in project name from CLDDR to CMDDR").

[^11]:
    Associated Press, "Just Francis," _Philippine Daily Inquirer_, March 2013, https://newsinfo.inquirer.net/373397/just-francis. The Vatican's first bulletin listed the name
    without a Roman numeral; the press office's gloss was "It will become Francis I after we have a Francis II."

[^12]:
    A. Phillips and M. Davis, eds., _Tags for Identifying Languages_, BCP 47 / RFC 5646 (IETF, September 2009), §3.1.6 (`Deprecated`), §3.1.7 (`Preferred-Value`, including the
    `iw`/`he` example), and §3.4 (stability of `Type`, `Subtag`, `Tag`, and `Added`), https://www.rfc-editor.org/rfc/rfc5646.txt.

[^13]:
    Gene Ontology Consortium, "Ontology Documentation," https://geneontology.org/docs/ontology-documentation/ — "Every term has a GO ID, a unique seven digit identifier prefixed by
    GO:"; obsoleted terms keep "the term and ID … in the ontology," tagged obsolete. See also OBO Foundry, Principle 3: URI/Identifier Space,
    https://obofoundry.org/principles/fp-003-uris.html.

[^14]:
    ISO 3166-3, _Codes for the representation of names of countries and their subdivisions — Part 3: Code for formerly used names of countries_. Burma → Myanmar is archived as
    `BUMM`; `CSHH` was first assigned to Serbia and Montenegro despite its prior use for Czechoslovakia and was subsequently changed to `CSXX`; withdrawn alpha-2 codes are
    transitionally reserved for at least fifty years. See https://en.wikipedia.org/wiki/ISO_3166-3 and ISO Online Browsing Platform, https://www.iso.org/obp/ui/#iso:code:3166:CS.

[^15]:
    CatholicOS, _ontology-semantic-canon_, github.com/CatholicOS/ontology-semantic-canon, `queries/jena/01-church-hierarchy.rq` (`osc:RChKPk9K152BirrIYgAREsY` = Clergy) and
    `sources/ontology-semantic-canon.ttl`; ontokit, github.com/CatholicOS/ontokit-web, `lib/ontology/iriGeneration.ts` (`uuidToBase62`, prefixed `"R"` "to ensure RDF/XML QName
    safety"). The same repository already ships the affordance layer beside those opaque IDs: `lib/hooks/useIriLabels.ts` resolves a set of IRIs to `rdfs:label`s and label-joins
    them into API responses (cached per project and branch), and the Turtle editor's Monaco hover provider — `registerHoverProvider` in `components/editor/TurtleEditor.tsx` —
    renders `Label: <prefLabel>` beside the resolved full IRI on hover.

[^16]:
    FOLIO (Federated Open Legal Information Ontology), https://folio.openlegalstandard.org. The concept _Murder_ resolves at
    `https://folio.openlegalstandard.org/R7Ttdyo4FsvaupPKT35Qry0`; every FOLIO concept IRI carries the same `R`-prefixed base62 local name.
