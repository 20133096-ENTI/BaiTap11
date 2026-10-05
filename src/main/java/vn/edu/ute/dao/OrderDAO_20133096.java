package vn.edu.ute.dao;

import vn.edu.ute.models.*;
import vn.edu.ute.utils.DBConnection_20133096;
import java.sql.*;
import java.util.*;

public class OrderDAO_20133096 {
    
    // Hàm lưu đơn hàng khi thanh toán COD
    public boolean insertOrder(int userId, double totalAmount, Collection<CartItem_20133096> cartItems) {
        String sqlOrder = "INSERT INTO Orders (UserID, TotalAmount, PaymentMethod, Status) VALUES (?, ?, 'COD', N'Đơn hàng mới')";
        String sqlDetail = "INSERT INTO OrderDetails (OrderID, BookID, Quantity, Price) VALUES (?, ?, ?, ?)";
        String sqlUpdateBook = "UPDATE Books SET Quantity = Quantity - ? WHERE BookID = ?"; // Trừ tồn kho

        try (Connection conn = DBConnection_20133096.getConnection()) {
            conn.setAutoCommit(false); // Bắt đầu Transaction
            
            // 1. Lưu Order
            PreparedStatement psOrder = conn.prepareStatement(sqlOrder, Statement.RETURN_GENERATED_KEYS);
            psOrder.setInt(1, userId);
            psOrder.setDouble(2, totalAmount);
            psOrder.executeUpdate();
            
            ResultSet rs = psOrder.getGeneratedKeys();
            int orderId = 0;
            if (rs.next()) orderId = rs.getInt(1);

            // 2. Lưu OrderDetails và Cập nhật số lượng Sách
            PreparedStatement psDetail = conn.prepareStatement(sqlDetail);
            PreparedStatement psUpdateBook = conn.prepareStatement(sqlUpdateBook);
            
            for (CartItem_20133096 item : cartItems) {
                psDetail.setInt(1, orderId);
                psDetail.setInt(2, item.getBookId());
                psDetail.setInt(3, item.getQuantity());
                psDetail.setDouble(4, item.getPrice());
                psDetail.addBatch();

                psUpdateBook.setInt(1, item.getQuantity());
                psUpdateBook.setInt(2, item.getBookId());
                psUpdateBook.addBatch();
            }
            psDetail.executeBatch();
            psUpdateBook.executeBatch();
            
            conn.commit(); // Hoàn tất Transaction
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Hàm lấy lịch sử đơn hàng theo UserID và Trạng thái (Nếu status rỗng -> lấy tất cả)
    public List<Order_20133096> getOrdersHistory(int userId, String status) {
        List<Order_20133096> list = new ArrayList<>();
        String sql = "SELECT * FROM Orders WHERE UserID = ?";
        if (status != null && !status.isEmpty() && !status.equals("All")) {
            sql += " AND Status = ?";
        }
        sql += " ORDER BY OrderDate DESC";

        try (Connection conn = DBConnection_20133096.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            if (status != null && !status.isEmpty() && !status.equals("All")) {
                ps.setString(2, status);
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order_20133096 order = new Order_20133096();
                order.setOrderId(rs.getInt("OrderID"));
                order.setUserId(rs.getInt("UserID"));
                order.setOrderDate(rs.getTimestamp("OrderDate"));
                order.setTotalAmount(rs.getDouble("TotalAmount"));
                order.setPaymentMethod(rs.getString("PaymentMethod"));
                order.setStatus(rs.getString("Status"));
                list.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}