package com.myprojects.mybookshelf.db;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DataSourceManager {

    public static final String DATASOURCE_JNDI_NAME = "java:comp/env/jdbc/myDB";
    public static final Logger LOGGER = Logger.getLogger(DataSourceManager.class.getName());

    public static Connection getConnection() throws SQLException {
        try{
            Context context = new InitialContext();
            DataSource dataSourceManager = (DataSource) context.lookup(DATASOURCE_JNDI_NAME);

            return dataSourceManager.getConnection();

        } catch (NamingException e) {
            LOGGER.log(Level.SEVERE,"Error in Connection Pool",e);
            throw new RuntimeException(e);
        }catch (SQLException e){
            LOGGER.log(Level.SEVERE,"Error in Connection Pool",e);
            throw new SQLException(e);
        }
    }
}




