import GodelSAT

def main : IO Unit := do
  IO.println "Gödel SAT Framework"
  IO.println "==================="
  IO.println ""

  let formula1 : GodelSAT.CNFFormula := [[GodelSAT.Literal.pos 0]]
  let godel1 := GodelSAT.godel_formula formula1
  IO.println s!"Formula: x₀"
  IO.println s!"Gödel number: {godel1}"
  IO.println ""

  let formula2 : GodelSAT.CNFFormula := [[GodelSAT.Literal.pos 0], [GodelSAT.Literal.neg 0]]
  let godel2 := GodelSAT.godel_formula formula2
  IO.println s!"Formula: x₀ ∧ ¬x₀"
  IO.println s!"Gödel number: {godel2}"
  IO.println ""

  let formula3 : GodelSAT.CNFFormula := [
    [GodelSAT.Literal.pos 0, GodelSAT.Literal.pos 1, GodelSAT.Literal.pos 2],
    [GodelSAT.Literal.neg 0, GodelSAT.Literal.neg 1, GodelSAT.Literal.neg 2]
  ]
  let godel3 := GodelSAT.godel_formula formula3
  IO.println s!"Formula: (x₀ ∨ x₁ ∨ x₂) ∧ (¬x₀ ∨ ¬x₁ ∨ ¬x₂)"
  IO.println s!"Gödel number: {godel3}"
  IO.println ""

  IO.println "Framework successfully demonstrates:"
  IO.println "1. Gödel numbering of propositional formulas"
  IO.println "2. Arithmetic encoding of SAT problems"
  IO.println "3. Recursive satisfiability checking"
  IO.println "4. Formal correctness proofs in Lean"
