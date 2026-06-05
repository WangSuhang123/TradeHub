<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="header.jsp"/>

<div class="min-h-screen bg-gray-100 py-8">
  <div class="max-w-4xl mx-auto px-4">
    <c:if test="${not empty product}">
      <div class="bg-white rounded-2xl shadow-lg overflow-hidden">
        <div class="grid grid-cols-1 md:grid-cols-2">
          <div class="p-6">
            <c:choose>
              <c:when test="${not empty product.image}">
                <img src="${pageContext.request.contextPath}/${product.image}" alt="${product.name}" class="w-full h-80 object-cover rounded-xl">
              </c:when>
              <c:otherwise>
                <div class="w-full h-80 bg-gray-200 rounded-xl flex items-center justify-center text-gray-400 text-lg">暂无图片</div>
              </c:otherwise>
            </c:choose>
          </div>
          <div class="p-6">
            <div class="flex items-center gap-2 mb-3">
              <span class="bg-blue-100 text-blue-700 px-3 py-1 rounded-full text-sm font-medium">${product.conditionText}</span>
              <span class="bg-gray-100 text-gray-600 px-3 py-1 rounded-full text-sm">${product.categoryName}</span>
            </div>
            <h1 class="text-2xl font-bold text-gray-800 mb-4">${product.name}</h1>

            <div class="flex items-baseline gap-3 mb-4">
              <span class="text-3xl font-bold text-red-500">¥${product.price}</span>
              <c:if test="${product.priceOriginal > 0}">
                <span class="text-lg text-gray-400 line-through">¥${product.priceOriginal}</span>
              </c:if>
            </div>

            <div class="flex items-center gap-4 text-sm text-gray-500 mb-4">
              <span>${product.views} 次浏览</span>
              <span>${product.createdTime}</span>
            </div>

            <div class="bg-gray-50 rounded-lg p-4 mb-4">
              <h3 class="text-sm font-semibold text-gray-700 mb-2">卖家信息</h3>
              <div class="flex items-center gap-2">
                <div class="w-10 h-10 bg-blue-100 rounded-full flex items-center justify-center text-blue-600 font-bold text-sm">
                  ${not empty product.userName ? product.userName.substring(0,1) : '?'}
                </div>
                <div>
                  <p class="text-sm font-medium text-gray-800">${not empty product.userName ? product.userName : '未知用户'}</p>
                  <p class="text-xs text-gray-500">校园二手交易平台</p>
                </div>
              </div>
            </div>

            <div class="flex gap-3">
              <c:if test="${product.status == 0}">
                <c:choose>
                  <c:when test="${not empty user && user.id == product.userId}">
                    <button onclick="Swal.fire({icon:'error',title:'无法购买自己发布的商品',text:'您不能购买或加入自己发布的商品',confirmButtonColor:'#2563EB'})"
                       class="flex-1 text-center bg-gray-300 text-gray-500 py-3 rounded-lg font-semibold cursor-not-allowed opacity-60">
                      加入购物车
                    </button>
                    <button onclick="Swal.fire({icon:'error',title:'无法购买自己发布的商品',text:'您不能购买自己发布的商品',confirmButtonColor:'#2563EB'})"
                       class="flex-1 text-center bg-gray-300 text-gray-500 py-3 rounded-lg font-semibold cursor-not-allowed opacity-60">
                      立即购买
                    </button>
                    <span class="px-4 py-3 bg-orange-50 border border-orange-200 rounded-lg text-orange-600 text-sm font-medium flex items-center gap-1">
                      <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/></svg>
                      这是您发布的商品
                    </span>
                  </c:when>
                  <c:otherwise>
                    <button onclick="addToCart(${product.id})"
                       class="flex-1 text-center bg-orange-500 text-white py-3 rounded-lg font-semibold hover:bg-orange-600 transition-colors">
                      加入购物车
                    </button>
                    <a href="javascript:handleBuy(${product.id})"
                       class="flex-1 text-center bg-blue-600 text-white py-3 rounded-lg font-semibold hover:bg-blue-700 transition-colors">
                      立即购买
                    </a>
                    <button id="favBtn" onclick="toggleFavorite()"
                            class="px-6 py-3 border border-gray-300 rounded-lg text-gray-600 hover:bg-gray-50 transition-colors">
                      ☆ 收藏
                    </button>
                  </c:otherwise>
                </c:choose>
              </c:if>
              <c:if test="${product.status != 0}">
                <span class="inline-block bg-red-100 text-red-700 px-4 py-2 rounded-lg text-sm font-medium">${product.statusText}</span>
              </c:if>
            </div>
          </div>
        </div>

        <div class="border-t border-gray-200 p-6">
          <h2 class="text-lg font-bold text-gray-800 mb-3">商品描述</h2>
          <p class="text-gray-600 leading-relaxed whitespace-pre-wrap">${product.description}</p>
        </div>
      </div>
    </c:if>
  </div>
