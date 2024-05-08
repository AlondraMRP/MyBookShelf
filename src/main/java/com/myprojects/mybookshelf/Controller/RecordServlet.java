package com.myprojects.mybookshelf.Controller;

import com.myprojects.mybookshelf.model.BookDAO;
import com.myprojects.mybookshelf.model.RecordsDAO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/record")
public class RecordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger LOGGER = Logger.getLogger(BookServlet.class.getName());

    private RecordsDAO recordsDAO;
    
    public void init (){
        recordsDAO = new RecordsDAO();
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        try{
            RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/RecordPage.jsp");

            int booksReadOverall = recordsDAO.booksReadOverall();
            request.setAttribute("booksReadOverall",booksReadOverall);

            double avgRatingOverall = recordsDAO.avgRatingOverall();
            request.setAttribute("avgRatingOverall", avgRatingOverall);

            HashMap<String, Integer> mostReadGenre = recordsDAO.mostReadGenre();
            request.setAttribute("mostReadGenre",mostReadGenre);

            LinkedHashMap<String, Integer> mostReadAuthors = recordsDAO.mostReadAuthors();
            request.setAttribute("mostReadAuthors", mostReadAuthors);

            LinkedHashMap<String, Double> topRatingBooks = recordsDAO.topRatingBooks();
            request.setAttribute("topRatingBooks", topRatingBooks);

            LinkedHashMap <Integer, Integer> booksReadPerYear = booksReadPerYear();
            request.setAttribute("booksReadPerYear", booksReadPerYear);

            dispatcher.forward(request, response);
            } catch (SQLException e){
            LOGGER.log(Level.SEVERE,"SQL Error",e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    public LinkedHashMap<Integer, Integer> booksReadPerYear () throws SQLException{
        LinkedHashMap<Integer, Integer> booksReadAllYears = new LinkedHashMap<>();
        for(int i = 2015; i <= 2024; i++){
          int numBookPerYear = recordsDAO.booksReadYearly(i);
          booksReadAllYears.put(i, numBookPerYear);
        }
        return booksReadAllYears;
    }
}