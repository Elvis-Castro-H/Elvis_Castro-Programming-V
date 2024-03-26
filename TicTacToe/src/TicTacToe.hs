module TicTacToe where

    import Board
    import Validator

    data Directions = LeftDir | RightDir | DownDir | DiagonalDownLeft | DiagonalDownRight deriving (Show)

    createEmptyBoard :: Int -> Int -> Board
    createEmptyBoard row col = replicate row (replicate col (Empty))

    createEmptyBoard' :: Int -> Int -> Board
    createEmptyBoard' row col = replicate row (replicate col (Filled (Left 'O')))

    chooseChar :: Bool -> Cell
    chooseChar True = Filled (Left 'X')
    chooseChar False = Filled (Right 'O')

    markCell :: Board -> Int -> Int -> Cell -> Board
    markCell board row col symbol =
        if isValidMove board row col
            then take row board ++ [take col (board !! row) ++ [symbol] ++ drop (col + 1) (board !! row)] ++ drop (row + 1) board
            else board

    finishGame :: Board -> Bool
    finishGame board = thereIsWinner board || verifyFilledBoard board

    thereIsWinner :: Board -> Bool
    thereIsWinner board = verifyGroup board || verifyGroup (getColumns board 0) || verifyGroup (getDiagonals board)

    verifyGroup :: [[Cell]] -> Bool
    verifyGroup [] = False
    verifyGroup (x:xs) = areEquals x || verifyGroup xs
 
    verifyFilledBoard :: Board -> Bool
    verifyFilledBoard [] = True
    verifyFilledBoard (x:xs) = if isEmptyRow x then False else verifyFilledBoard xs

    isEmptyRow :: [Cell] -> Bool
    isEmptyRow [] = True
    isEmptyRow (x:xs) = if x /= Empty then isEmptyRow xs else True
    
    areEquals :: [Cell] -> Bool
    areEquals [] = True
    areEquals (x:xs) | x == Empty = False
                     | otherwise = areEquals' x xs

    areEquals' :: Cell -> [Cell] -> Bool
    areEquals' _ [] = True
    areEquals' c (x:xs) = if c == x then areEquals' c xs else False

    getColumns :: Board -> Int -> [[Cell]]
    getColumns [] _ = []
    getColumns board col
        | col < 0 || col >= length (head board) = []
        | otherwise = getColumn col board : getColumns board (col + 1)

    getColumn :: Int -> Board -> [Cell]
    getColumn _ [] = []
    getColumn col (row:rows)
        | col < 0 || col >= length row = []
        | otherwise = row !! col : getColumn col rows

    getDiagonals :: Board -> [[Cell]]
    getDiagonals board = [leftDiagonal, rightDiagonal]
        where
            leftDiagonal = [board !! i !! i | i <- [0..size - 1]]
            rightDiagonal = [board !! i !! (size - 1 - i) | i <- [0..size - 1]]
            size = length board