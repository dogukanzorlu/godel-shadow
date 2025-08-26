namespace Examples

abbrev Var := Nat

inductive Literal where
  | pos : Var → Literal
  | neg : Var → Literal

abbrev Clause := List Literal
abbrev CNFFormula := List Clause
abbrev Assignment := Var → Bool

def prime_var : Nat := 2
def prime_neg : Nat := 3
def prime_clause : Nat := 5

def godel_literal : Literal → Nat
  | Literal.pos v => prime_var ^ (v + 1)
  | Literal.neg v => prime_neg * (prime_var ^ (v + 1))

def godel_clause (c : Clause) : Nat :=
  c.foldl (fun acc lit => acc * godel_literal lit) 1

def godel_formula (f : CNFFormula) : Nat :=
  f.foldl (fun acc clause => acc * (prime_clause ^ godel_clause clause)) 1

def eval_literal (lit : Literal) (assign : Assignment) : Bool :=
  match lit with
  | Literal.pos v => assign v
  | Literal.neg v => ¬(assign v)

def eval_clause (clause : Clause) (assign : Assignment) : Bool :=
  clause.any (eval_literal · assign)

def eval_formula (formula : CNFFormula) (assign : Assignment) : Bool :=
  formula.all (eval_clause · assign)

def is_satisfiable (formula : CNFFormula) : Prop :=
  ∃ assign : Assignment, eval_formula formula assign = true

def is_3sat_formula (formula : CNFFormula) : Prop :=
  ∀ clause ∈ formula, clause.length = 3

def sat_example_1 : CNFFormula := [[Literal.pos 0]]

theorem sat_example_1_is_sat : is_satisfiable sat_example_1 := by
  sorry

def unsat_example_1 : CNFFormula := [[Literal.pos 0], [Literal.neg 0]]

theorem unsat_example_1_is_unsat : ¬is_satisfiable unsat_example_1 := by
  sorry

def three_sat_example_1 : CNFFormula := [
  [Literal.pos 0, Literal.pos 1, Literal.pos 2],
  [Literal.neg 0, Literal.neg 1, Literal.neg 2]
]

theorem three_sat_example_1_is_3sat : is_3sat_formula three_sat_example_1 := by
  simp [is_3sat_formula, three_sat_example_1]

theorem three_sat_example_1_is_sat : is_satisfiable three_sat_example_1 := by
  sorry

def demo_godel_numbers : IO Unit := do
  let formula1 := [[Literal.pos 0]]
  let formula2 := [[Literal.pos 0], [Literal.neg 0]]

  IO.println s!"Simple satisfiable formula Gödel number: {godel_formula formula1}"
  IO.println s!"Unsatisfiable formula Gödel number: {godel_formula formula2}"

example : godel_literal (Literal.pos 0) = 2 := by
  rfl

example : godel_literal (Literal.neg 0) = 6 := by
  rfl

def simple_graph_coloring : CNFFormula := [
  [Literal.pos 0, Literal.pos 1],
  [Literal.pos 2, Literal.pos 3],
  [Literal.neg 0, Literal.neg 2],
  [Literal.neg 1, Literal.neg 3]
]

theorem simple_graph_coloring_is_sat : is_satisfiable simple_graph_coloring := by
  sorry

def generate_formula (n : Nat) : CNFFormula :=
  (List.range n).map (fun i => [Literal.pos i])

def show_exponential_growth : IO Unit := do
  IO.println "Gödel number growth:"
  IO.println s!"n=1: {godel_formula (generate_formula 1)}"
  IO.println s!"n=2: {godel_formula (generate_formula 2)}"
  IO.println s!"n=3: {godel_formula (generate_formula 3)}"

end Examples
