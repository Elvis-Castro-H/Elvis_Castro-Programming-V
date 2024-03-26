module TicTacToeTest (mainTicTacToeTest) where

import Test.QuickCheck
import TicTacToe
import Board

instance Arbitrary Cell where arbitrary = elements [Empty, Filled (Left 'O'), Filled (Right 'X')]

prop_verifyGroup :: [[Cell]] -> Bool
prop_verifyGroup group = verifyGroup group `seq` True

prop_verifyFilledBoard :: Board -> Bool
prop_verifyFilledBoard board = verifyFilledBoard board `seq` True

genBoard :: Gen Board
genBoard = vectorOf 3 $ vectorOf 3 arbitrary

prop_isEmptyRow :: Board -> Bool
prop_isEmptyRow board = all isEmptyRow board

prop_getDiagonals :: Board -> Property
prop_getDiagonals board =
    not (null board) ==>
    let diagonals = getDiagonals board
    in length diagonals == 2 && all (\cells -> length cells == length board) diagonals

mainTicTacToeTest :: IO ()
mainTicTacToeTest = do
    quickCheck prop_verifyGroup
    quickCheck prop_verifyFilledBoard
    quickCheckWith stdArgs { maxSize = 3 } prop_isEmptyRow
    quickCheckWith stdArgs { maxSize = 3 } prop_getDiagonals