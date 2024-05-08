package com.myprojects.mybookshelf.model;

import java.util.List;

public class Genre {
    protected int genre_id;
    protected String genre_name;

    public Genre(){

    }
    public Genre(int genre_id){
        this.genre_id = genre_id;
    }

    public Genre(int genre_id, String genre_name){
        this.genre_id = genre_id;
        this.genre_name = genre_name;
    }

    public Genre (String genre_name){
        this.genre_name = genre_name;
    }

    public int getGenre_id(){
        return genre_id;
    }

    public void setGenre_id(int genre_id){
        this.genre_id = genre_id;
    }

    public String getGenre_name (){
        return genre_name;
    }

    public void setGenre_name(String genre_name){
        this.genre_name = genre_name;
    }
}
