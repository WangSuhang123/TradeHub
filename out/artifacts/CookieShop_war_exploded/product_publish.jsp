<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="header.jsp"/>

<div class="min-h-screen bg-gray-100 py-8">
  <div class="max-w-2xl mx-auto px-4">
    <div class="bg-white rounded-2xl shadow-lg p-8">
      <h1 class="text-2xl font-bold text-gray-800 mb-6">发布商品</h1>

      <form action="${pageContext.request.contextPath}/product" method="post" enctype="multipart/form-data" class="space-y-5">
        <input type="hidden" name="method" value="publish">

        <div>
          <label class="block text-sm font-medium text-gray-700 mb-1">商品名称 <span class="text-red-500">*</span></label>
          <input type="text" name="name" required
                 class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                 placeholder="请输入商品名称">
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">分类 <span class="text-red-500">*</span></label>
            <select name="category_id" required
                    class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent bg-white">
              <option value="">请选择分类</option>
              <c:forEach items="${categoryList}" var="cat">
                <option value="${cat.id}">${cat.name}</option>
              </c:forEach>
            </select>
          </div>
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">成色 <span class="text-red-500">*</span></label>
            <select name="condition_level" required
                    class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent bg-white">
              <option value="1">全新</option>
              <option value="2">几乎全新</option>
              <option value="3" selected>有使用痕迹</option>
              <option value="4">老旧</option>
            </select>
          </div>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">售价 <span class="text-red-500">*</span></label>
            <div class="relative">
              <span class="absolute left-3 top-3 text-gray-500">¥</span>
              <input type="number" name="price" step="0.01" min="0" required
                     class="w-full pl-8 pr-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                     placeholder="0.00">
            </div>
          </div>
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">原价</label>
            <div class="relative">
              <span class="absolute left-3 top-3 text-gray-500">¥</span>
              <input type="number" name="price_original" step="0.01" min="0"
                     class="w-full pl-8 pr-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                     placeholder="0.00">
            </div>
          </div>
        </div>

        <div>
          <label class="block text-sm font-medium text-gray-700 mb-1">商品描述</label>
          <textarea name="description" rows="5"
                    class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                    placeholder="请描述商品的使用情况、购买时间、有无瑕疵等信息..."></textarea>
        </div>

        <div>
          <label class="block text-sm font-medium text-gray-700 mb-1">商品图片</label>
          <div class="border-2 border-dashed border-gray-300 rounded-lg p-6 text-center hover:border-blue-500 transition-colors">
            <input type="file" name="image" accept="image/*"
                   class="w-full text-sm text-gray-500 file:mr-4 file:py-2 file:px-4 file:rounded-lg file:border-0 file:text-sm file:font-semibold file:bg-blue-50 file:text-blue-700 hover:file:bg-blue-100">
            <p class="text-xs text-gray-400 mt-2">支持 JPG、PNG、GIF 格式</p>
          </div>
        </div>

        <div class="flex gap-3 pt-4">
          <button type="submit"
                  class="flex-1 bg-blue-600 text-white py-3 rounded-lg font-semibold hover:bg-blue-700 transition-colors">
            发布商品
          </button>
          <a href="${pageContext.request.contextPath}/index"
             class="px-6 py-3 border border-gray-300 rounded-lg text-gray-700 hover:bg-gray-50 transition-colors">
            取消
          </a>
        </div>
      </form>
    </div>
  </div>
</div>

<jsp:include page="footer.jsp"/>