module TestTowerOfHanoi where

import Test.QuickCheck (quickCheck)
import TowerOfHanoi

prop_moveDisk :: String -> String -> Property
prop_moveDisk from to = moveDisk from to === [(from, to)]

prop_hanoi_0 :: Property  
prop_hanoi_0 = hanoi 0 "A" "B" "C" === []

prop_hanoi_n :: Int -> Property
prop_hanoi_n n = length (hanoi n "A" "B" "C") === (2^n) - 1

main = do
  quickCheck prop_moveDisk
  quickCheck prop_hanoi_0
  quickCheck prop_hanoi_length 
