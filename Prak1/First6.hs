main :: IO ()
main = do
    let sumqwadpar :: [Int] -> Int
        sumqwadpar = sum . map (\x -> x * x) . filter even

    let list :: [Int] 
        list = [1,2,3,4,5,6,7,8,9,10]
    let list2 :: [Int]
        list2 = [11,12,13,14,15,16,17,18,19,20]
    let list3 :: [Int]
        list3 = [21,22,23,24,25,26,27,28,29,30]

    putStrLn $ "Cума квадратів парних чисел зі списку 1: " ++ show (list) ++ "=" ++ show (sumqwadpar list)
    putStrLn $ "Cума квадратів парних чисел зі списку 2: " ++ show (list2) ++ "=" ++ show (sumqwadpar list2)
    putStrLn $ "Cума квадратів парних чисел зі списку 3: " ++ show (list3) ++ "=" ++ show (sumqwadpar list3)