# Introduction

The applicability of mathematics to the physical world is often framed as a mystery or a fortunate accident. This paper argues for a structuralist resolution: that the "unreasonable effectiveness" of mathematics is, to a large extent, a logical consequence of the consistency of physical events.

Our thesis is that any system described by a non-mathematical object language of qualitative events---provided it satisfies basic conditions of coherence---admits a canonical representation as a mathematical structure. We formalize this by constructing a rigorous bridge between

- a qualitative first-order theory of experimental outcomes, and

- the ordered real structures used in classical and quantum mechanics.

Crucially, we avoid circularity by distinguishing three layers:

1.  **Minimal Coherence ($T_{\min}$):** A weak theory expressing only finite consistency of occurrences and exclusivities. From any $M \models T_{\min}$ we construct a canonical effect algebra $\mathbf{E}(M)$ by a free completion, without assuming algebraic closure at the operational level.

2.  **Rich Coherence ($T_{\mathrm{rich}}$):** A stronger theory adding operational closure principles. We show that $M \models T_{\mathrm{rich}}$ implies that $\mathbf{E}(M)$ is an Archimedean effect algebra with the Riesz decomposition property.

3.  **Structural Core ($\mathcal{S}$):** Using standard representation theorems, we derive from $\mathbf{E}(M)$ an order-unit space supporting ordered real vector spaces, states, and probabilities.

The upshot is that, for empirically coherent systems, the mathematics of physical theory emerges as the canonical structural completion of purely qualitative data.

## Related Work {#related-work .unnumbered}

Our approach is technically closest to the traditions of operational quantum logic and effect algebras. Foulis and Bennett introduced effect algebras as abstract models of unsharp events in quantum measurements, and proved representation results relating them to ordered abelian groups and convex structures. Generalized probabilistic theories and related frameworks axiomatize states, measurements, and transformations at an abstract level and derive convex state spaces and effect spaces.

On the philosophical side, the work resonates with both Hartry Field's nominalist program and ontic structural realism. Field showed that portions of classical physics can be reformulated without quantification over numbers, treating mathematics as a conservative representational aid. Structural realists argue that what our best physical theories get right is the structure they describe, rather than a particular underlying "substance." This paper contributes a concrete technical instantiation of that viewpoint, using the machinery of effect algebras and order-unit spaces to link empirical coherence to mathematical structure.

# The Minimal Operational Framework

We begin with a language that assumes no mathematical objects---no sets, functions, or numbers---only concrete experimental entities.

## The Language $\mathcal{L}_{\min}$

Let $\mathcal{L}_{\min}$ be a many-sorted first-order language with sorts:

- $\mathsf{Sys}$: Physical systems.

- $\mathsf{Run}$: Individual experimental realizations.

- $\mathsf{Out}$: Concrete outcome tokens.

The primitive predicates are:

- $\mathrm{Occurs}(o,r) \subseteq \mathsf{Out} \times \mathsf{Run}$: outcome $o$ occurs in run $r$.

- $\mathrm{SameKind}(o_1,o_2) \subseteq \mathsf{Out}^2$: $o_1$ and $o_2$ are tokens of the same empirical kind (an equivalence relation).

- $\mathrm{Exclusive}(o_1,o_2,r) \subseteq \mathsf{Out}^2 \times \mathsf{Run}$: in run $r$, $o_1$ and $o_2$ are presented as mutually exclusive alternatives.

An $\mathcal{L}_{\min}$-structure $M$ consists of underlying sets $\mathsf{Sys}^M$, $\mathsf{Run}^M$, $\mathsf{Out}^M$ and interpretations of these predicates.

## Minimal Coherence Theory $T_{\min}$

We define $T_{\min}$ as the set of axioms enforcing finite logical consistency of outcomes.

1.  **Kind Structure:** $\mathrm{SameKind}$ is an equivalence relation. We denote the set of equivalence classes (outcome-kinds) in a model $M$ by $$K(M) := \mathsf{Out}^M / \mathrm{SameKind}.$$

2.  **Exclusivity Respected by Occurrence:** Mutually exclusive alternatives cannot co-occur in a run: $$\forall r,o_1,o_2 \,\bigl( \mathrm{Exclusive}(o_1,o_2,r) \rightarrow \neg(\mathrm{Occurs}(o_1,r)\wedge\mathrm{Occurs}(o_2,r)) \bigr).$$

