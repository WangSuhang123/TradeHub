<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="header.jsp"/>

<div class="min-h-screen bg-gray-100 py-8">
  <div class="max-w-5xl mx-auto px-4">
    <div class="flex items-center justify-between mb-6">
      <h1 class="text-2xl font-bold text-gray-800">我的购物车</h1>
      <c:if test="${not empty cartList}">
        <div class="flex gap-2">
          <button onclick="batchDeleteCart()" class="text-sm text-red-500 hover:text-red-700 border border-red-300 px-3 py-1 rounded-lg hover:bg-red-50 transition">删除选中</button>
          <button onclick="clearAllCart()" class="text-sm text-white bg-red-500 hover:bg-red-600 px-3 py-1 rounded-lg transition">清空购物车</button>
        </div>
      </c:if>
    </div>

    <c:choose>
      <c:when test="${empty cartList}">
        <div class="bg-white rounded-xl shadow-md p-12 text-center">
          <svg class="w-20 h-20 text-gray-300 mx-auto mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 100 4 2 2 0 000-4z"/>
          </svg>
          <p class="text-gray-500 text-lg mb-4">购物车还是空的</p>
          <a href="${pageContext.request.contextPath}/product?method=list" class="inline-block bg-blue-600 text-white px-6 py-2.5 rounded-lg hover:bg-blue-700 transition">
            去逛逛
          </a>
        </div>
      </c:when>
      <c:otherwise>
        <div class="bg-white rounded-xl shadow-md overflow-hidden">
          <div class="p-4 border-b border-gray-100 flex items-center gap-3">
            <input type="checkbox" id="selectAll" onchange="toggleSelectAll(this)" class="w-4 h-4 text-blue-600 rounded" checked>
            <label for="selectAll" class="text-sm text-gray-600">全选</label>
          </div>
          <div class="divide-y divide-gray-100">
            <c:forEach items="${cartList}" var="cart">
              <div class="p-4 flex items-center gap-4 cart-item">
                <input type="checkbox" name="cartIds" value="${cart.id}" onchange="updateTotal()" checked class="cart-checkbox w-4 h-4 text-blue-600 rounded">
                <a href="${pageContext.request.contextPath}/product?method=detail&id=${cart.productId}" class="flex-shrink-0">
                  <c:choose>
                    <c:when test="${not empty cart.productImage}">
                      <img src="${pageContext.request.contextPath}/${cart.productImage}" class="w-20 h-20 object-cover rounded-lg">
                    </c:when>
                    <c:otherwise>
                      <div class="w-20 h-20 bg-gray-200 rounded-lg flex items-center justify-center text-gray-400 text-xs">暂无图片</div>
                    </c:otherwise>
                  </c:choose>
                </a>
                <div class="flex-1 min-w-0">
                  <a href="${pageContext.request.contextPath}/product?method=detail&id=${cart.productId}" class="text-sm font-medium text-gray-800 hover:text-blue-600 line-clamp-2">
                    ${cart.productName}
                  </a>
                  <div class="flex items-center gap-4 mt-2">
                    <span class="text-red-500 font-bold">&yen;<fmt:formatNumber value="${cart.productPrice}" pattern="#,##0.00"/></span>
                    <div class="flex items-center border border-gray-200 rounded-lg">
                      <button onclick="changeQty(${cart.id}, -1)" class="px-2 py-1 text-gray-500 hover:text-gray-700 hover:bg-gray-50 rounded-l-lg transition">-</button>
                      <input type="text" id="qty_${cart.id}" value="${cart.quantity}" 
                             onchange="updateQty(${cart.id}, this.value)" 
                             class="w-12 text-center text-sm border-x border-gray-200 py-1 outline-none">
                      <button onclick="changeQty(${cart.id}, 1)" class="px-2 py-1 text-gray-500 hover:text-gray-700 hover:bg-gray-50 rounded-r-lg transition">+</button>
                    </div>
                  </div>
                </div>
                <div class="flex flex-col items-end gap-2">
                  <span class="text-red-500 font-bold">&yen;<fmt:formatNumber value="${cart.subtotal}" pattern="#,##0.00"/></span>
                  <button onclick="deleteCart(${cart.id})" class="text-gray-400 hover:text-red-500 transition">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"/>
                    </svg>
                  </button>
                </div>
              </div>
            </c:forEach>
          </div>
        </div>
        <div class="mt-6 bg-white rounded-xl shadow-md p-4 flex items-center justify-between">
          <div class="text-sm text-gray-600">
            已选 <span id="selectedCount" class="text-blue-600 font-bold">${cartList.size()}</span> 件
          </div>
          <div class="flex items-center gap-4">
            <span class="text-gray-600">合计：</span>
            <span id="totalPrice" class="text-2xl font-bold text-red-500">&yen;<fmt:formatNumber value="${total}" pattern="#,##0.00"/></span>
            <button onclick="checkout()" class="bg-red-500 text-white px-8 py-3 rounded-lg font-semibold hover:bg-red-600 transition">
              结算
            </button>
          </div>
        </div>
      </c:otherwise>
    </c:choose>
  </div>
