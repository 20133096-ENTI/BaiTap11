<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head><title>Giỏ hàng của bạn</title></head>
<body>
    <h3 class="text-primary fw-bold mb-4"><i class="fas fa-shopping-cart me-2"></i>Giỏ hàng</h3>
    
    <c:if test="${empty sessionScope.cart}">
        <div class="alert alert-warning">Giỏ hàng của bạn đang trống!</div>
    </c:if>

    <c:if test="${not empty sessionScope.cart}">
        <table class="table table-bordered table-hover bg-white shadow-sm">
            <thead class="table-primary">
                <tr>
                    <th>Ảnh</th><th>Tên sách</th><th>Giá</th><th>Số lượng</th><th>Tổng cộng</th><th>Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <c:set var="totalAmount" value="0"/>
                <c:forEach items="${sessionScope.cart.values()}" var="item">
                    <c:set var="totalAmount" value="${totalAmount + (item.price * item.quantity)}"/>
                    <tr>
                        <td><img src="${item.coverImage}" width="50" alt="cover"></td>
                        <td class="fw-bold">${item.title}</td>
                        <td>${item.price} VNĐ</td>
                        <td>
                            <!-- Form cập nhật số lượng trong giới hạn tồn kho -->
                            <form action="${pageContext.request.contextPath}/cart/update" method="POST" class="d-flex">
                                <input type="hidden" name="bookId" value="${item.bookId}">
                                <input type="number" name="quantity" value="${item.quantity}" min="1" max="${item.maxQuantity}" class="form-control form-control-sm w-50 me-2">
                                <button type="submit" class="btn btn-sm btn-info text-white"><i class="fas fa-save"></i> Cập nhật</button>
                            </form>
                            <small class="text-muted">Tồn kho: ${item.maxQuantity}</small>
                        </td>
                        <td class="fw-bold text-danger">${item.price * item.quantity} VNĐ</td>
                        <td>
                            <a href="${pageContext.request.contextPath}/cart/remove?id=${item.bookId}" class="btn btn-sm btn-danger"><i class="fas fa-trash"></i></a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        
        <div class="text-end">
            <h4 class="fw-bold">Tổng tiền: <span class="text-danger">${totalAmount} VNĐ</span></h4>
            <form action="${pageContext.request.contextPath}/checkout" method="POST">
                <button type="submit" class="btn btn-success btn-lg mt-2 fw-bold"><i class="fas fa-check-circle me-2"></i>Thanh toán COD</button>
            </form>
        </div>
    </c:if>
</body>
</html>