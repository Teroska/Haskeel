import Functions (square)
main :: IO ()
main = do
    let list :: [Int] 
        list = [1,2,3,4,5,6,7,8,9,10]
    let listfilter :: [Int]
        listfilter = map square list
    putStrLn $ "Квадрати чисел зі списку: " ++ show listfilter