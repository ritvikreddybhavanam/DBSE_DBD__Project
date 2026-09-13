package com.example.backend.dto;

import java.time.LocalDate;

public class ReviewRequest {

    private Long movieId;
    private Double rating;
    private String title;
    private String content;
    private LocalDate watchedDate;
    private String viewingFormat;
    private Boolean rewatch;
    private Boolean spoilers;
    private String visibility;

    public ReviewRequest() {
    }

    public Long getMovieId() {
        return movieId;
    }

    public void setMovieId(Long movieId) {
        this.movieId = movieId;
    }

    public Double getRating() {
        return rating;
    }

    public void setRating(Double rating) {
        this.rating = rating;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public LocalDate getWatchedDate() {
        return watchedDate;
    }

    public void setWatchedDate(LocalDate watchedDate) {
        this.watchedDate = watchedDate;
    }

    public String getViewingFormat() {
        return viewingFormat;
    }

    public void setViewingFormat(String viewingFormat) {
        this.viewingFormat = viewingFormat;
    }

    public Boolean getRewatch() {
        return rewatch;
    }

    public void setRewatch(Boolean rewatch) {
        this.rewatch = rewatch;
    }

    public Boolean getSpoilers() {
        return spoilers;
    }

    public void setSpoilers(Boolean spoilers) {
        this.spoilers = spoilers;
    }

    public String getVisibility() {
        return visibility;
    }

    public void setVisibility(String visibility) {
        this.visibility = visibility;
    }
}