3.  **Non-Triviality of Runs:** $$\forall r\,\exists o\,\mathrm{Occurs}(o,r).$$

4.  **Finite Pattern Soundness:** For every finite tuple of outcome tokens $(o_1,\dots,o_n)$ and every assignment $\sigma\in\{0,1\}^n$ such that $$\sigma(i)=\sigma(j)=1 \text{ and } \mathrm{Exclusive}(o_i,o_j,r)$$ would hold for some run $r$, we add an axiom forbidding that pattern: $$\forall r\,\neg\Bigl(\bigwedge_{i:\,\sigma(i)=1}\mathrm{Occurs}(o_i,r)\;\wedge\;\bigwedge_{j:\,\sigma(j)=0}\neg\mathrm{Occurs}(o_j,r)\Bigr).$$ Intuitively, any finite pattern of occurrences that would contradict the given exclusivity relations is declared impossible.

::: definition_env
**Definition 1**. *A *minimally coherent system* is a model $M\models T_{\min}$.*
:::

Note that $M$ contains no algebraic structure: no sums, no complements, no probabilities. It is a bare catalogue of consistent events.

# The Canonical Effect Algebra

We now construct the algebraic skeleton of $M$. We employ a free universal construction to ensure we do not "smuggle" algebraic properties into the system but rather extract only what is empirically present.

## The Term Algebra

Let $K(M)$ be the set of outcome-kinds in $M$. For each $k \in K(M)$ introduce a generator symbol $g_k$.

We form the free term algebra $\mathcal{T}(K(M))$ over these generators in the signature of effect algebras $(0,1,\oplus,(\cdot)^\perp)$. Elements of $\mathcal{T}(K(M))$ are formal expressions built from the $g_k$, the constants $0,1$, the partial binary symbol $\oplus$, and the unary symbol $^\perp$, modulo the equational effect-algebra axioms (EA1)--(EA4).

## Empirical Congruence

We now identify terms that are forced to agree by the empirical behavior of $M$.

::: definition_env
**Definition 2** (Forced Relations). *For a minimally coherent system $M$, let $\Phi_M$ be the following set of pairs of terms in $\mathcal{T}(K(M))$:*

1.  ***Forced Zero:** If $k \in K(M)$ is such that no token of kind $k$ ever occurs in any run of $M$, then $$(g_k, 0) \in \Phi_M.$$*

2.  ***Forced Orthogonality (Defined Sum):** If outcome-kinds $k_1,k_2$ are always presented as mutually exclusive alternatives whenever they appear together in a run, we allow $g_{k_1} \oplus g_{k_2}$ as a term of $\mathcal{T}(K(M))$. This encodes the fact that their disjoint sum is well-defined.*

3.  ***Forced Sum / Coarse-Graining:** If there exists an outcome-kind $k_3$ such that in every run where $k_1,k_2,k_3$ appear as alternatives, a token of kind $k_3$ occurs if and only if a token of kind $k_1$ or $k_2$ occurs, then we include $$(g_{k_1} \oplus g_{k_2}, g_{k_3}) \in \Phi_M.$$*

4.  ***Forced Unit:** If there is an outcome-kind $k$ such that in every run of $M$ some token of kind $k$ occurs, then $$(g_k,1) \in \Phi_M.$$*

*Let $\approx_M$ be the smallest congruence on $\mathcal{T}(K(M))$ (with respect to the effect-algebra operations) that contains all pairs in $\Phi_M$.*
:::

::: definition_env
**Definition 3**. *The *canonical effect algebra* of $M$ is the quotient $$\mathbf{E}(M) := \mathcal{T}(K(M)) / \approx_M.$$*
:::

::: theorem
**Theorem 4** (Coherence $\Rightarrow$ Effect Algebra). *For any minimally coherent system $M \models T_{\min}$, the structure $\mathbf{E}(M)$ is a well-defined effect algebra. Moreover, $\mathbf{E}(M)$ satisfies the universal property: for any effect algebra $F$ and any map $f:K(M)\to F$ that respects the empirical facts of $M$, there exists a unique effect-algebra homomorphism $\tilde f:\mathbf{E}(M)\to F$ with $\tilde f([g_k]) = f(k)$ for all $k \in K(M)$.*
:::

