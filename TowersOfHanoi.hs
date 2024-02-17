module Hanoi where

    moveDisk :: String -> String -> [(String, String)]
    moveDisk from to = [(from, to)]

    hanoi :: Int -> String -> String -> String -> [(String, String)]
    hanoi 0 _ _ _ = []
    hanoi n source dest spare = 
        hanoi (n-1) source spare dest ++
        (moveDisk source dest) ++
        hanoi (n-1) spare dest source