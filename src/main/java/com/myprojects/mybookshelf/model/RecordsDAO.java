package com.myprojects.mybookshelf.model;

import com.myprojects.mybookshelf.Controller.BookServlet;
import com.myprojects.mybookshelf.db.DataSourceManager;

import java.sql.*;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

import static org.apache.commons.math3.util.Precision.round;

public class RecordsDAO {
    private static final Logger LOGGER = Logger.getLogger(BookServlet.class.getName());

    public RecordsDAO (){

    }

    public double avgRatingOverall() throws SQLException {
        String sql = "SELECT AVG(rating) AS avgRating FROM books";
        double avgRating = 0;

        try (Connection connection = DataSourceManager.getConnection()) {
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(sql);

            if (resultSet.next()) {
                avgRating = resultSet.getDouble("avgRating");

            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "ERROR GETTING RATING OVERALL", e);
        }

        return round(avgRating,2);

    }

    public double avgRatingYearly (int year) throws SQLException{
        String sql = "SELECT AVG(rating) FROM books WHERE YEAR(date_finished) = ?;";
        double avgRatingYearly = 0;

        try (Connection connection = DataSourceManager.getConnection()) {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, year);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                avgRatingYearly = resultSet.getDouble(1);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "ERROR GETTING RATING YEARLY", e);
        }

        return round(avgRatingYearly,2);
    }

    public double avgRatingMonthly (int month, int year) throws SQLException{
        String sql = "SELECT AVG(rating) FROM books WHERE month(date_finished) = ? and year(date_finished) = ?;";
        double avgRatingMonthly = 0;

        try (Connection connection = DataSourceManager.getConnection()) {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, month);
            statement.setInt(2, year);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                avgRatingMonthly = resultSet.getDouble(1);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "ERROR GETTING RATING MONTHLY", e);
        }

        return round(avgRatingMonthly,2);
    }

    public int booksReadOverall () throws SQLException{
        String sql = "SELECT COUNT(books.book_id) FROM books;";
        int booksRead = 0;

        try (Connection connection = DataSourceManager.getConnection()) {
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(sql);

            if (resultSet.next()) {
                booksRead = resultSet.getInt(1);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "ERROR GETTING BOOKS READ OVERALL", e);
        }

        return booksRead;
    }

    public int booksReadYearly ( int year) throws SQLException{
        String sql = "SELECT COUNT(books.book_id) FROM books WHERE YEAR(date_finished) = ?;";
        int booksReadYearly = 0;

        try (Connection connection = DataSourceManager.getConnection()) {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1,year);
            ResultSet resultSet = statement.executeQuery();

            if(resultSet.next()){
                booksReadYearly = resultSet.getInt(1);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "ERROR GETTING BOOKS READ YEARLY", e);
        }

        return booksReadYearly;
    }

    public int booksReadMonthly (int month, int year) throws SQLException{
        String sql = "SELECT COUNT(books.book_id) FROM books WHERE month(date_finished) = ? and year(date_finished) = ?;";
        int booksReadMonthly = 0;

        try(Connection connection = DataSourceManager.getConnection()) {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, month);
            statement.setInt(2,year);
            ResultSet resultSet = statement.executeQuery();

            if(resultSet.next()){
                booksReadMonthly = resultSet.getInt(1);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "ERROR GETTING BOOKS READ MONTHLY", e);
        }

        return booksReadMonthly;
    }

    public int booksReadDaily (int day, int month, int year) throws SQLException{
        String sql = "SELECT COUNT(books.book_id) FROM books " +
                     "WHERE day (date_finished) = ? and month(date_finished) = ? " +
                     "and year(date_finished) = ?;";

        int booksReadDaily = 0;
        try (Connection connection = DataSourceManager.getConnection()){

            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, day);
            statement.setInt(2,month);
            statement.setInt(3, year);
            ResultSet resultSet = statement.executeQuery();

            if(resultSet.next()){
                booksReadDaily = resultSet.getInt(1);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "ERROR GETTING BOOKS READ DAILY", e);
        }

        return booksReadDaily;
    }



    public HashMap<String, Integer> mostReadGenre() throws SQLException{
        String sql = "SELECT genres.genre_name, COUNT(books.title) as numBooks\n"+
        "FROM books LEFT JOIN genres\n"+
        "ON books.genre_id = genres.genre_id\n"+
        "GROUP BY genres.genre_name\n"+
        "ORDER BY numBooks DESC LIMIT 10;";
        HashMap<String, Integer> topGenres = new HashMap<String, Integer>();

        try (Connection connection = DataSourceManager.getConnection()) {
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(sql);

            while (resultSet.next()){
                String genre = resultSet.getString("genre_name");
                int numBooks = resultSet.getInt("numBooks");

                topGenres.put(genre,numBooks);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "ERROR GETTING MOST READ GENRE", e);
        }
        return topGenres;

    }

    public HashMap<String, Integer> mostReadGenreYearly(int year) throws SQLException{
        String sql = "SELECT genres.genre_name, COUNT(books.title) as numBooks\n" +
                "FROM books left JOIN genres\n" +
                "ON books.genre_id = genres.genre_id WHERE YEAR(date_finished) = ?\n" +
                "GROUP BY genres.genre_name\n" +
                "ORDER BY numBooks DESC LIMIT 10;";
        HashMap<String, Integer> topGenresYearly = new HashMap<String,Integer>();

        try (Connection connection = DataSourceManager.getConnection()) {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1,year);
            ResultSet resultSet = statement.executeQuery();

            while(resultSet.next()){
                String genre = resultSet.getString("genre_name");
                int numBooks = resultSet.getInt("numBooks");

                topGenresYearly.put(genre,numBooks);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "ERROR GETTING MOST READ GENRE YEARLY", e);
        }

        return topGenresYearly;
    }

    public HashMap<String, Integer> mostReadGenreMonthly(int month, int year) throws SQLException{
        String sql = "SELECT genres.genre_name, COUNT(books.title) as numBooks\n" +
                "FROM books left JOIN genres\n" +
                "ON books.genre_id = genres.genre_id WHERE MONTH(date_finished) = ? AND YEAR(date_finished) = ?\n" +
                "GROUP BY genres.genre_name\n" +
                "ORDER BY numBooks DESC LIMIT 5;";
        HashMap<String, Integer> topGenresMonthly = new HashMap<String,Integer>();

        try(Connection connection = DataSourceManager.getConnection()) {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, month);
            statement.setInt(2,year);
            ResultSet resultSet = statement.executeQuery();

            while(resultSet.next()){
                String genre = resultSet.getString("genre_name");
                int numBooks = resultSet.getInt("numBooks");

                topGenresMonthly.put(genre,numBooks);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "ERROR GETTING MOST READ GENRE MONTHLY", e);
        }

        return topGenresMonthly;
    }

    public LinkedHashMap<String, Integer> mostReadAuthors() throws SQLException{
        String sql = "SELECT authors.author_name, COUNT(books.title) AS bookAuthor\n" +
                "from books LEFT JOIN authors\n" +
                "ON books.author_id = authors.author_id\n" +
                "GROUP BY authors.author_name\n" +
                "ORDER BY bookAuthor DESC LIMIT 3";
        LinkedHashMap<String, Integer> topAuthors = new LinkedHashMap<String, Integer>();

        try(Connection connection = DataSourceManager.getConnection()) {
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(sql);

            while (resultSet.next()){
                String authorName = resultSet.getString("author_name");
                int numBooks = resultSet.getInt("bookAuthor");

                topAuthors.put(authorName,numBooks);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "ERROR GETTING MOST READ AUTHORS", e);
        }
        return topAuthors;

    }

    public LinkedHashMap<String, Integer> mostReadAuthorsByYear(int year) throws SQLException{
        String sql = "SELECT authors.author_name, COUNT(books.title) AS bookAuthor\n" +
                "                from books LEFT JOIN authors\n" +
                "                ON books.author_id = authors.author_id WHERE YEAR(books.date_finished) = ?\n" +
                "                GROUP BY authors.author_name\n" +
                "                ORDER BY bookAuthor DESC LIMIT 3";
        LinkedHashMap<String, Integer> topAuthorsByYear = new LinkedHashMap<>();

        try(Connection connection = DataSourceManager.getConnection()) {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, year);
            ResultSet resultSet = statement.executeQuery();

            while(resultSet.next()){
              String authorName = resultSet.getString("author_name");
              int numBook = resultSet.getInt("bookAuthor");

              topAuthorsByYear.put(authorName, numBook);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "ERROR GETTING MOST READ AUTHORS YEARLY", e);
        }

        return topAuthorsByYear;
    }

    public LinkedHashMap<String, Integer> mostReadAuthorMonthly (int month, int year) throws SQLException{
        String sql = "SELECT authors.author_name, COUNT(books.title) AS bookAuthor\n" +
                "                from books LEFT JOIN authors\n" +
                "                ON books.author_id = authors.author_id WHERE MONTH(books.date_finished) = ? AND YEAR(books.date_finished) = ?\n" +
                "                GROUP BY authors.author_name\n" +
                "                ORDER BY bookAuthor DESC LIMIT 3";
        LinkedHashMap<String, Integer> topAuthorsMonthly = new LinkedHashMap<>();

        try(Connection connection = DataSourceManager.getConnection()) {

            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1,month);
            statement.setInt(2,year);
            ResultSet resultSet = statement.executeQuery();

            while(resultSet.next()){
                String authorName = resultSet.getString("author_name");
                int numBooks = resultSet.getInt("bookAuthor");
                topAuthorsMonthly.put(authorName, numBooks);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "ERROR GETTING MOST READ AUTHORS MONTHLY", e);
        }
        return topAuthorsMonthly;
    }

    public LinkedHashMap<String, Double> topRatingBooks () throws SQLException{
        String sql = "SELECT books.title, MAX(books.rating) AS topRating FROM books\n" +
                "GROUP BY books.title\n" +
                "ORDER BY topRating DESC LIMIT 3";
        LinkedHashMap<String, Double> topRatingBook = new LinkedHashMap<>();

        try (Connection connection = DataSourceManager.getConnection()){
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(sql);

            while(resultSet.next()){
                String title = resultSet.getString("title");
                String newTitle = trimTitles(title);
                double rating = resultSet.getDouble("topRating");

                topRatingBook.put(newTitle, rating);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "ERROR GETTING TOP RATING BOOKS", e);
        }

        return topRatingBook;

    }

    public LinkedHashMap<String, Double> topRatingBooksYearly (int year) throws SQLException{
        String sql = "SELECT books.title, MAX(books.rating) AS topRating FROM books\n" +
                "WHERE YEAR(date_finished) = ?\n" +
                "GROUP BY books.title\n" +
                "ORDER BY topRating DESC LIMIT 3";
        LinkedHashMap<String, Double> topRatingBookYearly = new LinkedHashMap<>();

        try(Connection connection = DataSourceManager.getConnection()) {

            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, year);
            ResultSet resultSet = statement.executeQuery();

            while(resultSet.next()){
                String title = resultSet.getString("title");
                String newTitle = trimTitles(title);
                double rating = resultSet.getDouble("topRating");

                topRatingBookYearly.put(newTitle, rating);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "ERROR GETTING TOP RATING BOOKS YEARLY", e);
        }


        return topRatingBookYearly;

    }

    public LinkedHashMap<String, Double> topRatingBooksMonthly (int month, int year) throws SQLException{
        String sql = "SELECT books.title, MAX(books.rating) AS topRating FROM books\n" +
                    "WHERE MONTH(date_finished) = ? AND YEAR(date_finished) = ?\n" +
                    "GROUP BY books.title\n" +
                    "ORDER BY topRating DESC LIMIT 3";
        LinkedHashMap<String, Double> topRatingBookMonthly = new LinkedHashMap<>();

        try (Connection connection = DataSourceManager.getConnection()){

            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, month);
            statement.setInt(2, year);
            ResultSet resultSet = statement.executeQuery();

            while(resultSet.next()){
                String title = resultSet.getString("title");
                String newTitle = trimTitles(title);
                double rating = resultSet.getDouble("topRating");

                topRatingBookMonthly.put(newTitle, rating);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "ERROR GETTING TOP RATING BOOKS MONTHLY", e);
        }

        return topRatingBookMonthly;

    }
    public String trimTitles (String title){
        String newTitle = "";
        for(int i = 0; i < title.length(); i++){
            if(title.charAt(i) == '('){
                newTitle = title.substring(0, i);
                return newTitle;
            }
        }
        newTitle = title;
        return newTitle;
    }
}
