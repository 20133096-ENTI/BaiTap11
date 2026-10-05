package vn.edu.ute.dao;
import vn.edu.ute.models.Book_20133096;
import vn.edu.ute.utils.DBConnection_20133096;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookDAO_20133096 {
    public List<Book_20133096> getBooksPaging(int offset, int limit) {
        List<Book_20133096> list = new ArrayList<>();
        try (Connection conn = DBConnection_20133096.getConnection()) {
            String sql = "SELECT b.*, (SELECT STRING_AGG(a.author_name, ', ') FROM book_author ba JOIN author a ON ba.author_id = a.author_id WHERE ba.bookid = b.bookid) as authorName, (SELECT COUNT(*) FROM rating r WHERE r.bookid = b.bookid) as reviewCount FROM books b ORDER BY b.bookid OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, offset);
            ps.setInt(2, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapBook(rs));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
    
    public int countBooks() {
        try (Connection conn = DBConnection_20133096.getConnection()) {
            ResultSet rs = conn.prepareStatement("SELECT COUNT(*) FROM books").executeQuery();
            if(rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    public Book_20133096 getBookById(int id) {
        try (Connection conn = DBConnection_20133096.getConnection()) {
            String sql = "SELECT b.*, (SELECT STRING_AGG(a.author_name, ', ') FROM book_author ba JOIN author a ON ba.author_id = a.author_id WHERE ba.bookid = b.bookid) as authorName, (SELECT COUNT(*) FROM rating r WHERE r.bookid = b.bookid) as reviewCount FROM books b WHERE b.bookid = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapBook(rs);
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    public void insert(Book_20133096 b) {
        try (Connection conn = DBConnection_20133096.getConnection()) {
            String sql = "INSERT INTO books (isbn, title, publisher, price, quantity) VALUES (?,?,?,?,?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, b.getIsbn()); ps.setString(2, b.getTitle());
            ps.setString(3, b.getPublisher()); ps.setDouble(4, b.getPrice());
            ps.setInt(5, b.getQuantity());
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public void update(Book_20133096 b) {
        try (Connection conn = DBConnection_20133096.getConnection()) {
            String sql = "UPDATE books SET isbn=?, title=?, publisher=?, price=?, quantity=? WHERE bookid=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, b.getIsbn()); ps.setString(2, b.getTitle());
            ps.setString(3, b.getPublisher()); ps.setDouble(4, b.getPrice());
            ps.setInt(5, b.getQuantity()); ps.setInt(6, b.getBookid());
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public void delete(int id) {
        try (Connection conn = DBConnection_20133096.getConnection()) {
            PreparedStatement ps = conn.prepareStatement("DELETE FROM books WHERE bookid=?");
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    private Book_20133096 mapBook(ResultSet rs) throws SQLException {
        Book_20133096 b = new Book_20133096();
        b.setBookid(rs.getInt("bookid"));
        b.setIsbn(rs.getInt("isbn"));
        b.setTitle(rs.getString("title"));
        b.setPublisher(rs.getString("publisher"));
        b.setPrice(rs.getDouble("price"));
        b.setPublishDate(rs.getDate("publish_date"));
        b.setCoverImage(rs.getString("cover_image"));
        b.setQuantity(rs.getInt("quantity"));
        b.setAuthorName(rs.getString("authorName"));
        b.setReviewCount(rs.getInt("reviewCount"));
        return b;
    }
}