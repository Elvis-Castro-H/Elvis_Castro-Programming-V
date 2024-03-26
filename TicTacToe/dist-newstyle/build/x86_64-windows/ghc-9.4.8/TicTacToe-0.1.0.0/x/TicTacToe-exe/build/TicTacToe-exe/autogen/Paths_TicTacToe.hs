{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
#if __GLASGOW_HASKELL__ >= 810
{-# OPTIONS_GHC -Wno-prepositive-qualified-module #-}
#endif
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_TicTacToe (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where


import qualified Control.Exception as Exception
import qualified Data.List as List
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude


#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir `joinFileName` name)

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath




bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath
bindir     = "C:\\cabal\\bin"
libdir     = "C:\\cabal\\x86_64-windows-ghc-9.4.8\\TicTacToe-0.1.0.0-inplace-TicTacToe-exe"
dynlibdir  = "C:\\cabal\\x86_64-windows-ghc-9.4.8"
datadir    = "C:\\cabal\\x86_64-windows-ghc-9.4.8\\TicTacToe-0.1.0.0"
libexecdir = "C:\\cabal\\TicTacToe-0.1.0.0-inplace-TicTacToe-exe\\x86_64-windows-ghc-9.4.8\\TicTacToe-0.1.0.0"
sysconfdir = "C:\\cabal\\etc"

getBinDir     = catchIO (getEnv "TicTacToe_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "TicTacToe_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "TicTacToe_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "TicTacToe_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "TicTacToe_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "TicTacToe_sysconfdir") (\_ -> return sysconfdir)



joinFileName :: String -> String -> FilePath
joinFileName ""  fname = fname
joinFileName "." fname = fname
joinFileName dir ""    = dir
joinFileName dir fname
  | isPathSeparator (List.last dir) = dir ++ fname
  | otherwise                       = dir ++ pathSeparator : fname

pathSeparator :: Char
pathSeparator = '\\'

isPathSeparator :: Char -> Bool
isPathSeparator c = c == '/' || c == '\\'
