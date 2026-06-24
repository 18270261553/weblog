<template>
  <header class="sticky top-0 z-100 header-transparent">
    <nav class="bg-white/10 backdrop-blur-md border-b border-white/10 dark:bg-black/30 dark:border-white/5 nav-glass">
      <div class="max-w-screen-xl flex flex-wrap items-center justify-between mx-auto p-4">
        <!-- Logo -->
        <a href="/" class="flex items-center">
          <img src="@/assets/logo2.png" class="h-8 mr-3" alt="Logo" style="width: 66px;height: 64px" />
          <span class="self-center text-2xl font-semibold whitespace-nowrap text-white drop-shadow-lg">{{
              $store.state.setting.blogName }}</span>
        </a>

        <div class="flex items-center md:order-2">
          <!-- 暗黑模式切换按钮 -->
          <button
              @click="toggleDarkMode"
              class="mr-3 text-white/80 hover:text-white hover:bg-white/20 focus:outline-none focus:ring-4 focus:ring-white/20 rounded-lg p-2.5 transition-all duration-300"
          >
            <svg
                class="w-5 h-5"
                aria-hidden="true"
                xmlns="http://www.w3.org/2000/svg"
                fill="currentColor"
                viewBox="0 0 20 20"
                :class="isDarkMode ? 'hidden' : ''"
            >
              <path d="M10 15a5 5 0 1 0 0-10 5 5 0 0 0 0 10Zm0-11a1 1 0 0 0 1-1V1a1 1 0 0 0-2 0v2a1 1 0 0 0 1 1Zm0 12a1 1 0 0 0-1 1v2a1 1 0 1 0 2 0v-2a1 1 0 0 0-1-1ZM4.34 5.76a1 1 0 0 0 1.42-1.42L4.34 2.92a1 1 0 0 0-1.42 1.42l1.42 1.42Zm11.32 8.48a1 1 0 0 0-1.42-1.42l-1.42 1.42a1 1 0 0 0 1.42 1.42l1.42-1.42ZM4 10a1 1 0 0 0-1-1H1a1 1 0 0 0 0 2h2a1 1 0 0 0 1-1Zm15-1h-2a1 1 0 1 0 0 2h2a1 1 0 0 0 0-2ZM5.76 15.66a1 1 0 0 0-1.42 0 1 1 0 0 0 0 1.42l1.42 1.42a1 1 0 0 0 1.42-1.42l-1.42-1.42Zm8.48-11.32a1 1 0 0 0 1.42 0 1 1 0 0 0 0-1.42l-1.42-1.42a1 1 0 0 0-1.42 1.42l1.42 1.42Z"/>
            </svg>
            <svg
                class="w-5 h-5"
                aria-hidden="true"
                xmlns="http://www.w3.org/2000/svg"
                fill="currentColor"
                viewBox="0 0 20 20"
                :class="!isDarkMode ? 'hidden' : ''"
            >
              <path d="M17.75 19.25a1 1 0 0 1-1.41 0 8.98 8.98 0 0 0 4.74-7.46 1 1 0 0 1 1.59.93 10.98 10.98 0 0 1-5.92 8.49Zm-2.01-2.26a8.97 8.97 0 0 1-7.74-4.33 1 1 0 1 1 1.82-.8 6.98 6.98 0 0 0 6.05 3.42 1 1 0 0 1 .11 1.71ZM10 15a5 5 0 1 1 0-10 5 5 0 0 1 0 10Zm0-12a7 7 0 1 0 0 14 7 7 0 0 0 0-14Z"/>
            </svg>
            <span class="sr-only">切换暗黑模式</span>
          </button>

          <!-- 搜索框 -->
          <div class="flex mr-3">
            <button type="button" data-collapse-toggle="navbar-search" aria-controls="navbar-search"
                    aria-expanded="false"
                    class="md:hidden text-white/80 hover:text-white hover:bg-white/20 focus:outline-none focus:ring-4 focus:ring-white/20 rounded-lg text-sm p-2.5 mr-1 transition-all duration-300">
              <svg class="w-5 h-5" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 20 20">
                <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                      d="m19 19-4-4m0-7A7 7 0 1 1 1 8a7 7 0 0 1 14 0Z" />
              </svg>
              <span class="sr-only">搜索</span>
            </button>
            <div class="relative hidden md:block">
              <div class="flex items-center">
                <div class="relative flex-1">
                  <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
                    <svg class="w-4 h-4 text-white/60" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 20 20">
                      <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                            d="m19 19-4-4m0-7A7 7 0 1 1 1 8a7 7 0 0 1 14 0Z" />
                    </svg>
                  </div>
                  <input type="text" id="search-navbar" v-model="searchKeyword"
                         @input="handleSearchInput"
                         @keyup.down="navigateSuggestions('down')"
                         @keyup.up="navigateSuggestions('up')"
                         @keyup.enter="handleSearchEnter"
                         @focus="handleSearchFocus"
                         @blur="hideSuggestions"
                         class="block w-full p-2 pl-10 text-sm text-white bg-white/10 border border-white/20 rounded-l-lg focus:ring-2 focus:ring-white/30 focus:border-white/30 placeholder-white/50 backdrop-blur-sm transition-all duration-300"
                         placeholder="搜索文章..."
                  />
                  <!-- 搜索建议下拉列表 -->
                  <div v-if="showSuggestions && searchSuggestions.length > 0"
                       class="absolute top-full left-0 right-0 mt-1 bg-white/95 backdrop-blur-md border border-white/20 rounded-lg shadow-2xl z-50 max-h-80 overflow-y-auto">
                    <div v-for="(item, index) in searchSuggestions" :key="item.id"
                         @click="goToArticle(item.id)"
                         @mouseenter="activeSuggestionIndex = index"
                         :class="['px-4 py-3 cursor-pointer border-b border-gray-100/50 last:border-b-0 hover:bg-blue-50/50 transition-all duration-200',
                              activeSuggestionIndex === index ? 'bg-blue-50/50' : '']">
                      <div class="flex items-start">
                        <img v-if="item.titleImage" :src="item.titleImage"
                             class="w-12 h-12 object-cover rounded mr-3 flex-shrink-0">
                        <div class="flex-1 min-w-0">
                          <p class="text-sm font-medium text-gray-900 truncate">{{ item.title }}</p>
                          <p class="text-xs text-gray-500 mt-1 line-clamp-1">{{ item.description }}</p>
                        </div>
                      </div>
                    </div>
                    <div class="px-4 py-2 text-xs text-gray-400 text-center bg-gray-50/50">
                      共 {{ searchSuggestionsTotal }} 条结果
                    </div>
                  </div>
                  <div v-if="showSuggestions && searchKeyword && searchSuggestions.length === 0 && !searching"
                       class="absolute top-full left-0 right-0 mt-1 bg-white/95 backdrop-blur-md border border-white/20 rounded-lg shadow-2xl z-50 px-4 py-3 text-center text-gray-500 text-sm">
                    未找到相关文章
                  </div>
                  <div v-if="searching"
                       class="absolute top-full left-0 right-0 mt-1 bg-white/95 backdrop-blur-md border border-white/20 rounded-lg shadow-2xl z-50 px-4 py-3 text-center text-gray-500 text-sm">
                    搜索中...
                  </div>
                </div>
                <button @click="handleSearchClick"
                        class="px-4 py-2 bg-white/20 text-white text-sm font-medium rounded-r-lg hover:bg-white/30 focus:outline-none focus:ring-2 focus:ring-white/30 transition-all duration-300 border border-white/20 border-l-0 backdrop-blur-sm">
                  确定
                </button>
              </div>
            </div>
            <button data-collapse-toggle="navbar-search" type="button"
                    class="inline-flex items-center p-2 w-10 h-10 justify-center text-sm text-white/80 rounded-lg md:hidden hover:bg-white/20 focus:outline-none focus:ring-2 focus:ring-white/20 transition-all duration-300"
                    aria-controls="navbar-search" aria-expanded="false">
              <span class="sr-only">Open main menu</span>
              <svg class="w-5 h-5" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 17 14">
                <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                      d="M1 1h15M1 7h15M1 13h15" />
              </svg>
            </button>
          </div>

          <!-- 登录/用户 -->
          <span class="text-white/80 hover:text-white hover:bg-white/20 px-3 py-1 rounded-lg transition-all duration-300 cursor-pointer"
                v-if="isLogin == false" @click="$router.push('/login')">登录</span>
          <button type="button" v-else
                  class="flex mr-3 text-sm rounded-full focus:ring-4 focus:ring-white/20 transition-all duration-300"
                  id="user-menu-button" aria-expanded="false" data-dropdown-toggle="user-dropdown"
                  data-dropdown-placement="bottom">
            <span class="sr-only">Open user menu</span>
            <img class="w-8 h-8 rounded-full border-2 border-white/30" :src="$store.state.setting.avatar" alt="user photo">
          </button>
          <div class="z-50 hidden my-4 text-base list-none bg-white/95 backdrop-blur-md divide-y divide-gray-100 rounded-lg shadow-2xl border border-white/20"
               id="user-dropdown">
            <ul class="py-2" aria-labelledby="user-menu-button">
              <li>
                <a @click="$router.push('/admin')"
                   class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100/50 rounded-lg mx-2 transition-all duration-200">
                  <svg class="inline w-3 h-3 mb-2px mr-1 text-gray-700" aria-hidden="true"
                       xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 20 20">
                    <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                          d="M10 14v4m-4 1h8M1 10h18M2 1h16a1 1 0 0 1 1 1v11a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1Z" />
                  </svg>
                  进入后台
                </a>
              </li>
              <li>
                <a data-modal-target="logout-modal" data-modal-toggle="logout-modal"
                   class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100/50 rounded-lg mx-2 transition-all duration-200">
                  <svg class="inline w-3 h-3 mb-2px mr-1 text-gray-700" aria-hidden="true"
                       xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 16 16">
                    <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                          d="M4 8h11m0 0-4-4m4 4-4 4m-5 3H3a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h3" />
                  </svg>
                  退出登录
                </a>
              </li>
            </ul>
          </div>
        </div>

        <!-- 导航菜单 -->
        <div class="items-center justify-between hidden w-full md:flex md:w-auto md:order-1" id="navbar-search">
          <ul class="flex flex-col p-4 md:p-0 mt-4 font-medium border border-white/10 rounded-lg bg-white/5 backdrop-blur-sm md:flex-row md:space-x-1 md:mt-0 md:border-0 md:bg-transparent">
            <li class="nav-item">
              <a @click="$router.push('/')" :class="[currPath == '/' ? 'nav-link-active' : 'nav-link']"
                 class="block py-2 px-4 rounded-lg transition-all duration-300">
                Home
              </a>
            </li>
            <li class="nav-item">
              <a @click="$router.push('/index')" :class="[currPath == '/index' ? 'nav-link-active' : 'nav-link']"
                 class="block py-2 px-4 rounded-lg transition-all duration-300">
                首页
              </a>
            </li>
            <li class="nav-item">
              <a @click="$router.push('/category')" :class="[currPath == '/category' ? 'nav-link-active' : 'nav-link']"
                 class="block py-2 px-4 rounded-lg transition-all duration-300">
                分类
              </a>
            </li>
            <li class="nav-item">
              <a @click="$router.push('/tag')" :class="[currPath == '/tag' ? 'nav-link-active' : 'nav-link']"
                 class="block py-2 px-4 rounded-lg transition-all duration-300">
                标签
              </a>
            </li>
            <li class="nav-item">
              <a @click="$router.push('/archive')" :class="[currPath == '/archive' ? 'nav-link-active' : 'nav-link']"
                 class="block py-2 px-4 rounded-lg transition-all duration-300">
                归档
              </a>
            </li>
            <li class="nav-item">
              <a @click="$router.push('/aiChatbot')" :class="[currPath == '/aiChatbot' ? 'nav-link-active' : 'nav-link']"
                 class="block py-2 px-4 rounded-lg transition-all duration-300">
                AI搜索
              </a>
            </li>
            <li class="nav-item">
              <a @click="$router.push('/messageBoard')" :class="[currPath == '/messageBoard' ? 'nav-link-active' : 'nav-link']"
                 class="block py-2 px-4 rounded-lg transition-all duration-300">
                留言板
              </a>
            </li>
          </ul>
        </div>
      </div>
    </nav>

    <!-- 退出登录 modal -->
    <div id="logout-modal" tabindex="-1"
         class="fixed top-0 left-0 right-0 z-50 hidden p-4 overflow-x-hidden overflow-y-auto md:inset-0 h-[calc(100%-1rem)] max-h-full">
      <div class="relative w-full max-w-md max-h-full">
        <div class="relative bg-white/95 backdrop-blur-md rounded-lg shadow-2xl border border-white/20">
          <button type="button"
                  class="absolute top-3 right-2.5 text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm w-8 h-8 ml-auto inline-flex justify-center items-center"
                  data-modal-hide="logout-modal">
            <svg class="w-3 h-3" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 14 14">
              <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                    d="m1 1 6 6m0 0 6 6M7 7l6-6M7 7l-6 6" />
            </svg>
            <span class="sr-only">Close modal</span>
          </button>
          <div class="p-6 text-center">
            <svg class="mx-auto mb-4 text-gray-400 w-12 h-12" aria-hidden="true"
                 xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 20 20">
              <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                    d="M10 11V6m0 8h.01M19 10a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z" />
            </svg>
            <h3 class="mb-5 text-lg font-normal text-gray-500">是否退出登录?</h3>
            <button @click="logout" data-modal-hide="logout-modal" type="button"
                    class="text-white bg-blue-600 hover:bg-blue-700 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm inline-flex items-center px-5 py-2.5 text-center mr-2 transition-all duration-300">
              确认
            </button>
            <button data-modal-hide="logout-modal" type="button"
                    class="text-gray-500 bg-white hover:bg-gray-100 focus:ring-4 focus:outline-none focus:ring-gray-200 rounded-lg border border-gray-200 text-sm font-medium px-5 py-2.5 hover:text-gray-900 transition-all duration-300">
              取消
            </button>
          </div>
        </div>
      </div>
    </div>
  </header>
