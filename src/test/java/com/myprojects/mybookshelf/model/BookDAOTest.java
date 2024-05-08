package com.myprojects.mybookshelf.model;

import static org.junit.Assert.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.mockStatic;
import static org.powermock.api.mockito.PowerMockito.when;

import com.myprojects.mybookshelf.db.DataSourceManager;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockedStatic;
import org.mockito.junit.MockitoJUnitRunner;
import org.powermock.api.mockito.PowerMockito;
import org.powermock.core.classloader.annotations.PrepareForTest;
import org.powermock.modules.testng.PowerMockTestCase;

import java.sql.*;
import java.time.LocalDate;
import java.util.List;

@RunWith(MockitoJUnitRunner.class)
@PrepareForTest({DataSourceManager.class, Author.class, Genre.class, Book.class})
public class BookDAOTest extends PowerMockTestCase{

    @Mock
    private Connection connection;

    @Mock
    private DataSourceManager dataSourceManager;

    @Mock
    private PreparedStatement preparedStatement;

    @Mock
    private ResultSet resultSet;

    @InjectMocks
    private BookDAO bookDAO;


    @Test
    public void testFindAll() throws SQLException {
        PowerMockito.mockStatic(DataSourceManager.class);
        when(DataSourceManager.getConnection()).thenReturn(connection);
        when(connection.createStatement()).thenReturn(preparedStatement);
        when(preparedStatement.executeQuery(anyString())).thenReturn(resultSet);
        when(resultSet.next()).thenReturn(true).thenReturn(false);
        when(resultSet.getInt("book_id")).thenReturn(1);
        when(resultSet.getString("title")).thenReturn("Test Title");
        when(resultSet.getInt("publication_year")).thenReturn(2022);
        when(resultSet.getDouble("rating")).thenReturn(4.5);
        when(resultSet.getString("author_name")).thenReturn("Test Author");
        when(resultSet.getString("author_nationality")).thenReturn("Test Nationality");
        when(resultSet.getString("genre_name")).thenReturn("Test Genre");
        when(resultSet.getDate("date_finished")).thenReturn(Date.valueOf(LocalDate.now()));

        List<Book> bookList = bookDAO.findAll();

        assertNotNull(bookList);
        assertEquals(1, bookList.size());
    }
}