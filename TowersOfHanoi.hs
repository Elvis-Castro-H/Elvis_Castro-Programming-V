module Hanoi where

    moveDisk :: String -> String -> [(String, String)]
    moveDisk from to = [(from, to)]

    hanoi :: Int -> String -> String -> String -> [(String, String)]
    hanoi 0 _ _ _ = []
    hanoi n source dest spare = 
        hanoi (n-1) source spare dest ++
        (moveDisk source dest) ++
        hanoi (n-1) spare dest source

    getNumberOfDisks :: IO Int
    getNumberOfDisks = do
        putStrLn "Enter the number of disks"
        read <$> getLine

    getName :: String -> IO String
    getName rodName = do
        putStrLn $ "Enter the name for the " ++ rodName ++ " rod"
        getLine