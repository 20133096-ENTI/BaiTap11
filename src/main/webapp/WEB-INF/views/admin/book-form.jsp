<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<title>${empty book ? 'Thêm Sách' : 'Sửa Sách'}</title>
<div class="card">
    <div class="card-header bg-primary text-white"><h5>${empty book ? 'Thêm Mới Sách' : 'Cập Nhật Sách'}</h5></div>
    <div class="card-body">
        <form action="${pageContext.request.contextPath}/admin/books" method="POST">
            <input type="hidden" name="bookid" value="${book.bookid}">
            <div class="row">
                <div class="col-md-6 mb-3"><label>ISBN</label><input type="number" name="isbn" value="${book.isbn}" class="form-control" required></div>
                <div class="col-md-6 mb-3"><label>Tiêu đề</label><input type="text" name="title" value="${book.title}" class="form-control" required></div>
                <div class="col-md-6 mb-3"><label>Nhà xuất bản</label><input type="text" name="publisher" value="${book.publisher}" class="form-control"></div>
                <div class="col-md-6 mb-3"><label>Giá</label><input type="number" step="0.01" name="price" value="${book.price}" class="form-control" required></div>
                <div class="col-md-6 mb-3"><label>Số lượng</label><input type="number" name="quantity" value="${book.quantity}" class="form-control" required></div>
            </div>
            <button type="submit" class="btn btn-success">Lưu dữ liệu</button>
            <a href="${pageContext.request.contextPath}/admin/books" class="btn btn-secondary">Quay lại</a>
        </form>
    </div>
</div>