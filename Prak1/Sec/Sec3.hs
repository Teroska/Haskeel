main :: IO ()
main = do
    let maxRec :: [Int] -> Int
        maxRec [] = error "Empty list"
        maxRec [x] = x
        maxRec (x:xs) = max x (maxRec xs)
    
    let maxfold :: [Int] -> Int
        maxfold xs = foldl1 max xs
    
    putStrLn ("Максимальний елемент списку:" ++ show (maxRec [5, 2, 9, -3, 7])++ " " ++ show (maxRec [42]) ++ " " ++ show (maxRec [-5, -10, -2, -100]))
    putStrLn ("Максимальний елемент списку (fold):" ++ show (maxfold [5, 2, 9, -3, 7])++ " " ++ show (maxfold [42]) ++ " " ++ show (maxfold [-5, -10, -2, -100]))