</template>

<script setup>
import { useStore } from 'vuex'
import { useRoute, useRouter } from 'vue-router';
import { ref } from 'vue';
import { showModel, showMessage } from '@/composables/util'
import { onMounted } from 'vue'
import { initDropdowns, initCollapses, initModals } from 'flowbite'
import { searchArticles } from '@/api/frontend/search'

// 暗黑模式状态
const isDarkMode = ref(localStorage.getItem('darkMode') === 'true');

onMounted(() => {
  if (isDarkMode.value) {
    document.documentElement.classList.add('dark');
  } else {
    document.documentElement.classList.remove('dark');
  }
  initCollapses();
  initDropdowns();
  initModals();
})

const toggleDarkMode = () => {
  isDarkMode.value = !isDarkMode.value;
  if (isDarkMode.value) {
    document.documentElement.classList.add('dark');
    localStorage.setItem('darkMode', 'true');
  } else {
    document.documentElement.classList.remove('dark');
    localStorage.setItem('darkMode', 'false');
  }
};

const store = useStore()
const route = useRoute()
const router = useRouter()

const currPath = ref(route.path)
const searchKeyword = ref('')
const searchSuggestions = ref([])
const searchSuggestionsTotal = ref(0)
const showSuggestions = ref(false)
const searching = ref(false)
const activeSuggestionIndex = ref(-1)
let searchTimer = null

