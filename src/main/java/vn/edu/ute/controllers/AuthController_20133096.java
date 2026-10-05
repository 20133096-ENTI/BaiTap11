package vn.edu.ute.controllers;
import vn.edu.ute.dao.UserDAO_20133096;
import vn.edu.ute.models.User_20133096;
import vn.edu.ute.utils.EmailUtil_20133096;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Random;

@WebServlet(urlPatterns = {"/login", "/register", "/verify-otp", "/logout"})
public class AuthController_20133096 extends HttpServlet {
    private UserDAO_20133096 userDAO = new UserDAO_20133096();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        if ("/login".equals(path)) req.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(req, resp);
        else if ("/register".equals(path)) req.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(req, resp);
        else if ("/verify-otp".equals(path)) req.getRequestDispatcher("/WEB-INF/views/auth/otp.jsp").forward(req, resp);
        else if ("/logout".equals(path)) {
            req.getSession().invalidate();
            resp.sendRedirect("login");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        HttpSession session = req.getSession();
        if ("/login".equals(path)) {
            User_20133096 user = userDAO.login(req.getParameter("email"), req.getParameter("passwd"));
            if (user != null) {
                session.setAttribute("user", user);
                if (user.isAdmin()) resp.sendRedirect(req.getContextPath() + "/admin/books");
                else resp.sendRedirect(req.getContextPath() + "/home");
            } else {
                req.setAttribute("error", "Invalid credentials");
                req.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(req, resp);
            }
        } else if ("/register".equals(path)) {
            User_20133096 tempUser = new User_20133096();
            tempUser.setEmail(req.getParameter("email"));
            tempUser.setFullname(req.getParameter("fullname"));
            tempUser.setPhone(Integer.parseInt(req.getParameter("phone")));
            tempUser.setPasswd(req.getParameter("passwd"));
            
            // Tạo mã OTP 6 số ngẫu nhiên
            String otp = String.format("%06d", new Random().nextInt(999999));
            session.setAttribute("tempUser", tempUser);
            session.setAttribute("otp", otp);
            
            // XỬ LÝ NHANH: Comment dòng gửi mail thật để bỏ qua lỗi App Password
            // EmailUtil_20133096.sendOTP(tempUser.getEmail(), otp); 
            
            // In thẳng mã OTP ra màn hình Console để lấy nhập vào web
            System.out.println("\n=====================================");
            System.out.println("MÃ OTP ĐĂNG KÝ TÀI KHOẢN LÀ: " + otp);
            System.out.println("=====================================\n");
            
            // Chuyển hướng sang trang nhập OTP
            resp.sendRedirect("verify-otp");
        } else if ("/verify-otp".equals(path)) {
            String inputOtp = req.getParameter("otp");
            String sysOtp = (String) session.getAttribute("otp");
            if (sysOtp != null && sysOtp.equals(inputOtp)) {
                userDAO.register((User_20133096) session.getAttribute("tempUser"));
                session.removeAttribute("tempUser");
                session.removeAttribute("otp");
                resp.sendRedirect("login");
            } else {
                req.setAttribute("error", "Wrong OTP");
                req.getRequestDispatcher("/WEB-INF/views/auth/otp.jsp").forward(req, resp);
            }
        }
    }
}