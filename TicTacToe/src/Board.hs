module Board (Board, Cell(..)) where

    type Board = [[Cell]]    
    data Cell = Empty | Filled (Either Char Char) deriving (Show, Eq)
