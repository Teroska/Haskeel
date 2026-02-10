module LibraryDomain
    ( Genre(..)       
    , BookStatus(..) 
    , Book(..)  
    , libraryCatalog
    , availableBooks
    , booksByGenre
    , booksByAuthor
    , allBookTitles
    , totalPagesByGenre
    , averagePageCount
      
    ) where

data Genre
    = Fiction 
    | NonFiction 
    | Science 
    | History 
    | Programming 
    | Other
    deriving (Show, Eq)

data BookStatus
    = Available 
    | CheckedOut 
    | Archived
    deriving (Show, Eq)

data Book = Book {
    bookId    :: Int,
    title     :: String,
    author    :: String,
    year      :: Int,
    genre     :: Genre,
    pageCount :: Int,
    status    :: BookStatus
} deriving (Show, Eq)

libraryCatalog :: [Book]
libraryCatalog = 
    [ Book { bookId = 1, title = "Кобзар", author = "Тарас Шевченко", year = 1840, genre = Fiction, pageCount = 320, status = Available }
    , Book { bookId = 2, title = "Мистецтво програмування", author = "Дональд Кнут", year = 1968, genre = Programming, pageCount = 650, status = CheckedOut }
    , Book { bookId = 3, title = "Чистий код", author = "Robert C. Martin", year = 2008, genre = Programming, pageCount = 450, status = Available }
    , Book { bookId = 4, title = "1984", author = "George Orwell", year = 1949, genre = Fiction, pageCount = 328, status = Available }
    , Book { bookId = 5, title = "Sapiens: Людина розумна", author = "Yuval Noah Harari", year = 2011, genre = History, pageCount = 512, status = CheckedOut }
    , Book { bookId = 6, title = "Домашнє кондитерство", author = "Unknown", year = 2015, genre = NonFiction, pageCount = 220, status = Available }
    , Book { bookId = 7, title = "Історія України", author = "Unknown", year = 2003, genre = History, pageCount = 300, status = Archived }
    , Book { bookId = 8, title = "Алгоритми. Побудова та аналіз", author = "Cormen et al.", year = 1990, genre = Programming, pageCount = 1312, status = Available }
    ]

availableBooks :: [Book] -> [Book]
availableBooks books = filter (\b -> status b == Available) books

booksByGenre :: Genre -> [Book] -> [Book]
booksByGenre selectedGenre books = filter (\b -> genre b == selectedGenre) books

booksByAuthor :: String -> [Book] -> [Book]
booksByAuthor authorName books = filter (\b -> author b == authorName) books

allBookTitles :: [Book] -> [String]
allBookTitles books = map title books

totalPagesByGenre :: Genre -> [Book] -> Int
totalPagesByGenre selectedGenre books = 
        let targetBooks = filter (\b -> genre b == selectedGenre) books 
            pagesOnly = map pageCount targetBooks                       
        in sum pagesOnly    

averagePageCount :: [Book] -> Double
averagePageCount [] = 0.0
averagePageCount books = 
    let totalPages = sum (map pageCount books)
        totalBooks = length books
    in fromIntegral totalPages / fromIntegral totalBooks