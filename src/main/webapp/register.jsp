<%@ page import="org.example.bookstorecode.model.User" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    User checkUser = (User) session.getAttribute("user");
    if (checkUser != null) {
        response.sendRedirect("access-denied.jsp");
        return;
    }
%>
<%@ include file="include-header.jsp" %>

<h2>Đăng ký</h2>

<form id="registerForm" method="post" action="register" onsubmit="return validateForm()">
    <div>
        Tên: <input type="text" name="name" id="name"><br>
        <span id="nameError" style="color:red;"></span>
    </div>

    <div>
        Email: <input type="email" name="email" id="email"><br>
        <span id="emailError" style="color:red;"></span>
    </div>

    <div>
        Mật khẩu: <input type="password" name="password" id="password"><br>
        <label>Mật khẩu ít nhất 6 ký tự.</label><br>
        <span id="passwordError" style="color:red;"></span>
    </div>


    <input type="hidden" name="role" value="CUSTOMER" />
    <button type="submit">Đăng ký</button>
</form>

<a href="login">Đã có tài khoản?</a>

<script>
    function validateForm() {
        let isValid = true;

        // Xóa lỗi cũ
        document.getElementById("nameError").innerText = "";
        document.getElementById("emailError").innerText = "";
        document.getElementById("passwordError").innerText = "";

        const name = document.getElementById("name").value.trim();
        const email = document.getElementById("email").value.trim();
        const password = document.getElementById("password").value;

        // Validate name
        if (name.length < 2 || name.length > 50) {
            document.getElementById("nameError").innerText = "Tên phải từ 2 đến 50 ký tự.";
            isValid = false;
        }

        // Validate email
        const emailRegex = /^[\w.-]+@[\w.-]+\.[a-zA-Z]{2,}$/;
        if (!emailRegex.test(email)) {
            document.getElementById("emailError").innerText = "Email không hợp lệ.";
            isValid = false;
        }

        // Validate password
        if (password.length < 6) {
            document.getElementById("passwordError").innerText = "Mật khẩu vừa nhập không hợp lệ!.";
            isValid = false;
        }

        return isValid; // Chỉ gửi form nếu hợp lệ
    }
</script>
