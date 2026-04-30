<template>
  <div>
    <Header></Header>

    <div class="max-w-screen-xl mx-auto p-4">
      <!-- 搜索结果提示 -->
      <div class="mb-6 p-4 bg-blue-50 border-l-4 border-blue-500 rounded">
        <p class="text-gray-700">
          搜索关键词：<span class="font-semibold text-blue-600">{{ searchKey }}</span>
          ，共找到 <span class="font-semibold text-blue-600">{{ total }}</span> 篇文章
        </p>
      </div>

      <!-- 文章列表 -->
      <div v-if="articles.length > 0" class="grid gap-6">
        <div v-for="item in articles" :key="item.id"
             class="bg-white rounded-lg shadow-md overflow-hidden hover:shadow-lg transition-shadow duration-300">
          <div class="flex flex-col md:flex-row">
            <!-- 文章封面 -->
            <div class="md:w-1/3 h-48 md:h-auto overflow-hidden">
              <img :src="item.titleImage" :alt="item.title"
                   class="w-full h-full object-cover hover:scale-105 transition-transform duration-300"
                   @click="goArticleDetail(item.id)">
            </div>

            <!-- 文章内容 -->
            <div class="p-6 md:w-2/3 flex flex-col justify-between">
              <div>
                <h2 @click="goArticleDetail(item.id)"
                    class="text-xl font-bold mb-2 text-gray-800 hover:text-blue-600 cursor-pointer line-clamp-2">
                  {{ item.title }}
                </h2>
                <p class="text-gray-600 text-sm mb-4 line-clamp-2">{{ item.description }}</p>

                <!-- 文章元信息 -->
                <div class="flex items-center text-xs text-gray-500 space-x-4">
                                    <span class="flex items-center">
                                        <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                  d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z" />
                                        </svg>
                                        {{ item.createTime }}
                                    </span>
                  <span class="flex items-center" v-if="item.categoryName">
                                        <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                  d="M7 7h.01M7 3h5c.512 0 1.024.195 1.414.586l7 7a2 2 0 010 2.828l-7 7a2 2 0 01-2.828 0l-7-7A1.994 1.994 0 013 12V7a4 4 0 014-4z" />
                                        </svg>
                                        {{ item.categoryName }}
                                    </span>
                  <span class="flex items-center">
                                        <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                  d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                  d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
                                        </svg>
                                        {{ item.readNum }}
                                    </span>
                </div>
              </div>

              <!-- 标签 -->
              <div class="mt-4 flex flex-wrap gap-2" v-if="item.tags && item.tags.length > 0">
                                <span v-for="tag in item.tags" :key="tag.id"
                                      class="px-2 py-1 text-xs bg-gray-100 text-gray-600 rounded hover:bg-blue-100 hover:text-blue-600 cursor-pointer"
                                      @click="goTagArticleListPage(tag.id, tag.name)">
                                    {{ tag.name }}
                                </span>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- 无结果提示 -->
      <div v-else class="text-center py-20">
        <svg class="w-24 h-24 mx-auto text-gray-300 mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                d="M9.172 16.172a4 4 0 015.656 0M9 10h.01M15 10h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
        </svg>
        <p class="text-gray-500 text-lg">未找到相关文章</p>
        <p class="text-gray-400 text-sm mt-2">试试其他关键词吧</p>
      </div>

      <!-- 分页 -->
      <div v-if="total > 0" class="mt-8 flex justify-center">
        <el-pagination v-model:current-page="current" :page-size="size" :total="total"
                       :page-count="pages" layout="prev, pager, next" @current-change="handlePageChange"
                       background />
      </div>
    </div>

    <Footer></Footer>
  </div>
</template>

<script setup>
import Header from '@/layouts/components/Header.vue'
import Footer from '@/layouts/components/Footer.vue'
import { useRouter, useRoute } from 'vue-router'
import { ref, watch } from 'vue'
import { searchArticles } from '@/api/frontend/search'
import { getCategories } from '@/api/frontend/category'

const router = useRouter()
const route = useRoute()

const searchKey = ref(route.query.key || '')
const articles = ref([])
const current = ref(1)
const total = ref(0)
const size = ref(10)
const pages = ref(0)

// 获取搜索结果
function getSearchResults(currentNo) {
  if (!searchKey.value) {
    return
  }

  searchArticles({
    current: currentNo,
    size: size.value,
    searchKey: searchKey.value
  })
      .then((res) => {
        console.log(res)
        if (res.success == true) {
          articles.value = res.data
          current.value = res.current
          total.value = res.total
          pages.value = res.pages
        }
      })
}

// 监听路由变化
watch(() => route.query.key, (newKey) => {
  if (newKey) {
    searchKey.value = newKey
    current.value = 1
    getSearchResults(1)
  }
})

// 初始化搜索
if (searchKey.value) {
  getSearchResults(1)
}

// 分页处理
const handlePageChange = (page) => {
  getSearchResults(page)
  window.scrollTo(0, 0)
}

const goArticleDetail = (articleId) => {
  router.push({ path: '/article/detail', query: { articleId: articleId } })
}

const goTagArticleListPage = (id, name) => {
  router.push({ path: '/tag/list', query: { id: id, name: name } })
}

// 获取分类（用于侧边栏）
const categories = ref([])
getCategories().then((e) => {
  categories.value = e.data
})
</script>

<style scoped>
.line-clamp-2 {
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}
</style>
