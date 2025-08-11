<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>


<!-- DÙNG dynamic include để tránh xung đột page directive -->
<jsp:include page="../include-header.jsp" />

<div class="container my-4">

    <!-- Flash -->
    <c:if test="${not empty sessionScope.flash}">
        <div class="alert alert-success">${sessionScope.flash}</div>
        <c:remove var="flash" scope="session"/>
    </c:if>
    <c:if test="${not empty sessionScope.flash_err}">
        <div class="alert alert-danger">${sessionScope.flash_err}</div>
        <c:remove var="flash_err" scope="session"/>
    </c:if>

    <!-- Nếu có lỗi -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <c:if test="${not empty order}">
        <!-- Thông tin khách + đơn -->
        <div class="card mb-3">
            <div class="card-header d-flex justify-content-between align-items-center">
                <b>Thông tin đơn hàng</b>
                <c:if test="${order.status == 0}">
                    <form method="post" action="${pageContext.request.contextPath}/user-orders-cancel"
                          onsubmit="return confirm('Hủy đơn #${order.id}?');" class="m-0">
                        <input type="hidden" name="orderId" value="${order.id}">
                        <button type="submit" class="btn btn-outline-danger btn-sm">
                            <i class="fa fa-times"></i> Hủy đơn
                        </button>
                    </form>
                </c:if>
            </div>
            <div class="card-body row">
                <div class="col-md-6">
                    <div><b>Mã đơn:</b> #${order.id}</div>
                    <div><b>Ngày đặt:</b> ${order.createdAt}</div>
                    <div><b>Thanh toán:</b> ${order.paymentMethod}</div>
                    <div>
                        <b>Trạng thái:</b>
                        <c:choose>
                            <c:when test="${order.status == 0}"><span class="badge bg-warning text-dark">Chưa thanh toán</span></c:when>
                            <c:when test="${order.status == 1}"><span class="badge bg-info text-dark">Đã thanh toán</span></c:when>
                            <c:when test="${order.status == 2}"><span class="badge bg-success">Đã nhận</span></c:when>
                            <c:when test="${order.status == 3}"><span class="badge bg-secondary">Đã hủy</span></c:when>
                        </c:choose>
                    </div>
                </div>
                <div class="col-md-6">
                    <div><b>Khách hàng:</b> ${customerName}</div>
                    <div><b>Email:</b> ${customerEmail}</div>
                    <!-- Nếu cần số điện thoại, thêm field và set từ UserDao rồi hiển thị -->
                </div>
            </div>
        </div>

        <!-- Sản phẩm -->
        <div class="card">
            <div class="card-header"><b>Sản phẩm</b></div>
            <div class="card-body">
                <fmt:setLocale value="vi_VN"/>
                <div class="table-responsive">
                    <table class="table table-striped align-middle">
                        <thead>
                        <tr>
                            <th>Sách</th>
                            <th class="text-end">Giá</th>
                            <th class="text-center">SL</th>
                            <th class="text-end">Thành tiền</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="it" items="${order.items}">
                            <tr>
                                <td>${it.title}</td>
                                <td class="text-end"><fmt:formatNumber value="${it.price}" type="currency"/></td>
                                <td class="text-center">${it.quantity}</td>
                                <td class="text-end">
                                    <c:choose>
                                        <c:when test="${not empty it.lineTotal}">
                                            <fmt:formatNumber value="${it.lineTotal}" type="currency"/>
                                        </c:when>
                                        <c:otherwise>
                                            <fmt:formatNumber value="${it.price * it.quantity}" type="currency"/>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                        <tfoot>
                        <tr>
                            <th colspan="3" class="text-end">Tổng cộng</th>
                            <th class="text-end"><fmt:formatNumber value="${order.totalAmount}" type="currency"/></th>
                        </tr>
                        </tfoot>
                    </table>
                </div>

                <div class="mt-3">
                    <a href="${pageContext.request.contextPath}/user-orders" class="btn btn-outline-secondary">
                        <i class="fa fa-arrow-left"></i> Quay lại lịch sử đơn hàng
                    </a>
                </div>
            </div>
        </div>
    </c:if>
</div>

<!-- DÙNG dynamic include cho footer -->
<jsp:include page="../footer.jsp" />
