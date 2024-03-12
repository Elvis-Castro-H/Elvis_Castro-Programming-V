module LogAnalyzer(whatWentWrong) where

import LogParser
import LogTree

whatWentWrong :: [LogMessage] -> [String]
whatWentWrong logs = getErrorMessages (inOrder (build logs))

getErrorMessages :: [LogMessage] -> [String]
getErrorMessages [] = []
getErrorMessages (LogMessage (Error severity) _ msg : str) | severity >= 50 = msg : getErrorMessages str
                                                           | otherwise = getErrorMessages str
getErrorMessages (_ : str) = getErrorMessages str