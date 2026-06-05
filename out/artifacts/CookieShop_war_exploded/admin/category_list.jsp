<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="header.jsp"/>

<div class="p-8">
  <div class="flex justify-between items-center mb-8">
    <h1 class="text-3xl font-bold text-gray-800">分类管理</h1>
    <button onclick="document.getElementById('addForm').classList.toggle('hidden')"
            class="bg-blue-600 text-white px-4 py-2 rounded-lg text-sm font-semibold hover:bg-blue-700 transition-colors">
      添加分类
    </button>
  </div>

  <div id="addForm" class="hidden bg-white rounded-xl shadow-md p-6 mb-6">
    <h2 class="text-lg font-bold text-gray-800 mb-4">添加新分类</h2>
    <form action="${pageContext.request.contextPath}/admin" method="post" class="space-y-4">
      <input type="hidden" name="method" value="categoryAdd">
      <div>
        <label class="block text-sm font-medium text-gray-700 mb-1">分类名称</label>
        <input type="text" name="name" required
               class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
      </div>
      <div>
        <label class="block text-sm font-medium text-gray-700 mb-1">分类描述</label>
        <input type="text" name="description"
               class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
      </div>
      <button type="submit"
              class="bg-blue-600 text-white px-4 py-2 rounded-lg text-sm font-semibold hover:bg-blue-700 transition-colors">
        确认添加
      </button>
    </form>
  </div>

  <div class="bg-white rounded-xl shadow-md overflow-hidden">
    <table class="w-full text-sm">
      <thead class="bg-gray-50">
        <tr>
          <th class="px-6 py-3 text-left text-gray-600 font-medium">ID</th>
          <th class="px-6 py-3 text-left text-gray-600 font-medium">分类名称</th>
          <th class="px-6 py-3 text-left text-gray-600 font-medium">描述</th>
          <th class="px-6 py-3 text-left text-gray-600 font-medium">操作</th>
        </tr>
      </thead>
      <tbody class="divide-y divide-gray-100">
        <c:forEach items="${categoryList}" var="cat">
          <tr class="hover:bg-gray-50">
            <td class="px-6 py-4">${cat.id}</td>
            <td class="px-6 py-4 font-medium">${cat.name}</td>
            <td class="px-6 py-4 text-gray-500">${cat.description}</td>
            <td class="px-6 py-4 space-x-2">
              <button onclick="editCategory(${cat.id}, '${cat.name}', '${cat.description}')"
                      class="text-blue-600 hover:text-blue-800 text-sm">编辑</button>
              <a href="${pageContext.request.contextPath}/admin?method=categoryDelete&id=${cat.id}"
                 onclick="return confirm('确定要删除该分类吗？')"
                 class="text-red-600 hover:text-red-800 text-sm">删除</a>
            </td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
  </div>

  <div id="editForm" class="hidden fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
    <div class="bg-white rounded-xl shadow-lg p-6 w-full max-w-md mx-4">
      <h2 class="text-lg font-bold text-gray-800 mb-4">编辑分类</h2>
      <form action="${pageContext.request.contextPath}/admin" method="post" class="space-y-4">
        <input type="hidden" name="method" value="categoryEdit">
        <input type="hidden" name="id" id="editId">
        <div>
          <label class="block text-sm font-medium text-gray-700 mb-1">分类名称</label>
          <input type="text" name="name" id="editName" required
                 class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
        </div>
        <div>
          <label class="block text-sm font-medium text-gray-700 mb-1">分类描述</label>
          <input type="text" name="description" id="editDesc"
                 class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
        </div>
        <div class="flex gap-2">
          <button type="submit"
                  class="flex-1 bg-blue-600 text-white px-4 py-2 rounded-lg text-sm font-semibold hover:bg-blue-700 transition-colors">
            保存
          </button>
          <button type="button" onclick="document.getElementById('editForm').classList.add('hidden')"
                  class="flex-1 border border-gray-300 text-gray-700 px-4 py-2 rounded-lg text-sm font-semibold hover:bg-gray-50 transition-colors">
            取消
          </button>
        </div>
      </form>
    </div>
  </div>
</div>

<script>
function editCategory(id, name, desc) {
    document.getElementById('editId').value = id;
    document.getElementById('editName').value = name;
    document.getElementById('editDesc').value = desc || '';
    document.getElementById('editForm').classList.remove('hidden');
}
</script>

</body>
</html>