const keys = Object.keys(store.state.user)
const isLogin = ref(keys.length > 0)

const handleSearchFocus = () => {
  if (searchKeyword.value.trim() && searchSuggestions.value.length > 0) {
    showSuggestions.value = true
  }
}

const handleSearchInput = () => {
  if (searchTimer) {
    clearTimeout(searchTimer)
  }
  if (!searchKeyword.value.trim()) {
    searchSuggestions.value = []
    showSuggestions.value = false
    return
  }
  searching.value = true
  searchTimer = setTimeout(() => {
    fetchSearchSuggestions()
  }, 300)
}

const fetchSearchSuggestions = () => {
  searchArticles({
    current: 1,
    size: 5,
    searchKey: searchKeyword.value.trim()
  }).then((res) => {
    searching.value = false
    if (res.success && res.data) {
      searchSuggestions.value = res.data
      searchSuggestionsTotal.value = res.total || 0
      showSuggestions.value = true
      activeSuggestionIndex.value = -1
    }
  }).catch(() => {
    searching.value = false
  })
}

const navigateSuggestions = (direction) => {
  if (!showSuggestions.value || searchSuggestions.value.length === 0) {
    if (direction === 'down' && searchKeyword.value.trim()) {
      showSuggestions.value = true
      fetchSearchSuggestions()
    }
    return
  }
  if (direction === 'down') {
    activeSuggestionIndex.value = Math.min(
        activeSuggestionIndex.value + 1,
        searchSuggestions.value.length - 1
    )
  } else if (direction === 'up') {
    activeSuggestionIndex.value = Math.max(
        activeSuggestionIndex.value - 1,
        -1
    )
  }
}

