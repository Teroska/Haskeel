main :: IO ()
main = do
    let grades :: [Int]
        grades = [60, 75, 90, 100, 45, 82, 73]
    let threshold :: Double
        threshold = 70.0

    let normalaise :: [Int] -> [Double]
        normalaise xs = 
            let maxGrade = fromIntegral (maximum xs)
            in map (\x -> fromIntegral x / maxGrade * 100) xs

    let filterGrades :: [Double] -> Double -> [Double]
        filterGrades list th = filter (>= th) list
    
    let average :: [Double] -> Double
        average [] = 0
        average xs = 
            let total = foldl (+) 0 xs     
                count = fromIntegral (length xs) 
            in total / count

    let normalizedList = normalaise grades
    let filteredList = filterGrades normalizedList threshold
    let avgBefore = average normalizedList
    let avgAfter = average filteredList

    putStrLn ("1. Вихідний список:      " ++ show grades)
    putStrLn ("2. Нормалізований список: " ++ show normalizedList)
    putStrLn ("3. Список після фільтру:  " ++ show filteredList)
    putStrLn ("4. Середнє (до фільтру):    " ++ show avgBefore)
    putStrLn ("5. Середнє (після фільтру): " ++ show avgAfter)