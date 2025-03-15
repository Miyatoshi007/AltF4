<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Error</title>
<style>
body {
	margin: 0;
	padding: 0;
	background-color: #000;
	color: #fff;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
	font-family: 'Arial', sans-serif;
}

.error-container {
	text-align: center;
}

.error-face svg {
	width: 120px;
	height: 120px;
	fill: #fff;
	margin-bottom: 20px;
}

.error-message {
	font-size: 24px;
	margin: 0;
}

.home-link {
	display: inline-block;
	margin-top: 20px;
	padding: 10px 20px;
	border: 2px solid #fff;
	color: #fff;
	text-decoration: none;
	font-size: 18px;
	border-radius: 5px;
	transition: all 0.3s;
}

.home-link:hover {
	background-color: #fff;
	color: #000;
}
</style>
</head>
<body>
	<div class="error-container">
		<div class="error-face">
			<!-- SVG mặt buồn -->
			<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                <circle cx="12" cy="12" r="10" fill="none" stroke="#fff"
					stroke-width="2" />
                <circle cx="9" cy="10" r="1.5" fill="#fff" />
                <circle cx="15" cy="10" r="1.5" fill="#fff" />
                <path d="M8 16c1.333-2 4.667-2 6 0" stroke="#fff"
					stroke-width="2" fill="none" stroke-linecap="round" />
            </svg>
		</div>
		<p class="error-message">${ errorMessage }</p>
		<a href="./.." class="home-link">Go Back Home</a>
	</div>
</body>
</html>
