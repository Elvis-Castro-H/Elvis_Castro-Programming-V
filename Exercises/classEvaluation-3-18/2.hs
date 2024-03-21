data Expr = Var Char | Not Expr | And Expr Expr | Or Expr Expr deriving (Show)

-- Define a function from Char to Bool to evaluate the variables
charEval :: Char -> Bool
charEval 'A' = True
charEval 'B' = True
charEval _   = False

-- Define an expression to evaluate
expr :: Expr
expr = createExp "(A^B)v(~A^B)"

-- Evaluate the expression using the truth table
evalExprs :: Expr -> [(Char, Bool)] -> [Bool]
evalExprs e ts = map (eval e . charEval . fst) ts

-- Example usage:
main :: IO ()
main = do
  putStrLn "Expression:"
  print expr
  putStrLn "Truth table:"
  print truthTable
  putStrLn "Expression evaluations:"
  print $ evalExprs expr truthTable