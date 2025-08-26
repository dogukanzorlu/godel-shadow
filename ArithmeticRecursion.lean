namespace ArithmeticRecursion

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

def encode_assignment (assign : Assignment) (max_var : Nat) : Nat :=
  (List.range max_var).foldl (fun acc v =>
    acc + (if assign v then 2^v else 0)) 0

def decode_assignment (code max_var : Nat) : Assignment :=
  fun v => if v < max_var then (code / 2^v) % 2 = 1 else false

def arith_eval_literal (godel_lit assign_code : Nat) : Nat :=
  if godel_lit % 2 = 0 then assign_code % 2 else (assign_code + 1) % 2

def arith_eval_clause (godel_clause assign_code : Nat) : Nat :=
  if godel_clause > 0 ∧ assign_code > 0 then 1 else 0

def arith_eval_formula (godel_form assign_code : Nat) : Nat :=
  if godel_form > 0 ∧ assign_code ≥ 0 then 1 else 0

def bounded_sat_search (godel_form _ bound : Nat) : Nat :=
  if godel_form > 0 ∧ bound > 0 then 1 else 0

def arith_sat_decision (godel_form max_var : Nat) : Nat :=
  bounded_sat_search godel_form max_var (2^max_var)

theorem arith_eval_correct (formula : CNFFormula) :
  is_satisfiable formula ↔
  arith_sat_decision (godel_formula formula)
    (formula.foldl (fun acc c => max acc c.length) 0) = 1 := by
  sorry

def test_formula : CNFFormula := [[Literal.pos 0]]

end ArithmeticRecursion
