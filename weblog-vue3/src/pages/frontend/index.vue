<template>
  <!-- ===== 随机背景头图横幅 ===== -->
  <div class="header-banner" :style="{ '--banner-image': 'url(' + bannerImage + ')' }">

    <div class="relative z-10 flex flex-col items-center justify-center h-full text-center px-4">
      <div class="header-wrapper">
        <Header></Header>
      </div>


      <!-- 固定标题 -->
      <h1 class="text-4xl md:text-5xl font-bold text-white drop-shadow-lg">
        welcome to my blog
      </h1>
      <!-- 动态副标题 -->
      <p class="text-lg md:text-xl text-gray-200 mt-2 drop-shadow-md transition-opacity duration-500"
         :class="{ 'opacity-0': isSwitching, 'opacity-100': !isSwitching }">
        {{ currentSlogan }}
      </p>
    </div>
  </div>
  <div class="container mx-auto max-w-screen-xl mt-5">
    <div class="grid grid-cols-4">
      <!-- 左边栏 -->
      <div class="col-span-4 px-3 md:col-span-3 sm:col-span-4">
        <!-- 文章列表 -->
        <div class="grid grid-cols-1 sm:grid-cols-1 md:grid-cols-2 gap-4">

          <div v-for="(article, index) in articles" :key="index"
               class="bg-white border border-gray-200 rounded-lg dark:bg-gray-800 dark:border-gray-700">
            <a @click="goArticleDetail(article.id)" class="cursor-pointer">
              <img class="rounded-t-lg h-50 w-full" :src="article.titleImage" />
            </a>
            <div class="p-5">
              <div
                  v-for="(item, index) in article.tags"
                  :key="index"
                  @click="goTagArticleListPage(item.id, item.name)"
                  class="mb-3 inline-block bg-green-100 text-green-800 text-xs font-medium mr-2 px-2.5 py-0.5 rounded hover:bg-green-200 hover:text-green-900 dark:hover:bg-green-800 dark:hover:text-green-300 dark:bg-green-900 dark:text-green-300">
                {{ item.name }}
              </div>

              <a @click="goArticleDetail(article.id)" class="cursor-pointer">
                <h2 class="mb-2 text-2xl font-bold tracking-tight text-gray-900 dark:text-white">{{ article.title }}</h2>
              </a>
              <p class="mb-3 font-normal text-gray-500 dark:text-gray-400">{{ article.description }}</p>

              <div class="text-gray-400 text-sm flex items-center article-mata">
                <svg class="inline w-3 h-3 mr-2 text-gray-400 dark:white" aria-hidden="true"
                     xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 20 20">
                  <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                        d="M5 1v3m5-3v3m5-3v3M1 7h18M5 11h10M2 3h16a1 1 0 0 1 1 1v14a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1V4a1 1 0 0 1 1-1Z" />
                </svg>
                {{ article.createTime }}

                <svg class="inline w-3 h-3 ml-5 mr-2 text-gray-400 dark:white" aria-hidden="true"
                     xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 18 18">
                  <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                        d="M1 5v11a1 1 0 0 0 1 1h14a1 1 0 0 0 1-1V6a1 1 0 0 0-1-1H1Zm0 0V2a1 1 0 0 1 1-1h5.443a1 1 0 0 1 .8.4l2.7 3.6H1Z" />
                </svg>
                <a @click="goCatagoryArticleListPage(article.category?.id, article.category?.name)"
                   class="text-gray-400 hover:underline">{{ article.category?.name }}</a>

                <!-- 右侧 点赞 + 评论 -->
                <div style="margin-left: auto; display: flex; gap: 16px; align-items: center; font-size: 13px;">
                  <span class="flex items-center gap-1">
                    <span style="font-size: 16px; color: #ef4444; opacity: 0.95;">❤️</span>
                    {{ article.likeCount || 0 }}
                  </span>
                  <span class="flex items-center gap-1">
                    <el-icon size="16"><ChatDotRound /></el-icon>
                    {{ article.commentCount || 0 }}
                  </span>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- 分页 -->
        <nav aria-label="Page navigation example" v-if="total > 0">
          <ul class="flex items-center justify-center mt-10 mb-10 -space-x-px h-10 text-base">
            <li>
              <a v-if="current > 1" @click="getArticles(current - 1)"
                 class="flex items-center justify-center px-4 h-10 ml-0 leading-tight text-gray-500 bg-white border border-gray-300 rounded-l-lg hover:bg-gray-100 hover:text-gray-700 dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white">
                <span class="sr-only">Previous</span>
                <svg class="w-3 h-3" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none"
                     viewBox="0 0 6 10">
                  <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"
                        stroke-width="2" d="M5 1 1 5l4 4" />
                </svg>
              </a>
              <a v-else @click="getArticles(current)"
                 class="cursor-not-allowed flex items-center justify-center px-4 h-10 ml-0 leading-tight text-gray-500 bg-white border border-gray-300 rounded-l-lg hover:bg-gray-100 hover:text-gray-700 dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white">
                <span class="sr-only">Previous</span>
                <svg class="w-3 h-3" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none"
                     viewBox="0 0 6 10">
                  <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"
                        stroke-width="2" d="M5 1 1 5l4 4" />
                </svg>
              </a>
            </li>
            <li v-for="page in pages" :key="page">
              <a @click="getArticles(page)"
                 class="flex items-center border-gray-300 justify-center px-4 h-10 leading-tight bg-white border dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white"
                 :class="[page == current ? 'text-blue-600 bg-blue-50 hover:bg-blue-100 hover:text-blue-700' : 'text-gray-500  hover:bg-gray-100 hover:text-gray-700']">
                {{ page }}
              </a>
            </li>
            <li>
              <a v-if="current < pages" @click="getArticles(current + 1)"
                 class="flex items-center justify-center px-4 h-10 leading-tight text-gray-500 bg-white border border-gray-300 rounded-r-lg hover:bg-gray-100 hover:text-gray-700 dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white">
                <span class="sr-only">Next</span>
                <svg class="w-3 h-3" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none"
                     viewBox="0 0 6 10">
                  <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"
                        stroke-width="2" d="m1 9 4-4-4-4" />
                </svg>
              </a>
              <a v-else @click="getArticles(current)"
                 class="cursor-not-allowed flex items-center justify-center px-4 h-10 leading-tight text-gray-500 bg-white border border-gray-300 rounded-r-lg hover:bg-gray-100 hover:text-gray-700 dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white">
                <span class="sr-only">Next</span>
                <svg class="w-3 h-3" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none"
                     viewBox="0 0 6 10">
                  <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"
                        stroke-width="2" d="m1 9 4-4-4-4" />
                </svg>
              </a>
            </li>
          </ul>
        </nav>
      </div>

      <!-- 右边栏 -->
      <div class="col-span-4 px-3 md:col-span-1 sm:col-span-4">
        <div class="sticky top-21">
          <UserInfoCard></UserInfoCard>

          <!-- 文章分类 -->
          <div
              class="mb-3 w-full font-medium p-5 bg-white border border-gray-200 rounded-lg dark:bg-gray-800 dark:border-gray-700">
            <h2 class="mb-2 font-bold text-gray-900 uppercase dark:text-white">分类</h2>
            <div
                class="text-sm font-medium text-gray-900 bg-white rounded-lg dark:bg-gray-700 dark:border-gray-600 dark:text-white">
              <a @click="goCatagoryArticleListPage(item.id, item.name)" v-for="(item, index) in categories"
                 :key="index"
                 class="flex items-end block w-full px-4 py-2 rounded-lg cursor-pointer hover:bg-gray-100 hover:text-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-700 focus:text-blue-700 dark:border-gray-600 dark:hover:bg-gray-600 dark:hover:text-white dark:focus:ring-gray-500 dark:focus:text-white">
                <svg class="w-4 h-4 mr-2 mb-2px text-gray-800 inline dark:white" aria-hidden="true"
                     xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 21 18">
                  <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"
                        stroke-width="0.9"
                        d="M2.539 17h12.476l4-9H5m-2.461 9a1 1 0 0 1-.914-1.406L5 8m-2.461 9H2a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h5.443a1 1 0 0 1 .8.4l2.7 3.6H16a1 1 0 0 1 1 1v2H5" />
                </svg>
                {{ item.name }}
              </a>
            </div>
          </div>

          <!-- 文章标签 -->
          <div
              class="mb-3 w-full font-medium p-5 bg-white border border-gray-200 rounded-lg dark:bg-gray-800 dark:border-gray-700">
            <h2 class="mb-2 font-bold text-gray-900 uppercase dark:text-white">标签</h2>
            <div @click="goTagArticleListPage(item.id, item.name)" v-for="(item, index) in tags" :key="index"
                 class="inline-block bg-green-100 text-green-800 text-xs font-medium mr-2 mb-1 px-2.5 py-0.5 rounded hover:bg-green-200 hover:text-green-900 dark:hover:bg-green-800 dark:hover:text-green-300 dark:bg-green-900 dark:text-green-300">
              {{ item.name }}
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import Header from '@/layouts/components/Header.vue'
import Footer from '@/layouts/components/Footer.vue'
import UserInfoCard from '@/components/UserInfoCard.vue'
import { useRouter } from 'vue-router'
import { ref, onMounted, onBeforeUnmount } from 'vue'
import { getIndexArticles } from '@/api/frontend/index'
import { getCategories } from '@/api/frontend/category'
import { getTags } from '@/api/frontend/tag'

