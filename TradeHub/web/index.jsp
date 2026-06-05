<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="header.jsp"/>

<div class="bg-gradient-to-br from-orange-50 via-white to-yellow-50">
  <div class="max-w-7xl mx-auto px-4 py-12">
    <div class="text-center mb-10">
      <h1 class="text-4xl md:text-5xl font-extrabold text-gray-800 mb-3">
        <span class="text-brand">TradeHub</span> 校园二手交易
      </h1>
      <p class="text-lg text-gray-500">让闲置物品找到新主人，安全便捷的校园交易体验</p>
    </div>

    <div class="relative w-full max-w-5xl mx-auto mb-10 rounded-2xl overflow-hidden shadow-xl group/carousel">
      <c:choose>
        <c:when test="${not empty carouselList}">
          <div class="relative aspect-[21/9] md:aspect-[21/7] bg-gray-200">
            <div id="carouselTrack" class="flex h-full transition-transform duration-500 ease-in-out">
              <c:forEach items="${carouselList}" var="slide">
                <a href="${not empty slide.link ? slide.link : 'javascript:void(0)'}" class="w-full flex-shrink-0 relative" style="min-width:100%">
                  <c:choose>
                    <c:when test="${not empty slide.image}">
                      <img src="${pageContext.request.contextPath}/${slide.image}" alt="${slide.title}" class="w-full h-full object-cover">
                    </c:when>
                    <c:otherwise>
                      <div class="w-full h-full bg-gray-300 flex items-center justify-center text-gray-400">暂无图片</div>
                    </c:otherwise>
                  </c:choose>
                  <div class="absolute bottom-0 left-0 right-0 bg-gradient-to-t from-black/50 to-transparent p-4 md:p-6">
                    <span class="text-white text-sm md:text-lg font-bold drop-shadow-md">${slide.title}</span>
                  </div>
                </a>
              </c:forEach>
            </div>

            <c:if test="${carouselList.size() > 1}">
              <button id="carouselPrev" class="absolute left-3 top-1/2 -translate-y-1/2 w-10 h-10 md:w-12 md:h-12 rounded-full bg-white/80 hover:bg-white text-gray-700 hover:text-brand shadow-lg flex items-center justify-center opacity-0 group-hover/carousel:opacity-100 transition-all duration-300 hover:scale-110 backdrop-blur-sm">
                <svg class="w-5 h-5 md:w-6 md:h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M15 19l-7-7 7-7"/></svg>
              </button>
              <button id="carouselNext" class="absolute right-3 top-1/2 -translate-y-1/2 w-10 h-10 md:w-12 md:h-12 rounded-full bg-white/80 hover:bg-white text-gray-700 hover:text-brand shadow-lg flex items-center justify-center opacity-0 group-hover/carousel:opacity-100 transition-all duration-300 hover:scale-110 backdrop-blur-sm">
                <svg class="w-5 h-5 md:w-6 md:h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M9 5l7 7-7 7"/></svg>
              </button>
              <div id="carouselDots" class="absolute bottom-3 left-1/2 -translate-x-1/2 flex gap-2">
              </div>
            </c:if>
          </div>
        </c:when>
        <c:otherwise>
          <div class="aspect-[21/9] md:aspect-[21/7] bg-gradient-to-r from-orange-400 to-yellow-400 rounded-2xl flex items-center justify-center">
            <div class="text-center text-white">
              <h2 class="text-2xl md:text-4xl font-bold mb-2">TradeHub 校园二手交易</h2>
              <p class="text-sm md:text-lg opacity-90">让闲置物品找到新主人</p>
            </div>
          </div>
        </c:otherwise>
      </c:choose>
    </div>

    <div class="flex justify-center flex-wrap gap-2 mb-8">
      <a href="${pageContext.request.contextPath}/product?method=list"
         class="px-5 py-2.5 rounded-full bg-brand text-white text-sm font-semibold hover:bg-primary-dark transition shadow-md shadow-brand/20">全部</a>
      <c:forEach items="${categoryList}" var="cat">
        <a href="${pageContext.request.contextPath}/product?method=list&categoryId=${cat.id}"
           class="px-5 py-2.5 rounded-full bg-white border border-gray-200 text-gray-700 text-sm font-medium hover:border-brand hover:text-brand hover:bg-orange-50 transition">${cat.name}</a>
      </c:forEach>
    </div>

    <div class="flex flex-col lg:flex-row gap-8">
      <div class="flex-1">
        <div class="flex items-center justify-between mb-6">
          <h2 class="text-2xl font-bold text-gray-800">最新发布</h2>
          <a href="${pageContext.request.contextPath}/product?method=list" class="text-sm text-brand hover:text-primary-dark font-medium">查看更多 →</a>
        </div>
        <c:choose>
          <c:when test="${not empty latestList}">
            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-5">
              <c:forEach items="${latestList}" var="p">
                <a href="${pageContext.request.contextPath}/product?method=detail&id=${p.id}"
                   class="group bg-white rounded-xl shadow-sm hover:shadow-lg transition-all duration-300 overflow-hidden border border-gray-100 hover:border-brand/20">
                  <div class="relative overflow-hidden">
                    <c:choose>
                      <c:when test="${not empty p.image}">
                        <img src="${pageContext.request.contextPath}/${p.image}" alt="${p.name}"
                             class="w-full h-48 object-cover group-hover:scale-105 transition-transform duration-500">
                      </c:when>
                      <c:otherwise>
                        <div class="w-full h-48 bg-gray-100 flex items-center justify-center">
                          <svg class="w-12 h-12 text-gray-300" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z"/></svg>
                        </div>
                      </c:otherwise>
                    </c:choose>
                    <c:if test="${p.priceOriginal > p.price}">
                      <span class="absolute top-2 left-2 bg-red-500 text-white text-xs px-2 py-0.5 rounded-full font-medium">
                        ${Math.round((1 - p.price / p.priceOriginal) * 100)}% OFF
                      </span>
                    </c:if>
                  </div>
                  <div class="p-4">
                    <p class="text-sm font-semibold text-gray-800 group-hover:text-brand transition line-clamp-2 mb-1">${p.name}</p>
                    <div class="flex items-center gap-1 text-xs text-gray-400 mb-2">
                      <span class="bg-orange-50 text-brand px-1.5 py-0.5 rounded">${p.conditionText}</span>
                      <span>${p.categoryName}</span>
                    </div>
                    <div class="flex items-center justify-between">
                      <span class="text-lg font-bold text-red-500">&yen;${p.price}</span>
                      <span class="text-xs text-gray-400">${p.views}次浏览</span>
                    </div>
                  </div>
                </a>
              </c:forEach>
            </div>
          </c:when>
          <c:otherwise>
            <div class="text-center py-16 bg-white rounded-2xl shadow-sm">
              <p class="text-6xl mb-4">📦</p>
              <p class="text-lg text-gray-400">暂无商品，快去发布第一个吧！</p>
              <a href="${pageContext.request.contextPath}/product?method=publish"
                 class="inline-block mt-4 bg-brand text-white px-6 py-3 rounded-full font-semibold hover:bg-primary-dark transition">发布商品</a>
            </div>
          </c:otherwise>
        </c:choose>
      </div>

      <div class="lg:w-72">
        <h2 class="text-xl font-bold text-gray-800 mb-5">🔥 热门推荐</h2>
        <div class="space-y-3">
          <c:forEach items="${hotList}" var="p" varStatus="status">
            <a href="${pageContext.request.contextPath}/product?method=detail&id=${p.id}"
               class="flex items-center gap-3 p-3 bg-white rounded-lg shadow-sm hover:shadow-md transition-all border border-gray-50 hover:border-brand/20">
              <span class="text-xl font-bold ${status.count <= 3 ? 'text-brand' : 'text-gray-300'} w-8 text-center flex-shrink-0">
                ${status.count}
              </span>
              <c:choose>
                <c:when test="${not empty p.image}">
                  <img src="${pageContext.request.contextPath}/${p.image}" alt="${p.name}" class="w-14 h-14 object-cover rounded-lg flex-shrink-0">
                </c:when>
                <c:otherwise>
                  <div class="w-14 h-14 bg-gray-100 rounded-lg flex-shrink-0 flex items-center justify-center">
                    <svg class="w-6 h-6 text-gray-300" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z"/></svg>
                  </div>
                </c:otherwise>
              </c:choose>
              <div class="flex-1 min-w-0">
                <p class="text-sm font-medium text-gray-800 truncate">${p.name}</p>
                <p class="text-sm font-bold text-red-500">&yen;${p.price}</p>
              </div>
            </a>
          </c:forEach>
        </div>
      </div>
    </div>
  </div>
