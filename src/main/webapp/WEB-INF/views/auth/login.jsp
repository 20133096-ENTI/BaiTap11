<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head><title>Đăng nhập</title><link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"></head>
<body class="bg-light">
<div class="container mt-5" style="max-width: 400px;">
    <div class="card shadow">
        <div class="card-body">
            <h3 class="text-center mb-4">Đăng nhập</h3>
            <p class="text-danger">${error}</p>
            <form action="${pageContext.request.contextPath}/login" method="POST">
                <div class="mb-3"><label>Email:</label><input type="email" name="email" class="form-control" required></div>
                <div class="mb-3"><label>Mật khẩu:</label><input type="password" name="passwd" class="form-control" required></div>
                <button type="submit" class="btn btn-primary w-100">Đăng nhập</button>
            </form>
            <div class="mt-3 text-center"><a href="${pageContext.request.contextPath}/register">Chưa có tài khoản? Đăng ký ngay</a></div>
        </div>
    </div>
</div>
</body>
</html>