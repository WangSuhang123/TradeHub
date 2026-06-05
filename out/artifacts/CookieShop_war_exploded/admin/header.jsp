<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <title>后台管理 - TradeHub</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen">

<nav class="bg-gray-800 text-white shadow-lg">
  <div class="max-w-7xl mx-auto px-4">
    <div class="flex justify-between items-center h-16">
      <div class="flex items-center space-x-8">
        <a href="${pageContext.request.contextPath}/admin" class="text-xl font-bold">TradeHub 后台</a>
        <a href="${pageContext.request.contextPath}/admin?method=userList" class="hover:text-gray-300 text-sm">用户管理</a>
        <a href="${pageContext.request.contextPath}/admin?method=productList" class="hover:text-gray-300 text-sm">商品管理</a>
        <a href="${pageContext.request.contextPath}/admin?method=categoryList" class="hover:text-gray-300 text-sm">分类管理</a>
        <a href="${pageContext.request.contextPath}/carousel?method=list" class="hover:text-gray-300 text-sm">轮播图管理</a>
      </div>
      <div class="flex items-center space-x-4">
        <a href="${pageContext.request.contextPath}/index" class="text-gray-400 hover:text-white text-sm">前台首页</a>
        <a href="${pageContext.request.contextPath}/user?method=logout" class="text-gray-400 hover:text-white text-sm">退出</a>
      </div>
    </div>
  </div>
</nav>