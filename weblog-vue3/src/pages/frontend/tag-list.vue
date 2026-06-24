<template>
  <Header></Header>

  <div class="container mx-auto max-w-screen-xl mt-5">
    <!-- ===== 页面标题 ===== -->
    <div class="mb-5 px-3">
      <h1 class="text-2xl font-bold text-gray-900 dark:text-white flex items-center gap-2">
        <span class="text-3xl">🏷️</span> 全部标签
        <span class="text-sm font-normal text-gray-400 ml-2">共 {{ tags.length }} 个标签</span>
      </h1>
      <p class="text-gray-500 dark:text-gray-400 text-sm mt-1">点击标签查看相关文章</p>
    </div>

    <div class="grid grid-cols-4">
      <!-- 左边栏 -->
      <div class="col-span-4 px-3 md:col-span-3 sm:col-span-4">
        <!-- ===== 标签网格（卡片式布局） ===== -->
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
          <div
              v-for="(item, index) in tags"
              :key="index"
              @click="goTagArticleListPage(item.id, item.name)"
              class="group bg-white border border-gray-200 rounded-lg p-5 hover:shadow-lg hover:border-blue-400 transition-all duration-300 cursor-pointer dark:bg-gray-800 dark:border-gray-700 dark:hover:border-blue-500"
          >
            <div class="flex items-start justify-between">
              <div class="flex-1">
                <!-- 标签图标 -->
                <div class="w-12 h-12 rounded-lg bg-green-50 dark:bg-green-900/30 flex items-center justify-center mb-3 group-hover:scale-110 transition-transform">
                  <svg class="w-6 h-6 text-green-600 dark:text-green-400" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 20 20">
                    <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                          d="M4 18h12M4 18V6a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v12M4 18H2M18 18h-2M6 10h8M6 14h4" />
                  </svg>
                </div>
                <!-- 标签名称 -->
                <h3 class="text-lg font-semibold text-gray-900 dark:text-white group-hover:text-green-600 dark:group-hover:text-green-400 transition-colors">
                  {{ item.name }}
                </h3>
                <!-- 文章数量 -->
                <p class="text-sm text-gray-400 mt-1">{{ item.articleCount || 0 }} 篇文章</p>
              </div>
              <!-- 箭头 -->
              <svg class="w-5 h-5 text-gray-300 group-hover:text-green-500 group-hover:translate-x-1 transition-all" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
              </svg>
            </div>
          </div>
        </div>

        <!-- ===== 空状态 ===== -->
        <div v-if="tags.length === 0" class="text-center py-12">
          <p class="text-gray-400">暂无标签</p>
        </div>
      </div>

      <!-- 右边栏 -->
      <div class="col-span-4 px-3 md:col-span-1 sm:col-span-4">
        <div class="sticky top-21">
          <UserInfoCard></UserInfoCard>

          <!-- 热门标签排行 -->
          <div class="mt-3 w-full p-5 bg-white border border-gray-200 rounded-lg dark:bg-gray-800 dark:border-gray-700">
            <h2 class="mb-3 font-bold text-gray-900 uppercase dark:text-white">🔥 热门标签</h2>
            <div class="space-y-1.5">
              <div
                  v-for="(item, index) in topTags"
                  :key="index"
                  @click="goTagArticleListPage(item.id, item.name)"
                  class="flex items-center justify-between px-3 py-2 rounded-lg cursor-pointer hover:bg-gray-100 dark:hover:bg-gray-700 transition-colors"
              >
                                <span class="text-sm text-gray-700 dark:text-gray-300">
                                    <span class="text-gray-400 mr-2">{{ index + 1 }}</span>
                                    {{ item.name }}
                                </span>
                <span class="text-xs text-gray-400">{{ item.articleCount || 0 }} 篇</span>
              </div>
              <div v-if="topTags.length === 0" class="text-center text-gray-400 text-sm py-4">
                暂无热门标签
              </div>
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
import { getTags } from '@/api/frontend/tag'
import { ref, computed } from 'vue'

const router = useRouter()

const goTagArticleListPage = (id, name) => {
  router.push({path: '/tag/list', query: {id: id, name: name}})
}

const tags = ref([])

// ===== 计算属性：按文章数量排序的前5个标签 =====
const topTags = computed(() => {
  return [...tags.value]
      .sort((a, b) => (b.articleCount || 0) - (a.articleCount || 0))
      .slice(0, 5)
})

// ===== 加载标签 =====
getTags().then((e) => {
  if (e.success) {
    tags.value = e.data
  }
})
</script>