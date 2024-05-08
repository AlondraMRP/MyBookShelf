package com.myprojects.mybookshelf.Controller;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import javax.swing.*;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import com.myprojects.mybookshelf.model.*;
import org.apache.poi.ss.usermodel.*;


@WebServlet("/upload")
@MultipartConfig
public class UploadServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger LOGGER = Logger.getLogger(UploadServlet.class.getName());

    private BookDAO bookDAO;
    private AuthorDAO authorDAO;
    private GenreDAO genreDAO;

    public void init() {
        bookDAO = new BookDAO();
        authorDAO = new AuthorDAO();
        genreDAO = new GenreDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/uploadBookForm.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Part filePart = request.getPart("file");

        try (InputStream inputStream = filePart.getInputStream()) {
            Workbook workbook = WorkbookFactory.create(inputStream);
            Sheet sheet = workbook.getSheetAt(0);
            List<Book> books = new ArrayList<>();
            boolean skipHeader = true;
            Iterator<Row> rowIterator = sheet.rowIterator();


            if (skipHeader && rowIterator.hasNext()) {
                rowIterator.next();
            }

            while (rowIterator.hasNext()) {
                Row row = rowIterator.next();
                if (row == null) {
                    continue;
                }

                Book book = new Book();
                Author author = new Author();
                Genre genre = new Genre();

                Cell titleCell = row.getCell(0);
                String title = titleCell != null ? titleCell.getStringCellValue() : "";
                book.setTitle(title);

                Cell publicationYearCell = row.getCell(1);
                int publication_year = (int) (publicationYearCell != null ? publicationYearCell.getNumericCellValue() : 0);
                book.setPublication_year(publication_year);

               Cell ratingCell = row.getCell(2);
               double rating = (double) (ratingCell != null ? ratingCell.getNumericCellValue() : 0);
               book.setRating(rating);

               Cell authorNameCell = row.getCell(3);
               String author_name = authorNameCell != null? authorNameCell.getStringCellValue() : "";
               author.setAuthor_name(author_name);

               Cell authorNationalityCell = row.getCell(4);
               String author_nationality = authorNationalityCell != null? authorNationalityCell.getStringCellValue() : "";
               author.setAuthor_nationality(author_nationality);
               book.setAuthor(author);

               Cell genreCell = row.getCell(5);
               String genre_name = genreCell != null? genreCell.getStringCellValue() : "";
               genre.setGenre_name(genre_name);
               book.setGenre(genre);

               Cell dateCell = row.getCell(6);

               LocalDate dateFinished = dateCell != null? dateCell.getLocalDateTimeCellValue().toLocalDate() : null;
               book.setDateFinished(dateFinished);

               authorDAO.create(author);
               genreDAO.create(genre);
               books.add(book);
            }

            for (Book book : books) {

                try {
                    boolean bookInserted = bookDAO.create(book);
                    if (!bookInserted) {
                        LOGGER.log(Level.SEVERE, "Book not added!!");
                        response.sendRedirect("/jsp/ErrorPage.jsp");
                        return;
                    }
                } catch (SQLException e) {
                    LOGGER.log(Level.SEVERE, "Error creating book in database", e);
                    throw e;
                }
            }
            LOGGER.log(Level.INFO, "Book added!");
            response.sendRedirect("list");
        } catch (IOException | SQLException e) {
            LOGGER.log(Level.SEVERE, "Internal Error, Excel not uploaded correctly", e);
            e.printStackTrace();

        }
    }
}



