zero :: Maybe Int
zero = Just 0

app :: (a->b) -> Maybe a -> Maybe b
app f Nothing = Nothing
app f (Just x) = Just $ f x

data Nat = Zero | Succ Nat
