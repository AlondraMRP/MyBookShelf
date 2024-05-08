package com.myprojects.mybookshelf.model;

import java.sql.SQLException;

public interface DAOGenre extends DAO <Genre, String>{
    boolean update(Book book) throws SQLException;
}
