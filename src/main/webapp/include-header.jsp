<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.bookstorecode.model.User" %>
<%@ page import="org.example.bookstorecode.model.Role" %>

<%
    User user = (User) session.getAttribute("user");
    String headerPath = "/guest-header.jsp"; // ✅ gán mặc định

    if (user != null) {
        if (user.getRole() == Role.ADMIN) {
            headerPath = "/admin/header.jsp";
        } else if (user.getRole() == Role.CUSTOMER) {
            headerPath = "/user/header.jsp";
        }
    }
%>

<jsp:include page="<%= headerPath %>" />
