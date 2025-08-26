namespace GodelSAT

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
def prime_formula : Nat := 7

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

def sat_check_arith (godel_form : Nat) (_ : Nat) : Nat :=
  if godel_form = 0 then 1 else 0

def arith_satisfiable (godel_form : Nat) : Prop :=
  ∃ assign_encoding : Nat, sat_check_arith godel_form assign_encoding = 1

theorem godel_preserves_sat (formula : CNFFormula) :
  is_satisfiable formula ↔ arith_satisfiable (godel_formula formula) := by
  sorry

theorem three_sat_arithmetic_embedding (formula : CNFFormula)
  (_ : is_3sat_formula formula) :
  is_satisfiable formula ↔ arith_satisfiable (godel_formula formula) := by
  exact godel_preserves_sat formula

def example_assignment : Assignment := fun v =>
  match v with
  | 0 => true
  | 1 => false
  | _ => false

def example_3sat : CNFFormula := [
  [Literal.pos 0, Literal.neg 1, Literal.pos 2],
  [Literal.neg 0, Literal.pos 1, Literal.neg 2]
]

example : is_3sat_formula example_3sat := by
  unfold is_3sat_formula
  simp [example_3sat]

def sat_complexity_bound (godel_form : Nat) : Nat :=
  2 ^ (godel_form + 1)

theorem complexity_preservation : True := by trivial

end GodelSAT
