strToTuples :: String -> [(String, Int)]
strToTuples "" = [("",-1)]
strToTuples lst = listToTuples (split' lst ',')

listToTuples :: [String] -> [(String, Int)]
listToTuples [] = []
listToTuples (x:xs) = strToTup x : listToTuples xs

split' :: String -> Char -> [String]
split' [] _ = []
split' (x:xs) c | x == c = split' xs c
               | otherwise = (x : takeWhile (/= c) xs) : split' (dropWhile (/= c) xs) c

strToTup :: String -> (String, Int)    
strToTup "" = ("",0)
strToTup str = (takeWhile (/=' ') str, read (dropWhile (/=' ') str))

-- 1
calculateAverage :: String -> Int
calculateAverage "" = 0
calculateAverage str = div (sum (getAges (strToTuples str))) (length (getAges (strToTuples str)) )

getAges :: [(String, Int)] -> [Int]
getAges [] = []
getAges (x:xs) = snd x : getAges xs

-- 2
getNames :: String -> [String]
getNames "" = []
getNames str = getNames' (strToTuples str)

getNames' :: [(String, Int)] -> [String]
getNames' [] = []
getNames' (x:xs) = fst x : getNames' xs

-- 3
listOfLessThan :: String -> Int -> [(String, Int)]
listOfLessThan "" _ = []
listOfLessThan str maxAge = listOfLessThan' maxAge (strToTuples str)

listOfLessThan' :: Int -> [(String, Int)] -> [(String, Int)]
listOfLessThan' _ [] = []
listOfLessThan' maxAge ((name, age) : xs)
  | age < maxAge = (name, age) : listOfLessThan' maxAge xs
  | otherwise = listOfLessThan' maxAge xs

-- 4
getTuplesBetween :: String -> Int -> Int -> [(String, Int)]
getTuplesBetween "" _ _ = []
getTuplesBetween str min max = getTuplesBetween' (strToTuples str) min max

getTuplesBetween' :: [(String, Int)] -> Int -> Int -> [(String, Int)]
getTuplesBetween' [] _ _ = []
getTuplesBetween' ((name, age):xs) min max = if age <= max && age >= min then (name, age) : getTuplesBetween' xs min max else getTuplesBetween' xs min max
