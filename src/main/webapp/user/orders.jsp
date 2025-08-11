<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ include file="../include-header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>



<div class="container my-4">
  <h4 class="mb-3">Lịch sử đơn hàng</h4>

  <c:choose>
    <c:when test="${empty orders}">
      <div class="alert alert-info">Bạn chưa có đơn hàng nào.</div>
    </c:when>
    <c:otherwise>
      <div class="row g-3">
        <c:forEach var="o" items="${orders}">
          <div class="col-12">
            <div class="card shadow-sm">
              <div class="card-body d-flex flex-wrap justify-content-between gap-2">
                <div>
                  <div class="fw-semibold">
                    Đơn #${o.id}
                    <span class="text-muted"> • ${o.createdAt}</span>
                  </div>
                  <div class="mt-2">
                    <span class="badge bg-light text-dark me-1">${o.paymentMethod}</span>
                    <c:choose>
                      <c:when test="${o.status == 0}"><span class="badge bg-warning text-dark">Chưa thanh toán</span></c:when>
                      <c:when test="${o.status == 1}"><span class="badge bg-info text-dark">Đã thanh toán</span></c:when>
                      <c:when test="${o.status == 2}"><span class="badge bg-success">Đã nhận</span></c:when>
                      <c:when test="${o.status == 3}"><span class="badge bg-secondary">Đã hủy</span></c:when>
                    </c:choose>
                  </div>
                </div>

                <div class="text-end">
                  <fmt:setLocale value="vi_VN"/>
                  <div class="fw-semibold">
                    <fmt:formatNumber value="${o.totalAmount}" type="currency"/>
                  </div>
                  <div class="mt-2 d-flex justify-content-end gap-2">
                    <a class="btn btn-outline-primary btn-sm"
                       href="${pageContext.request.contextPath}/user-orders-detail?id=${o.id}">
                      Chi tiết
                    </a>
                    <c:if test="${o.status == 0}">
                      <form method="post" action="${pageContext.request.contextPath}/cancel-order"
                            onsubmit="return confirm('Hủy đơn #${o.id}?');" class="m-0">
                        <input type="hidden" name="orderId" value="${o.id}">
                        <button type="submit" class="btn btn-outline-danger btn-sm">Hủy</button>
                      </form>
                    </c:if>
                  </div>
                </div>
              </div>

              <!-- Tóm tắt vài item -->
              <c:if test="${not empty o.items}">
                <div class="table-responsive px-3 pb-3">
                  <table class="table table-sm mb-0">
                    <thead>
                    <tr>
                      <th style="width:60%">Sách</th>
                      <th class="text-center">SL</th>
                      <th class="text-end">Giá</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="it" items="${o.items}" end="2">
                      <tr>
                        <td>${it.title}</td>
                        <td class="text-center">${it.quantity}</td>
                        <td class="text-end"><fmt:formatNumber value="${it.price}" type="currency"/></td>
                      </tr>
                    </c:forEach>
                    </tbody>
                  </table>
                </div>
              </c:if>

            </div>
          </div>
        </c:forEach>
      </div>
    </c:otherwise>
  </c:choose>

  <div class="mt-3">
    <a href="${pageContext.request.contextPath}/user-book-store" class="btn btn-success">Tiếp tục mua sắm</a>
  </div>
</div>


<%@ include file="../footer.jsp" %>



