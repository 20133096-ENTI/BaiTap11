package vn.edu.ute.controllers;
import vn.edu.ute.dao.BookDAO_20133096;
import vn.edu.ute.dao.RatingDAO_20133096;
import vn.edu.ute.models.Rating_20133096;
import vn.edu.ute.models.User_20133096;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(urlPatterns = {"/book/detail"})
public class BookController_20133096 extends HttpServlet {
    private BookDAO_20133096 bookDAO = new BookDAO_20133096();
    private RatingDAO_20133096 ratingDAO = new RatingDAO_20133096();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        req.setAttribute("book", bookDAO.getBookById(id));
        req.setAttribute("reviews", ratingDAO.getReviewsByBookId(id));
        req.getRequestDispatcher("/WEB-INF/views/user/detail.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User_20133096 user = (User_20133096) session.getAttribute("user");
        if(user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        
        Rating_20133096 r = new Rating_20133096();
        r.setUserid(user.getId());
        r.setBookid(Integer.parseInt(req.getParameter("bookid")));
        r.setReviewText(req.getParameter("review_text"));
        ratingDAO.addReview(r);
        
        resp.sendRedirect(req.getContextPath() + "/book/detail?id=" + r.getBookid());
    }
}