package vn.edu.ute.controllers;

import vn.edu.ute.dao.OrderDAO_20133096;
import vn.edu.ute.models.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.HashMap;

@WebServlet(urlPatterns = {"/cart", "/cart/add", "/cart/update", "/cart/remove", "/checkout"})
public class CartController_20133096 extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        HttpSession session = req.getSession();
        
        if (path.equals("/cart")) {
            req.getRequestDispatcher("/WEB-INF/views/user/cart.jsp").forward(req, resp);
        } else if (path.equals("/cart/remove")) {
            int bookId = Integer.parseInt(req.getParameter("id"));
            HashMap<Integer, CartItem_20133096> cart = (HashMap<Integer, CartItem_20133096>) session.getAttribute("cart");
            if (cart != null) cart.remove(bookId);
            resp.sendRedirect(req.getContextPath() + "/cart");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        HttpSession session = req.getSession();
        HashMap<Integer, CartItem_20133096> cart = (HashMap<Integer, CartItem_20133096>) session.getAttribute("cart");
        if (cart == null) cart = new HashMap<>();

        if (path.equals("/cart/add")) {
            int bookId = Integer.parseInt(req.getParameter("bookId"));
            String title = req.getParameter("title");
            String coverImage = req.getParameter("coverImage");
            double price = Double.parseDouble(req.getParameter("price"));
            int maxQuantity = Integer.parseInt(req.getParameter("maxQuantity")); // Lấy từ DB số lượng tồn
            
            if (cart.containsKey(bookId)) {
                CartItem_20133096 item = cart.get(bookId);
                if (item.getQuantity() < maxQuantity) item.setQuantity(item.getQuantity() + 1);
            } else {
                cart.put(bookId, new CartItem_20133096(bookId, title, coverImage, price, 1, maxQuantity));
            }
            session.setAttribute("cart", cart);
            resp.sendRedirect(req.getContextPath() + "/cart");

        } else if (path.equals("/cart/update")) {
            int bookId = Integer.parseInt(req.getParameter("bookId"));
            int quantity = Integer.parseInt(req.getParameter("quantity"));
            
            if (cart.containsKey(bookId)) {
                CartItem_20133096 item = cart.get(bookId);
                if (quantity > 0 && quantity <= item.getMaxQuantity()) {
                    item.setQuantity(quantity);
                }
            }
            resp.sendRedirect(req.getContextPath() + "/cart");

        } else if (path.equals("/checkout")) {
            User_20133096 user = (User_20133096) session.getAttribute("user");
            if (user == null) {
                resp.sendRedirect(req.getContextPath() + "/login");
                return;
            }
            
            double total = 0;
            for (CartItem_20133096 item : cart.values()) {
                total += item.getPrice() * item.getQuantity();
            }

            OrderDAO_20133096 orderDAO = new OrderDAO_20133096();
            if (orderDAO.insertOrder(user.getUserId(), total, cart.values())) {
                session.removeAttribute("cart"); // Xóa giỏ hàng sau khi mua thành công
                resp.sendRedirect(req.getContextPath() + "/order/history?msg=success");
            } else {
                resp.getWriter().println("Thanh toán COD thất bại!");
            }
        }
    }
}