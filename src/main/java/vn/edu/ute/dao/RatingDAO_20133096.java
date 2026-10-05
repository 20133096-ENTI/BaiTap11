package vn.edu.ute.dao;
import vn.edu.ute.models.Rating_20133096;
import vn.edu.ute.utils.DBConnection_20133096;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RatingDAO_20133096 {
    public List<Rating_20133096> getReviewsByBookId(int bookId) {
        List<Rating_20133096> list = new ArrayList<>();
        try (Connection conn = DBConnection_20133096.getConnection()) {
            String sql = "SELECT r.*, u.fullname FROM rating r JOIN users u ON r.userid = u.id WHERE r.bookid = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, bookId);
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                Rating_20133096 r = new Rating_20133096();
                r.setUserid(rs.getInt("userid"));
                r.setBookid(rs.getInt("bookid"));
                r.setRating(rs.getInt("rating"));
                r.setReviewText(rs.getString("review_text"));
                r.setUserFullName(rs.getString("fullname"));
                list.add(r);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
    
    public void addReview(Rating_20133096 r) {
        try (Connection conn = DBConnection_20133096.getConnection()) {
            String sql = "INSERT INTO rating (userid, bookid, review_text) VALUES (?,?,?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, r.getUserid());
            ps.setInt(2, r.getBookid());
            ps.setString(3, r.getReviewText());
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }
}