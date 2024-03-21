module ExamSolveAlt where

data Expr = Var Char 
          | Not Expr 
          | And Expr Expr 
          | Or Expr Expr 
          deriving (Show)

-- Función que convierte un carácter y dos expresiones en una expresión lógica
convertToExpression :: Char -> Expr -> Expr -> Expr
convertToExpression '∩' e1 e2 = And e1 e2
convertToExpression '∪' e1 e2 = Or e1 e2
convertToExpression _ e1 e2   = Var '0'  -- Valor por defecto, en caso de operador no reconocido

-- Función que verifica si un carácter es un operador lógico
isOperator :: Char -> Bool
isOperator c = c elem "^|"

-- Función que construye una expresión lógica a partir de una cadena de texto
parseExpression  :: String -> Expr
parseExpression  []       = Var '0'
parseExpression  [x]      = Var x  
parseExpression  ('~':xs) = Not (parseExpression  xs)
parseExpression  (x:y:xs)
  | isOperator y = convertToExpression y (parseExpression  [x]) (parseExpression  xs)
  | otherwise    = parseExpression  (y:xs)

-- Función que encuentra el valor de verdad de una expresión lógica dado un conjunto de asignaciones
evaluateExpression :: Expr -> [(Char, Bool)] -> Bool
evaluateExpression (Var c) tuples = findBoolValue c tuples
evaluateExpression (Not e) tuples = not (evaluateExpression e tuples)
evaluateExpression (And e1 e2) tuples = (evaluateExpression e1 tuples) && (evaluateExpression e2 tuples)
evaluateExpression (Or e1 e2) tuples = (evaluateExpression e1 tuples) || (evaluateExpression e2 tuples)

-- Función que busca el valor booleano de un carácter en un conjunto de tuplas
findBoolValue :: Char -> [(Char, Bool)] -> Bool
findBoolValue c ((char, bool):tuples)
  | c == char = bool
  | otherwise = findBoolValue c tuples

-- Función que obtiene el valor booleano de una expresión lógica a partir de una cadena de texto y un conjunto de asignaciones
getBooleanValueFromString :: String -> [(Char, Bool)] -> Bool
getBooleanValueFromString expr tuples = evaluateExpression (buildExpressionFromString expr) tuples