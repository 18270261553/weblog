<template>
  <el-container>
    <el-aside :width='$store.state.menuWidth'>
      <AdminMenu></AdminMenu>
    </el-aside>

    <el-container>
      <el-header>
        <AdminHeader></AdminHeader>
      </el-header>

      <el-main>
        <!-- ✅ 用 Suspense 或动态组件懒加载 -->
        <Suspense>
          <template #default>
            <AdminTagList />
          </template>
          <template #fallback>
            <div>加载中...</div>
          </template>
        </Suspense>
        <router-view v-slot="{ Component }">
          <Transition name="fade">
            <keep-alive :max="10">
              <component :is="Component"></component>
            </keep-alive>
          </Transition>
        </router-view>
      </el-main>

      <el-footer>
        <AdminFooter></AdminFooter>
      </el-footer>
    </el-container>
  </el-container>
</template>

<script setup>
import { defineAsyncComponent } from 'vue'

// ✅ 改成异步组件（懒加载）
const AdminHeader = defineAsyncComponent(() => import('@/layouts/components/AdminHeader.vue'))
const AdminMenu = defineAsyncComponent(() => import('@/layouts/components/AdminMenu.vue'))
const AdminTagList = defineAsyncComponent(() => import('@/layouts/components/AdminTagList.vue'))
const AdminFooter = defineAsyncComponent(() => import('@/layouts/components/AdminFooter.vue'))
</script>