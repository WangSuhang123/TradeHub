<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="header.jsp"/>

<div class="p-8">
  <h1 class="text-3xl font-bold text-gray-800 mb-8">后台管理</h1>

  <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
    <div class="bg-white rounded-xl shadow-md p-6">
      <div class="flex items-center justify-between">
        <div>
          <p class="text-gray-500 text-sm">用户总数</p>
          <p class="text-3xl font-bold text-gray-800 mt-1">${userCount}</p>
        </div>
        <div class="w-12 h-12 bg-blue-100 rounded-lg flex items-center justify-center text-blue-600 text-xl">👥</div>
      </div>
    </div>
    <div class="bg-white rounded-xl shadow-md p-6">
      <div class="flex items-center justify-between">
        <div>
          <p class="text-gray-500 text-sm">分类数量</p>
          <p class="text-3xl font-bold text-gray-800 mt-1">${fn:length(categoryList)}</p>
        </div>
        <div class="w-12 h-12 bg-green-100 rounded-lg flex items-center justify-center text-green-600 text-xl">�</div>
      </div>
    </div>
    <div class="bg-white rounded-xl shadow-md p-6">
      <div class="flex items-center justify-between">
        <div>
          <p class="text-gray-500 text-sm">快捷操作</p>
        </div>
        <div class="w-12 h-12 bg-purple-100 rounded-lg flex items-center justify-center text-purple-600 text-xl">⚡</div>
      </div>
    </div>
  </div>

  <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
    <a href="${pageContext.request.contextPath}/admin?method=userList" class="bg-white rounded-xl shadow-md p-6 hover:shadow-lg transition-shadow">
      <h2 class="text-lg font-bold text-gray-800">用户管理</h2>
      <p class="text-gray-500 text-sm mt-1">查看用户列表，封禁/解封用户账号</p>
    </a>
    <a href="${pageContext.request.contextPath}/admin?method=productList" class="bg-white rounded-xl shadow-md p-6 hover:shadow-lg transition-shadow">
      <h2 class="text-lg font-bold text-gray-800">商品管理</h2>
      <p class="text-gray-500 text-sm mt-1">查看所有商品，下架违规商品</p>
    </a>
    <a href="${pageContext.request.contextPath}/admin?method=categoryList" class="bg-white rounded-xl shadow-md p-6 hover:shadow-lg transition-shadow">
      <h2 class="text-lg font-bold text-gray-800">分类管理</h2>
      <p class="text-gray-500 text-sm mt-1">添加、编辑、删除商品分类</p>
    </a>
    <a href="${pageContext.request.contextPath}/carousel?method=list" class="bg-white rounded-xl shadow-md p-6 hover:shadow-lg transition-shadow">
      <h2 class="text-lg font-bold text-gray-800">轮播图管理</h2>
      <p class="text-gray-500 text-sm mt-1">管理首页轮播图，上传图片、调整排序</p>
    </a>
  </div>
</div>

</body>
</html>