<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head><title>Lịch sử đơn hàng</title></head>
<body>
    <h3 class="text-primary fw-bold mb-4"><i class="fas fa-history me-2"></i>Lịch sử đơn hàng</h3>
    
    <c:if test="${param.msg == 'success'}">
        <div class="alert alert-success">🎉 Bạn đã đặt hàng thành công! Đơn hàng đang chờ xác nhận.</div>
    </c:if>

    <!-- Bộ lọc Trạng Thái -->
    <div class="mb-4">
        <form action="${pageContext.request.contextPath}/order/history" method="GET" class="d-flex align-items-center w-50">
            <label class="fw-bold me-2">Lọc theo trạng thái:</label>
            <select name="status" class="form-select me-2" onchange="this.form.submit()">
                <option value="All" ${currentStatus == 'All' ? 'selected' : ''}>Tất cả</option>
                <option value="Đơn hàng mới" ${currentStatus == 'Đơn hàng mới' ? 'selected' : ''}>Đơn hàng mới</option>
                <option value="Đã xác nhận" ${currentStatus == 'Đã xác nhận' ? 'selected' : ''}>Đã xác nhận</option>
                <option value="Chuẩn bị hàng" ${currentStatus == 'Chuẩn bị hàng' ? 'selected' : ''}>Chuẩn bị hàng</option>
                <option value="Vận chuyển" ${currentStatus == 'Vận chuyển' ? 'selected' : ''}>Vận chuyển</option>
                <option value="Giao hàng" ${currentStatus == 'Giao hàng' ? 'selected' : ''}>Giao hàng</option>
                <option value="Đã giao" ${currentStatus == 'Đã giao' ? 'selected' : ''}>Đã giao</option>
                <option value="Đơn hàng hủy" ${currentStatus == 'Đơn hàng hủy' ? 'selected' : ''}>Đơn hàng hủy</option>
                <option value="Đơn hàng hoàn" ${currentStatus == 'Đơn hàng hoàn' ? 'selected' : ''}>Đơn hàng hoàn</option>
            </select>
        </form>
    </div>

    <!-- Bảng Danh sách đơn hàng -->
    <table class="table table-bordered bg-white shadow-sm">
        <thead class="table-dark">
            <tr>
                <th>Mã Đơn</th><th>Ngày đặt</th><th>Tổng tiền</th><th>Hình thức thanh toán</th><th>Trạng thái</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${orders}" var="o">
                <tr>
                    <td class="fw-bold">#${o.orderId}</td>
                    <td>${o.orderDate}</td>
                    <td class="text-danger fw-bold">${o.totalAmount} VNĐ</td>
                    <td><span class="badge bg-secondary">${o.paymentMethod}</span></td>
                    <td>
                        <span class="badge ${o.status == 'Đơn hàng mới' ? 'bg-primary' : (o.status == 'Đã giao' ? 'bg-success' : 'bg-warning text-dark')}">
                            ${o.status}
                        </span>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    
    <p class="text-muted mt-3"><i>*Ghi chú: Giảng viên sẽ vào Database đổi cột Status trong bảng Orders để kiểm tra trạng thái nhảy trên web.</i></p>
</body>
</html>