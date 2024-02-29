import Data.Char

-- 1. Work through the examples from this chapter using GHCi.

examples :: IO ()
examples = do
  putStrLn $ "f"

sum' :: Int -> Int -> Int
sum' x y = x + y

head' :: [a] -> a
head' list = head list

getByIndex :: [a] -> Int -> a
getByIndex list i = list !! i

getNItems :: [a] -> Int -> [a]
getNItems [] _ = []
getNItems list n = take n list

removeNFrom :: [a] -> Int -> [a]
removeNFrom list n = drop n list

sumOfList :: [Int] -> Int
sumOfList ls = sum ls 

productOfList :: [Int] -> Int
productOfList ls = product ls 

appendLists :: [a] -> [a] -> [a]
appendLists ls1 ls2 = ls1 ++ ls2

reverseList :: [a] -> [a]
reverseList ls = reverse ls

{-2. Parenthesise the following numeric expressions:
2^3*4
2*3+4*5
2+3*4^5-}

{-
(2^3)*4
(2*3)+(4*5)
2+(3*(4^5))
-}

isOperand :: Char -> Bool
isOperand c = elem c "^*/+-"

isDigit' :: Char -> Bool
isDigit' c = isDigit c || (c == '.')

tupleFromExpression :: String -> (String, Char, String)
tupleFromExpression (x:y:z) = ([x],y,z)
tupleFromExpression "" = ([],' ',[])

precedence :: Char -> Int
precedence '^' = 3
precedence '*' = 2
precedence '/' = 2
precedence '+' = 1
precedence '-' = 1
precedence _   = 0

addParentheses :: String -> String
addParentheses [] = []
addParentheses [x] = [x]
addParentheses (x:y:z:xs)
    | isOperand y && isDigit' x && isDigit' z && not (null xs) && isOperand (head xs) && (precedence y > precedence (head xs)) = "(" ++ [x,y,z] ++ ")" ++ addParentheses xs
    | isOperand y && isDigit' x && isDigit' z = "(" ++ [x,y,z] ++ ")" ++ addParentheses xs
    | otherwise = x : addParentheses (y:z:xs)
addParentheses xs = xs

{- 3. The script below contains three syntactic errors. Correct these errors and then check that your
script works properly using GHCi.
N = a ’div’ length xs
where
a = 10
xs = [1,2,3,4,5]-}

exercise3 :: IO()
exercise3 = do
  print n
  where
    n = a `div` length xs
      where
        a = 10
        xs = [1,2,3,4,5]

{- 4. The library function last selects the last element of a non-empty list; for example, last
[1,2,3,4,5] = 5. Show how the function last could be defined in terms of the other library
functions introduced in this chapter. Can you think of another possible definition? -}
last' :: [a] -> a
last' x = head (reverse x)

last'' :: [a] -> a
last'' xs = xs !! (length xs - 1)

{-5. The library function init removes the last element from a non-empty list; for example, init
[1,2,3,4,5] = [1,2,3,4]. Show how init could similarly be defined in two different ways-}
init' :: [a] -> [a]
init' [] = []
init' (x:xs) = if length xs > 1 then x : init' xs else x:[]

init'' :: [a] -> [a]
init'' [] = []
init'' xs = reverse (tail (reverse xs))
