module ValidatorTest (mainValidatorTest) where 

import Test.QuickCheck
import Validator
import Board

instance Arbitrary Cell where arbitrary = elements [Empty, Filled (Left 'O'), Filled (Right 'X')]

prop_betweenTheSize :: Board -> Int -> Int -> Bool
prop_betweenTheSize board row col =
    let size = length board
    in betweenTheSize board row col == (row >= 0 && col >= 0 && row < size && col < size)

mainValidatorTest :: IO ()
mainValidatorTest = do
    putStrLn "Running Validator property tests..."
    quickCheck prop_betweenTheSize