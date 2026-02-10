import LibraryDomain
import System.IO (hSetEncoding, stdout, utf8)

main :: IO ()
main = do
 
    putStrLn $ " Усі доступні книжки:\n" ++ showBooks (availableBooks libraryCatalog)
    
    putStrLn $ "\n Книжки жанру Програмування:\n" ++ showBooks (booksByGenre Programming libraryCatalog)
    
    putStrLn $ "\n Список книжок Авторів «George Orwell» «Robert C. Martin»:\n" ++ 
               showBooks (booksByAuthor "George Orwell" libraryCatalog) ++ 
               showBooks (booksByAuthor "Robert C. Martin" libraryCatalog)

    putStrLn $ "\n Назви всіх книжок:\n" ++ unlines (allBookTitles libraryCatalog)
    
    putStrLn $ "\n Загальна кількість сторінок (Програмування): " ++ show (totalPagesByGenre Programming libraryCatalog)
    
    putStrLn $ "\n Середня кількість сторінок у каталозі: " ++ show (averagePageCount libraryCatalog)

showBooks :: [Book] -> String
showBooks books = unlines (map showBook books)
showBook :: Book -> String
showBook b = 
    "ID: " ++ show (bookId b) ++ 
    " — \"" ++ title b ++ "\"" ++         
    ", автор: " ++ author b ++
    " (" ++ show (year b) ++ ")" ++
    ", жанр: " ++ show (genre b) ++
    ", сторінок: " ++ show (pageCount b) ++ 
    ", статус: " ++ show (status b)