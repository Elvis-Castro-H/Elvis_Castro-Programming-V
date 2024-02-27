--parenthesizedFunction :: String -> [String]
--parenthesizedFunction "" = []

aux :: [Char] -> [Char]
"" = []
aux (x:xs) = x : aux xs

split2 :: String -> Char -> [String]
split2 [] _ = []
split2 (x:xs) c | x == c = split2 xs c
                | otherwise = (x : takeWhile (/= c) xs) : split2 (dropWhile (/= c) xs) c

split :: String -> Char -> [String]
split [] _ = []
split (x:xs) c | x == c = split xs c
               | otherwise = [splitAux2 (x:xs) c] ++ split xs c


splitAux2 :: String -> Char -> String
splitAux2 [] _ = []
splitAux2 (x:y:xs) c | y==c = [x]
                | otherwise = x: splitAux2 xs c

getWord :: String c -> String 
             