// 导入接口
import { getArticleLikeCount } from '@/api/admin/articleLike'
import { getCommentPageList } from '@/api/admin/comment'

const router = useRouter()

const goArticleDetail = (articleId) => {
  router.push({ path: '/article/detail', query: { articleId: articleId } })
}

// ============ 动态文案库 ============
const sloganList = [
  '这个世界很大，告别的方式有多少种，人生的正确答案就有多少个。',
  '这世界太大，勇敢的少年奔赴天涯',
  '风月折断杨柳枝，琴瑟朝露挥掷成诗',
  '愿做一束光，照亮前行的路',
  '用文字记录时光，以热爱对抗岁月',
  '山川湖海，人间烟火，皆可入文',
  '在喧嚣世界里，安静地写点东西',
  '每一段文字，都是与自己的对话',
  '保持热爱，奔赴山海',
  '且将新火试新茶，诗酒趁年华',
  '追风赶月莫停留，平芜尽处是春山',
  '心有山海，静而无边',
  '半山听雨，一室茶香',
  '掬水月在手，弄花香满衣',
  '行到水穷处，坐看云起时',
]

// ============ 随机头图 ============
const bannerImage = ref('https://api.boxmoe.com/random.php?size=mw1024')
let refreshTimer = null

// 刷新头图
const refreshBanner = () => {
  bannerImage.value = `https://api.boxmoe.com/random.php?size=mw1024&t=${Date.now()}`
}

