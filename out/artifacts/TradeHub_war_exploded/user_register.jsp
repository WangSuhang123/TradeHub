<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="header.jsp"/>

<div class="min-h-screen bg-gradient-to-br from-blue-50 via-white to-orange-50 flex items-center justify-center py-12">
  <div class="max-w-lg w-full mx-4">
    <div class="bg-white rounded-2xl shadow-xl p-8">
      <div class="text-center mb-8">
        <div class="inline-flex items-center justify-center w-16 h-16 bg-blue-100 rounded-full mb-4">
          <svg class="w-8 h-8 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18 9v3m0 0v3m0-3h3m-3 0h-3m-2-5a4 4 0 11-8 0 4 4 0 018 0zM3 20a6 6 0 0112 0v1H3v-1z"/>
          </svg>
        </div>
        <h1 class="text-3xl font-bold text-gray-800">注册 TradeHub</h1>
        <p class="text-gray-500 mt-2">加入校园二手交易平台</p>
      </div>

      <form id="registerForm" action="${pageContext.request.contextPath}/user" method="post" class="space-y-4" novalidate>
        <input type="hidden" name="method" value="register">
        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">学号 <span class="text-red-500">*</span></label>
            <input type="text" id="student_id" name="student_id" required
                   class="w-full px-3 py-2.5 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all"
                   placeholder="请输入学号">
            <p id="studentIdError" class="text-red-500 text-xs mt-1 hidden"></p>
          </div>
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">用户名 <span class="text-red-500">*</span></label>
            <input type="text" id="username" name="username" required
                   class="w-full px-3 py-2.5 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all"
                   placeholder="2-20位字母或中文">
            <p id="usernameError" class="text-red-500 text-xs mt-1 hidden"></p>
          </div>
        </div>
        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">密码 <span class="text-red-500">*</span></label>
            <div class="relative">
              <input type="password" id="password" name="password" required
                     class="w-full px-3 py-2.5 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all"
                     placeholder="请输入密码">
              <button type="button" id="togglePwd" class="absolute right-3 top-3 text-gray-400 hover:text-gray-600">
                <svg id="eyeOff" class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.543-7a9.97 9.97 0 011.563-3.029m5.858.908a3 3 0 114.243 4.243M9.878 9.878l4.242 4.242M4.929 4.929l14.142 14.142"/></svg>
                <svg id="eyeOn" class="w-5 h-5 hidden" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"/></svg>
              </button>
            </div>
            <div id="pwdStrength" class="mt-2 hidden">
              <div class="flex gap-1 mb-1">
                <div id="strengthBar1" class="h-1.5 flex-1 rounded-full bg-gray-200 transition-all duration-300"></div>
                <div id="strengthBar2" class="h-1.5 flex-1 rounded-full bg-gray-200 transition-all duration-300"></div>
                <div id="strengthBar3" class="h-1.5 flex-1 rounded-full bg-gray-200 transition-all duration-300"></div>
              </div>
              <p id="strengthText" class="text-xs text-gray-400">请输入密码</p>
            </div>
          </div>
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">确认密码 <span class="text-red-500">*</span></label>
            <input type="password" id="confirm_password" name="confirm_password" required
                   class="w-full px-3 py-2.5 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all"
                   placeholder="请再次输入密码">
            <p id="confirmError" class="text-red-500 text-xs mt-1 hidden">两次密码不一致</p>
          </div>
        </div>
        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">姓名 <span class="text-red-500">*</span></label>
            <input type="text" id="name" name="name" required
                   class="w-full px-3 py-2.5 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all"
                   placeholder="真实姓名">
            <p id="nameError" class="text-red-500 text-xs mt-1 hidden"></p>
          </div>
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">手机号 <span class="text-red-500">*</span></label>
            <input type="text" id="phone" name="phone"
                   class="w-full px-3 py-2.5 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all"
                   placeholder="请输入手机号">
            <p id="phoneError" class="text-red-500 text-xs mt-1 hidden">请输入正确的11位手机号</p>
          </div>
        </div>
        <div>
          <label class="block text-sm font-medium text-gray-700 mb-1">学校</label>
          <input type="text" name="school"
                 class="w-full px-3 py-2.5 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all"
                 placeholder="所在学校">
        </div>
        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">邮箱</label>
            <input type="text" id="email" name="email"
                   class="w-full px-3 py-2.5 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all"
                   placeholder="请输入邮箱">
            <p id="emailError" class="text-red-500 text-xs mt-1 hidden">请输入正确的邮箱格式</p>
          </div>
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">QQ号</label>
            <input type="text" name="qq"
                   class="w-full px-3 py-2.5 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all"
                   placeholder="QQ号">
          </div>
        </div>
        <button type="submit" id="submitBtn"
                class="w-full bg-blue-600 text-white py-3 rounded-lg font-semibold hover:bg-blue-700 transition-all duration-200 transform hover:scale-[1.02] active:scale-[0.98] mt-6">
          注册
        </button>
      </form>

      <div class="text-center mt-6">
        <p class="text-gray-500 text-sm">
          已有账号？
          <a href="${pageContext.request.contextPath}/user?method=login" class="text-blue-600 hover:text-blue-800 font-medium">
            立即登录
          </a>
        </p>
      </div>
    </div>
  </div>
