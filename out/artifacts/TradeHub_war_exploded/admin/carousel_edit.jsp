<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="header.jsp"/>

<div class="p-8">
  <div class="max-w-2xl mx-auto">
    <div class="bg-white rounded-xl shadow-lg p-8">
      <h1 class="text-2xl font-bold text-gray-800 mb-6">${not empty carousel ? '编辑轮播图' : '添加轮播图'}</h1>

      <form action="${pageContext.request.contextPath}/carousel" method="post" enctype="multipart/form-data" class="space-y-5">
        <input type="hidden" name="method" value="${not empty carousel ? 'edit' : 'add'}">
        <c:if test="${not empty carousel}">
          <input type="hidden" name="id" value="${carousel.id}">
        </c:if>

        <div>
          <label class="block text-sm font-medium text-gray-700 mb-1">标题 <span class="text-red-500">*</span></label>
          <input type="text" name="title" value="${not empty carousel ? carousel.title : ''}" required maxlength="50"
                 class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
                 placeholder="请输入轮播图标题（最多50字）">
          <p class="text-xs text-gray-400 mt-1">建议简短有力，如"教材课本低价转让"</p>
        </div>

        <div>
          <label class="block text-sm font-medium text-gray-700 mb-1">跳转链接</label>
          <input type="text" name="link" value="${not empty carousel ? carousel.link : ''}"
                 class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
                 placeholder="例如：/product?method=list&categoryId=1">
        </div>

        <div>
          <label class="block text-sm font-medium text-gray-700 mb-1">轮播图片 <span class="text-red-500">*</span></label>
          <c:if test="${not empty carousel and not empty carousel.image}">
            <div class="mb-3">
              <p class="text-xs text-gray-500 mb-1">当前图片：</p>
              <img src="${pageContext.request.contextPath}/${carousel.image}" class="w-64 h-32 object-cover rounded-lg border">
            </div>
          </c:if>
          <div class="border-2 border-dashed border-gray-300 rounded-lg p-6 text-center hover:border-blue-500 transition-colors">
            <input type="file" name="image" accept="image/jpeg,image/png,image/gif,image/webp"
                   class="w-full text-sm text-gray-500 file:mr-4 file:py-2 file:px-4 file:rounded-lg file:border-0 file:text-sm file:font-semibold file:bg-blue-50 file:text-blue-700 hover:file:bg-blue-100"
                   ${empty carousel ? 'required' : ''}>
            <p class="text-xs text-gray-400 mt-2">支持 JPG、PNG、GIF、WebP 格式，建议尺寸 1200×400</p>
          </div>
        </div>

        <div class="grid grid-cols-2 gap-4">
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">排序权重</label>
            <input type="number" name="sort_order" value="${not empty carousel ? carousel.sortOrder : 0}" min="0"
                   class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
            <p class="text-xs text-gray-400 mt-1">数字越小越靠前</p>
          </div>
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">状态</label>
            <select name="status"
                    class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 bg-white">
              <option value="1" ${not empty carousel and carousel.status == 1 ? 'selected' : ''}>启用</option>
              <option value="0" ${empty carousel or carousel.status == 0 ? 'selected' : ''}>禁用</option>
            </select>
          </div>
        </div>

        <div class="flex gap-3 pt-4">
          <button type="submit"
                  class="flex-1 bg-blue-600 text-white py-3 rounded-lg font-semibold hover:bg-blue-700 transition-colors">
            ${not empty carousel ? '保存修改' : '添加轮播图'}
          </button>
          <a href="${pageContext.request.contextPath}/carousel?method=list"
             class="px-6 py-3 border border-gray-300 rounded-lg text-gray-700 hover:bg-gray-50 transition-colors">
            取消
          </a>
        </div>
      </form>
    </div>
  </div>
</div>

</body>
</html>
