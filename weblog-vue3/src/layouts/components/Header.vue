<template>

    <header class="sticky top-0 z-100">

        <nav class="bg-white border-gray-200 border-b dark:bg-black dark:border-gray-800">
            <div class="max-w-screen-xl flex flex-wrap items-center justify-between mx-auto p-4">
                <a href="/" class="flex items-center">
                    <img src="@/assets/logo2.png" class="h-8 mr-3" alt="Flowbite Logo" style="width: 66px;height: 64px" />
                    <span class="self-center text-2xl font-semibold whitespace-nowrap dark:text-white">{{
                        $store.state.setting.blogName }}</span>
                </a>

                <div class="flex items-center md:order-2">
                  <!-- 暗黑模式切换按钮 -->
                  <button
                      @click="toggleDarkMode"
                      class="mr-3 text-gray-500 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-700 focus:outline-none focus:ring-4 focus:ring-gray-200 dark:focus:ring-gray-700 rounded-lg p-2.5"
                  >
                    <svg
                        class="w-5 h-5"
                        aria-hidden="true"
                        xmlns="http://www.w3.org/2000/svg"
                        fill="currentColor"
                        viewBox="0 0 20 20"
                        :class="isDarkMode ? 'hidden' : ''"
                    >
                      <!-- 太阳图标 -->
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
                      <!-- 月亮图标 -->
                      <path d="M17.75 19.25a1 1 0 0 1-1.41 0 8.98 8.98 0 0 0 4.74-7.46 1 1 0 0 1 1.59.93 10.98 10.98 0 0 1-5.92 8.49Zm-2.01-2.26a8.97 8.97 0 0 1-7.74-4.33 1 1 0 1 1 1.82-.8 6.98 6.98 0 0 0 6.05 3.42 1 1 0 0 1 .11 1.71ZM10 15a5 5 0 1 1 0-10 5 5 0 0 1 0 10Zm0-12a7 7 0 1 0 0 14 7 7 0 0 0 0-14Z"/>
                    </svg>
                    <span class="sr-only">切换暗黑模式</span>
                  </button>

                    <div class="flex mr-3">
                        <button type="button" data-collapse-toggle="navbar-search" aria-controls="navbar-search"
                            aria-expanded="false"
                            class="md:hidden text-gray-500 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-700 focus:outline-none focus:ring-4 focus:ring-gray-200 dark:focus:ring-gray-700 rounded-lg text-sm p-2.5 mr-1">
                            <svg class="w-5 h-5" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none"
                                viewBox="0 0 20 20">
                                <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                    d="m19 19-4-4m0-7A7 7 0 1 1 1 8a7 7 0 0 1 14 0Z" />
                            </svg>
                            <span class="sr-only">搜索</span>
                        </button>
                        <div class="relative hidden md:block">
                            <div class="flex items-center">
                                <div class="relative flex-1">
                                    <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
                                        <svg class="w-4 h-4 text-gray-500 dark:text-gray-400" aria-hidden="true"
                                            xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 20 20">
                                            <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"
                                                stroke-width="2" d="m19 19-4-4m0-7A7 7 0 1 1 1 8a7 7 0 0 1 14 0Z" />
                                        </svg>
                                        <span class="sr-only">Search icon</span>
                                    </div>
                                    <input type="text" id="search-navbar" v-model="searchKeyword"
                                        @input="handleSearchInput"
                                        @keyup.down="navigateSuggestions('down')"
                                        @keyup.up="navigateSuggestions('up')"
                                        @keyup.enter="handleSearchEnter"
                                        @focus="handleSearchFocus"
                                        @blur="hideSuggestions"
                                        class="block w-full p-2 pl-10 text-sm text-gray-900 border border-gray-300 rounded-l-lg bg-gray-50 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                                        placeholder="搜索文章...">

                                    <!-- 搜索建议下拉列表 -->
                                    <div v-if="showSuggestions && searchSuggestions.length > 0"
                                        class="absolute top-full left-0 right-0 mt-1 bg-white border border-gray-200 rounded-lg shadow-lg z-50 max-h-80 overflow-y-auto">
                                        <div v-for="(item, index) in searchSuggestions" :key="item.id"
                                            @click="goToArticle(item.id)"
                                            @mouseenter="activeSuggestionIndex = index"
                                            :class="['px-4 py-3 cursor-pointer border-b border-gray-100 last:border-b-0 hover:bg-blue-50',
                                                    activeSuggestionIndex === index ? 'bg-blue-50' : '']">
                                            <div class="flex items-start">
                                                <img v-if="item.titleImage" :src="item.titleImage"
                                                    class="w-12 h-12 object-cover rounded mr-3 flex-shrink-0">
                                                <div class="flex-1 min-w-0">
                                                    <p class="text-sm font-medium text-gray-900 truncate">{{ item.title }}</p>
                                                    <p class="text-xs text-gray-500 mt-1 line-clamp-1">{{ item.description }}</p>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="px-4 py-2 text-xs text-gray-400 text-center bg-gray-50">
                                            共 {{ searchSuggestionsTotal }} 条结果，点击查看更多
                                        </div>
                                    </div>

                                    <!-- 无结果提示 -->
                                    <div v-if="showSuggestions && searchKeyword && searchSuggestions.length === 0 && !searching"
                                        class="absolute top-full left-0 right-0 mt-1 bg-white border border-gray-200 rounded-lg shadow-lg z-50 px-4 py-3 text-center text-gray-500 text-sm">
                                        未找到相关文章
                                    </div>

                                    <!-- 加载中 -->
                                    <div v-if="searching"
                                        class="absolute top-full left-0 right-0 mt-1 bg-white border border-gray-200 rounded-lg shadow-lg z-50 px-4 py-3 text-center text-gray-500 text-sm">
                                        搜索中...
                                    </div>
                                </div>

                                <!-- 确定按钮 -->
                                <button @click="handleSearchClick"
                                    class="px-4 py-2 bg-blue-600 text-white text-sm font-medium rounded-r-lg hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 transition-colors">
                                    确定
                                </button>
                            </div>
                        </div>
                        <button data-collapse-toggle="navbar-search" type="button"
                            class="inline-flex items-center p-2 w-10 h-10 justify-center text-sm text-gray-500 rounded-lg md:hidden hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-gray-200 dark:text-gray-400 dark:hover:bg-gray-700 dark:focus:ring-gray-600"
                            aria-controls="navbar-search" aria-expanded="false">
                            <span class="sr-only">Open main menu</span>
                            <svg class="w-5 h-5" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none"
                                viewBox="0 0 17 14">
                                <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                    d="M1 1h15M1 7h15M1 13h15" />
                            </svg>
                        </button>
                    </div>

                    <span class="text-gray-900 hover:text-blue-700" v-if="isLogin == false"
                        @click="$router.push('/login')">登录</span>
                    <button type="button" v-else
                        class="flex mr-3 text-sm rounded-full md:mr-0 focus:ring-4 focus:ring-gray-300 dark:focus:ring-gray-600"
                        id="user-menu-button" aria-expanded="false" data-dropdown-toggle="user-dropdown"
                        data-dropdown-placement="bottom">
                        <span class="sr-only">Open user menu</span>
                        <!-- 用户登录头像 -->
                        <img class="w-8 h-8 rounded-full" :src="$store.state.setting.avatar" alt="user photo">
                    </button>
                    <!-- Dropdown menu -->
                    <div class="z-50 hidden my-4 text-base list-none bg-white divide-y divide-gray-100 rounded-lg shadow dark:bg-gray-700 dark:divide-gray-600"
                        id="user-dropdown">
                        <ul class="py-2" aria-labelledby="user-menu-button">
                            <li>
                                <a @click="$router.push('/admin')"
                                    class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 dark:hover:bg-gray-600 dark:text-gray-200 dark:hover:text-white">
                                    <svg class="inline w-3 h-3 mb-2px mr-1 text-gray-700 dark:text-white" aria-hidden="true"
                                        xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 20 20">
                                        <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"
                                            stroke-width="2"
                                            d="M10 14v4m-4 1h8M1 10h18M2 1h16a1 1 0 0 1 1 1v11a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1Z" />
                                    </svg>
                                    进入后台
                                </a>
                            </li>
                            <li>
                                <a data-modal-target="logout-modal" data-modal-toggle="logout-modal"
                                    class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 dark:hover:bg-gray-600 dark:text-gray-200 dark:hover:text-white">
                                    <svg class="inline w-3 h-3 mb-2px mr-1 text-gray-700 dark:text-white" aria-hidden="true"
                                        xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 16 16">
                                        <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"
                                            stroke-width="2"
                                            d="M4 8h11m0 0-4-4m4 4-4 4m-5 3H3a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h3" />
                                    </svg>
                                    退出登录
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="items-center justify-between hidden w-full md:flex md:w-auto md:order-1" id="navbar-search">
                    <div class="relative mt-3 md:hidden">
                        <div class="flex items-center">
                            <div class="relative flex-1">
                                <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
                                    <svg class="w-4 h-4 text-gray-500 dark:text-gray-400" aria-hidden="true"
                                        xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 20 20">
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
                                    class="block w-full p-2 pl-10 text-sm text-gray-900 border border-gray-300 rounded-l-lg bg-gray-50 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                                    placeholder="搜索文章...">

                                <!-- 移动端搜索建议下拉列表 -->
                                <div v-if="showSuggestions && searchSuggestions.length > 0"
                                    class="absolute top-full left-0 right-0 mt-1 bg-white border border-gray-200 rounded-lg shadow-lg z-50 max-h-80 overflow-y-auto">
                                    <div v-for="(item, index) in searchSuggestions" :key="item.id"
                                        @click="goToArticle(item.id)"
                                        @mouseenter="activeSuggestionIndex = index"
                                        :class="['px-4 py-3 cursor-pointer border-b border-gray-100 last:border-b-0 hover:bg-blue-50',
                                                activeSuggestionIndex === index ? 'bg-blue-50' : '']">
                                        <div class="flex items-start">
                                            <img v-if="item.titleImage" :src="item.titleImage"
                                                class="w-12 h-12 object-cover rounded mr-3 flex-shrink-0">
                                            <div class="flex-1 min-w-0">
                                                <p class="text-sm font-medium text-gray-900 truncate">{{ item.title }}</p>
                                                <p class="text-xs text-gray-500 mt-1 line-clamp-1">{{ item.description }}</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- 移动端确定按钮 -->
                            <button @click="handleSearchClick"
                                class="px-4 py-2 bg-blue-600 text-white text-sm font-medium rounded-r-lg hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 transition-colors">
                                确定
                            </button>
                        </div>
                    </div>
                    <ul
                        class="flex flex-col p-4 md:p-0 mt-4 font-medium border border-gray-100 rounded-lg bg-gray-50 md:flex-row md:space-x-8 md:mt-0 md:border-0 md:bg-white dark:bg-gray-800 md:dark:bg-gray-900 dark:border-gray-700">
                        <li>
                            <a @click="$router.push('/')" :class="[currPath == '/' ? 'text-blue-700' : 'text-gray-900']"
                                class="block py-2 pl-3 pr-4 rounded md:bg-transparent md:p-0 md:dark:text-blue-500"
                                aria-current="page">
                                首页
                            </a>
                        </li>
                        <li>
                            <a @click="$router.push('/category')"
                                :class="[currPath == '/category' ? 'text-blue-700' : 'text-gray-900']"
                                class="block py-2 pl-3 pr-4 rounded hover:bg-gray-100 md:hover:bg-transparent md:hover:text-blue-700 md:p-0 md:dark:hover:text-blue-500 dark:text-white dark:hover:bg-gray-700 dark:hover:text-white md:dark:hover:bg-transparent dark:border-gray-700">
                                分类
                            </a>
                        </li>
                        <li>
                            <a @click="$router.push('/tag')"
                                :class="[currPath == '/tag' ? 'text-blue-700' : 'text-gray-900']"
                                class="block py-2 pl-3 pr-4 rounded hover:bg-gray-100 md:hover:bg-transparent md:hover:text-blue-700 md:p-0 dark:text-white md:dark:hover:text-blue-500 dark:hover:bg-gray-700 dark:hover:text-white md:dark:hover:bg-transparent dark:border-gray-700">
                                标签
                            </a>
                        </li>

                        <li>
                            <a @click="$router.push('/archive')"
                                :class="[currPath == '/archive' ? 'text-blue-700' : 'text-gray-900']"
                                class="block py-2 pl-3 pr-4 rounded hover:bg-gray-100 md:hover:bg-transparent md:hover:text-blue-700 md:p-0 dark:text-white md:dark:hover:text-blue-500 dark:hover:bg-gray-700 dark:hover:text-white md:dark:hover:bg-transparent dark:border-gray-700">
                                归档
                            </a>
                        </li>
                      <li>
                        <a @click="$router.push('/aiChatbot')"
                           :class="[currPath == '/aiChatbot' ? 'text-blue-700' : 'text-gray-900']"
                           class="block py-2 pl-3 pr-4 rounded hover:bg-gray-100 md:hover:bg-transparent md:hover:text-blue-700 md:p-0 dark:text-white md:dark:hover:text-blue-500 dark:hover:bg-gray-700 dark:hover:text-white md:dark:hover:bg-transparent dark:border-gray-700">
                          AI搜索
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
                <div class="relative bg-white rounded-lg shadow dark:bg-gray-700">
                    <button type="button"
                        class="absolute top-3 right-2.5 text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm w-8 h-8 ml-auto inline-flex justify-center items-center dark:hover:bg-gray-600 dark:hover:text-white"
                        data-modal-hide="logout-modal">
                        <svg class="w-3 h-3" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none"
                            viewBox="0 0 14 14">
                            <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="m1 1 6 6m0 0 6 6M7 7l6-6M7 7l-6 6" />
                        </svg>
                        <span class="sr-only">Close modal</span>
                    </button>
                    <div class="p-6 text-center">
                        <svg class="mx-auto mb-4 text-gray-400 w-12 h-12 dark:text-gray-200" aria-hidden="true"
                            xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 20 20">
                            <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M10 11V6m0 8h.01M19 10a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z" />
                        </svg>
                        <h3 class="mb-5 text-lg font-normal text-gray-500 dark:text-gray-400">是否退出登录?</h3>
                        <button @click="logout" data-modal-hide="logout-modal" type="button"
                            class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800 font-medium rounded-lg text-sm inline-flex items-center px-5 py-2.5 text-center mr-2">
                            确认
                        </button>
                        <button data-modal-hide="logout-modal" type="button"
                            class="text-gray-500 bg-white hover:bg-gray-100 focus:ring-4 focus:outline-none focus:ring-gray-200 rounded-lg border border-gray-200 text-sm font-medium px-5 py-2.5 hover:text-gray-900 focus:z-10 dark:bg-gray-700 dark:text-gray-300 dark:border-gray-500 dark:hover:text-white dark:hover:bg-gray-600 dark:focus:ring-gray-600">
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
// initialize components based on data attribute selectors
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

