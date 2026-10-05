<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Trang Chủ - Danh mục Sách</title>
    <style>
        .book-card { 
            transition: transform 0.2s ease-in-out, box-shadow 0.2s; 
            border: none; 
            border-radius: 12px; 
        }
        .book-card:hover { 
            transform: translateY(-5px); 
            box-shadow: 0 10px 20px rgba(0,0,0,0.15) !important; 
        }
        .book-cover { 
            width: 140px; 
            height: 200px; 
            object-fit: cover; 
            border-radius: 8px; 
        }
        .book-title { 
            text-decoration: none; 
            color: #2c3e50; 
            font-weight: 700; 
            font-size: 1.3rem; 
            transition: color 0.2s; 
        }
        .book-title:hover { color: #0d6efd; }
    </style>
</head>
<body>
    <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-2">
        <h3 class="text-primary fw-bold"><i class="fas fa-list-ul me-2"></i>Danh mục Sách Mới</h3>
    </div>

    <div class="row">
        <c:forEach items="${books}" var="b">
            <div class="col-md-12 mb-4">
                <div class="card book-card shadow-sm h-100 p-2">
                    <div class="card-header bg-white border-bottom-0 pb-0">
                        <span class="badge bg-warning text-dark px-3 py-2 fs-6 rounded-pill"><i class="fas fa-pen-nib me-2"></i>Tác giả: ${b.authorName}</span>
                    </div>
                    <div class="card-body d-flex flex-column flex-md-row align-items-center align-items-md-start">
                        <img src="${b.coverImage}" alt="Cover" class="book-cover me-md-4 mb-3 mb-md-0 border shadow-sm">
                        
                        <div class="flex-grow-1 w-100">
                            <h5 class="mb-3"><a href="${pageContext.request.contextPath}/book/detail?id=${b.bookid}" class="book-title">${b.title}</a></h5>
                            
                            <div class="row g-2 text-muted mb-3 fs-6">
                                <div class="col-sm-6"><i class="fas fa-barcode me-2 text-secondary"></i><strong>ISBN:</strong> ${b.isbn}</div>
                                <div class="col-sm-6"><i class="fas fa-building me-2 text-secondary"></i><strong>NXB:</strong> ${b.publisher}</div>
                                <div class="col-sm-6"><i class="fas fa-calendar-alt me-2 text-secondary"></i><strong>Ngày XB:</strong> ${b.publishDate}</div>
                                <div class="col-sm-6"><i class="fas fa-cubes me-2 text-secondary"></i><strong>Số lượng:</strong> <span class="badge bg-success ms-1">${b.quantity}</span></div>
                            </div>
                            
                            <div class="d-flex align-items-center mt-auto pt-3 border-top">
                                <span class="text-danger me-2"><i class="fas fa-heart"></i></span>
                                <strong class="text-secondary">Đánh giá (${b.reviewCount})</strong>
                                <a href="${pageContext.request.contextPath}/book/detail?id=${b.bookid}" class="btn btn-outline-primary btn-sm ms-auto fw-bold px-3 rounded-pill">Chi tiết <i class="fas fa-arrow-right ms-1"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
    
    <!-- THANH PHÂN TRANG -->
    <div class="d-flex justify-content-center mt-4">
        <nav>
            <ul class="pagination pagination-lg shadow-sm">
                <c:if test="${currentPage > 1}">
                    <li class="page-item">
                        <a class="page-link text-primary fw-bold" href="?page=${currentPage - 1}">&laquo; Trước</a>
                    </li>
                </c:if>
                <c:forEach begin="1" end="${totalPages}" var="i">
                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                        <a class="page-link fw-bold" href="?page=${i}">${i}</a>
                    </li>
                </c:forEach>
                <c:if test="${currentPage < totalPages}">
                    <li class="page-item">
                        <a class="page-link text-primary fw-bold" href="?page=${currentPage + 1}">Sau &raquo;</a>
                    </li>
                </c:if>
            </ul>
        </nav>
    </div>
</body>
</html>