test :: [Char] -> Bool
test ['a', _ , _] = True

fac :: Int ->Int
fac n | n==0 = 1
      | otherwise = fac(n-1) * n

