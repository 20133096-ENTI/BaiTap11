package vn.edu.ute.controllers;
import vn.edu.ute.dao.BookDAO_20133096;
import vn.edu.ute.models.Book_20133096;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(urlPatterns = {"/admin/books", "/admin/books/add", "/admin/books/edit", "/admin/books/delete"})
public class AdminBookController_20133096 extends HttpServlet {
    private BookDAO_20133096 bookDAO = new BookDAO_20133096();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        if ("/admin/books".equals(path)) {
            int page = req.getParameter("page") == null ? 1 : Integer.parseInt(req.getParameter("page"));
            int limit = 5;
            req.setAttribute("books", bookDAO.getBooksPaging((page - 1) * limit, limit));
            req.setAttribute("currentPage", page);
            req.setAttribute("totalPages", (int) Math.ceil((double) bookDAO.countBooks() / limit));
            req.getRequestDispatcher("/WEB-INF/views/admin/book-list.jsp").forward(req, resp);
        } else if ("/admin/books/add".equals(path)) {
            req.getRequestDispatcher("/WEB-INF/views/admin/book-form.jsp").forward(req, resp);
        } else if ("/admin/books/edit".equals(path)) {
            int id = Integer.parseInt(req.getParameter("id"));
            req.setAttribute("book", bookDAO.getBookById(id));
            req.getRequestDispatcher("/WEB-INF/views/admin/book-form.jsp").forward(req, resp);
        } else if ("/admin/books/delete".equals(path)) {
            bookDAO.delete(Integer.parseInt(req.getParameter("id")));
            resp.sendRedirect(req.getContextPath() + "/admin/books");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        Book_20133096 b = new Book_20133096();
        b.setIsbn(Integer.parseInt(req.getParameter("isbn")));
        b.setTitle(req.getParameter("title"));
        b.setPublisher(req.getParameter("publisher"));
        b.setPrice(Double.parseDouble(req.getParameter("price")));
        b.setQuantity(Integer.parseInt(req.getParameter("quantity")));
        
        if(req.getParameter("bookid") != null && !req.getParameter("bookid").isEmpty()){
            b.setBookid(Integer.parseInt(req.getParameter("bookid")));
            bookDAO.update(b);
        } else {
            bookDAO.insert(b);
        }
        resp.sendRedirect(req.getContextPath() + "/admin/books");
    }
}