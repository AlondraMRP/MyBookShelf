package com.myprojects.mybookshelf.Controller;

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

@WebServlet("/yearly")
public class RecordYearlyServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger LOGGER = Logger.getLogger(BookServlet.class.getName());

    private RecordsDAO recordsDAO;

    public void init (){
        recordsDAO = new RecordsDAO();
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/RecordYearlyPage.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String selectedYear = request.getParameter("selectedYear");
        request.setAttribute("selectedYear", selectedYear);
        if(selectedYear == null) {
            LOGGER.log(Level.INFO, "Year is null!");
        }

        try {
            int booksReadYearly = recordsDAO.booksReadYearly(Integer.parseInt(selectedYear));
            request.setAttribute("booksReadYearly", booksReadYearly);

            double avgRatingYearly = recordsDAO.avgRatingYearly(Integer.parseInt(selectedYear));
            request.setAttribute("avgRatingYearly", avgRatingYearly);

            LinkedHashMap<String, Integer> topAuthorsYearly = recordsDAO.mostReadAuthorsByYear(Integer.parseInt(selectedYear));
            request.setAttribute("topAuthorsYearly", topAuthorsYearly);

            LinkedHashMap<String, Double> topRatingBooksYearly = recordsDAO.topRatingBooksYearly(Integer.parseInt(selectedYear));
            request.setAttribute("topRatingBooksYearly", topRatingBooksYearly);

            HashMap<String, Integer> mostReadGenreYearly = recordsDAO.mostReadGenreYearly(Integer.parseInt(selectedYear));
            request.setAttribute("mostReadGenreYearly", mostReadGenreYearly);

            LinkedHashMap<String, Integer> allBookReadPerMonth = allReadBookPerMonth(Integer.parseInt(selectedYear));
            request.setAttribute("allBookReadPerMonth", allBookReadPerMonth);


        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE,"SQL Error", e);
        }
        RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/RecordYearlyPage.jsp");
        dispatcher.forward(request, response);
    }

    public LinkedHashMap<String, Integer> allReadBookPerMonth (int year) throws SQLException{
        String[] months = {
                "January", "February", "March", "April", "May", "June",
                "July", "August", "September", "October", "November", "December"
        };
       LinkedHashMap<String, Integer> booksReadPerMonth = new LinkedHashMap<>();


       for(int i = 1; i <= 12; i ++){
         String month = months[i-1];
         int numBooks = recordsDAO.booksReadMonthly(i, year);

         booksReadPerMonth.put(month,numBooks);
       }
       return booksReadPerMonth;
    }
}