</div>

<script>
(function() {
  var track = document.getElementById('carouselTrack');
  if (!track) return;

  var slideCount = track.children.length;
  if (slideCount <= 1) return;

  var dotsContainer = document.getElementById('carouselDots');
  var prevBtn = document.getElementById('carouselPrev');
  var nextBtn = document.getElementById('carouselNext');
  var currentIndex = 0;
  var autoPlayInterval = 4000;
  var autoPlayTimer = null;

  for (var i = 0; i < slideCount; i++) {
    var dot = document.createElement('button');
    dot.className = 'w-2.5 h-2.5 md:w-3 md:h-3 rounded-full transition-all duration-300 ' + (i === 0 ? 'bg-white scale-125' : 'bg-white/50 hover:bg-white/80');
    dot.setAttribute('aria-label', '轮播图 ' + (i + 1));
    dot.onclick = (function(idx) {
      return function() { goToSlide(idx); };
    })(i);
    dotsContainer.appendChild(dot);
  }

  function updateTrackPosition() {
    track.style.transform = 'translateX(-' + (currentIndex * 100) + '%)';
    var dots = dotsContainer.querySelectorAll('button');
    for (var i = 0; i < dots.length; i++) {
      dots[i].className = 'w-2.5 h-2.5 md:w-3 md:h-3 rounded-full transition-all duration-300 ' + (i === currentIndex ? 'bg-white scale-125' : 'bg-white/50 hover:bg-white/80');
    }
  }

  function goToSlide(index) {
    currentIndex = (index + slideCount) % slideCount;
    updateTrackPosition();
    resetAutoPlay();
  }

  function nextSlide() { goToSlide(currentIndex + 1); }
  function prevSlide() { goToSlide(currentIndex - 1); }

  function startAutoPlay() {
    stopAutoPlay();
    autoPlayTimer = setInterval(nextSlide, autoPlayInterval);
  }

  function stopAutoPlay() {
    if (autoPlayTimer) { clearInterval(autoPlayTimer); autoPlayTimer = null; }
  }

  function resetAutoPlay() { stopAutoPlay(); startAutoPlay(); }

  prevBtn.addEventListener('click', function(e) { e.preventDefault(); prevSlide(); });
  nextBtn.addEventListener('click', function(e) { e.preventDefault(); nextSlide(); });

  var carouselContainer = track.parentElement;
  carouselContainer.addEventListener('mouseenter', stopAutoPlay);
  carouselContainer.addEventListener('mouseleave', startAutoPlay);

  var touchStartX = 0;
  carouselContainer.addEventListener('touchstart', function(e) {
    touchStartX = e.changedTouches[0].screenX;
  }, { passive: true });
  carouselContainer.addEventListener('touchend', function(e) {
    var diff = touchStartX - e.changedTouches[0].screenX;
    if (Math.abs(diff) > 50) { diff > 0 ? nextSlide() : prevSlide(); }
  });

  startAutoPlay();
})();
</script>

<jsp:include page="footer.jsp"/>