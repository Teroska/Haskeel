
main :: IO ()
main = do
    let square :: Int -> Int
        square x = x * x

    let list :: [Int] 
        list = [1,2,3,4,5,6,7,8,9,10]

    let listSquare :: [Int]
        listSquare = map square list

    let listfilter :: [Int]
        listfilter = filter even list
    
    let listsum :: Int
        listsum = sum list

    putStrLn $ "Список чисел: " ++ show list
    putStrLn $ "Квадрати чисел зі списку: " ++ show listSquare
    putStrLn $ "Парні числа зі списку: " ++ show listfilter
    putStrLn $ "Сума чисел зі списку: " ++ show listsum
