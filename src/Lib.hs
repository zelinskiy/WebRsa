{-# LANGUAGE DataKinds       #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeOperators   #-}
module Lib
    ( startApp
    ) where

import Data.Aeson hiding (encode, decode)
import Data.Aeson.TH
import Network.Wai
import Network.Wai.Handler.Warp
import Servant

import Data.Char (chr)

type API = "encode" :> Capture "e" Integer :> Capture "n" Integer :> Capture "msg" String :> Get '[JSON] String
  :<|> "static" :> Raw

startApp :: IO ()
startApp = run 8080 $ serve (Proxy :: Proxy API) server

server :: Server API
server = (\e n m -> return (encrypt e n m))
  :<|> serveDirectoryFileServer "./static"

encrypt :: Integer -> Integer -> String -> String
encrypt 0 0 msg = 
  let primes      = take 90 $ filter isPrime [1..]
      p1          = last primes
      p2          = last $ init primes
      tot         = totient p1 p2
      e           =  myE tot
      n           = p1  * p2 
      rsa_encoded =  rsa_encode n e $ encode msg      
      encrypted   = concatMap show rsa_encoded
      d           =  myD e n tot
      decrypted   = decode $ rsa_decode d n rsa_encoded
  in "enc:"       ++ encrypted
      ++ "; dec:" ++ decrypted
      ++ "; p1:"  ++ show p1
      ++ "; p2:"  ++ show p2
      ++ "; tot:" ++ show tot
      ++ "; e:"   ++ show e
      ++ "; n:"   ++ show n
      ++ "; d:"   ++ show d
encrypt e n msg =
  let rsa_encoded = rsa_encode n e $ encode msg
      encrypted   = concatMap show rsa_encoded
  in "enc:" ++ encrypted



encode :: String -> [Integer]
encode s = map (toInteger . fromEnum ) s
 
rsa_encode :: Integer -> Integer -> [Integer] -> [Integer]
rsa_encode n e numbers = map (\num -> mod ( num ^ e ) n ) numbers
 
rsa_decode :: Integer -> Integer -> [Integer] -> [Integer]
rsa_decode d n ciphers = map (\c -> mod ( c ^ d ) n ) ciphers
 
decode :: [Integer] -> String
decode encoded = map ( chr . fromInteger ) encoded 
 
divisors :: Integer -> [Integer]
divisors n = [m | m <- [1..n] , mod n m == 0 ]
 
isPrime :: Integer -> Bool
isPrime n = divisors n == [1,n]
 
totient :: Integer -> Integer -> Integer
totient prime1 prime2 = (prime1 - 1 ) * ( prime2 - 1 ) 
 
myE :: Integer -> Integer
myE tot = head [n | n <- [2..tot - 1] , gcd n tot == 1]
 
myD :: Integer -> Integer -> Integer  -> Integer
myD e n phi = head [d | d <- [1..n] , mod ( d * e ) phi == 1]
