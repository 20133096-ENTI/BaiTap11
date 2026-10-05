<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title><sitemesh:write property="title"/></title>
    <!-- Thư viện Bootstrap & Icon -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        body { 
            background-color: #f4f6f9; 
            display: flex; 
            flex-direction: column; 
            min-height: 100vh; /* Đẩy footer xuống đáy */
        }
        .main-content { flex: 1; }
        .navbar { box-shadow: 0 4px 6px rgba(0,0,0,0.1); }
        .footer { background-color: #2c3e50; color: #ecf0f1; padding: 20px 0; }
    </style>
    <sitemesh:write property="head"/>
</head>
<body>
    <!-- HEADER -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary sticky-top py-3">
        <div class="container">
            <a class="navbar-brand fw-bold fs-4" href="${pageContext.request.contextPath}/home">
                <i class="fas fa-book-reader me-2"></i>BookStore
            </a>
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/home">Trang Chủ</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/home">Sản phẩm</a></li>
                    <c:if test="${not empty sessionScope.user and sessionScope.user.admin}">
                        <li class="nav-item"><a class="nav-link text-warning fw-bold" href="${pageContext.request.contextPath}/admin/books"><i class="fas fa-cogs me-1"></i>Trang quản trị</a></li>
                    </c:if>
                </ul>
                <ul class="navbar-nav">
                    <c:if test="${empty sessionScope.user}">
                        <li class="nav-item"><a class="btn btn-light text-primary fw-bold px-4 rounded-pill" href="${pageContext.request.contextPath}/login">Đăng nhập</a></li>
                    </c:if>
                    <c:if test="${not empty sessionScope.user}">
                        <li class="nav-item"><span class="nav-link text-white"><i class="fas fa-user-circle fs-5 me-1"></i> ${sessionScope.user.fullname}</span></li>
                        <li class="nav-item"><a class="btn btn-danger ms-3 rounded-pill" href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt me-1"></i>Đăng xuất</a></li>
                    </c:if>
                </ul>
            </div>
        </div>
    </nav>

    <!-- NỘI DUNG TỪNG TRANG (SẼ CHÈN VÀO ĐÂY) -->
    <div class="container main-content mt-4 mb-5">
        <sitemesh:write property="body"/>
    </div>

    <!-- FOOTER -->
    <footer class="footer text-center mt-auto">
        <div class="container">
            <p class="mb-0 fs-5">
                <strong>Họ tên:</strong> Lê Nghĩa Tình | 
                <strong>MSSV:</strong> 20133096 | 
                <strong>Mã đề:</strong> 02
            </p>
        </div>
    </footer>
</body>
</html>