::: proof
*Proof.* By construction, the term algebra $\mathcal{T}(K(M))$ satisfies the effect-algebra axioms syntactically. The relation $\approx_M$ is a congruence by definition: it is the smallest equivalence relation containing $\Phi_M$ and closed under the operations $0,1,\oplus,(\cdot)^\perp$. Quotienting by a congruence preserves equational axioms and the quasi-equations encoding partiality, so $\mathbf{E}(M)$ inherits an effect-algebra structure.

The universal property is the usual one for a free algebra modulo a congruence: any map from generators into an effect algebra that satisfies the identifying equations in $\Phi_M$ extends uniquely to a homomorphism from the quotient. ◻
:::

This theorem establishes the first bridge: mere finite consistency ($T_{\min}$) is sufficient to generate a canonical event logic $\mathbf{E}(M)$.

# From Coherence to Rich Structure

While $\mathbf{E}(M)$ is an effect algebra, it may be weak (e.g., lacking limits or sufficient refinements). To recover the mathematics of physical theories, we require specific structural properties: the *Riesz Decomposition Property (RDP)* and *Archimedeaness*. Instead of assuming these algebraically, we introduce a stronger operational theory $T_{\mathrm{rich}}$ that forces them.

## The Theory $T_{\mathrm{rich}}$

We now strengthen $T_{\min}$ to a theory $T_{\mathrm{rich}}$ that captures operational analogues of the Riesz decomposition property and Archimedeaness.

::: axiom_env
**Axiom 1** (Operational Refinement (Riesz-Type)). *For any outcome-kinds $A,B,X,Y,C \in K(M)$, suppose:*

1.  *In every run $r$ where tokens of kinds $A,B,C$ are presented as alternatives, a token of kind $C$ occurs in $r$ if and only if a token of kind $A$ or a token of kind $B$ occurs in $r$.*

2.  *In every run $r'$ where tokens of kinds $X,Y,C$ are presented as alternatives, a token of kind $C$ occurs in $r'$ if and only if a token of kind $X$ or a token of kind $Y$ occurs in $r'$.*

*Then there exist outcome-kinds $Z_{AX}, Z_{AY}, Z_{BX}, Z_{BY}$ such that:*

- *Whenever $A$ and $X$ appear as alternatives, $Z_{AX}$ occurs iff tokens of kinds $A$ and $X$ occur together, and similarly for the other pairs.*

- *Whenever $A$ appears as an alternative, its occurrence is empirically equivalent (at the level of runs) to the disjunction "$Z_{AX}$ or $Z_{AY}$", and similarly for $B,X,Y$.*

*Intuitively: any two ways of coarse-graining the same measurement context admit a common refinement into joint alternatives.*
:::

::: axiom_env
**Axiom 2** (Finite Exhaustion (Archimedean-Type)). *There is no outcome-kind $k \in K(M)$ such that, for every integer $N \ge 1$, there exists a single run $r$ and $N$ distinct tokens $o_1,\dots,o_N$ of kind $k$ with $$\bigwedge_{i\neq j} \mathrm{Exclusive}(o_i,o_j,r).$$ In other words, one cannot pack arbitrarily many mutually exclusive copies of the same outcome-kind into a single run.*
:::

::: definition_env
**Definition 5**. *A *richly coherent system* is a model $M \models T_{\mathrm{rich}}$.*
:::

## The Algebra of Rich Systems

::: theorem
**Theorem 6** ($T_{\mathrm{rich}}$ Implies Rich Algebra). *Let $M \models T_{\mathrm{rich}}$. Then the canonical effect algebra $\mathbf{E}(M)$ satisfies:*

1.  *the Riesz Decomposition Property (RDP), and*

2.  *the Archimedean Property.*
:::

::: proof
*Sketch.* The Operational Refinement axiom ensures that whenever a coarse-grained measurement outcome-kind $C$ can be empirically decomposed as "$A$ or $B$" and also as "$X$ or $Y$", there exist joint refinements $Z_{ij}$ that realize the overlaps between these decompositions. Translated into the effect algebra, this is precisely the condition that whenever $c = a \oplus b = x \oplus y$ there exist $z_{ij}$ refining $a,b,x,y$ such that $a = z_{AX} \oplus z_{AY}$, $b = z_{BX} \oplus z_{BY}$, $x = z_{AX} \oplus z_{BX}$, $y = z_{AY} \oplus z_{BY}$. This is the Riesz Decomposition Property.

