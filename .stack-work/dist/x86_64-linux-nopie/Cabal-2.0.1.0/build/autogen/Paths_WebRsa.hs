{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -fno-warn-implicit-prelude #-}
module Paths_WebRsa (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
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
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/nik/projects/WebRsa/.stack-work/install/x86_64-linux-nopie/lts-11.4/8.2.2/bin"
libdir     = "/home/nik/projects/WebRsa/.stack-work/install/x86_64-linux-nopie/lts-11.4/8.2.2/lib/x86_64-linux-ghc-8.2.2/WebRsa-0.1.0.0-EpPPjqUEr1t4srfLuTMeS4"
dynlibdir  = "/home/nik/projects/WebRsa/.stack-work/install/x86_64-linux-nopie/lts-11.4/8.2.2/lib/x86_64-linux-ghc-8.2.2"
datadir    = "/home/nik/projects/WebRsa/.stack-work/install/x86_64-linux-nopie/lts-11.4/8.2.2/share/x86_64-linux-ghc-8.2.2/WebRsa-0.1.0.0"
libexecdir = "/home/nik/projects/WebRsa/.stack-work/install/x86_64-linux-nopie/lts-11.4/8.2.2/libexec/x86_64-linux-ghc-8.2.2/WebRsa-0.1.0.0"
sysconfdir = "/home/nik/projects/WebRsa/.stack-work/install/x86_64-linux-nopie/lts-11.4/8.2.2/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "WebRsa_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "WebRsa_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "WebRsa_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "WebRsa_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "WebRsa_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "WebRsa_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