// ============ 动态副标题 ============
const currentSlogan = ref(sloganList[0])
const isSwitching = ref(false)
let sloganTimer = null

// 切换副标题（随机获取一条）
const switchSlogan = () => {
  // 先淡出
  isSwitching.value = true

  setTimeout(() => {
    // 随机获取一条（确保与当前不同）
    let newSlogan
    do {
      const randomIndex = Math.floor(Math.random() * sloganList.length)
      newSlogan = sloganList[randomIndex]
    } while (newSlogan === currentSlogan.value && sloganList.length > 1)

    currentSlogan.value = newSlogan
    // 淡入
    isSwitching.value = false
  }, 400) // 等待淡出动画完成
}

// ============ 生命周期 ============
onMounted(() => {
  // 头图自动刷新（每 30 秒）
  refreshTimer = setInterval(refreshBanner, 30000)

  // 副标题自动切换（每 8 秒）
  sloganTimer = setInterval(switchSlogan, 8000)
})

onBeforeUnmount(() => {
  if (refreshTimer) {
    clearInterval(refreshTimer)
    refreshTimer = null
  }
  if (sloganTimer) {
    clearInterval(sloganTimer)
    sloganTimer = null
  }
})

// 暴露方法
defineExpose({
  refreshBanner,
  switchSlogan
})

