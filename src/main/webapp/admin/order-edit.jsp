<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../include-header.jsp" %>

<h2>Sửa trạng thái đơn hàng #${order.id}</h2>

<form action="${pageContext.request.contextPath}/admin-order?action=edit&id=${order.id}" method="post">
    <label>Trạng thái đơn hàng:</label>
    <select name="status">
        <option value="0" ${order.status == 0 ? 'selected' : ''}>Chưa thanh toán</option>
        <option value="1" ${order.status == 1 ? 'selected' : ''}>Đã thanh toán</option>
        <option value="2" ${order.status == 2 ? 'selected' : ''}>Đã giao</option>
        <option value="3" ${order.status == 3 ? 'selected' : ''}>Đã hủy</option>
    </select>

    <br><br>

    <button type="submit">Cập nhật</button>
    <a href="${pageContext.request.contextPath}/manage-orders">Quay lại</a>
</form>