const handleSearchEnter = () => {
  if (activeSuggestionIndex.value >= 0 && searchSuggestions.value[activeSuggestionIndex.value]) {
    goToArticle(searchSuggestions.value[activeSuggestionIndex.value].id)
  } else if (searchKeyword.value.trim()) {
    handleSearchClick()
  }
}

const handleSearchClick = () => {
  if (!searchKeyword.value.trim()) {
    showMessage('请输入搜索关键词', 'warning')
    return
  }
  router.push({ path: '/search', query: { key: searchKeyword.value.trim() } })
  searchKeyword.value = ''
  showSuggestions.value = false
}

const goToArticle = (articleId) => {
  router.push({ path: '/article/detail', query: { articleId: articleId } })
  searchKeyword.value = ''
  showSuggestions.value = false
}

const hideSuggestions = () => {
  setTimeout(() => {
    showSuggestions.value = false
  }, 200)
}

const logout = () => {
  store.dispatch('logout')
  showMessage('退出登录成功', 'success')
  isLogin.value = false
}
</script>

<style scoped>
/* ========== 基础容器 ========== */
.container {
  max-width: 1260px;
}

/* ========== 玻璃态 Header ========== */
.header-transparent {
  position: sticky;
  top: 0;
  z-index: 100;
}

.nav-glass {
  background: rgba(0, 0, 0, 0.25) !important;
  backdrop-filter: blur(16px) !important;
  -webkit-backdrop-filter: blur(16px) !important;
  border-bottom: 1px solid rgba(255, 255, 255, 0.08) !important;
  transition: all 0.3s ease;
}

