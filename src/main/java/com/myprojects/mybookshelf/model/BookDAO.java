package com.myprojects.mybookshelf.model;

import com.myprojects.mybookshelf.Controller.BookServlet;
import com.myprojects.mybookshelf.db.DataSourceManager;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.logging.Level;
import java.util.logging.Logger;

public class BookDAO implements DAOBook{
    private static final Logger LOGGER = Logger.getLogger(BookServlet.class.getName());


    public BookDAO(){

    }


    @Override
    public Optional<Book> find(String id) throws SQLException {
       String sql = "SELECT books.book_id, books.title, books.publication_year, books.rating, authors.author_name," +
               " authors.author_nationality,genres.genre_name, books.date_finished, books.price\n" +
               "FROM ((books\n" +
               "INNER JOIN authors ON books.author_id = authors.author_id)\n" +
               "INNER JOIN genres ON books.genre_id = genres.genre_id) WHERE book_id = ?";

        int book_id=0; String title = ""; int publication_year =0;
        LocalDate dateFinished = null;
        double rating =0; String author_name ="";
        String author_nationality = ""; String genre_name = ""; String price = "";

        try (Connection connection = DataSourceManager.getConnection()) {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, Integer.parseInt(id));
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                book_id = resultSet.getInt("book_id");
                title = resultSet.getString("title");
                publication_year = resultSet.getInt("publication_year");
                ;
                rating = resultSet.getDouble("rating");
                author_name = resultSet.getString("author_name");
                author_nationality = resultSet.getString("author_nationality");
                genre_name = resultSet.getString("genre_name");
                dateFinished = resultSet.getDate("date_finished").toLocalDate();
                price = resultSet.getString("price");

            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "ERROR FINDING BOOK", e);
        } catch (NumberFormatException e) {
            LOGGER.log(Level.SEVERE, "ERROR FORMATTING NUMBER IN FINDING BOOK", e);
        }
        return Optional.of(new Book(book_id,title, publication_year, rating,
                                   new Author(author_name, author_nationality),
                                   new Genre(genre_name),
                                   dateFinished, price));

    }

    @Override
    public List<Book> findAll() throws SQLException {
        String sql = "SELECT books.book_id, books.title, books.publication_year, books.rating, " +
                "authors.author_name, authors.author_nationality,genres.genre_name, books.date_finished, books.price\n" +
                "FROM ((books\n" +
                "INNER JOIN authors ON books.author_id = authors.author_id)\n" +
                "INNER JOIN genres ON books.genre_id = genres.genre_id);";

        List <Book> bookList = new ArrayList<>();

        try (Connection connection = DataSourceManager.getConnection()) {
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(sql);

            while (resultSet.next()) {
                int book_id = resultSet.getInt("book_id");
                String title = resultSet.getString("title");
                int publication_year = resultSet.getInt("publication_year");
                double rating = resultSet.getDouble("rating");
                String author_name = resultSet.getString("author_name");
                String author_nationality = resultSet.getString("author_nationality");
                String genre_name = resultSet.getString("genre_name");
                LocalDate dateFinished = resultSet.getDate("date_finished").toLocalDate();
                String price = resultSet.getString("price");

                Book book = new Book(book_id, title, publication_year, rating,
                        new Author(author_name, author_nationality),
                        new Genre(genre_name), dateFinished, price);
                bookList.add(book);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "ERROR FINDING ALL BOOKS", e);
        }
        return bookList;
    }


    @Override
    public boolean create(Book book) throws SQLException {

        String sqlInsertBook =  "INSERT INTO books (title, publication_year, rating, author_id, genre_id, date_finished, price)" +
                                "VALUES (?, ?, ? ,   " +
                                "(SELECT author_id FROM authors WHERE author_name = ? LIMIT 1),"+
                                "(SELECT genre_id FROM genres WHERE genre_name = ? LIMIT 1), ?, ?)";

        boolean bookRowInserted = false;

        try (Connection connection = DataSourceManager.getConnection()) {
            PreparedStatement statementBook = connection.prepareStatement(sqlInsertBook);
            statementBook.setString(1, book.getTitle());
            statementBook.setInt(2, book.getPublication_year());
            statementBook.setDouble(3, book.getRating());
            statementBook.setObject(4, book.getAuthor().getAuthor_name());
            statementBook.setObject(5, book.getGenre().getGenre_name());
            statementBook.setDate(6, Date.valueOf(book.getDateFinished()));
            statementBook.setString(7, book.getPrice());
            bookRowInserted = statementBook.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "ERROR CREATING BOOK", e);
        }

        return bookRowInserted;
    }

    @Override
    public boolean update(Book book) throws SQLException {

        String sqlUpdateBook = "UPDATE books SET title = ?, publication_year = ?, rating = ?,"+
                                "author_id = (SELECT author_id FROM authors WHERE author_name = ? AND author_nationality = ? LIMIT 1),"+
                                "genre_id = (SELECT genre_id FROM genres WHERE genre_name = ? LIMIT 1), date_finished = ?, price = ? "+
                                "WHERE book_id = ?;";
        boolean rowUpdatedBook = false;

        try (Connection connection = DataSourceManager.getConnection()) {
            PreparedStatement statementUpdateBook = connection.prepareStatement(sqlUpdateBook);
            statementUpdateBook.setString(1, book.getTitle());
            statementUpdateBook.setInt(2, book.getPublication_year());
            statementUpdateBook.setDouble(3, book.getRating());
            statementUpdateBook.setString(4, book.getAuthor().getAuthor_name());
            statementUpdateBook.setString(5, book.getAuthor().getAuthor_nationality());
            statementUpdateBook.setString(6, book.getGenre().getGenre_name());
            statementUpdateBook.setDate(7, Date.valueOf(book.getDateFinished()));
            statementUpdateBook.setString(8, book.getPrice());
            statementUpdateBook.setInt(9, book.getBook_id());
            rowUpdatedBook = statementUpdateBook.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "ERROR UPDATING BOOK", e);
        }
        return rowUpdatedBook;
    }

    @Override
    public boolean delete(Book book) throws SQLException {
        boolean rowDeletedBook = false;
        String sqlDeleteBook = "DELETE FROM books WHERE book_id = ?";

        try (Connection connection = DataSourceManager.getConnection()) {
            PreparedStatement deleteBookStatement = connection.prepareStatement(sqlDeleteBook);
            deleteBookStatement.setInt(1, book.getBook_id());
            rowDeletedBook = deleteBookStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "ERROR DELETING BOOK", e);
        }

        return rowDeletedBook;
    }
}