</div>

<script>
(function() {
    var passwordInput = document.getElementById('password');
    var confirmInput = document.getElementById('confirm_password');
    var phoneInput = document.getElementById('phone');
    var emailInput = document.getElementById('email');
    var usernameInput = document.getElementById('username');
    var studentIdInput = document.getElementById('student_id');
    var nameInput = document.getElementById('name');
    var form = document.getElementById('registerForm');
    var togglePwdBtn = document.getElementById('togglePwd');
    var pwdStrengthDiv = document.getElementById('pwdStrength');

    var PHONE_REGEX = /^1[3-9]\d{9}$/;
    var EMAIL_REGEX = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    var USERNAME_REGEX = /^[\u4e00-\u9fa5a-zA-Z][\u4e00-\u9fa5a-zA-Z0-9]{1,19}$/;

    function showError(el, msg) {
        if (el && el.nextElementSibling) {
            el.nextElementSibling.textContent = msg;
            el.nextElementSibling.classList.remove('hidden');
        }
        el.classList.add('border-red-500');
        el.classList.remove('border-green-500');
    }

    function showSuccess(el) {
        if (el && el.nextElementSibling) {
            el.nextElementSibling.classList.add('hidden');
        }
        el.classList.remove('border-red-500');
        el.classList.add('border-green-500');
    }

    function clearValidation(el) {
        if (el && el.nextElementSibling) {
            el.nextElementSibling.classList.add('hidden');
        }
        el.classList.remove('border-red-500', 'border-green-500');
    }

    function checkPasswordStrength(pwd) {
        var hasLetter = /[a-zA-Z]/.test(pwd);
        var hasDigit = /\d/.test(pwd);
        var hasSpecial = /[!@#$%^&*(),.?":{}|<>_\-+=\[\]\\;'`~]/.test(pwd);
        var len = pwd.length;

        var bar1 = document.getElementById('strengthBar1');
        var bar2 = document.getElementById('strengthBar2');
        var bar3 = document.getElementById('strengthBar3');
        var text = document.getElementById('strengthText');

        if (len === 0) {
            pwdStrengthDiv.classList.add('hidden');
            return;
        }
        pwdStrengthDiv.classList.remove('hidden');

        if (len < 6 || (!hasLetter && !hasDigit && !hasSpecial)) {
            bar1.className = 'h-1.5 flex-1 rounded-full bg-red-500 transition-all duration-300';
            bar2.className = 'h-1.5 flex-1 rounded-full bg-gray-200 transition-all duration-300';
            bar3.className = 'h-1.5 flex-1 rounded-full bg-gray-200 transition-all duration-300';
            text.textContent = '弱 - 建议使用字母+数字组合';
            text.className = 'text-xs text-red-500';
        } else if (hasLetter && hasDigit && !hasSpecial && len >= 6) {
            bar1.className = 'h-1.5 flex-1 rounded-full bg-yellow-500 transition-all duration-300';
            bar2.className = 'h-1.5 flex-1 rounded-full bg-yellow-500 transition-all duration-300';
            bar3.className = 'h-1.5 flex-1 rounded-full bg-gray-200 transition-all duration-300';
            text.textContent = '中 - 添加特殊字符可使密码更强';
            text.className = 'text-xs text-yellow-600';
        } else if (hasLetter && hasDigit && hasSpecial && len >= 8) {
            bar1.className = 'h-1.5 flex-1 rounded-full bg-green-500 transition-all duration-300';
            bar2.className = 'h-1.5 flex-1 rounded-full bg-green-500 transition-all duration-300';
            bar3.className = 'h-1.5 flex-1 rounded-full bg-green-500 transition-all duration-300';
            text.textContent = '强 - 密码强度极佳';
            text.className = 'text-xs text-green-600';
        } else {
            bar1.className = 'h-1.5 flex-1 rounded-full bg-yellow-500 transition-all duration-300';
            bar2.className = 'h-1.5 flex-1 rounded-full bg-yellow-500 transition-all duration-300';
            bar3.className = 'h-1.5 flex-1 rounded-full bg-gray-200 transition-all duration-300';
            text.textContent = '中 - 建议使用字母+数字+特殊字符组合';
            text.className = 'text-xs text-yellow-600';
        }
    }

    passwordInput.addEventListener('input', function() {
        checkPasswordStrength(this.value);
        if (confirmInput.value) {
            checkConfirmMatch();
        }
    });

    function checkConfirmMatch() {
        if (confirmInput.value === '') {
            clearValidation(confirmInput);
            return;
        }
        if (confirmInput.value === passwordInput.value) {
            showSuccess(confirmInput);
        } else {
            showError(confirmInput, '两次密码不一致');
        }
    }

    confirmInput.addEventListener('input', checkConfirmMatch);

    phoneInput.addEventListener('input', function() {
        var val = this.value.replace(/\s/g, '');
        if (val === '') { clearValidation(this); return; }
        if (PHONE_REGEX.test(val)) {
            showSuccess(this);
        } else {
            showError(this, '请输入正确的11位手机号');
        }
    });

    emailInput.addEventListener('input', function() {
        var val = this.value.trim();
        if (val === '') { clearValidation(this); return; }
        if (EMAIL_REGEX.test(val)) {
            showSuccess(this);
        } else {
            showError(this, '请输入正确的邮箱格式');
        }
    });

    usernameInput.addEventListener('input', function() {
        var val = this.value.trim();
        if (val === '') { clearValidation(this); return; }
        if (val.length < 2) {
            showError(this, '用户名至少2个字符');
        } else if (val.length > 20) {
            showError(this, '用户名不超过20个字符');
        } else if (!USERNAME_REGEX.test(val)) {
            showError(this, '用户名需以字母或中文开头');
        } else {
            showSuccess(this);
        }
    });

    studentIdInput.addEventListener('input', function() {
        var val = this.value.trim();
        if (val === '') { clearValidation(this); return; }
        if (val.length < 4) {
            showError(this, '学号格式不正确');
        } else {
            showSuccess(this);
        }
    });

    nameInput.addEventListener('input', function() {
        var val = this.value.trim();
        if (val === '') { clearValidation(this); return; }
        if (val.length < 2) {
            showError(this, '姓名至少2个字符');
        } else {
            showSuccess(this);
        }
    });

    togglePwdBtn.addEventListener('click', function() {
        var type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
        passwordInput.setAttribute('type', type);
        document.getElementById('eyeOff').classList.toggle('hidden');
        document.getElementById('eyeOn').classList.toggle('hidden');
    });

    form.addEventListener('submit', function(e) {
        var hasError = false;
        var phoneVal = phoneInput.value.replace(/\s/g, '');
        var emailVal = emailInput.value.trim();
        var usernameVal = usernameInput.value.trim();
        var studentIdVal = studentIdInput.value.trim();
        var nameVal = nameInput.value.trim();
        var pwdVal = passwordInput.value;

        if (!studentIdVal || studentIdVal.length < 4) {
            showError(studentIdInput, '请输入正确的学号');
            hasError = true;
        }

        if (!usernameVal || usernameVal.length < 2 || !USERNAME_REGEX.test(usernameVal)) {
            showError(usernameInput, '用户名需以字母或中文开头，至少2个字符');
            hasError = true;
        }

        if (!nameVal || nameVal.length < 2) {
            showError(nameInput, '请输入真实姓名');
            hasError = true;
        }

        if (!pwdVal || pwdVal.length < 6) {
            Swal.fire({ icon: 'warning', title: '密码太短', text: '密码长度至少需要6位', confirmButtonColor: '#2563EB' });
            hasError = true;
        }

        if (phoneVal && !PHONE_REGEX.test(phoneVal)) {
            showError(phoneInput, '请输入正确的11位手机号');
            hasError = true;
        }

        if (emailVal && !EMAIL_REGEX.test(emailVal)) {
            showError(emailInput, '请输入正确的邮箱格式');
            hasError = true;
        }

        if (passwordInput.value !== confirmInput.value) {
            showError(confirmInput, '两次密码不一致');
            hasError = true;
        }

        if (hasError) {
            e.preventDefault();
            return;
        }

        var btn = document.getElementById('submitBtn');
        btn.disabled = true;
        btn.innerHTML = '<span class="inline-flex items-center"><svg class="animate-spin -ml-1 mr-2 h-4 w-4 text-white" fill="none" viewBox="0 0 24 24"><circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle><path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path></svg>注册中...</span>';
    });
})();
</script>

<c:if test="${not empty failMsg}">
<script>
    Swal.fire({ icon: 'error', title: '注册失败', text: '${failMsg}', confirmButtonColor: '#2563EB' });
</script>
</c:if>
<c:if test="${not empty msg}">
<script>
    Swal.fire({ icon: 'success', title: '注册成功', text: '${msg}', confirmButtonColor: '#2563EB' }).then(function() {
        window.location.href = '${pageContext.request.contextPath}/user?method=login';
    });
</script>
</c:if>

<jsp:include page="footer.jsp"/>