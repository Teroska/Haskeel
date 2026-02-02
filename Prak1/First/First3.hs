main :: IO ()
main = do
    let factorial :: Int -> Int
        factorial n = if n==0 then 1 else n * factorial (n - 1)

    let recurs :: [Int] -> Int
        recurs [] = 0
        recurs (x:xs) = x + recurs xs

    putStrLn $ "Факторіал числа 5 = (" ++ show (factorial 5) ++ ")"
    putStrLn $ "Рекурсивна сума чисел від 1 до 3 = (" ++ show (recurs [1,2,3]) ++ ")"
    putStrLn $ "Рекурсивна сума чисел 10, -5, 7 = (" ++ show (recurs [10, -5, 7]) ++ ")"
