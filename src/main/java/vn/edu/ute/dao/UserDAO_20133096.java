package vn.edu.ute.dao;
import vn.edu.ute.models.User_20133096;
import vn.edu.ute.utils.DBConnection_20133096;
import java.sql.*;

public class UserDAO_20133096 {
    public User_20133096 login(String email, String pass) {
        try (Connection conn = DBConnection_20133096.getConnection()) {
            String sql = "SELECT * FROM users WHERE email=? AND passwd=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, pass);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User_20133096 u = new User_20133096();
                u.setId(rs.getInt("id"));
                u.setEmail(rs.getString("email"));
                u.setFullname(rs.getNString("fullname"));
                u.setAdmin(rs.getBoolean("is_admin"));
                return u;
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    public void register(User_20133096 u) {
        try (Connection conn = DBConnection_20133096.getConnection()) {
            String sql = "INSERT INTO users (email, fullname, phone, passwd) VALUES (?,?,?,?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, u.getEmail());
            ps.setString(2, u.getFullname());
            ps.setInt(3, u.getPhone());
            ps.setString(4, u.getPasswd());
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }
}