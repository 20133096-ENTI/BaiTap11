<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<title>Chi Tiết Sách</title>
<div class="card mb-4">
    <div class="card-body d-flex">
        <img src="${book.coverImage}" width="200" alt="Cover" class="me-4">
        <div>
            <h3>Tiêu đề: ${book.title}</h3>
            <p>Mã isbn: ${book.isbn}</p>
            <p>Tác giả: ${book.authorName}</p>
            <p>Publisher: ${book.publisher}</p>
            <p>Publisher date: ${book.publishDate}</p>
            <p>Quantity: ${book.quantity}</p>
            <p><strong>Reviews (${book.reviewCount})</strong></p>
        </div>
    </div>
</div>
<h4>Reviews</h4>
<ul class="list-group mb-4">
    <c:forEach items="${reviews}" var="r">
        <li class="list-group-item"><strong>[${r.userFullName}]:</strong> [${r.reviewText}]</li>
    </c:forEach>
</ul>
<h4>Form thêm reviews</h4>
<form action="${pageContext.request.contextPath}/book/detail" method="POST">
    <input type="hidden" name="bookid" value="${book.bookid}">
    <div class="mb-3">
        <textarea name="review_text" class="form-control" rows="3" required></textarea>
    </div>
    <button type="submit" class="btn btn-primary">[Submit]</button>
</form>