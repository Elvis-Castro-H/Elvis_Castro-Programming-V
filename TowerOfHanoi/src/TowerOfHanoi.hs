module TowerOfHanoi where

-- Represents the movement of a disk from one rod to another.
    moveDisk :: String -> String -> [(String, String)]
    moveDisk from to = [(from, to)]

-- Solves the Towers of Hanoi problem for the specified number of disks.
    hanoi :: Int -> String -> String -> String -> [(String, String)]
    hanoi 0 _ _ _ = []
    hanoi n source dest spare = 
        hanoi (n-1) source spare dest ++
        (moveDisk source dest) ++
        hanoi (n-1) spare dest source

-- Retrieves the number of disks from user input.
    getNumberOfDisks :: IO Int
    getNumberOfDisks = do
        putStrLn "Enter the number of disks"
        read <$> getLine

-- Retrieves the name for a rod from user input.
    getName :: String -> IO String
    getName rodName = do
        putStrLn $ "Enter the name for the " ++ rodName ++ " rod"
        getLine

-- Main function to interactively solve the Towers of Hanoi problem.
    main :: IO ()
    main = do
        n <- getNumberOfDisks
        source <- getName "source"
        dest <- getName "destination"
        spare <- getName "spare"
        putStrLn $ "\nEach tuple in the following sequence indicates the movement of a disk from the initial position to the final position, following the Towers of Hanoi algorithm.\n"
        print $ hanoi n source dest spare