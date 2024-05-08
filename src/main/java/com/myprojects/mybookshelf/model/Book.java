package com.myprojects.mybookshelf.model;


import java.time.LocalDate;

public class Book {
    protected int book_id;
    protected  String title;
    protected  int publication_year;
    protected double rating;
    protected Author author;
    protected Genre genre;
    protected LocalDate dateFinished;
    protected String price;

    public Book (){

    }
    public Book (int book_id){
        this.book_id = book_id;
    }

    public Book(int book_id, String title, int publication_year, double rating, Author author, Genre genre, LocalDate dateFinished, String price){
        this.book_id = book_id;
        this.title = title;
        this.publication_year = publication_year;
        this.rating = rating;
        this.author = author;
        this.genre = genre;
        this.dateFinished = dateFinished;
        this.price = price;
    }

    public Book(String title, int publication_year, double rating, Author author, Genre genre, LocalDate dateFinished, String price){
      this.title = title;
      this.publication_year = publication_year;
      this.rating = rating;
      this.author = author;
      this.genre = genre;
      this.dateFinished = dateFinished;
      this.price = price;
    }


    public int getBook_id() {
        return book_id;
    }

    public void setBook_id(int book_id) {
        this.book_id = book_id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getPublication_year() {
        return publication_year;
    }

    public void setPublication_year(int publication_year) {
        this.publication_year = publication_year;
    }

    public double getRating() {
        return rating;
    }

    public void setRating(double rating) {
        this.rating = rating;
    }

    public Author getAuthor() {
        return author;
    }

    public void setAuthor(Author author) {
        this.author = author;
    }

    public Genre getGenre() {
        return genre;
    }

    public void setGenre(Genre genre) {
        this.genre = genre;
    }
    public LocalDate getDateFinished() {
        return dateFinished;
    }

    public void setDateFinished(LocalDate dateFinished) {

        this.dateFinished = dateFinished;
    }
    public String getPrice (){
        return price;
    }
    public void setPrice (String price){
        this.price = price;
    }
}
