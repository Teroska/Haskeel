module Functions
    ( square
    , absValue
    , maxOfTwo
    ) where

square :: Int -> Int
square x = x * x

absValue :: Int -> Int
absValue y = if y < 0 then -y else y

maxOfTwo :: Int -> Int -> Int
maxOfTwo a b = if a > b then a else b
