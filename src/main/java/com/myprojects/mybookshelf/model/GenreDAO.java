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

public class GenreDAO implements DAOGenre{
    private static final Logger LOGGER = Logger.getLogger(BookServlet.class.getName());
    @Override
    public Optional<Genre> find(String s) throws SQLException {
        return Optional.empty();
    }

    @Override
    public List<Genre> findAll() throws SQLException {
        return null;
    }

    @Override
    public boolean create(Genre genre) throws SQLException {
        boolean genreRowInserted = false;
        String sqlInsertGenre = "INSERT INTO genres (genre_name) VALUES (?);";

        try (Connection connection = DataSourceManager.getConnection()) {
            PreparedStatement statementGenre = connection.prepareStatement(sqlInsertGenre);
            statementGenre.setString(1, genre.getGenre_name());
            genreRowInserted = statementGenre.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "ERROR CREATING GENRE", e);
        }

        return genreRowInserted;
    }

    @Override
    public boolean update(Genre o) throws SQLException {
        return false;
    }

    @Override
    public boolean update(Book book) throws SQLException {

        String sqlUpdateGenre = "UPDATE genres SET genre_name = ? WHERE genre_id = (SELECT genre_id FROM books WHERE title = ?);";
        boolean rowUpdateGenre = false;

        try (Connection connection = DataSourceManager.getConnection()) {
            PreparedStatement updateGenreStatement = connection.prepareStatement(sqlUpdateGenre);
            updateGenreStatement.setString(1, book.getGenre().getGenre_name());
            updateGenreStatement.setString(2, book.getTitle());
            rowUpdateGenre = updateGenreStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "ERROR UPDATING GENRE", e);
        }

        return rowUpdateGenre;
    }

    @Override
    public boolean delete(Genre genre) throws SQLException {
        String sqlDeleteGenre = "DELETE FROM genres WHERE genre_id = ?";
        boolean rowDeleteGenre = false;

        try (Connection connection = DataSourceManager.getConnection()) {
            PreparedStatement deleteGenreStatement = connection.prepareStatement(sqlDeleteGenre);
            deleteGenreStatement.setInt(1, genre.getGenre_id());
            rowDeleteGenre = deleteGenreStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "ERROR DELETING GENRE", e);
        }

        return rowDeleteGenre;
    }
}
