<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin - <sitemesh:write property="title"/></title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
    <sitemesh:write property="head"/>
</head>
<body>
    <nav class="navbar navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="#">Admin Dashboard</a>
            <a class="btn btn-outline-light" href="${pageContext.request.contextPath}/home">Back to Site</a>
        </div>
    </nav>
    <div class="container mt-4">
        <sitemesh:write property="body"/>
    </div>
</body>
</html>