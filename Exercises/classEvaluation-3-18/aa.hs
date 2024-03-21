  import Data.Maybe
  data Expr = Var Char | Not Expr | And Expr Expr | Or Expr Expr deriving (Show)

  parseVar :: String -> Maybe (Expr, String)
  parseVar ('(':rest) = do
      (exp, rest') <- parseOr rest
      if null rest'
          then Nothing
          else if head rest' == ')'
              then Just (exp, tail rest')
              else Nothing
  parseVar ('~':rest) = do
      (exp, rest') <- parseVar rest
      return (Not exp, rest')
  parseVar (c:rest) | elem c ['A'..'Z'] = Just (Var c, rest)
                   | otherwise = Nothing
  parseVar _ = Nothing

  parseAnd :: String -> Maybe (Expr, String)
  parseAnd input = do
      (exp1, rest) <- parseVar input
      if null rest
          then Just (exp1, rest)
          else if head rest == '^'
              then do
                  (exp2, rest') <- parseAnd (tail rest)
                  return (And exp1 exp2, rest')
              else Just (exp1, rest)

  parseOr :: String -> Maybe (Expr, String)
  parseOr input = do
      (exp1, rest) <- parseAnd input
      if null rest
          then Just (exp1, rest)
          else if head rest == 'v'
              then do
                  (exp2, rest') <- parseOr (tail rest)
                  return (Or exp1 exp2, rest')
              else Just (exp1, rest)

  parseExpression :: String -> Maybe Expr
  parseExpression input = do
      (exp, _) <- parseOr input
      return exp

  eval :: Expr -> [(Char, Bool)] -> Bool
  eval (Var c) assignments = case lookup c assignments of
      Just value -> value
      Nothing -> error "Variable not found in assignments"
  eval (Not exp) assignments = not (eval exp assignments)
  eval (And exp1 exp2) assignments = eval exp1 assignments && eval exp2 assignments
  eval (Or exp1 exp2) assignments = eval exp1 assignments || eval exp2 assignments

  evaluate :: String -> Bool
  evaluate str = eval (fromMaybe (Var '0') (parseExpression str)) [('A', True), ('B', False), ('C', True)]