The Finite Exhaustion axiom directly rules out infinitesimal effects: if an element $e\in \mathbf{E}(M)$ could be added to itself arbitrarily many times without exceeding the unit, this would correspond to being able to realize arbitrarily many mutually exclusive tokens of the same kind within a single run, contradicting the axiom. This is exactly the Archimedean condition. ◻
:::

Thus, richly coherent systems give rise to effect algebras with the structural properties required for the standard representation theorems.

# The Emergence of Essential Mathematics

We now cross the final bridge using standard representation theorems from the literature on effect algebras and ordered abelian groups.

## Representation as an Ordered Group Interval

::: theorem
**Theorem 7** (Representation of Rich Algebras). *Let $\mathbf{E}$ be an effect algebra satisfying the Riesz Decomposition Property and the Archimedean Property. Then there exists a partially ordered abelian group $(G,+,\leq)$ with an order unit $u \in G$ such that $$\mathbf{E}\cong [0,u]_G := \{ g \in G \mid 0 \le g \le u \}$$ as effect algebras, where $\oplus$ corresponds to group addition restricted to $[0,u]_G$.*
:::

From this group $G$, we canonically construct the real vector space $V = G \otimes_{\mathbb{Z}} \mathbb{R}$ and extend the order to $V$, making $(V,\le,u)$ an order-unit space.

::: corollary
**Corollary 8** (Structural Core). *For any richly coherent system $M \models T_{\mathrm{rich}}$, there exists a canonical mathematical structure $$\mathcal{S}(M) = (V(M), V(M)^+, u)$$ where $V(M)$ is an ordered real vector space, $V(M)^+$ is its positive cone, and $u$ is an order unit. This structure supports:*

- ***States / Probability:** States are positive linear functionals $\omega: V(M) \to \mathbb{R}$ with $\omega(u)=1$.*

- ***Observables:** Elements of $V(M)$.*

- ***Norms:** The order-unit norm $\|v\|_u = \inf \{ \lambda > 0 \mid -\lambda u \le v \le \lambda u \}$.*
:::

In many concrete cases (e.g. when $\mathbf{E}(M)$ arises from positive operators on a Hilbert space) this representation recovers the familiar functional-analytic structures of quantum theory. For our purposes, it suffices that $\mathcal{S}(M)$ supports the fragment $\mathsf{Math_{\mathrm{phys}}}$ of mathematics required for classical and quantum physics: real numbers, linear spaces, ordered structure, and probabilities.

# Philosophical Synthesis

We have established a chain of implications: $$M \models T_{\mathrm{rich}}
    \quad\xrightarrow{\;\text{free completion}\;}\quad
    \mathbf{E}(M) 
    \quad\xrightarrow{\;\text{representation}\;}\quad
    \mathcal{S}(M).$$

Here $\mathbf{E}(M)$ is the canonical effect algebra extracted from the qualitative data of $M$, and $\mathcal{S}(M) = (V(M), V(M)^+, u)$ is the associated order-unit space constructed from $\mathbf{E}(M)$ by the standard representation theorems. The structure $\mathcal{S}(M)$ contains the "essential mathematics" of physical theory---real numbers, linearity, probability, and order---derived purely from the operational consistency of $M$.

We now make precise what it means, in this setting, to say that a system is "mathematical in its structure" rather than merely *describable* by mathematics.

::: definition_env
**Definition 9** (Structural Mathematicality). *Let $M$ be a physical system described in the operational language $\mathcal{L}_{\min}$, and let $\mathbf{E}(M)$ be its canonical effect algebra. We say that $M$ is *structurally mathematical* (for $\mathsf{Math_{\mathrm{phys}}}$) if there exist:*

- *an ordered real vector space with order unit $(V, V^+, u)$, and*

- *an effect-algebra isomorphism $$\iota : \mathbf{E}(M) \;\xrightarrow{\ \cong\ }\; [0,u]_V := \{ v \in V \mid 0 \le v \le u \},$$*

