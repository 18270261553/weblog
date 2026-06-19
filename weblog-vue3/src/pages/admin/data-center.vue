<script setup>
import { onMounted, ref, nextTick } from 'vue'
import * as echarts from 'echarts'

// 顶部核心指标数据
const topMetrics = ref({
  todayViews: 934700,
  todayUsers: 264700,
  todayNewUsers: 24930,
  totalUsers: 984520,
  todayComments: 84520,
  totalArticles: 84520
})

// 待处理事项数据
const pendingTasks = ref([
  { label: '评论审核', count: 89 },
  { label: '举报反馈', count: 23 },
  { label: '文章待审核', count: 15 },
  { label: '用户申诉', count: 7 }
])

// 快捷功能入口
const quickActions = ref([
  { name: '文章管理', icon: '📝' },
  { name: '用户管理', icon: '👥' },
  { name: '评论管理', icon: '💬' },
  { name: '分类管理', icon: '📂' },
  { name: '标签管理', icon: '🏷️' },
  { name: '系统设置', icon: '⚙️' }
])

let chart1, chart2

// 打开航天中控大屏（新窗口）
const openFullScreen = () => {
  window.open('/#/screenView', '_blank')
}

onMounted(() => {
  nextTick(() => {
    initCharts()
  })
})

const initCharts = () => {
  // 1. 月度访问/发布趋势柱状图
  chart1 = echarts.init(document.getElementById('chart-monthly'))
  chart1.setOption({
    tooltip: { trigger: 'axis' },
    grid: { left: '3%', right: '4%', bottom: '3%', containLabel: true },
    xAxis: {
      type: 'category',
      data: ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月']
    },
    yAxis: { type: 'value' },
    legend: { data: ['文章阅读量', '文章发布量'] },
    series: [
      {
        name: '文章阅读量',
        type: 'bar',
        data: [320, 332, 301, 434, 390, 330, 320, 300, 340, 390, 320, 330],
        itemStyle: { color: '#5B8FF9' }
      },
      {
        name: '文章发布量',
        type: 'bar',
        data: [210, 180, 190, 230, 290, 220, 190, 230, 260, 290, 220, 180],
        itemStyle: { color: '#61DDAA' }
      }
    ]
  })

  // 2. 年度用户增长/活跃度趋势图
  chart2 = echarts.init(document.getElementById('chart-yearly'))
  chart2.setOption({
    tooltip: { trigger: 'axis' },
    grid: { left: '3%', right: '4%', bottom: '3%', containLabel: true },
    xAxis: {
      type: 'category',
      boundaryGap: false,
      data: ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月']
    },
    yAxis: { type: 'value' },
    legend: { data: ['活跃用户', '新增用户'] },
    series: [
      {
        name: '活跃用户',
        type: 'line',
        areaStyle: { color: 'rgba(91, 143, 249, 0.3)' },
        data: [120, 132, 101, 134, 90, 230, 210, 100, 220, 210, 200, 230],
        itemStyle: { color: '#5B8FF9' }
      },
      {
        name: '新增用户',
        type: 'line',
        areaStyle: { color: 'rgba(97, 221, 170, 0.3)' },
        data: [230, 250, 180, 260, 190, 450, 320, 180, 450, 420, 410, 520],
        itemStyle: { color: '#61DDAA' }
      }
    ]
  })
}
</script>

