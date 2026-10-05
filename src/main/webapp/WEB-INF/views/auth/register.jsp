<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head><title>Đăng ký</title><link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"></head>
<body class="bg-light">
<div class="container mt-5" style="max-width: 500px;">
    <div class="card shadow">
        <div class="card-body">
            <h3 class="text-center mb-4">Đăng ký tài khoản</h3>
            <form action="${pageContext.request.contextPath}/register" method="POST">
                <div class="mb-3"><label>Email:</label><input type="email" name="email" class="form-control" required></div>
                <div class="mb-3"><label>Họ và tên:</label><input type="text" name="fullname" class="form-control" required></div>
                <div class="mb-3"><label>Số điện thoại:</label><input type="number" name="phone" class="form-control" required></div>
                <div class="mb-3"><label>Mật khẩu:</label><input type="password" name="passwd" class="form-control" required></div>
                <button type="submit" class="btn btn-success w-100">Đăng ký</button>
            </form>
            <div class="mt-3 text-center"><a href="${pageContext.request.contextPath}/login">Đã có tài khoản? Đăng nhập</a></div>
        </div>
    </div>
</div>
</body>
</html>