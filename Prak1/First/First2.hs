main :: IO ()
main = do
    let square :: Int -> Int --Чиста функція бо приймає один аргумент і повертає значення без побічних ефектів
        square x = x * x

    let absValue :: Int -> Int --Чиста функція бо приймає один аргумент і повертає значення без побічних ефектів
        absValue y = if y < 0 then -y else y

    let maxoftwo :: Int -> Int -> Int --Чиста функція бо приймає два аргументи і повертає значення без побічних ефектів
        maxoftwo a b = if a > b then a else b

    putStrLn $ "Квадрат числа 10 = (" ++ show (square 10) ++ ")" 
    putStrLn $ "Абсолютне значення числа -15 = (" ++ show (absValue (-15)) ++ ")"
    putStrLn $ "Максимальне з чисел 10 і 15 = (" ++ show (maxoftwo 10 15) ++ ")"