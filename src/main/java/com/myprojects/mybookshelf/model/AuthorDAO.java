package com.myprojects.mybookshelf.model;

import com.myprojects.mybookshelf.Controller.BookServlet;
import com.myprojects.mybookshelf.db.DataSourceManager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;
import java.util.Optional;
import java.util.logging.Level;
import java.util.logging.Logger;

public class AuthorDAO implements DAOAuthor {
    private static final Logger LOGGER = Logger.getLogger(BookServlet.class.getName());
    @Override
    public Optional<Author> find(String s) throws SQLException {
        return Optional.empty();
    }

    @Override
    public List<Author> findAll() throws SQLException {
        return null;
    }

    @Override
    public boolean create(Author author) throws SQLException {

        String sqlInsertAuthor = "INSERT INTO authors(author_name, author_nationality) VALUES (?, ?);";
        boolean authorRowInserted = false;

        try (Connection connection = DataSourceManager.getConnection()) {
            PreparedStatement statementAuthor = connection.prepareStatement(sqlInsertAuthor);
            statementAuthor.setString(1, author.getAuthor_name());
            statementAuthor.setString(2, author.getAuthor_nationality());
            authorRowInserted = statementAuthor.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "ERROR CREATING AUTHOR", e);
        }

        return authorRowInserted;
    }

    @Override
    public boolean update(Author o) throws SQLException {
        return false;
    }

    @Override
    public boolean update(Book book) throws SQLException {
        return false;
    }

    @Override
    public boolean update(Book book, Author author) throws SQLException {
        boolean rowUpdatedAuthor = false;
        String sqlUpdateAuthor = "UPDATE authors SET author_name = ?, author_nationality = ? WHERE author_id = (SELECT author_id FROM books WHERE book_id = ? )";

        try (Connection connection = DataSourceManager.getConnection()) {
            PreparedStatement updateAuthorStatement = connection.prepareStatement(sqlUpdateAuthor);
            updateAuthorStatement.setString(1, author.getAuthor_name());
            updateAuthorStatement.setString(2, author.getAuthor_nationality());
            updateAuthorStatement.setInt(3, book.getBook_id());
            rowUpdatedAuthor = updateAuthorStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "ERROR UPDATING AUTHOR", e);
        }

        return rowUpdatedAuthor;
    }

    @Override
    public boolean delete(Author author) throws SQLException {
        String sqlDeleteAuthor = "DELETE FROM authors WHERE author_id = ?";
        boolean rowDeletedAuthor = false;

        try (Connection connection = DataSourceManager.getConnection()) {
            PreparedStatement deleteAuthorStatement = connection.prepareStatement(sqlDeleteAuthor);
            deleteAuthorStatement.setInt(1, author.getAuthor_id());
            rowDeletedAuthor = deleteAuthorStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "ERROR DELETING AUTHOR", e);
        }

        return rowDeletedAuthor;
    }

}
