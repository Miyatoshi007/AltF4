<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <title>Quên mật khẩu</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    <style>
        /* Styling similar to the register form */
        body {
            background-color: #f4f7fc;
            font-family: "Arial", sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background: radial-gradient(circle, rgba(0, 102, 204, 0.1) 20%, rgba(0, 102, 204, 0) 40%);
            overflow: hidden;
        }

        .container {
            width: 100%;
            max-width: 400px;
            padding: 30px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .form-control {
            border-radius: 30px;
            padding: 15px;
        }

        .btn-custom {
            background-color: #0066cc;
            color: white;
            border-radius: 30px;
            padding: 12px;
            font-weight: bold;
            border: none;
            width: 100%;
            transition: background-color 0.3s;
        }

        .btn-custom:hover {
            background-color: #005bb5;
        }

        .error-message {
            color: red;
            font-size: 14px;
            text-align: center;
            margin-bottom: 10px;
        }

        .hidden {
            display: none;
        }
    </style>
    <script>
        function showStep(step) {
            document.querySelectorAll(".step").forEach(stepDiv => stepDiv.classList.add("hidden"));
            document.querySelector("#step-" + step).classList.remove("hidden");
        }
    </script>
</head>
<body>
    <div class="container">
        <h3 class="text-center">Quên mật khẩu</h3>

        <c:if test="${not empty errorMessage}">
            <div class="error-message">${errorMessage}</div>
        </c:if>

        <!-- Step 1: Enter Email -->
        <div id="step-1" class="step ${sessionScope.currentStep == 'step1' ? '' : 'hidden'}">
            <form action="/ASM/forgotPass/checkMail" method="post">
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="text" class="form-control mb-3" id="email" name="email" placeholder="Nhập email đã đăng ký" value="${email}" />
                </div>
                <button type="submit" class="btn btn-custom">Gửi mã OTP</button>
            </form>
        </div>

        <!-- Step 2: Verify OTP -->
        <div id="step-2" class="step ${sessionScope.currentStep == 'step2' ? '' : 'hidden'}">
            <form action="/ASM/forgotPass/checkOTP" method="post">
                <div class="form-group">
                    <label for="otp">Nhập mã OTP</label>
                    <input type="text" class="form-control mb-3" id="otp" name="otp" placeholder="Nhập mã OTP được gửi đến email" />
                </div>
                <button type="submit" class="btn btn-custom">Xác thực</button>
            </form>
        </div>

        <!-- Step 3: Enter New Password -->
        <div id="step-3" class="step ${sessionScope.currentStep == 'step3' ? '' : 'hidden'}">
            <form action="/ASM/forgotPass/changePass" method="post">
                <div class="form-group mb-3">
                    <label for="new-password">Mật khẩu mới</label>
                    <input type="password" class="form-control" id="new-password" name="new-password" placeholder="Nhập mật khẩu mới" />
                </div>
                <div class="form-group mb-3">
                    <label for="confirm-password">Xác nhận mật khẩu mới</label>
                    <input type="password" class="form-control" id="confirm-password" name="confirm-password" placeholder="Xác nhận mật khẩu mới" />
                </div>
                <button type="submit" class="btn btn-custom">Đặt lại mật khẩu</button>
            </form>
        </div>
    </div>
</body>
</html>
