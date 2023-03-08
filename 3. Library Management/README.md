# Library Managment Contract

- Contract Library is declared 
- Struct Book is declared to store the details of the book, including id, name, author, year, and isFinished status
- An array of Books and a mapping from book id to owner address are declared as private variables 
- Event AddBook is declared 
- Function addBook is declared to add a book to the library with parameters name, author, year and finished status 
- Function _getBooks is declared as private view function to return all the books in the library with parameter finished status 
- Function getUnfinishedBooks is declared as external view function to return all the books in the library which are not finished 
- Function getFinishedBooks is declared as external view function to return all the books in the library which are finished 
- Function setFinished is declared to set the finished status of a book with parameters bookId and finished