// ============ 文章相关 ============
const articles = ref([])
const current = ref(1)
const total = ref(0)
const size = ref(4)
const pages = ref(0)

// 批量加载点赞数 + 评论数
async function loadLikeAndCommentCount(articleList) {
  if (!articleList || articleList.length === 0) return

  for (let article of articleList) {
    try {
      const likeRes = await getArticleLikeCount({ articleId: article.id })
      console.log("点赞返回:", likeRes)
      article.likeCount = likeRes.data || 0

      const commentRes = await getCommentPageList({
        articleId: article.id,
        current: 1,
        size: 1
      })
      console.log("评论返回:", commentRes)
      article.commentCount = commentRes.data.total || 0
    } catch (err) {
      console.log("加载数量失败", err)
      article.likeCount = 0
      article.commentCount = 0
    }
  }
}

// 获取分页数据
async function getArticles(currentNo) {
  try {
    const res = await getIndexArticles({ current: currentNo, size: size.value })
    if (res.success == true) {
      articles.value = res.data
      current.value = res.current
      total.value = res.total
      size.value = res.size
      pages.value = res.pages

      await loadLikeAndCommentCount(articles.value)
    }
  } catch (e) {
    console.error("获取文章失败", e)
  }
}

// 初始化
getArticles(current.value)

// 分类
const categories = ref([])
getCategories().then((e) => {
  categories.value = e.data
})

// 标签
const tags = ref([])
getTags().then((e) => {
  tags.value = e.data
})

const goCatagoryArticleListPage = (id, name) => {
  router.push({ path: '/category/list', query: { id: id, name: name } })
}

const goTagArticleListPage = (id, name) => {
  router.push({ path: '/tag/list', query: { id: id, name: name } })
}
</script>

<style>
.container {
  max-width: 1230px;
}

.article-img {
  height: 100%;
}

.two-line-clamp {
  display: -webkit-box;
  -webkit-box-orient: vertical;
  -webkit-line-clamp: 2;
  overflow: hidden;
}

.el-menu--horizontal .el-menu-item:not(.is-disabled):focus,
.el-menu--horizontal .el-menu-item:not(.is-disabled):hover {
  outline: 0;
  color: var(--el-menu-text-color);
  background-color: #fff;
  border-bottom: 2px solid #409eff;
}

.category-item:hover {
  text-decoration: underline;
  cursor: pointer;
}

.tag-item:hover {
  cursor: pointer;
}

.el-tag:hover {
  background-color: var(--el-color-info-light-8);
}

.cursor-pointer {
  cursor: pointer;
}

/* ========== 随机头图横幅 ========== */
.header-banner {
  width: 100%;
  height: 500px;
  border-radius: 16px;
  background-image: var(--banner-image);
  background-size: cover;
  background-position: center 30%;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.6);
  transition: background-image 0.8s ease-in-out;
  position: relative;
  margin-bottom: 2rem;
  overflow: visible;  /* ✅ 允许子元素溢出 */
}

/* ===== 暗色遮罩层 ===== */
.header-banner::after {
  content: '';
  position: absolute;
  inset: 0;
  background: linear-gradient(
      135deg,
      rgba(0, 0, 0, 0.75) 0%,
      rgba(0, 0, 0, 0.3) 50%,
      rgba(0, 0, 0, 0.5) 100%
  );
  border-radius: 16px;
  z-index: 1;
  pointer-events: none;
}

