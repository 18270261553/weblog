<template>
  <el-config-provider :locale="locale">
    <!-- 这一层包裹全局，实现白天黑夜自动切换 -->
    <div class="min-h-screen bg-white dark:bg-black text-gray-900 dark:text-white transition-colors duration-200">
      <router-view></router-view>
    </div>
  </el-config-provider>
</template>

<script setup>
import {defineComponent} from 'vue'
import zhCn from 'element-plus/dist/locale/zh-cn.mjs'

let locale = zhCn

// 初始化暗黑模式（页面一打开就读取本地存储）
if (localStorage.getItem('darkMode') === 'true') {
  document.documentElement.classList.add('dark')
} else {
  document.documentElement.classList.remove('dark')
}
</script>

<style>
body {
  font-family: -apple-system-font, BlinkMacSystemFont, "Helvetica Neue", "PingFang SC", "Hiragino Sans GB", "Microsoft YaHei UI", "Microsoft YaHei", Arial, sans-serif;
  color: #4c4e4d;
  font-size: 16px;
  background: #f4f4f4;
  line-height: 1.6;
  margin: 0; /* 去掉默认边距 */
}

/* 黑夜模式下 body 背景变黑 */
.dark body {
  background: #000 !important;
  color: #fff !important;
}

#nprogress .bar {
  background: #409eff !important;
}
</style>