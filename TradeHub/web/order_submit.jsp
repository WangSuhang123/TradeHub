<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="header.jsp"/>

<div class="min-h-screen bg-gray-100 py-8">
  <div class="max-w-2xl mx-auto px-4">
    <h1 class="text-3xl font-bold text-gray-800 mb-8">确认订单信息</h1>

    <div class="bg-white rounded-2xl shadow-lg p-6 mb-6">
      <h2 class="text-lg font-bold text-gray-800 mb-4">商品信息</h2>

      <c:choose>
        <c:when test="${not empty product}">
          <div class="flex items-center gap-4 p-4 bg-gray-50 rounded-lg">
            <c:choose>
              <c:when test="${not empty product.image}">
                <img src="${pageContext.request.contextPath}/${product.image}" alt="${product.name}" class="w-20 h-20 object-cover rounded-lg">
              </c:when>
              <c:otherwise>
                <div class="w-20 h-20 bg-gray-200 rounded-lg flex items-center justify-center text-gray-400 text-xs">暂无图片</div>
              </c:otherwise>
            </c:choose>
            <div class="flex-1">
              <h3 class="font-semibold text-gray-800">${product.name}</h3>
              <p class="text-sm text-gray-500">${product.conditionText} | ${product.categoryName}</p>
              <p class="text-xl font-bold text-red-500 mt-1">¥${product.price}</p>
            </div>
          </div>
        </c:when>
        <c:when test="${not empty cartList}">
          <div class="space-y-3">
            <c:forEach items="${cartList}" var="cart">
              <c:set var="isSelected" value="false"/>
              <c:forEach items="${selectedIds}" var="sid">
                <c:if test="${sid == cart.id}"><c:set var="isSelected" value="true"/></c:if>
              </c:forEach>
              <c:if test="${isSelected}">
                <div class="flex items-center gap-4 p-3 bg-gray-50 rounded-lg">
                  <c:choose>
                    <c:when test="${not empty cart.productImage}">
                      <img src="${pageContext.request.contextPath}/${cart.productImage}" class="w-16 h-16 object-cover rounded-lg flex-shrink-0">
                    </c:when>
                    <c:otherwise>
                      <div class="w-16 h-16 bg-gray-200 rounded-lg flex-shrink-0 flex items-center justify-center text-gray-400 text-xs">无图</div>
                    </c:otherwise>
                  </c:choose>
                  <div class="flex-1 min-w-0">
                    <p class="text-sm font-medium text-gray-800 truncate">${cart.productName}</p>
                    <p class="text-xs text-gray-500">x${cart.quantity}</p>
                  </div>
                  <span class="text-sm font-bold text-red-500">&yen;<fmt:formatNumber value="${cart.subtotal}" pattern="#,##0.00"/></span>
                </div>
              </c:if>
            </c:forEach>
          </div>
          <div class="mt-4 text-right">
            <span class="text-gray-600">合计：</span>
            <span class="text-2xl font-bold text-red-500">&yen;<fmt:formatNumber value="${total}" pattern="#,##0.00"/></span>
          </div>
        </c:when>
      </c:choose>
    </div>

    <c:if test="${not empty failMsg}">
      <div class="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-lg mb-4 text-sm">${failMsg}</div>
    </c:if>

    <div class="bg-white rounded-2xl shadow-lg p-6">
      <h2 class="text-lg font-bold text-gray-800 mb-4">您的联系方式</h2>
      <c:choose>
        <c:when test="${not empty product}">
          <form action="${pageContext.request.contextPath}/order" method="post" class="space-y-4">
            <input type="hidden" name="method" value="confirm">
            <input type="hidden" name="productId" value="${product.id}">
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-1">联系人 <span class="text-red-500">*</span></label>
              <input type="text" name="name" value="${user.name}" required
                     class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
            </div>
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-1">联系电话 <span class="text-red-500">*</span></label>
              <input type="text" name="phone" value="${user.phone}" required
                     class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
            </div>
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-1">交易地点 <span class="text-red-500">*</span></label>
              <input type="text" name="address" required
                     class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
                     placeholder="例如：图书馆门口、3号教学楼一楼">
            </div>
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-1">给卖家留言</label>
              <textarea name="seller_msg" rows="3"
                        class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
                        placeholder="选填，如：请尽快联系我"></textarea>
            </div>
            <div class="flex gap-3 pt-4">
              <button type="submit"
                      class="flex-1 bg-blue-600 text-white py-3 rounded-lg font-semibold hover:bg-blue-700 transition-colors">
                确认下单
              </button>
              <a href="${pageContext.request.contextPath}/product?method=detail&id=${product.id}"
                 class="px-6 py-3 border border-gray-300 rounded-lg text-gray-700 hover:bg-gray-50 transition-colors">
                取消
              </a>
            </div>
          </form>
        </c:when>
        <c:when test="${not empty cartList}">
          <form action="${pageContext.request.contextPath}/order" method="post" class="space-y-4">
            <input type="hidden" name="method" value="confirmCart">
            <input type="hidden" name="productIds" value="${productIds}">
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-1">联系人 <span class="text-red-500">*</span></label>
              <input type="text" name="name" value="${user.name}" required
                     class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
            </div>
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-1">联系电话 <span class="text-red-500">*</span></label>
              <input type="text" name="phone" value="${user.phone}" required
                     class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
            </div>
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-1">交易地点 <span class="text-red-500">*</span></label>
              <input type="text" name="address" required
                     class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
                     placeholder="例如：图书馆门口、3号教学楼一楼">
            </div>
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-1">给卖家留言</label>
              <textarea name="seller_msg" rows="3"
                        class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
                        placeholder="选填，如：请尽快联系我"></textarea>
            </div>
            <div class="flex gap-3 pt-4">
              <button type="submit"
                      class="flex-1 bg-blue-600 text-white py-3 rounded-lg font-semibold hover:bg-blue-700 transition-colors">
                确认下单（共${fn:length(selectedIds)}件）
              </button>
              <a href="${pageContext.request.contextPath}/cart?method=list"
                 class="px-6 py-3 border border-gray-300 rounded-lg text-gray-700 hover:bg-gray-50 transition-colors">
                取消
              </a>
            </div>
          </form>
        </c:when>
      </c:choose>
    </div>
  </div>
</div>

<jsp:include page="footer.jsp"/>