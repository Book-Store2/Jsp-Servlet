<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include-header.jsp" %>
<table class="table">
    <thead>
    <tr>
        <th>ID</th>
        <th>Tên khách hàng</th>
        <th>Tổng tiền</th>
        <th>Ngày đặt hàng</th>
        <th>Trạng thái</th>
        <th>Thanh toán</th>
        <th>Chức năng</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="order" items="${orders}">
        <tr>
            <td>${order.id}</td>
            <td>${order.customerName}</td>
            <td>${order.totalPrice}</td>
            <td>${order.orderDate}</td>
            <td>
                <c:choose>
                    <c:when test="${order.status == 0}">Chưa thanh toán</c:when>
                    <c:when test="${order.status == 1}">Đã thanh toán</c:when>
                    <c:when test="${order.status == 2}">Đã giao</c:when>
                    <c:when test="${order.status == 3}">Đã hủy</c:when>
                </c:choose>
            </td>
            <td>${order.paymentMethod}</td>
            <td>
                <a href="${pageContext.request.contextPath}/admin-order?id=${order.id}">
                    Xem
                </a>
                |
                <a href="${pageContext.request.contextPath}/admin-order?action=edit&id=${order.id}">
                    Sửa
                </a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
