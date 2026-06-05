<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="header.jsp"/>

<div class="min-h-screen bg-gradient-to-br from-blue-50 via-white to-orange-50 flex items-center justify-center py-12">
  <div class="max-w-md w-full mx-4">
    <div class="bg-white rounded-2xl shadow-xl p-8">
      <div class="text-center mb-8">
        <div class="inline-flex items-center justify-center w-16 h-16 bg-blue-100 rounded-full mb-4">
          <svg class="w-8 h-8 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
          </svg>
        </div>
        <h1 class="text-3xl font-bold text-gray-800">登录 TradeHub</h1>
        <p class="text-gray-500 mt-2">校园二手交易平台</p>
      </div>

      <form id="loginForm" action="${pageContext.request.contextPath}/user" method="post" class="space-y-5">
        <input type="hidden" name="method" value="login">
        <div>
          <label class="block text-sm font-medium text-gray-700 mb-1">学号</label>
          <input type="text" id="studentId" name="student_id" required
                 value="${param.student_id}"
                 class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all"
                 placeholder="请输入学号">
        </div>
        <div>
          <label class="block text-sm font-medium text-gray-700 mb-1">密码</label>
          <div class="relative">
            <input type="password" id="password" name="password" required
                   class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all"
                   placeholder="请输入密码">
            <button type="button" id="togglePwd" class="absolute right-3 top-3 text-gray-400 hover:text-gray-600">
              <svg id="eyeOff" class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.543-7a9.97 9.97 0 011.563-3.029m5.858.908a3 3 0 114.243 4.243M9.878 9.878l4.242 4.242M4.929 4.929l14.142 14.142"/></svg>
              <svg id="eyeOn" class="w-5 h-5 hidden" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"/></svg>
            </button>
          </div>
        </div>
        <button type="submit" id="submitBtn"
                class="w-full bg-blue-600 text-white py-3 rounded-lg font-semibold hover:bg-blue-700 transition-all duration-200 transform hover:scale-[1.02] active:scale-[0.98]">
          登录
        </button>
      </form>

      <div class="text-center mt-6">
        <p class="text-gray-500 text-sm">
          还没有账号？
          <a href="${pageContext.request.contextPath}/user?method=register" class="text-blue-600 hover:text-blue-800 font-medium">
            立即注册
          </a>
        </p>
      </div>
    </div>
  </div>
</div>

<script>
(function() {
    var togglePwd = document.getElementById('togglePwd');
    var passwordInput = document.getElementById('password');
    var form = document.getElementById('loginForm');
    var studentIdInput = document.getElementById('studentId');
    var submitBtn = document.getElementById('submitBtn');

    togglePwd.addEventListener('click', function() {
        var type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
        passwordInput.setAttribute('type', type);
        document.getElementById('eyeOff').classList.toggle('hidden');
        document.getElementById('eyeOn').classList.toggle('hidden');
    });

    form.addEventListener('submit', function() {
        submitBtn.disabled = true;
        submitBtn.innerHTML = '<span class="inline-flex items-center"><svg class="animate-spin -ml-1 mr-2 h-4 w-4 text-white" fill="none" viewBox="0 0 24 24"><circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle><path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path></svg>登录中...</span>';
    });
})();
</script>

<c:if test="${not empty failMsg}">
<script>
var studentIdVal = '${param.student_id}';
document.getElementById('password').value = '';
Swal.fire({
    icon: 'error',
    title: '登录失败',
    text: '${failMsg}',
    confirmButtonColor: '#2563EB'
}).then(function() {
    document.getElementById('password').focus();
});
</script>
</c:if>

<c:if test="${not empty msg}">
<script>
Swal.fire({
    icon: 'success',
    title: '${msg}',
    confirmButtonColor: '#2563EB'
});
</script>
</c:if>

<jsp:include page="footer.jsp"/>