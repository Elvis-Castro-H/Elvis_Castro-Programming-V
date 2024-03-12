module Test(testMain) where

import LogParser
import LogTree
import LogAnalyzer

testParse :: (String -> [LogMessage])
          -> Int
          -> FilePath
          -> IO [LogMessage]
testParse parse n file = take n . parse <$> readFile file

testWhatWentWrong :: (String -> [LogMessage])
                  -> ([LogMessage] -> [String])
                  -> FilePath
                  -> IO [String]
testWhatWentWrong parse whatWentWrong file
  = whatWentWrong . parse <$> readFile file

-- Para ejecutar el programa no reconoce el archivo desde "stack run" pero ejecutando la funcion testMain sí lo hace desde ghci
testBasic :: IO ()
testBasic = do
  let testFile = "log_file.log"

  parsedLogs <- testParse parseLogs 100 testFile
  result <- testWhatWentWrong parseLogs whatWentWrong testFile

  putStrLn "Parsed Logs:"
  print parsedLogs

  putStrLn "\nErrors with severity >= 50:"
  print result

testMain :: IO ()
testMain = do
  putStrLn "Running LogAnalyzer Tests..."
  putStrLn "\nTest 1: Basic Test"
  testBasic
