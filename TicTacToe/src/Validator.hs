module Validator where
    import Board

    isValidMove :: Board -> Int -> Int -> Bool
    isValidMove board row col = isValid where isValid = betweenTheSize board row col && isDisoccupied board row col

    betweenTheSize :: Board -> Int -> Int -> Bool
    betweenTheSize board x y = betweenLower && betweenUpper 
        where
            betweenLower = x >= 0 && y >= 0
            betweenUpper = x < length board && y < length board

    isDisoccupied :: Board -> Int -> Int -> Bool
    isDisoccupied board row col = ((board !! row) !! col) == Empty