<template>
  <div class="dashboard-wrapper">
    <!-- 右上角跳转按钮 新增部分 -->
    <button class="screen-btn" @click="openFullScreen">
      🚀 进入航天中控大屏
    </button>

    <!-- 顶部核心数据区 -->
    <div class="top-section">
      <!-- 左侧大卡片：核心数据概览 -->
      <div class="main-card">
        <div class="main-card-icon">
          <svg width="64" height="64" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path d="M14 2H6C4.9 2 4.01 2.9 4.01 4L4 20C4 21.1 4.89 22 5.99 22H18C19.1 22 20 21.1 20 20V8L14 2Z" stroke="white" stroke-width="2"/>
            <path d="M14 2V8H20" stroke="white" stroke-width="2"/>
            <path d="M8 13H16" stroke="white" stroke-width="2"/>
            <path d="M8 17H16" stroke="white" stroke-width="2"/>
          </svg>
        </div>
        <div class="main-card-content">
          <p class="card-title">WeBlog 全站核心数据</p>
          <h2 class="card-big-value">1523.53w</h2>
          <div class="card-sub-items">
            <div class="sub-item">
              <p class="sub-label">今日阅读</p>
              <p class="sub-value">53w</p>
            </div>
            <div class="sub-item">
              <p class="sub-label">今日新增用户</p>
              <p class="sub-value">53w</p>
            </div>
            <div class="sub-item">
              <p class="sub-label">今日评论数</p>
              <p class="sub-value">53w</p>
            </div>
          </div>
        </div>
      </div>

      <!-- 右侧迷你指标卡片组 -->
      <div class="mini-cards">
        <div class="mini-card">
          <div class="mini-card-icon user"></div>
          <div class="mini-card-content">
            <p class="mini-value">{{ (topMetrics.todayViews / 10000).toFixed(1) }}w</p>
            <p class="mini-label">今日阅读量</p>
          </div>
        </div>
        <div class="mini-card">
          <div class="mini-card-icon comment"></div>
          <div class="mini-card-content">
            <p class="mini-value">{{ (topMetrics.todayUsers / 10000).toFixed(1) }}w</p>
            <p class="mini-label">今日活跃用户</p>
          </div>
        </div>
        <div class="mini-card">
          <div class="mini-card-icon newuser"></div>
          <div class="mini-card-content">
            <p class="mini-value">{{ (topMetrics.todayNewUsers / 10000).toFixed(2) }}w</p>
            <p class="mini-label">今日新增用户</p>
          </div>
        </div>
        <div class="mini-card">
          <div class="mini-card-icon totaluser"></div>
          <div class="mini-card-content">
            <p class="mini-value">{{ (topMetrics.totalUsers / 10000).toFixed(1) }}w</p>
            <p class="mini-label">总用户数</p>
          </div>
        </div>
      </div>
    </div>

    <!-- 中间图表区 -->
    <div class="charts-section">
      <div class="chart-card">
        <h3 class="chart-title">月度访问/发布趋势</h3>
        <div id="chart-monthly" class="chart"></div>
      </div>
      <div class="chart-card">
        <h3 class="chart-title">年度用户增长/活跃度趋势</h3>
        <div id="chart-yearly" class="chart"></div>
      </div>
    </div>

    <!-- 下方内容区：左侧表格 + 右侧快捷入口 -->
    <div class="bottom-section">
      <!-- 左侧：文章列表 -->
      <div class="table-card">
        <h3 class="table-title">热门文章列表</h3>
        <table class="article-table">
          <thead>
          <tr>
            <th>文章标题</th>
            <th>分类</th>
            <th>阅读量</th>
            <th>评论数</th>
            <th>发布时间</th>
            <th>状态</th>
            <th>操作</th>
          </tr>
          </thead>
          <tbody>
          <tr>
            <td>Vue3 入门到精通实战教程</td>
            <td>技术</td>
            <td>3221</td>
            <td>53</td>
            <td>2026-04-20</td>
            <td><span class="status online">已上线</span></td>
            <td>
              <button class="btn-edit">✏️</button>
              <button class="btn-delete">🗑️</button>
            </td>
          </tr>
          <tr>
            <td>SpringBoot 项目最佳实践</td>
            <td>后端</td>
            <td>3360</td>
            <td>44</td>
            <td>2026-04-18</td>
            <td><span class="status online">已上线</span></td>
            <td>
              <button class="btn-edit">✏️</button>
              <button class="btn-delete">🗑️</button>
            </td>
          </tr>
          <tr>
            <td>Java 面试题整理（2026版）</td>
            <td>面试</td>
            <td>5380</td>
            <td>24</td>
            <td>2026-04-15</td>
            <td><span class="status offline">已下线</span></td>
            <td>
              <button class="btn-edit">✏️</button>
              <button class="btn-delete">🗑️</button>
            </td>
          </tr>
          </tbody>
        </table>
      </div>

      <!-- 右侧：待处理 + 快捷功能 -->
      <div class="sidebar">
        <!-- 待处理事项 -->
        <div class="pending-card">
          <h3 class="sidebar-title">待处理事项</h3>
          <div class="pending-list">
            <div v-for="item in pendingTasks" :key="item.label" class="pending-item">
              <span>{{ item.label }}</span>
              <span class="count">{{ item.count }} 条 →</span>
            </div>
          </div>
        </div>

        <!-- 常用功能入口 -->
        <div class="quick-action-card">
          <h3 class="sidebar-title">常用功能</h3>
          <div class="action-grid">
            <div v-for="action in quickActions" :key="action.name" class="action-item">
              <span class="icon">{{ action.icon }}</span>
              <span class="name">{{ action.name }}</span>
            </div>
          </div>
        </div>

        <!-- 公告栏 -->
        <div class="notice-card">
          <h3 class="sidebar-title">公告栏</h3>
          <div class="notice-content">
            <p class="notice-item">【系统维护】本周日凌晨2点进行数据库优化维护，预计时长2小时</p>
            <p class="notice-item">【新功能】已上线文章AI润色功能，可在编辑页体验</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.dashboard-wrapper {
  background-color: #f5f7fa;
  padding: 20px;
  min-height: 100vh;
  position: relative;
}

