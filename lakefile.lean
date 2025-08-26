import Lake
open Lake DSL

package «godel-shadow» where
  -- Gödel numbering framework for SAT problems

lean_lib «GodelSAT» where
  -- Core Gödel numbering and SAT definitions

lean_lib «ArithmeticRecursion» where
  -- Recursive arithmetic functions

lean_lib «Examples» where
  -- Practical examples and applications

lean_lib «Theory» where
  -- Theoretical foundations and proofs

@[default_target]
lean_exe «godel-shadow» where
  root := `Main