</div>

<script>
var isLoggedIn = "${not empty user}" === "true";
var isOwner = "${user.id}" === "${product.userId}";
let isFav = false;

function requireLogin(msg) {
    if (isLoggedIn) return true;
    Swal.fire({
        icon: 'warning',
        title: '请登录后操作',
        text: msg || '您需要先登录才能执行此操作',
        confirmButtonText: '去登录',
        confirmButtonColor: '#2563EB',
        showCancelButton: true,
        cancelButtonText: '取消',
        cancelButtonColor: '#6B7280'
    }).then(function(result) {
        if (result.isConfirmed) {
            window.location.href = '${pageContext.request.contextPath}/user?method=login';
        }
    });
    return false;
}

function handleBuy(productId) {
    if (!requireLogin('请登录后下单购买')) return;
    if (isOwner) {
        Swal.fire({ icon: 'error', title: '不能购买自己的商品', text: '您不能购买自己发布的商品', confirmButtonColor: '#2563EB' });
        return;
    }
    window.location.href = '${pageContext.request.contextPath}/order?method=submit&productId=' + productId;
}

function addToCart(productId) {
    if (!requireLogin('请登录后将商品加入购物车')) return;
    if (isOwner) {
        Swal.fire({ icon: 'error', title: '不能添加自己的商品', text: '您不能将自己的商品加入购物车', confirmButtonColor: '#2563EB' });
        return;
    }
    fetch('${pageContext.request.contextPath}/cart?method=add&productId=' + productId, {method:'POST'})
        .then(function(r) { return r.json(); })
        .then(function(data) {
            if (data.success) {
                Swal.fire({ icon: 'success', title: '已加入购物车', showConfirmButton: false, timer: 1500 });
                var badge = document.getElementById('cartBadge');
                if (badge) {
                    var count = parseInt(badge.textContent) || 0;
                    badge.textContent = count + 1;
                    badge.classList.remove('hidden');
                }
            } else {
                if (data.message && data.message.indexOf('登录') !== -1) {
                    requireLogin(data.message);
                } else {
                    Swal.fire({ icon: 'warning', title: data.message, confirmButtonColor: '#2563EB' });
                }
            }
        });
}

function toggleFavorite() {
    if (!requireLogin('请登录后收藏商品')) return;
    var method = isFav ? 'remove' : 'add';
    fetch('${pageContext.request.contextPath}/favorite?method=' + method + '&productId=${product.id}', {method:'POST'})
        .then(function(r) { return r.text(); })
        .then(function(data) {
            if(data.includes('ok')) {
                isFav = !isFav;
                document.getElementById('favBtn').innerHTML = isFav ? '★ 已收藏' : '☆ 收藏';
                document.getElementById('favBtn').className = isFav
                    ? 'px-6 py-3 border border-yellow-400 rounded-lg text-yellow-600 bg-yellow-50 hover:bg-yellow-100 transition-colors'
                    : 'px-6 py-3 border border-gray-300 rounded-lg text-gray-600 hover:bg-gray-50 transition-colors';
            }
        });
}
</script>

<jsp:include page="footer.jsp"/>