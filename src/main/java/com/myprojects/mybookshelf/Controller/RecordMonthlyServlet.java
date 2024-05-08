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

@WebServlet("/monthly")
public class RecordMonthlyServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger LOGGER = Logger.getLogger(BookServlet.class.getName());

    private RecordsDAO recordsDAO;

    public void init (){
        recordsDAO = new RecordsDAO();
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/RecordMonthlyPage.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String selectedMonth = request.getParameter("selectedMonth");
        String[] months = {
                "January", "February", "March", "April", "May", "June",
                "July", "August", "September", "October", "November", "December"
        };
        String monthName = months[Integer.parseInt(selectedMonth) - 1];
        request.setAttribute("monthName", monthName);
        String selectedYear = request.getParameter("selectedYear");
        request.setAttribute("selectedYear", selectedYear);

        if (selectedMonth == null){
            LOGGER.log(Level.SEVERE,"Month is null!");
        }
        if(selectedYear == null) {
            LOGGER.log(Level.SEVERE, "Year is null!");
        }

        try{
            int booksReadMonthly = recordsDAO.booksReadMonthly(Integer.parseInt(selectedMonth), Integer.parseInt(selectedYear));
            request.setAttribute("booksReadMonthly", booksReadMonthly);

            double avgRatingMonthly = recordsDAO.avgRatingMonthly(Integer.parseInt(selectedMonth),Integer.parseInt(selectedYear));
            request.setAttribute("avgRatingMonthly", avgRatingMonthly);

            LinkedHashMap<String, Double> topRatingMonthly = recordsDAO.topRatingBooksMonthly(Integer.parseInt(selectedMonth),Integer.parseInt(selectedYear));
            request.setAttribute("topRatingMonthly", topRatingMonthly);

            LinkedHashMap<String, Integer> topAuthorsMonthly = recordsDAO.mostReadAuthorMonthly(Integer.parseInt(selectedMonth),Integer.parseInt(selectedYear));
            request.setAttribute("topAuthorsMonthly", topAuthorsMonthly);

            HashMap<String, Integer> mostReadGenreMonthly = recordsDAO.mostReadGenreMonthly(Integer.parseInt(selectedMonth),Integer.parseInt(selectedYear));
            request.setAttribute("mostReadGenreMonthly", mostReadGenreMonthly);

            LinkedHashMap<Integer, Integer> booksPerDay = booksReadPerDay(Integer.parseInt(selectedMonth),Integer.parseInt(selectedYear));
            request.setAttribute("booksPerDay", booksPerDay);

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE,"SQL Error", e);
        }
        RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/RecordMonthlyPage.jsp");
        dispatcher.forward(request, response);
    }

    public LinkedHashMap<Integer, Integer> booksReadPerDay (int month, int year) throws SQLException{

        LinkedHashMap<Integer, Integer> booksPerDay = new LinkedHashMap<>();
        if(month == 2){
            for(int i = 1; i<= 28; i++){
              int numBooks = recordsDAO.booksReadDaily(i, month, year);
                booksPerDay.put(i,numBooks);
            }
          return booksPerDay;
        } else if (month == 4 || month == 6 || month == 9 || month == 11 ){
            for(int i = 1; i<= 30; i++){
                int numBooks = recordsDAO.booksReadDaily(i, month, year);
                booksPerDay.put(i,numBooks);
            }
            return booksPerDay;
        } else {
            for(int i = 1; i<= 31; i++){
                int numBooks = recordsDAO.booksReadDaily(i, month, year);
                booksPerDay.put(i,numBooks);
            }
            return booksPerDay;
        }
    }
}