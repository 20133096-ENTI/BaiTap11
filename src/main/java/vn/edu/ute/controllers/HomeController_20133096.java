package vn.edu.ute.controllers;
import vn.edu.ute.dao.BookDAO_20133096;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(urlPatterns = {"/home"})
public class HomeController_20133096 extends HttpServlet {
    private BookDAO_20133096 bookDAO = new BookDAO_20133096();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int page = 1;
        int pageSize = 3;
        if(req.getParameter("page") != null) page = Integer.parseInt(req.getParameter("page"));
        
        int total = bookDAO.countBooks();
        int totalPages = (int) Math.ceil((double) total / pageSize);
        
        req.setAttribute("books", bookDAO.getBooksPaging((page - 1) * pageSize, pageSize));
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        req.getRequestDispatcher("/WEB-INF/views/user/home.jsp").forward(req, resp);
    }
}