package vn.edu.ute.models;
public class Rating_20133096 {
    private int userid;
    private int bookid;
    private int rating;
    private String reviewText;
    // Virtual field
    private String userFullName;
    
    // Getters and Setters
    public int getUserid() { return userid; } public void setUserid(int userid) { this.userid = userid; }
    public int getBookid() { return bookid; } public void setBookid(int bookid) { this.bookid = bookid; }
    public int getRating() { return rating; } public void setRating(int rating) { this.rating = rating; }
    public String getReviewText() { return reviewText; } public void setReviewText(String reviewText) { this.reviewText = reviewText; }
    public String getUserFullName() { return userFullName; } public void setUserFullName(String userFullName) { this.userFullName = userFullName; }
}