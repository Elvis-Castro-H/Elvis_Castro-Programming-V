module TestInClass where

import Data.Maybe

-- Student: Elvis Jose Castro Huanca

data Expr = Var Char | Not Expr | And Expr Expr | Or Expr Expr deriving (Show)

-- 1. 
parseVariable :: String -> Maybe (Expr, String)
parseVariable ('(':rest) = do
    (exp, rest') <- parseOr rest
    if null rest'
        then Nothing
        else if head rest' == ')'
            then Just (exp, tail rest')
            else Nothing
parseVariable ('~':rest) = do
    (exp, rest') <- parseVariable rest
    return (Not exp, rest')
parseVariable (c:rest) | elem c "ABC" = Just (Var c, rest)
                       | otherwise = Nothing
parseVariable _ = Nothing

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

parseAnd :: String -> Maybe (Expr, String)
parseAnd input = do
    (exp1, rest) <- parseVariable input
    if null rest
        then Just (exp1, rest)
        else if head rest == '^'
            then do
                (exp2, rest') <- parseAnd (tail rest)
                return (And exp1 exp2, rest')
            else Just (exp1, rest)

parseExpression :: String -> Maybe Expr
parseExpression input = do
    (exp, _) <- parseOr input
    return exp

-- 2. 
evaluateExpression :: Expr -> [(Char, Bool)] -> Bool
evaluateExpression (Var c) booleanValue = case lookup c booleanValue of
    Just value -> value
evaluateExpression (Not exp) booleanValue = not (evaluateExpression exp booleanValue)
evaluateExpression (And exp1 exp2) booleanValue = evaluateExpression exp1 booleanValue && evaluateExpression exp2 booleanValue
evaluateExpression (Or exp1 exp2) booleanValue = evaluateExpression exp1 booleanValue || evaluateExpression exp2 booleanValue

evaluateString :: String -> Bool
evaluateString str = evaluateExpression (fromMaybe (Var '0') (parseExpression str)) [('A', True), ('B', False), ('C', True)]
