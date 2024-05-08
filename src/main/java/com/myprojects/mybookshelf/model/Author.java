package com.myprojects.mybookshelf.model;

public class Author {
    protected int author_id;
    protected String author_name;
    protected String author_nationality;

    public Author(){

    }
    public Author(int author_id){
        this.author_id = author_id;
    }

    public Author(int author_id, String author_name, String author_nationality){
        this.author_name = author_name;
        this.author_nationality = author_nationality;
        this.author_id =author_id;
    }
    public Author(String author_name, String author_nationality){
        this.author_name = author_name;
        this.author_nationality = author_nationality;
    }



    public int getAuthor_id(){
        return author_id;
    }
    public void setAuthor_id(int author_id){
        this.author_id = author_id;
    }

    public String getAuthor_name(){
        return author_name;
    }
    public void setAuthor_name(String author_name){
        this.author_name = author_name;
    }

    public String getAuthor_nationality(){
        return author_nationality;
    }

    public void setAuthor_nationality(String author_nationality) {
        this.author_nationality = author_nationality;
    }
}