*such that $(V, V^+, u)$ supports the fragment $\mathsf{Math_{\mathrm{phys}}}$ of mathematics required for classical and quantum physics (ordered real numbers, linear structure, states, and probabilities).*

*The representation is called *canonical* if any two such triples $(V, V^+, u, \iota)$ and $(V', V'^+, u', \iota')$ are related by a unique order-unit isomorphism $T : V \to V'$ with $T(u) = u'$ and $T \circ \iota = \iota'$.*
:::

In other words, a system is structurally mathematical when its empirically accessible effect structure is not merely modeled by *some* piece of mathematics, but *forces*---up to order-unit isomorphism---a specific order-unit space realizing the $\mathsf{Math_{\mathrm{phys}}}$ fragment.

The results of the previous sections now immediately yield:

::: theorem
**Theorem 10** (Rich Coherence Implies Structural Mathematicality). *Let $M$ be a richly coherent system, i.e. a model $M \models T_{\mathrm{rich}}$. Then $M$ is structurally mathematical in the sense of the preceding definition. More concretely, there exists a canonical order-unit space $$\mathcal{S}(M) = (V(M), V(M)^+, u)$$ and an effect-algebra isomorphism $$\iota : \mathbf{E}(M) \;\xrightarrow{\ \cong\ }\; [0,u]_{V(M)} := \{ v \in V(M) \mid 0 \le v \le u \},$$ unique up to order-unit isomorphism.*
:::

::: proof
*Proof sketch.* By construction, any $M \models T_{\mathrm{rich}}$ gives rise to an effect algebra $\mathbf{E}(M)$ that satisfies the Riesz Decomposition Property and the Archimedean Property. The standard representation theorem for such effect algebras yields a partially ordered abelian group $(G,+,\leq)$ with order unit $u$ such that $\mathbf{E}(M) \cong [0,u]_G$ as effect algebras.

Passing to the real vector-space completion $V = G \otimes_{\mathbb{Z}} \mathbb{R}$ and extending the order, we obtain an order-unit space $(V, V^+, u)$ whose interval $[0,u]_V$ is naturally identified with $[0,u]_G$ and hence with $\mathbf{E}(M)$. Setting $\mathcal{S}(M) = (V(M), V(M)^+, u)$ and taking $\iota$ to be the composite of these identifications gives the desired representation. Uniqueness up to order-unit isomorphism follows from the uniqueness part of the representation theorem. ◻
:::

**Conclusion.** Since every richly coherent system $M \models T_{\mathrm{rich}}$ gives rise to such a canonical order-unit representation $\mathcal{S}(M)$, rich empirical coherence entails structural mathematicality in the following sense:

- All empirically accessible distinctions about $M$ that can be expressed in the operational language $\mathcal{L}_{\min}$ are encoded in $\mathbf{E}(M)$, and hence in the interval $[0,u]_{V(M)} \subseteq \mathcal{S}(M)$.

- The mathematics of standard physical theories ($\mathsf{Math_{\mathrm{phys}}}$) is available *internally* to $\mathcal{S}(M)$, without being postulated at the outset: real numbers, linear combinations, ordered structure, and probabilistic states arise as the structural completion of qualitative empirical data.

On this view, mathematics is not an external imposition on the world but the rigid skeleton of coherent behavior. Different metaphysical interpretations of that skeleton are possible (nominalist, structural realist, Platonist), but the core structural claim is invariant: whenever a system satisfies the rich coherence constraints encoded in $T_{\mathrm{rich}}$, it thereby instantiates a canonical piece of mathematical structure of the sort used in classical and quantum physics.

::: thebibliography
9 Foulis, D. J., & Bennett, M. K. (1994). Effect algebras and unsharp quantum logics. *Foundations of Physics*, 24(10), 1331--1352.

Worrall, J. (1989). Structural realism: The best of both worlds? *Dialectica*, 43(1-2), 99--124.

Wigner, E. P. (1960). The unreasonable effectiveness of mathematics in the natural sciences. *Communications on Pure and Applied Mathematics*, 13(1), 1--14.

Gudder, S. (1998). An overview of effect algebras. *International Journal of Theoretical Physics*, 37(1), 915--919.

Field, H. (1980). *Science without numbers: A defence of nominalism*. Princeton University Press.
:::