// 切换白天/黑夜
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

// 获取焦点时显示建议
const handleSearchFocus = () => {
    if (searchKeyword.value.trim() && searchSuggestions.value.length > 0) {
        showSuggestions.value = true
    }
}

// 防抖搜索
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

// 获取搜索建议
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

// 键盘导航
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

// 回车处理
const handleSearchEnter = () => {
    if (activeSuggestionIndex.value >= 0 && searchSuggestions.value[activeSuggestionIndex.value]) {
        // 如果选中了某个建议项，直接跳转
        goToArticle(searchSuggestions.value[activeSuggestionIndex.value].id)
    } else if (searchKeyword.value.trim()) {
        // 否则跳转到搜索结果页
        handleSearchClick()
    }
}

// 点击确定按钮
const handleSearchClick = () => {
    if (!searchKeyword.value.trim()) {
        showMessage('请输入搜索关键词', 'warning')
        return
    }
    router.push({ path: '/search', query: { key: searchKeyword.value.trim() } })
    searchKeyword.value = ''
    showSuggestions.value = false
}

// 跳转到文章详情
const goToArticle = (articleId) => {
    router.push({ path: '/article/detail', query: { articleId: articleId } })
    searchKeyword.value = ''
    showSuggestions.value = false
}

// 隐藏建议列表
const hideSuggestions = () => {
    setTimeout(() => {
        showSuggestions.value = false
    }, 200)
}

const logout = () => {
    store.dispatch('logout')

    // 提示登出成功
    showMessage('退出登录成功', 'success')

    isLogin.value = false
}

</script>

<style scoped>
.container {
    max-width: 1260px;
}

.header-container {
    border-bottom: solid 1px var(--el-menu-border-color);
}

.el-menu--horizontal {
    border-bottom: 0;
}

.el-menu {
    /* max-width: 1260px; */
    height: 55px;
}

.el-header {
    border-bottom: 1px solid #dcdfe6;
    ;
    height: 55px;
}

.navbar-wrapper {
    height: 55px;
}

.logo-img {
    height: 40px;
}

.logo-container {
    /* display: flex;
    align-items: center; */
}

.logo-container>a {
    height: 28px;
    width: 128px;
}

.title {
    font-size: 1.6rem;
    font-weight: 800;
}

.title-li:hover {
    border-bottom: 1px solid #fff !important;
}

/* body {
    @apply bg-light-50;
} */

.bg-gray-hover:hover {
    border-bottom: 1px solid #fff !important;
    background-color: #f4f4f5 !important;
}

.line-clamp-1 {
    display: -webkit-box;
    -webkit-line-clamp: 1;
    -webkit-box-orient: vertical;
    overflow: hidden;
}
</style>
