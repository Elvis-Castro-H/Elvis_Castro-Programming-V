module LogParser(parseLogs, MessageType(..), LogMessage(..)) where

data MessageType = Info | Warning | Error Int deriving (Show, Eq)

type TimeStamp = Int

data LogMessage = LogMessage MessageType TimeStamp String
                | Unknown String
                deriving (Show, Eq)

instance Ord LogMessage where
  compare (LogMessage _ ts1 _) (LogMessage _ ts2 _) = compare ts1 ts2                

charFromStr :: String -> Char
charFromStr (x:_) = x

getMessageType :: Char -> Int -> MessageType
getMessageType x y
    | x == 'I' = Info
    | x == 'W' = Warning
    | x == 'E' = Error y
    | otherwise = error "Invalid message type"

parseMessage :: String -> LogMessage
parseMessage str =
    let (msgType, rest) = splitAt 1 str
        (timeStamp, msg) = getTimeStampString (words rest)
    in case msgType of
        "I" -> LogMessage Info timeStamp msg
        "W" -> LogMessage Warning timeStamp msg
        "E" -> LogMessage (getMessageType (charFromStr msgType) timeStamp) (getTimeStampError msg) (getMsgError msg)
        _   -> Unknown str
  

parseLogs :: String -> [LogMessage]
parseLogs logFile = map parseMessage (lines logFile)

getTimeStampError :: String -> Int
getTimeStampError s = read $ takeWhile (\c -> c /= ' ') s

getMsgError :: String -> String
getMsgError (x:xs) = if x == ' ' then xs else getMsgError xs

getTimeStampString :: [String] -> (TimeStamp, String)
getTimeStampString (x:xs) = (read x, unwords xs)