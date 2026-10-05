<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<title>Quản lý Sách</title>
<div class="d-flex justify-content-between mb-3">
    <h3>Danh Sách Sách</h3>
    <a href="${pageContext.request.contextPath}/admin/books/add" class="btn btn-success">Thêm Mới</a>
</div>
<table class="table table-bordered table-striped">
    <thead class="table-dark">
        <tr><th>ID</th><th>Tiêu đề</th><th>ISBN</th><th>Nhà xuất bản</th><th>Giá</th><th>Số lượng</th><th>Action</th></tr>
    </thead>
    <tbody>
        <c:forEach items="${books}" var="b">
            <tr>
                <td>${b.bookid}</td><td>${b.title}</td><td>${b.isbn}</td><td>${b.publisher}</td><td>${b.price}</td><td>${b.quantity}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/admin/books/edit?id=${b.bookid}" class="btn btn-warning btn-sm">Sửa</a>
                    <a href="${pageContext.request.contextPath}/admin/books/delete?id=${b.bookid}" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có chắc muốn xóa cuốn sách này?')">Xóa</a>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>
<nav>
    <ul class="pagination justify-content-center">
        <c:if test="${currentPage > 1}"><li class="page-item"><a class="page-link" href="?page=${currentPage - 1}">Trang trước</a></li></c:if>
        <c:forEach begin="1" end="${totalPages}" var="i"><li class="page-item ${i == currentPage ? 'active' : ''}"><a class="page-link" href="?page=${i}">${i}</a></li></c:forEach>
        <c:if test="${currentPage < totalPages}"><li class="page-item"><a class="page-link" href="?page=${currentPage + 1}">Trang sau</a></li></c:if>
    </ul>
</nav>