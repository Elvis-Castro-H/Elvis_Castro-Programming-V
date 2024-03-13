module Tree where

data Tree a = Leaf | Node Integer (Tree a) a (Tree a) deriving (Show, Eq)

foldTree :: [a] -> Tree a
foldTree [] = Leaf
foldTree xs = buildTree xs (treeHeight (length xs))

treeHeight :: Int -> Integer
treeHeight numElements
  | numElements <= 0 = -1
  | otherwise = floor (logBase 2 (fromIntegral numElements + 1))

buildTree :: [a] -> Integer -> Tree a
buildTree [] _ = Leaf
buildTree [x] _ = Node 0 Leaf x Leaf
buildTree xs h =
    let (left, x:right) = splitAt (div (length xs) 2) xs
    in Node h (buildTree left (h - 1)) x (buildTree right (h - 1))

heightOfTree :: Tree a -> Integer
heightOfTree Leaf = -1
heightOfTree (Node h _ _ _) = h
