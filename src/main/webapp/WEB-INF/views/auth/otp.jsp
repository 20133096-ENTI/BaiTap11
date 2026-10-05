<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head><title>Xác nhận OTP</title><link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"></head>
<body class="bg-light">
<div class="container mt-5" style="max-width: 400px;">
    <div class="card shadow">
        <div class="card-body text-center">
            <h3 class="mb-4">Xác nhận OTP</h3>
            <p class="text-danger">${error}</p>
            <p>Vui lòng kiểm tra Email (hoặc Console) để lấy mã OTP.</p>
            <form action="${pageContext.request.contextPath}/verify-otp" method="POST">
                <div class="mb-3"><input type="text" name="otp" class="form-control text-center" placeholder="Nhập mã 6 số" required></div>
                <button type="submit" class="btn btn-primary w-100">Xác thực</button>
            </form>
        </div>
    </div>
</div>
</body>
</html>