/* 深色模式下的玻璃态 */
.dark .nav-glass {
  background: rgba(0, 0, 0, 0.4) !important;
  border-bottom: 1px solid rgba(255, 255, 255, 0.05) !important;
}

/* ========== 导航项样式 ========== */
.nav-item {
  position: relative;
}

/* 导航链接 - 默认 */
.nav-link {
  color: rgba(255, 255, 255, 0.75) !important;
  font-weight: 500;
  letter-spacing: 0.3px;
  position: relative;
  padding: 8px 16px !important;
  border-radius: 10px !important;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

/* 导航链接 - 悬停 */
.nav-link:hover {
  color: #ffffff !important;
  background: rgba(255, 255, 255, 0.12) !important;
  transform: translateY(-1px);
}

/* 导航链接 - 激活状态 */
.nav-link-active {
  color: #ffffff !important;
  background: rgba(255, 255, 255, 0.15) !important;
  font-weight: 600;
  padding: 8px 16px !important;
  border-radius: 10px !important;
  position: relative;
  box-shadow: 0 4px 15px rgba(255, 255, 255, 0.08);
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.nav-link-active:hover {
  background: rgba(255, 255, 255, 0.2) !important;
  transform: translateY(-1px);
}

/* ========== 导航项之间的分割线 ========== */
.nav-item::after {
  content: '';
  position: absolute;
  right: -2px;
  top: 50%;
  transform: translateY(-50%);
  width: 1px;
  height: 24px;
  background: rgba(255, 255, 255, 0.1);
  border-radius: 1px;
  transition: all 0.3s ease;
}

/* 最后一个导航项不显示分割线 */
.nav-item:last-child::after {
  display: none;
}

/* 分割线在深色模式下更淡 */
.dark .nav-item::after {
  background: rgba(255, 255, 255, 0.06);
}

/* 移动端导航菜单项分割线 */
@media (max-width: 768px) {
  .nav-item::after {
    display: none;
  }
}

/* ========== 搜索框样式 ========== */
.search-input {
  background: rgba(255, 255, 255, 0.08) !important;
  border: 1px solid rgba(255, 255, 255, 0.12) !important;
  color: #ffffff !important;
  backdrop-filter: blur(8px);
  transition: all 0.3s ease;
}

.search-input::placeholder {
  color: rgba(255, 255, 255, 0.4) !important;
}

.search-input:focus {
  background: rgba(255, 255, 255, 0.12) !important;
  border-color: rgba(255, 255, 255, 0.25) !important;
  box-shadow: 0 0 20px rgba(255, 255, 255, 0.05);
}

/* ========== 响应式适配 ========== */
@media (max-width: 768px) {
  .nav-glass {
    background: rgba(0, 0, 0, 0.35) !important;
  }

  .nav-link,
  .nav-link-active {
    padding: 10px 16px !important;
  }
}

@media (max-width: 480px) {
  .nav-glass {
    background: rgba(0, 0, 0, 0.4) !important;
  }
}
</style>