</div>

<script>
function changeQty(id, delta) {
    var input = document.getElementById('qty_' + id);
    var newQty = parseInt(input.value) + delta;
    if (newQty < 1) newQty = 1;
    if (newQty > 99) newQty = 99;
    updateQty(id, newQty);
}

function updateQty(id, qty) {
    var q = parseInt(qty);
    if (isNaN(q) || q < 1) q = 1;
    if (q > 99) q = 99;
    fetch('${pageContext.request.contextPath}/cart?method=update&id=' + id + '&quantity=' + q, { method: 'POST' })
        .then(function(r) { return r.json(); })
        .then(function(data) {
            if (data.success) location.reload();
        });
}

function deleteCart(id) {
    Swal.fire({
        title: '确认移除？',
        text: '将从购物车中移除此商品',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: '确认移除',
        cancelButtonText: '取消',
        confirmButtonColor: '#EF4444'
    }).then(function(result) {
        if (result.isConfirmed) {
            fetch('${pageContext.request.contextPath}/cart?method=delete&id=' + id, { method: 'POST' })
                .then(function(r) { return r.json(); })
                .then(function(data) {
                    if (data.success) location.reload();
                });
        }
    });
}

function batchDeleteCart() {
    var checkboxes = document.querySelectorAll('.cart-checkbox:checked');
    if (checkboxes.length === 0) {
        Swal.fire({ icon: 'info', title: '请先选择商品', confirmButtonColor: '#2563EB' });
        return;
    }
    Swal.fire({
        title: '确认移除？',
        text: '将移除选中的 ' + checkboxes.length + ' 件商品',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: '确认移除',
        cancelButtonText: '取消',
        confirmButtonColor: '#EF4444'
    }).then(function(result) {
        if (result.isConfirmed) {
            var ids = Array.from(checkboxes).map(function(cb) { return cb.value; });
            var form = document.createElement('form');
            form.method = 'POST';
            form.action = '${pageContext.request.contextPath}/cart?method=batchDelete';
            ids.forEach(function(id) {
                var input = document.createElement('input');
                input.type = 'hidden';
                input.name = 'ids';
                input.value = id;
                form.appendChild(input);
            });
            document.body.appendChild(form);
            form.submit();
        }
    });
}

function clearAllCart() {
    Swal.fire({
        title: '确认清空购物车？',
        text: '将移除购物车中的全部商品',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: '确认清空',
        cancelButtonText: '取消',
        confirmButtonColor: '#DC2626'
    }).then(function(result) {
        if (result.isConfirmed) {
            fetch('${pageContext.request.contextPath}/cart?method=clearAll', { method: 'POST' })
                .then(function(r) { return r.json(); })
                .then(function(data) {
                    if (data.success) location.reload();
                    else Swal.fire({ icon: 'error', title: '操作失败', confirmButtonColor: '#2563EB' });
                });
        }
    });
}

function toggleSelectAll(checkbox) {
    document.querySelectorAll('.cart-checkbox').forEach(function(cb) { cb.checked = checkbox.checked; });
    updateTotal();
}

function updateTotal() {
    var checkboxes = document.querySelectorAll('.cart-checkbox:checked');
    var count = checkboxes.length;
    document.getElementById('selectedCount').textContent = count;
    var total = 0;
    checkboxes.forEach(function(cb) {
        var row = cb.closest('.cart-item');
        var priceText = row.querySelector('.text-red-500').textContent.replace('¥', '').replace(/,/g, '');
        total += parseFloat(priceText);
    });
    document.getElementById('totalPrice').textContent = '¥' + total.toFixed(2);
}

function checkout() {
    var checkboxes = document.querySelectorAll('.cart-checkbox:checked');
    if (checkboxes.length === 0) {
        Swal.fire({ icon: 'info', title: '请先选择商品', confirmButtonColor: '#2563EB' });
        return;
    }
    Swal.fire({
        title: '确认结算？',
        text: '将结算选中的 ' + checkboxes.length + ' 件商品',
        icon: 'question',
        showCancelButton: true,
        confirmButtonText: '确认结算',
        cancelButtonText: '取消',
        confirmButtonColor: '#2563EB'
    }).then(function(result) {
        if (result.isConfirmed) {
            var form = document.createElement('form');
            form.method = 'POST';
            form.action = '${pageContext.request.contextPath}/cart?method=checkout';
            checkboxes.forEach(function(cb) {
                var input = document.createElement('input');
                input.type = 'hidden';
                input.name = 'ids';
                input.value = cb.value;
                form.appendChild(input);
            });
            document.body.appendChild(form);
            form.submit();
        }
    });
}
</script>

<jsp:include page="footer.jsp"/>