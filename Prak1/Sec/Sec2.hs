fib :: Int -> [Integer]
fib n = go n 0 1
    where
        go 0 a _ = [a]
        go k a b = a : go (k - 1) b (a + b)

main :: IO ()
main = do 
    
    putStrLn $ "Перші 10 чисел Фібоначчі:" ++ show (fib 9) 