/* 新增大屏跳转按钮样式 */
.screen-btn {
  position: absolute;
  top: 20px;
  right: 20px;
  background: linear-gradient(135deg, #165DFF 0%, #0040C9 100%);
  color: white;
  border: none;
  border-radius: 8px;
  padding: 10px 20px;
  font-size: 16px;
  font-weight: bold;
  cursor: pointer;
  box-shadow: 0 4px 12px rgba(22, 93, 255, 0.4);
  transition: all 0.3s;
  z-index: 999;
}
.screen-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 6px 20px rgba(22, 93, 255, 0.6);
}

/* 原有样式完全保留 */
.top-section {
  display: flex;
  gap: 20px;
  margin-bottom: 20px;
}
.main-card {
  flex: 2;
  background: linear-gradient(135deg, #5B8FF9 0%, #73A6FF 100%);
  border-radius: 12px;
  padding: 24px;
  color: white;
  display: flex;
  align-items: center;
  gap: 20px;
}
.main-card-icon {
  width: 80px;
  height: 80px;
  background: rgba(255,255,255,0.15);
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
}
.main-card-content .card-title {
  font-size: 16px;
  margin: 0 0 8px;
  opacity: 0.9;
}
.main-card-content .card-big-value {
  font-size: 32px;
  margin: 0 0 16px;
  font-weight: bold;
}
.card-sub-items {
  display: flex;
  gap: 40px;
}
.sub-item .sub-label {
  font-size: 14px;
  opacity: 0.8;
  margin: 0 0 4px;
}
.sub-item .sub-value {
  font-size: 20px;
  margin: 0;
  font-weight: bold;
}

.mini-cards {
  flex: 1;
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 15px;
}
.mini-card {
  background: white;
  border-radius: 12px;
  padding: 20px;
  display: flex;
  align-items: center;
  gap: 15px;
  box-shadow: 0 2px 12px rgba(0,0,0,0.05);
}
.mini-card-icon {
  width: 40px;
  height: 40px;
  border-radius: 8px;
}
.mini-card-icon.user { background: #E6F7FF; }
.mini-card-icon.comment { background: #FFF7E6; }
.mini-card-icon.newuser { background: #F6FFED; }
.mini-card-icon.totaluser { background: #F9F0FF; }
.mini-card-content .mini-value {
  font-size: 22px;
  font-weight: bold;
  margin: 0 0 4px;
  color: #333;
}
.mini-card-content .mini-label {
  font-size: 14px;
  margin: 0;
  color: #666;
}

.charts-section {
  display: flex;
  gap: 20px;
  margin-bottom: 20px;
}
.chart-card {
  flex: 1;
  background: white;
  border-radius: 12px;
  padding: 20px;
  box-shadow: 0 2px 12px rgba(0,0,0,0.05);
}
.chart-title {
  font-size: 16px;
  margin: 0 0 16px;
  color: #333;
}
.chart {
  width: 100%;
  height: 300px;
}

.bottom-section {
  display: flex;
  gap: 20px;
}
.table-card {
  flex: 2;
  background: white;
  border-radius: 12px;
  padding: 20px;
  box-shadow: 0 2px 12px rgba(0,0,0,0.05);
}
.table-title {
  font-size: 16px;
  margin: 0 0 16px;
  color: #333;
}
.article-table {
  width: 100%;
  border-collapse: collapse;
}
.article-table th {
  text-align: left;
  padding: 12px 8px;
  color: #666;
  font-weight: 500;
  border-bottom: 1px solid #eee;
}
.article-table td {
  padding: 12px 8px;
  color: #333;
  border-bottom: 1px solid #f5f5f5;
}
.status {
  padding: 4px 12px;
  border-radius: 4px;
  font-size: 12px;
}
.status.online { background: #F6FFED; color: #52C41A; }
.status.offline { background: #FFF2F0; color: #FF4D4F; }
.btn-edit, .btn-delete {
  background: none;
  border: none;
  cursor: pointer;
  margin: 0 4px;
}

.sidebar {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 15px;
}
.pending-card, .quick-action-card, .notice-card {
  background: white;
  border-radius: 12px;
  padding: 20px;
  box-shadow: 0 2px 12px rgba(0,0,0,0.05);
}
.sidebar-title {
  font-size: 16px;
  margin: 0 0 16px;
  color: #333;
}
.pending-list .pending-item {
  display: flex;
  justify-content: space-between;
  padding: 10px 0;
  border-bottom: 1px solid #f5f5f5;
}
.count { color: #5B8FF9; }
.action-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 15px;
}
.action-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 15px 10px;
  border-radius: 8px;
  background: #f9fafc;
  cursor: pointer;
  transition: all 0.2s;
}
.action-item:hover { background: #f0f7ff; }
.action-item .icon { font-size: 24px; margin-bottom: 8px; }
.action-item .name { font-size: 14px; color: #333; }
.notice-content .notice-item {
  font-size: 14px;
  color: #666;
  margin: 0 0 10px;
  line-height: 1.5;
}
</style>