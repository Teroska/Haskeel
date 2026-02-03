main :: IO ()
main = do
    let square :: Int -> Int
        square x = x * x

    let list :: [Int]
        list = [1, 2, 3, 4, 5, 6]

    let list1 :: [Int]
        list1 = [0, -1, -2, 10]

    let list2 :: [Int]
        list2 = [5, 5, 5]

    let qwadlist :: [Int] -> [Int]
        qwadlist = map square

    let filterlist :: [Int] -> [Int]
        filterlist = filter even . qwadlist
        
    let sumlist :: [Int] -> Int
        sumlist = foldl (+) 0 
    
    let sumqwadlist :: [Int] -> Int
        sumqwadlist = foldl (+) 0 . qwadlist
    
    putStrLn ("Список квадратів 1 списку: " ++ show (qwadlist list))
    putStrLn ("Список квадратів 2 списку: " ++ show (qwadlist list1))
    putStrLn ("Список квадратів 3 списку: " ++ show (qwadlist list2))
    putStrLn ("Список парних квадратів 1 списку: " ++ show (filterlist list))
    putStrLn ("Список парних квадратів 2 списку: " ++ show (filterlist list1))
    putStrLn ("Список парних квадратів 3 списку: " ++ show (filterlist list2))
    putStrLn ("Сума елементів 1 списку: " ++ show (sumlist list))
    putStrLn ("Сума елементів 2 списку: " ++ show (sumlist list1))
    putStrLn ("Сума елементів 3 списку: " ++ show (sumlist list2))
    putStrLn ("Сума квадратів елементів 1 списку: " ++ show (sumqwadlist list))
    putStrLn ("Сума квадратів елементів 2 списку: " ++ show (sumqwadlist list1))
    putStrLn ("Сума квадратів елементів 3 списку: " ++ show (sumqwadlist list2))
