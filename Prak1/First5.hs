main :: IO ()
main = do

    let square :: Int -> Int
        square x = x * x

    let list :: [Int] 
        list = [1,2,3,4,5,6,7,8,9,10]

    let listfilter :: [Int]
        listfilter = filter even list
    
    let listSquare :: [Int]
        listSquare = map square listfilter
    
    let listsum :: Int
        listsum = sum listSquare
    
    putStrLn $ "Cума квадратів парних чисел зі списку: " ++ show listsum