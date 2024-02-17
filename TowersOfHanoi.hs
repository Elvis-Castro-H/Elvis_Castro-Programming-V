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

    main :: IO ()
    main = do
        n <- getNumberOfDisks
        source <- getName "source"
        dest <- getName "destination"
        free <- getName "spare"
        putStrLn $ "Each tuple in the following sequence indicates the movement of a disk from the initial position to the final position, following the Towers of Hanoi algorithm."
        print $ hanoi n source dest free