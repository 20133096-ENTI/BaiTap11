package vn.edu.ute.controllers;

import vn.edu.ute.dao.OrderDAO_20133096;
import vn.edu.ute.models.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/order/history")
public class OrderController_20133096 extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User_20133096 user = (User_20133096) session.getAttribute("user");
        
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String status = req.getParameter("status"); // Lấy trạng thái từ bộ lọc
        if (status == null) status = "All";

        OrderDAO_20133096 dao = new OrderDAO_20133096();
        List<Order_20133096> orders = dao.getOrdersHistory(user.getUserId(), status);
        
        req.setAttribute("orders", orders);
        req.setAttribute("currentStatus", status);
        req.getRequestDispatcher("/WEB-INF/views/user/order-history.jsp").forward(req, resp);
    }
}