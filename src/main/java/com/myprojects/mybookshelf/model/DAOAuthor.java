package com.myprojects.mybookshelf.model;

import java.sql.SQLException;

public interface DAOAuthor extends DAO <Author, String>{
    boolean update(Book book) throws SQLException;

    boolean update(Book book, Author author) throws SQLException;
}