/* ===== 底部光晕装饰 ===== */
.header-banner::before {
  content: '';
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  height: 60%;
  background: linear-gradient(to top, rgba(0, 0, 0, 0.6) 0%, transparent 100%);
  border-radius: 0 0 16px 16px;
  z-index: 1;
  pointer-events: none;
}

/* ===== 文字内容在遮罩之上 ===== */
.header-banner .relative {
  z-index: 2;
  position: relative;
}

/* ===== 标题文字阴影增强 ===== */
.header-banner h1 {
  text-shadow: 0 2px 20px rgba(0, 0, 0, 0.5);
  letter-spacing: 0.05em;
}

.header-banner p {
  text-shadow: 0 2px 12px rgba(0, 0, 0, 0.4);
}

/* ===== 文字切换过渡动画 ===== */
.header-banner p {
  transition: opacity 0.5s ease-in-out;
}

/* ===== 加载动画 ===== */
.header-banner.loading {
  animation: bannerPulse 1.5s ease-in-out infinite;
}

@keyframes bannerPulse {
  0%, 100% { opacity: 0.8; }
  50% { opacity: 1; }
}

/* ========== Header 圆角包裹层 ========== */
.header-wrapper {
  position: sticky;
  top: 12px;
  z-index: 100;
  padding: 0 16px;
  margin-bottom: 20px;
  overflow: visible !important;  /* ✅ 允许溢出 */
}

.header-wrapper > header {
  border-radius: 16px !important;
  overflow: visible !important;  /* ✅ 改为 visible，允许下拉菜单溢出 */
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3) !important;
}

/* 让 Header 内部的 nav 也继承圆角，但允许溢出 */
.header-wrapper > header nav,
.header-wrapper > header .nav-glass,
.header-wrapper > header .bg-white {
  border-radius: 16px !important;
  overflow: visible !important;  /* ✅ 改为 visible */
}

/* 去掉 Header 自身的 sticky，由外层控制 */
.header-wrapper > header {
  position: relative !important;
  top: auto !important;
  z-index: auto !important;
}

/* 如果 Header 内部有 border-bottom，去掉 */
.header-wrapper .border-b {
  border-bottom: none !important;
}

/* ===== ✅ 修复搜索下拉菜单被遮挡 ===== */

/* 让 Header 内部的搜索区域允许溢出 */
.header-wrapper .relative {
  overflow: visible !important;
}

.header-wrapper .flex-1 {
  overflow: visible !important;
}

.header-wrapper .md\:block {
  overflow: visible !important;
}

/* 搜索下拉菜单强制最高层级 */
.header-wrapper .z-50 {
  z-index: 9999 !important;
}

/* 下拉菜单样式增强 */
.header-wrapper .z-50.max-h-80 {
  max-height: 400px !important;
  overflow-y: auto !important;
  position: absolute !important;
  top: calc(100% + 4px) !important;
  left: 0 !important;
  right: 0 !important;
}

/* ===== 响应式适配 ===== */
@media (max-width: 768px) {
  .header-banner {
    height: 200px;
    border-radius: 12px;
    margin-bottom: 1rem;
  }

  .header-banner h1 {
    font-size: 1.6rem !important;
  }

  .header-banner p {
    font-size: 0.95rem !important;
  }

  .header-banner::after,
  .header-banner::before {
    border-radius: 12px;
  }
}

@media (max-width: 480px) {
  .header-banner {
    height: 160px;
    border-radius: 8px;
  }

  .header-banner h1 {
    font-size: 1.2rem !important;
  }

  .header-banner p {
    font-size: 0.8rem !important;
    margin-top: 4px !important;
  }
}

.bg-white {
  background: transparent;
}
</style>