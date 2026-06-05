<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="header.jsp"/>

<div class="min-h-screen bg-gray-100 py-8">
  <div class="max-w-7xl mx-auto px-4">
    <h1 class="text-3xl font-bold text-gray-800 mb-8">我的订单</h1>

    <div class="flex flex-wrap gap-2 mb-6">
      <a href="${pageContext.request.contextPath}/user?method=center"
         class="px-4 py-2 rounded-lg bg-white border border-gray-300 text-gray-700 text-sm font-medium hover:bg-gray-50">个人信息</a>
      <a href="${pageContext.request.contextPath}/user?method=myProducts"
         class="px-4 py-2 rounded-lg bg-white border border-gray-300 text-gray-700 text-sm font-medium hover:bg-gray-50">我发布的</a>
      <a href="${pageContext.request.contextPath}/user?method=myFavorites"
         class="px-4 py-2 rounded-lg bg-white border border-gray-300 text-gray-700 text-sm font-medium hover:bg-gray-50">我收藏的</a>
      <a href="${pageContext.request.contextPath}/order?method=myOrders"
         class="px-4 py-2 rounded-lg bg-blue-600 text-white text-sm font-medium">我的订单</a>
    </div>

    <div class="flex gap-0 mb-6">
      <a href="${pageContext.request.contextPath}/order?method=myOrders&tab=buyer"
         class="px-6 py-3 rounded-l-lg text-sm font-medium ${tab == 'buyer' ? 'bg-blue-600 text-white' : 'bg-white border border-gray-300 text-gray-700 hover:bg-gray-50'}">
        我买到的
      </a>
      <a href="${pageContext.request.contextPath}/order?method=myOrders&tab=seller"
         class="px-6 py-3 rounded-r-lg text-sm font-medium ${tab == 'seller' ? 'bg-blue-600 text-white' : 'bg-white border border-gray-300 text-gray-700 hover:bg-gray-50'}">
        我卖出的
      </a>
    </div>

    <c:choose>
      <c:when test="${tab == 'buyer'}">
        <c:choose>
          <c:when test="${not empty buyerOrders}">
            <div class="space-y-4">
              <c:forEach items="${buyerOrders}" var="order">
                <div class="bg-white rounded-xl shadow-md p-6">
                  <div class="flex justify-between items-start mb-4">
                    <div>
                      <span class="text-sm text-gray-500">订单编号：#${order.id}</span>
                      <span class="ml-3 px-2 py-0.5 rounded text-xs font-medium
                        <c:choose>
                          <c:when test="${order.status == 0}">bg-yellow-100 text-yellow-700</c:when>
                          <c:when test="${order.status == 1}">bg-blue-100 text-blue-700</c:when>
                          <c:when test="${order.status == 2}">bg-purple-100 text-purple-700</c:when>
                          <c:when test="${order.status == 3}">bg-green-100 text-green-700</c:when>
                          <c:otherwise>bg-gray-100 text-gray-600</c:otherwise>
                        </c:choose>">
                        ${order.statusText}
                      </span>
                    </div>
                    <span class="text-sm text-gray-500">${order.datetime}</span>
                  </div>

                  <div class="flex items-center gap-4 mb-4">
                    <c:set var="steps" value="${['待付款','已付款','已发货','已完成']}"/>
                    <c:set var="activeStep" value="${order.status < 4 ? order.status : 0}"/>
                    <c:forEach items="${steps}" var="step" varStatus="s">
                      <c:if test="${s.index > 0}">
                        <div class="flex-1 h-0.5 ${order.status == 4 ? 'bg-gray-200' : (s.index <= activeStep ? 'bg-blue-500' : 'bg-gray-200')}"></div>
                      </c:if>
                      <div class="flex flex-col items-center">
                        <div class="w-6 h-6 rounded-full flex items-center justify-center text-xs font-bold
                          ${order.status == 4 ? 'bg-gray-200 text-gray-400' : (s.index <= activeStep ? 'bg-blue-500 text-white' : 'bg-gray-200 text-gray-400')}">
                          <c:choose>
                            <c:when test="${order.status == 4}">✕</c:when>
                            <c:when test="${s.index < activeStep}">✓</c:when>
                            <c:otherwise>${s.index + 1}</c:otherwise>
                          </c:choose>
                        </div>
                        <span class="text-xs mt-1 ${order.status == 4 ? 'text-gray-400' : (s.index <= activeStep ? 'text-blue-600 font-medium' : 'text-gray-400')}">${step}</span>
                      </div>
                    </c:forEach>
                  </div>

                  <c:forEach items="${order.itemList}" var="item">
                    <div class="flex items-center gap-4 p-3 bg-gray-50 rounded-lg mb-3">
                      <span class="text-sm font-medium text-gray-800">${item.productName}</span>
                      <span class="text-sm text-gray-500">x1</span>
                      <span class="ml-auto text-lg font-bold text-red-500">&yen;${item.price}</span>
                    </div>
                  </c:forEach>

                  <div class="flex justify-between items-center text-sm text-gray-500 border-t pt-3">
                    <div>
                      <span>卖家：${order.sellerName}</span>
                      <c:if test="${not empty order.sellerPhone}">
                        <span class="ml-4">卖家电话：${order.sellerPhone}</span>
                      </c:if>
                      <c:if test="${not empty order.phone}">
                        <span class="ml-4">我的电话：${order.phone}</span>
                      </c:if>
                      <c:if test="${not empty order.address}">
                        <span class="ml-4">地点：${order.address}</span>
                      </c:if>
                    </div>
                    <span class="font-bold text-gray-800">合计：&yen;${order.total}</span>
                  </div>

                  <c:if test="${not empty order.sellerMsg}">
                    <div class="mt-2 text-sm text-gray-500 bg-blue-50 p-2 rounded">买家留言：${order.sellerMsg}</div>
                  </c:if>

                  <div class="flex gap-2 mt-4">
                    <c:if test="${order.status == 0}">
                      <a href="${pageContext.request.contextPath}/order?method=pay&orderId=${order.id}"
                         onclick="return confirmPay('${order.total}')"
                         class="flex-1 text-center py-2 bg-orange-500 text-white rounded-lg text-sm font-medium hover:bg-orange-600 transition">
                        立即付款
                      </a>
                      <a href="${pageContext.request.contextPath}/order?method=cancel&orderId=${order.id}"
                         onclick="return confirm('确定要取消该订单吗？')"
                         class="flex-1 text-center py-2 border border-red-500 text-red-600 rounded-lg text-sm font-medium hover:bg-red-50 transition">
                        取消订单
                      </a>
                    </c:if>
                    <c:if test="${order.status == 2}">
                      <a href="${pageContext.request.contextPath}/order?method=confirmReceive&orderId=${order.id}"
                         onclick="return confirm('确认已收到商品？')"
                         class="flex-1 text-center py-2 bg-green-500 text-white rounded-lg text-sm font-medium hover:bg-green-600 transition">
                        确认收货
                      </a>
                    </c:if>
                  </div>
                </div>
              </c:forEach>
            </div>
          </c:when>
          <c:otherwise>
            <div class="text-center py-16 bg-white rounded-2xl shadow-md">
              <p class="text-6xl mb-4">🛒</p>
              <p class="text-xl text-gray-500">还没有买过任何商品</p>
              <a href="${pageContext.request.contextPath}/product?method=list"
                 class="inline-block mt-4 bg-blue-600 text-white px-6 py-3 rounded-lg font-semibold hover:bg-blue-700 transition">
                去逛逛
              </a>
            </div>
          </c:otherwise>
        </c:choose>
      </c:when>

      <c:when test="${tab == 'seller'}">
        <c:choose>
          <c:when test="${not empty sellerOrders}">
            <div class="space-y-4">
              <c:forEach items="${sellerOrders}" var="order">
                <div class="bg-white rounded-xl shadow-md p-6">
                  <div class="flex justify-between items-start mb-4">
                    <div>
                      <span class="text-sm text-gray-500">订单编号：#${order.id}</span>
                      <span class="ml-3 px-2 py-0.5 rounded text-xs font-medium
                        <c:choose>
                          <c:when test="${order.status == 0}">bg-yellow-100 text-yellow-700</c:when>
                          <c:when test="${order.status == 1}">bg-blue-100 text-blue-700</c:when>
                          <c:when test="${order.status == 2}">bg-purple-100 text-purple-700</c:when>
                          <c:when test="${order.status == 3}">bg-green-100 text-green-700</c:when>
                          <c:otherwise>bg-gray-100 text-gray-600</c:otherwise>
                        </c:choose>">
                        ${order.statusText}
                      </span>
                    </div>
                    <span class="text-sm text-gray-500">${order.datetime}</span>
                  </div>

                  <div class="flex items-center gap-4 mb-4">
                    <c:set var="steps" value="${['待付款','已付款','已发货','已完成']}"/>
                    <c:set var="activeStep" value="${order.status < 4 ? order.status : 0}"/>
                    <c:forEach items="${steps}" var="step" varStatus="s">
                      <c:if test="${s.index > 0}">
                        <div class="flex-1 h-0.5 ${order.status == 4 ? 'bg-gray-200' : (s.index <= activeStep ? 'bg-blue-500' : 'bg-gray-200')}"></div>
                      </c:if>
                      <div class="flex flex-col items-center">
                        <div class="w-6 h-6 rounded-full flex items-center justify-center text-xs font-bold
                          ${order.status == 4 ? 'bg-gray-200 text-gray-400' : (s.index <= activeStep ? 'bg-blue-500 text-white' : 'bg-gray-200 text-gray-400')}">
                          <c:choose>
                            <c:when test="${order.status == 4}">✕</c:when>
                            <c:when test="${s.index < activeStep}">✓</c:when>
                            <c:otherwise>${s.index + 1}</c:otherwise>
                          </c:choose>
                        </div>
                        <span class="text-xs mt-1 ${order.status == 4 ? 'text-gray-400' : (s.index <= activeStep ? 'text-blue-600 font-medium' : 'text-gray-400')}">${step}</span>
                      </div>
                    </c:forEach>
                  </div>

                  <c:forEach items="${order.itemList}" var="item">
                    <div class="flex items-center gap-4 p-3 bg-gray-50 rounded-lg mb-3">
                      <span class="text-sm font-medium text-gray-800">${item.productName}</span>
                      <span class="text-sm text-gray-500">x1</span>
                      <span class="ml-auto text-lg font-bold text-red-500">&yen;${item.price}</span>
                    </div>
                  </c:forEach>

                  <div class="flex justify-between items-center text-sm text-gray-500 border-t pt-3">
                    <div>
                      <span>买家：${order.buyerName}</span>
                      <c:if test="${not empty order.buyerPhone}">
                        <span class="ml-4">买家电话：${order.buyerPhone}</span>
                      </c:if>
                      <c:if test="${not empty order.address}">
                        <span class="ml-4">地点：${order.address}</span>
                      </c:if>
                    </div>
                    <span class="font-bold text-gray-800">合计：&yen;${order.total}</span>
                  </div>

                  <c:if test="${not empty order.sellerMsg}">
                    <div class="mt-2 text-sm text-gray-500 bg-blue-50 p-2 rounded">买家留言：${order.sellerMsg}</div>
                  </c:if>

                  <div class="flex gap-2 mt-4">
                    <c:if test="${order.status == 0}">
                      <a href="${pageContext.request.contextPath}/order?method=cancel&orderId=${order.id}"
                         onclick="return confirm('确定要取消该订单吗？')"
                         class="flex-1 text-center py-2 border border-red-500 text-red-600 rounded-lg text-sm font-medium hover:bg-red-50 transition">
                        取消订单
                      </a>
                    </c:if>
                    <c:if test="${order.status == 1}">
                      <a href="${pageContext.request.contextPath}/order?method=ship&orderId=${order.id}"
                         onclick="return confirm('确认已发货？')"
                         class="flex-1 text-center py-2 bg-blue-500 text-white rounded-lg text-sm font-medium hover:bg-blue-600 transition">
                        确认发货
                      </a>
                    </c:if>
                  </div>
                </div>
              </c:forEach>
            </div>
          </c:when>
          <c:otherwise>
            <div class="text-center py-16 bg-white rounded-2xl shadow-md">
              <p class="text-6xl mb-4">📦</p>
              <p class="text-xl text-gray-500">还没有卖出的订单</p>
            </div>
          </c:otherwise>
        </c:choose>
      </c:when>
    </c:choose>
  </div>
</div>

<script>
function confirmPay(total) {
    return confirm('模拟支付 ¥' + total + ' ？\n\n（此为模拟支付，点击确定后将更新订单状态为"已付款"）');
}
</script>

<jsp:include page="footer.jsp"/>