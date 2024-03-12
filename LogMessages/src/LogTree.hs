module LogTree(inOrder, build) where
import LogParser

data MessageTree = Leaf | Node MessageTree LogMessage MessageTree deriving(Show)


insert :: LogMessage -> MessageTree -> MessageTree
insert (Unknown _) tree = tree
insert value Leaf = Node Leaf value Leaf
insert value (Node left x right) | value == x = (Node left x right)
                                 | value < x = (Node (insert value left) x right)
                                 | value > x = (Node left x (insert value right))

build :: [LogMessage] -> MessageTree
build [] = Leaf
build (x:xs) = insert x (build xs)             

inOrder :: MessageTree -> [LogMessage]
inOrder Leaf = []
inOrder (Node left x right) = inOrder left ++ [x] ++ inOrder right
