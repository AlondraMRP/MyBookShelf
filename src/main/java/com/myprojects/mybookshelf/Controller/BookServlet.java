package com.myprojects.mybookshelf.Controller;

import java.io.*;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.myprojects.mybookshelf.model.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;



@WebServlet("/")
public class BookServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final Logger LOGGER = Logger.getLogger(BookServlet.class.getName());

    private BookDAO bookDAO;
    private AuthorDAO authorDAO;
    private GenreDAO genreDAO;


    public void init() {
        bookDAO = new BookDAO();
        authorDAO = new AuthorDAO();
        genreDAO = new GenreDAO();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getServletPath();

        try {
            switch (action) {
                case "/new":
                    showNewForm(request, response);
                    break;
                case "/insert":
                    createBook(request, response);
                    break;
                case "/delete":
                    deleteBook(request, response);
                    break;
                case "/edit":
                    showEditForm(request, response);
                    break;
                case "/update":
                    updateBook(request, response);
                    break;
                default:
                    listBook(request, response);
                    break;
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE,"SQL Error",e);
        }

    }

    private void listBook(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/bookList.jsp");
        List<Book> listBook = bookDAO.findAll();
        request.setAttribute("listBook", listBook);

        dispatcher.forward(request,response);
    }

    private void updateBook(HttpServletRequest request, HttpServletResponse response)
    throws SQLException, IOException{
        int book_id = Integer.parseInt(request.getParameter("book_id"));

        String title = request.getParameter("title");
        int publication_year = Integer.parseInt(request.getParameter("publication_year"));
        double rating = Double.parseDouble(request.getParameter("rating"));
        String author_name = request.getParameter("author_name");
        String author_nationality = request.getParameter("author_nationality");
        String genre_name = request.getParameter("genre_name");
        LocalDate dateFinished = LocalDate.parse(request.getParameter("dateFinished"));
        String price = request.getParameter("price");

        Author authorUpdated = new Author(author_name, author_nationality);
        Genre genreUpdated = new Genre(genre_name);
        Book bookUpdated = new Book(book_id, title, publication_year, rating, authorUpdated, genreUpdated,dateFinished, price);

        authorDAO.update(bookUpdated, authorUpdated);
        genreDAO.update(bookUpdated);
        bookDAO.update(bookUpdated);


        response.sendRedirect("list");
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
    throws SQLException, ServletException, IOException{
        String book_id = request.getParameter("id");
        Optional<Book> existingBook = bookDAO.find(book_id);
        request.setAttribute("book",existingBook);
        existingBook.ifPresent(s->request.setAttribute("book",s));
        RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/bookForm.jsp");
        dispatcher.forward(request, response);

    }

    private void deleteBook(HttpServletRequest request, HttpServletResponse response)
    throws SQLException, IOException{
        int book_id = Integer.parseInt(request.getParameter("id"));
        Book book = new Book(book_id);
        bookDAO.delete(book);


        response.sendRedirect("list");

    }

    private void createBook(HttpServletRequest request, HttpServletResponse response)
    throws SQLException, IOException{
        String title = request.getParameter("title");
        int publication_year = Integer.parseInt(request.getParameter("publication_year"));
        double rating = Double.parseDouble(request.getParameter("rating"));
        String author_name = request.getParameter("author_name");
        String author_nationality = request.getParameter("author_nationality");
        String genre_name = request.getParameter("genre_name");
        LocalDate dateFinished = LocalDate.parse(request.getParameter("dateFinished"));
        String price = request.getParameter("price");

        Author newAuthor = new Author(author_name, author_nationality);
        Genre newGenre = new Genre(genre_name);
        Book newBook = new Book(title, publication_year, rating, newAuthor, newGenre, dateFinished, price);

        authorDAO.create(newAuthor);
        genreDAO.create(newGenre);
        bookDAO.create(newBook);

        response.sendRedirect("list");

    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException{
        RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/bookForm.jsp");
        dispatcher.forward(request, response);

    }


}


