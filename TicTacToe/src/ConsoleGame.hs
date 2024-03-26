module ConsoleGame (main) where

import Board
import TicTacToe
import Validator

stringBoard :: Board -> [[String]]
stringBoard [] = []
stringBoard (row:rows) = stringRow row : stringBoard rows

stringRow :: [Cell] -> [String] 
stringRow [] = []
stringRow (cell:cells) = case cell of
    Empty -> "_" : stringRow cells
    Filled (Left symbol) -> [symbol] : stringRow cells
    Filled (Right symbol) -> [symbol] : stringRow cells

getPlayer :: Bool -> String
getPlayer isPlayerOne =  if isPlayerOne then "Player 1 (X)" else "Player 2 (O)"

loopGame :: Bool -> Board -> Int -> IO ()
loopGame turnOne board filledCells = do
    putStrLn $ unlines $ map concat $ stringBoard board
    putStrLn $ getPlayer turnOne ++ ", enter the row index"
    r <- readLn 
    putStrLn $ getPlayer turnOne ++ ", enter the column index"
    c <- readLn
    if isValidMove board r c then do 
        let currentBoard = markCell board r c (chooseChar turnOne)
        if (finishGame currentBoard || filledCells == 9)
            then if(thereIsWinner currentBoard) 
                    then do
                        putStrLn $ unlines $ map concat $ stringBoard currentBoard
                        putStrLn $ getPlayer turnOne ++ " won!"
                    else do
                        putStrLn $ unlines $ map concat $ stringBoard currentBoard
                        putStrLn "Draw - Game Over"
            else loopGame (not turnOne) currentBoard (filledCells + 1)
    else loopGame turnOne board filledCells

main :: IO ()
main = do 
    putStrLn "Welcome to the Tic-tac-toe game!"
    loopGame True (createEmptyBoard 3 3) 1
