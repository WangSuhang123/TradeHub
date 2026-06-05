<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<footer class="bg-gray-900 text-gray-300 mt-16">
  <div class="max-w-7xl mx-auto px-4 py-12">
    <div class="grid grid-cols-1 md:grid-cols-4 gap-8">
      <div class="md:col-span-2">
        <h3 class="text-xl font-bold text-white mb-4">TradeHub</h3>
        <p class="text-gray-400 text-sm leading-relaxed max-w-md">校园二手交易平台，让闲置物品找到新主人。安全、便捷、可信赖的校园交易体验。</p>
      </div>
      <div>
        <h3 class="text-sm font-semibold text-white uppercase tracking-wider mb-4">快速链接</h3>
        <ul class="space-y-2 text-sm">
          <li><a href="${pageContext.request.contextPath}/product?method=list" class="hover:text-white transition">全部商品</a></li>
          <li><a href="${pageContext.request.contextPath}/product?method=publish" class="hover:text-white transition">发布商品</a></li>
          <li><a href="${pageContext.request.contextPath}/order?method=myOrders" class="hover:text-white transition">我的订单</a></li>
        </ul>
      </div>
      <div>
        <h3 class="text-sm font-semibold text-white uppercase tracking-wider mb-4">关于</h3>
        <ul class="space-y-2 text-sm">
          <li><span class="text-gray-500">联系邮箱</span></li>
          <li><span class="text-gray-400">support@tradehub.com</span></li>
        </ul>
      </div>
    </div>
    <div class="border-t border-gray-800 mt-10 pt-6 text-center text-gray-500 text-sm">
      &copy; 2026 TradeHub. 校园二手交易平台. All Rights Reserved.
    </div>
  </div>
</footer>