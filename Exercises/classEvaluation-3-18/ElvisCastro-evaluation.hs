-- ELVIS JOSE CASTRO HUANCA

data Expr = Var Char | Not Expr | And Expr Expr | Or Expr Expr deriving (Show)
-- 1
opToExp :: Char -> Expr -> Expr -> Expr 
opToExp c exp1 exp2 | c == '^' = And exp1 exp2
                    | c == 'v' = Or exp1 exp2
                    | otherwise = error "Error parser"


verifyNot :: String -> Expr
verifyNot (x:y:xs) = if isNotOp x then Not (Var y) else Var x

isNotOp :: Char -> Bool
isNotOp c = c == '~'

createExp :: String -> Expr
createExp (x:y:z:xs) = opToExp y (Var x) (Var z)

isOperator :: Char -> Bool
isOperator c = elem c "^v"

getFstExp :: String -> String 
getFstExp (x:xs) = takeWhile (/=')') xs



-- 2
eval :: Expr -> (Char -> Bool) -> Bool
eval (Var x) f = f x
eval (Not e) f = not (eval e f)
eval (And e1 e2) f = eval e1 f && eval e2 f
eval (Or e1 e2) f = eval e1 f || eval e2 f

charEval :: Char -> Bool
charEval 'A' = True
charEval 'B' = False
charEval 'C' = True
charEval _   = False


