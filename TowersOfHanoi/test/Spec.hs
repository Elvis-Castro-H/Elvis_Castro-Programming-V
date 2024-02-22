import Test.QuickCheck
import TowerOfHanoi

-- Test for hanoi function
prop_hanoi :: Int -> Property
prop_hanoi n = n >= 0 ==> length (hanoi n "a" "b" "c") == 2^n - 1

-- Test that no larger disk is on top of a smaller one.
prop_NoLargerOnSmaller :: Int -> Property
prop_NoLargerOnSmaller n = n >= 0 ==> noLargerOnSmaller (hanoi n "a" "b" "c")
  where
    noLargerOnSmaller moves = all (\(from, to) -> from < to) moves

-- Run the tests.
main :: IO ()
main = do
    quickCheck prop_hanoi
    quickCheck prop_NoLargerOnSmaller
