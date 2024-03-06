module ArithmeticExpression (Expression(..)) where
import Data.Char

--STUDENT: ELVIS JOSE CASTRO HUANCA

data Expression = Val Int 
                | Sum Expression Expression 
                | Mult Expression Expression
                | Sub Expression Expression
                | Pow Expression Expression
                | Div Expression Expression deriving Show

parseExpression :: String -> Expression
parseExpression "" = (Val 0)
parseExpression str = createExpression (getFirstOperator str) (getFirstVal str) (parseExpression (deleteFstOperand str))

deleteFstOperand :: String -> String 
deleteFstOperand "" = ""
deleteFstOperand (x:xs) = if(isDigit x) then deleteFstOperand xs else if (isOperator x) then xs else deleteFstOperand xs

getFirstVal :: String -> Expression
getFirstVal "" = (Val 0)
getFirstVal (x:xs) = if isDigit x then Val (read (x : takeWhile (isDigit) xs)) else getFirstVal xs

getFirstOperator :: String -> Char
getFirstOperator [] = '_'
getFirstOperator (x:xs) = if (isOperator x) then x else getFirstOperator xs

isOperator :: Char -> Bool
isOperator c = elem c "^*/+-"

createExpression :: Char -> Expression -> Expression -> Expression
createExpression c fstExp sndExp | c ==  '^' = Pow  fstExp sndExp
                                | c ==  '*' = Mult fstExp sndExp
                                | c == '/'  = Div  fstExp sndExp
                                | c == '+' = Sum  fstExp sndExp
                                | c == '-' = Sub  fstExp sndExp
                                | otherwise = fstExp                              