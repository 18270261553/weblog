import { fileURLToPath, URL } from 'node:url'

import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import WindiCSS from 'vite-plugin-windicss'
import path from 'node:path'
import AutoImport from 'unplugin-auto-import/vite'
import Components from 'unplugin-vue-components/vite'
import { ElementPlusResolver } from 'unplugin-vue-components/resolvers'
import compression from 'vite-plugin-compression'

// https://vitejs.dev/config/
export default defineConfig({
  server: {
    host: '0.0.0.0',
    allowedHosts: true,
    proxy: {
      '/api': {
        target: 'http://localhost:8081',
        hmr: false,
        changeOrigin: true,
        rewrite: (path) => path.replace(/^\/api/, ''),
      },
    },
  },
  plugins: [
    vue(),
    WindiCSS(),
    AutoImport({
      resolvers: [ElementPlusResolver()],
    }),
    Components({
      resolvers: [ElementPlusResolver()],
    }),
    // 新增：gzip 压缩插件，能显著减小打包后的文件体积
    compression({
      algorithm: 'gzip',
      ext: '.gz',
      threshold: 10240, // 10KB 以上的文件才压缩
    }),
  ],
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url)),
    },
  },
  // ========== 新增构建优化配置 ==========
  build: {
    // 开启 CSS 代码分割，避免将所有样式打包进一个文件
    cssCodeSplit: true,
    // 生成 sourcemap 文件（调试用，生产环境可关闭）
    sourcemap: false,
    // 打包后移除所有 console.log 和 debugger 语句（可选）
    // terserOptions: {
    //   compress: {
    //     drop_console: true,
    //     drop_debugger: true,
    //   },
    // },
    rollupOptions: {
      output: {
        // 更精细的代码分割策略
        manualChunks(id) {
          // 将 Vue 生态相关的库打包到一起
          if (id.includes('node_modules')) {
            if (id.includes('vue') || id.includes('@vue') || id.includes('vue-router') || id.includes('vuex') || id.includes('pinia')) {
              return 'vendor-vue'
            }
            // 将 Element Plus 单独打包
            if (id.includes('element-plus') || id.includes('@element-plus')) {
              return 'vendor-element'
            }
            // 其他第三方库
            return 'vendor'
          }
        },
        // 分块文件命名，便于缓存
        chunkFileNames: 'assets/js/[name]-[hash].js',
        entryFileNames: 'assets/js/[name]-[hash].js',
        assetFileNames: 'assets/[ext]/[name]-[hash].[ext]',
      },
    },
    // 增加 chunk 大小警告阈值，避免过度碎片化
    chunkSizeWarningLimit: 1000,
  },
  // 优化依赖预构建，能提升启动和热更新速度
  optimizeDeps: {
    include: ['vue', 'vue-router', 'vuex', 'element-plus', 'axios'],
  },
})