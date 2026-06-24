<template>
  <Header></Header>

  <div class="container mx-auto max-w-screen-xl mt-5">
    <!-- ===== 页面标题 ===== -->
    <div class="mb-5 px-3">
      <h1 class="text-2xl font-bold text-gray-900 dark:text-white flex items-center gap-2">
        <span class="text-3xl">📂</span> 全部分类
        <span class="text-sm font-normal text-gray-400 ml-2">共 {{ categories.length }} 个分类</span>
      </h1>
      <p class="text-gray-500 dark:text-gray-400 text-sm mt-1">按分类浏览文章，快速找到你感兴趣的内容</p>
    </div>

    <div class="grid grid-cols-4">
      <!-- 左边栏 -->
      <div class="col-span-4 px-3 md:col-span-3 sm:col-span-4">
        <!-- ===== 分类网格（卡片式布局） ===== -->
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
          <div
              v-for="(item, index) in categories"
              :key="index"
              @click="goCatagoryArticleListPage(item.id, item.name)"
              class="group bg-white border border-gray-200 rounded-lg p-5 hover:shadow-lg hover:border-blue-400 transition-all duration-300 cursor-pointer dark:bg-gray-800 dark:border-gray-700 dark:hover:border-blue-500"
          >
            <div class="flex items-start justify-between">
              <div class="flex-1">
                <!-- 分类图标 -->
                <div class="w-12 h-12 rounded-lg bg-blue-50 dark:bg-blue-900/30 flex items-center justify-center mb-3 group-hover:scale-110 transition-transform">
                  <svg class="w-6 h-6 text-blue-600 dark:text-blue-400" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 21 18">
                    <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="0.9"
                          d="M2.539 17h12.476l4-9H5m-2.461 9a1 1 0 0 1-.914-1.406L5 8m-2.461 9H2a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h5.443a1 1 0 0 1 .8.4l2.7 3.6H16a1 1 0 0 1 1 1v2H5" />
                  </svg>
                </div>
                <!-- 分类名称 -->
                <h3 class="text-lg font-semibold text-gray-900 dark:text-white group-hover:text-blue-600 dark:group-hover:text-blue-400 transition-colors">
                  {{ item.name }}
                </h3>
                <!-- 文章数量（如果有） -->
                <p class="text-sm text-gray-400 mt-1">{{ item.articleCount || 0 }} 篇文章</p>
              </div>
              <!-- 箭头 -->
              <svg class="w-5 h-5 text-gray-300 group-hover:text-blue-500 group-hover:translate-x-1 transition-all" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
              </svg>
            </div>
          </div>
        </div>

        <!-- ===== 空状态 ===== -->
        <div v-if="categories.length === 0" class="text-center py-12">
          <p class="text-gray-400">暂无分类</p>
        </div>
      </div>

      <!-- 右边栏 -->
      <div class="col-span-4 px-3 md:col-span-1 sm:col-span-4">
        <div class="sticky top-21">
          <UserInfoCard></UserInfoCard>

          <!-- 热门标签（可选） -->
          <div class="mt-3 w-full font-medium p-5 bg-white border border-gray-200 rounded-lg dark:bg-gray-800 dark:border-gray-700">
            <h2 class="mb-2 font-bold text-gray-900 uppercase dark:text-white">热门标签</h2>
            <div class="flex flex-wrap gap-2">
                            <span v-for="tag in hotTags" :key="tag.id"
                                  class="px-3 py-1 text-xs bg-gray-100 dark:bg-gray-700 rounded-full text-gray-600 dark:text-gray-300 cursor-pointer hover:bg-blue-100 dark:hover:bg-blue-900 transition-colors">
                                {{ tag.name }}
                            </span>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <Footer></Footer>
</template>

<script setup>
import Header from '@/layouts/components/Header.vue'
import Footer from '@/layouts/components/Footer.vue'
import UserInfoCard from '@/components/UserInfoCard.vue'
import { useRouter } from 'vue-router'
import { getCategories } from '@/api/frontend/category'
import { getTags } from '@/api/frontend/tag'
import { ref, onMounted } from 'vue'

const router = useRouter()

const goCatagoryArticleListPage = (id, name) => {
  router.push({ path: '/category/list', query: { id: id, name: name } })
}

const categories = ref([])
const hotTags = ref([])

onMounted(async () => {
  try {
    const res = await getCategories()
    if (res.success) {
      categories.value = res.data
    }

    // 获取标签（可选）
    const tagRes = await getTags()
    if (tagRes.success) {
      hotTags.value = tagRes.data.slice(0, 10) // 只取前10个
    }
  } catch (e) {
    console.error('加载分类失败', e)
  }
})
</script>