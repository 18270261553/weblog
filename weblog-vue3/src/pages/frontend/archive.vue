<template>
  <!-- 1. 引入全局顶部导航栏（和首页一样） -->
  <Header></Header>

  <!-- 2. 归档页面主体（保持你之前的内容） -->
  <main class="container mx-auto px-4 py-6">
    <div class="flex flex-col lg:flex-row gap-6">
      <!-- 左侧归档列表 -->
      <div class="flex-1">
        <!-- 无数据提示 -->
        <div v-if="archiveList.length === 0" class="text-center py-10 text-gray-500">
          暂无归档文章
        </div>

        <!-- 按年月分组渲染 -->
        <div v-for="monthGroup in archiveList" :key="monthGroup.month" class="mb-6 bg-white dark:bg-gray-800 rounded-lg shadow p-4">
          <h3 class="text-xl font-bold mb-4 text-gray-900 dark:text-white">{{ monthGroup.month }}</h3>
          <div class="space-y-4">
            <div v-for="article in monthGroup.articles" :key="article.id" class="flex items-center gap-4 pb-4 border-b border-gray-100 dark:border-gray-700 last:border-0">
              <img
                  :src="article.titleImage || '/default-cover.png'"
                  alt="封面"
                  class="w-20 h-14 object-cover rounded flex-shrink-0"
              />
              <div class="flex-1 min-w-0">
                <router-link :to="`/article/detail?articleId=${article.id}`" class="block truncate font-medium text-gray-900 dark:text-white hover:text-blue-600 dark:hover:text-blue-400">
                  {{ article.title }}
                </router-link>
                <p class="text-sm text-gray-500 dark:text-gray-400 mt-1 flex items-center">
                  <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
                  </svg>
                  {{ formatDate(article.createTime) }}
                </p>
              </div>
            </div>
          </div>
        </div>

        <!-- 分页 -->
        <div class="flex justify-center items-center gap-2 mt-8">
          <button
              @click="handlePrevPage"
              :disabled="page === 1"
              class="px-4 py-2 border rounded hover:bg-gray-100 dark:hover:bg-gray-700 disabled:opacity-50 disabled:cursor-not-allowed"
          >
            &lt;
          </button>
          <span class="px-4 py-2 border rounded bg-blue-500 text-white">{{ page }}</span>
          <button
              @click="handleNextPage"
              :disabled="page >= totalPages"
              class="px-4 py-2 border rounded hover:bg-gray-100 dark:hover:bg-gray-700 disabled:opacity-50 disabled:cursor-not-allowed"
          >
            &gt;
          </button>
          <span class="text-gray-500 ml-2">共 {{ total }} 篇文章</span>
        </div>
      </div>

      <!-- 右侧侧边栏 -->
      <div class="w-full lg:w-80 space-y-6">
        <!-- 右边栏 -->
        <div class="col-span-4 px-3 md:col-span-1 sm:col-span-4">
          <UserInfoCard></UserInfoCard>
        </div>
        <!-- 分类列表 -->
        <div class="bg-white dark:bg-gray-800 rounded-lg shadow p-4">
          <h4 class="font-bold mb-3 text-gray-900 dark:text-white">分类</h4>
          <div class="flex flex-wrap gap-2">
            <span v-for="cat in categories" :key="cat.id" class="px-3 py-1 bg-gray-100 dark:bg-gray-700 rounded-full text-sm">{{ cat.name }}</span>
          </div>
        </div>
      </div>
    </div>
  </main>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useStore } from 'vuex'
import { getArchiveArticles } from '@/api/frontend/archive'
import { getCategories } from '@/api/frontend/category'
import Header from "@/layouts/components/Header.vue";
import UserInfoCard from "@/components/UserInfoCard.vue";
// 引入你的顶部导航组件（和首页一样的）


const store = useStore()
const archiveList = ref([])
const categories = ref([])
const page = ref(1)
const pageSize = ref(10)
const total = ref(0)
const totalPages = ref(1)

// 日期格式化
const formatDate = (dateStr) => {
  if (!dateStr) return ''
  const date = new Date(dateStr)
  const year = date.getFullYear()
  const month = String(date.getMonth() + 1).padStart(2, '0')
  const day = String(date.getDate()).padStart(2, '0')
  return `${year}-${month}-${day}`
}

// 获取归档文章
const fetchArchiveArticles = async () => {
  const res = await getArchiveArticles({
    page: page.value,
    size: pageSize.value
  })
  if (res.success) {
    archiveList.value = res.data
    total.value = res.total
    totalPages.value = Math.ceil(res.total / pageSize.value)
  }
}

// 获取分类列表
const fetchCategories = async () => {
  const res = await getCategories()
  if (res.success) {
    categories.value = res.data
  }
}

// 分页事件
const handlePrevPage = () => {
  if (page.value > 1) {
    page.value--
    fetchArchiveArticles()
  }
}
const handleNextPage = () => {
  if (page.value < totalPages.value) {
    page.value++
    fetchArchiveArticles()
  }
}

onMounted(() => {
  fetchArchiveArticles()
  fetchCategories()
})
</script>

<style scoped>
</style>