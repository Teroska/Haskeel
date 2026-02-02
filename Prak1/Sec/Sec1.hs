main :: IO ()
main = do
    let factorial :: Int -> Int
        factorial n = if n==0 then 1 else n * factorial (n - 1)

    putStrLn "Факторіали чисел:" 
    putStrLn $ "0 = (" ++ show (factorial 0) ++ ")"
    putStrLn $ "1 = (" ++ show (factorial 1) ++ ")"
    putStrLn $ "5 = (" ++ show (factorial 5) ++ ")"
    putStrLn $ "7 = (" ++ show (factorial 7) ++ ")"
    putStrLn $ "10 = (" ++ show (factorial 10) ++ ")"

