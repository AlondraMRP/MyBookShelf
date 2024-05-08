package com.myprojects.mybookshelf.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Optional;

public interface DAO <T, ID> {
    Optional<T> find(String id) throws SQLException;

    List<T> findAll() throws SQLException;

    boolean create(T o) throws SQLException;
   boolean update(T o) throws SQLException;

    boolean delete(T o) throws SQLException;

}
