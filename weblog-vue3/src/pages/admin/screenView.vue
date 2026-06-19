<script setup>
import { onMounted, ref, nextTick } from 'vue'

// 核心静态数据
const coreData = ref({
  onlineUser: 168,
  totalUser: 12580,
  totalArticle: 860,
  totalView: 1865200,
  todayView: 24930,
  todayComment: 8452
})

// 实时访客列表
const visitorList = ref([
  { time: '02:15:12', ip: '110.182.xxx.xx', area: '四川成都', page: 'Vue3入门教程', source: '百度' },
  { time: '02:15:10', ip: '221.226.xxx.xx', area: '江苏苏州', page: 'SpringBoot实战', source: '直接访问' },
  { time: '02:15:08', ip: '120.24.xxx.xx', area: '广东深圳', page: 'Java面试题', source: '谷歌' },
  { time: '02:15:05', ip: '114.248.xxx.xx', area: '北京朝阳', page: 'MySQL优化', source: '知乎' },
  { time: '02:15:02', ip: '117.136.xxx.xx', area: '上海浦东', page: 'Git教程', source: 'B站' },
])

let mapChart, trendChart, typeChart, rankChart, sourceChart, warnChart

onMounted(() => {
  nextTick(() => {
    initAllCharts()
    startAnimation()
  })
})

const initAllCharts = () => {
  const echarts = window.echarts

  // 1. 全国用户分布地图
  mapChart = echarts.init(document.getElementById('map-chart'))
  const mapData = [
    { name: '北京', value: 2542 },
    { name: '上海', value: 3251 },
    { name: '广东', value: 4852 },
    { name: '江苏', value: 3654 },
    { name: '浙江', value: 2987 },
    { name: '四川', value: 2145 },
    { name: '山东', value: 1854 },
    { name: '湖北', value: 1654 },
    { name: '福建', value: 1542 },
    { name: '陕西', value: 1245 },
  ]
  const cityCoord = {
    '北京': [116.46, 39.92],
    '上海': [121.48, 31.22],
    '广东': [113.27, 23.13],
    '江苏': [118.78, 32.04],
    '浙江': [120.19, 30.26],
    '四川': [104.06, 30.67],
    '山东': [117.00, 36.66],
    '湖北': [114.31, 30.52],
    '福建': [119.30, 26.08],
    '陕西': [108.95, 34.27]
  }

  mapChart.setOption({
    backgroundColor: 'transparent',
    tooltip: { trigger: 'item', formatter: '{b}<br/>访问用户数：{c} 人' },
    geo: {
      map: 'china',
      roam: false,
      zoom: 1.2,
      label: { show: true, color: '#fff', fontSize: 10 },
      itemStyle: {
        areaColor: 'rgba(14, 37, 89, 0.6)',
        borderColor: '#0091ff',
        borderWidth: 1,
        shadowColor: 'rgba(0, 145, 255, 0.5)',
        shadowBlur: 10
      },
      emphasis: {
        itemStyle: { areaColor: 'rgba(0, 145, 255, 0.3)', borderColor: '#00ffff' }
      }
    },
    series: [
      { name: '访问用户数', type: 'map', geoIndex: 0, data: mapData },
      {
        type: 'effectScatter',
        coordinateSystem: 'geo',
        data: mapData.map(item => ({
          name: item.name,
          value: [...cityCoord[item.name], item.value]
        })),
        symbolSize: val => val[2] / 300 + 8,
        rippleEffect: { brushType: 'stroke', scale: 4, period: 3 },
        itemStyle: { color: '#00ffff', shadowBlur: 10 }
      }
    ]
  })

  // 2. 24小时访问趋势
  trendChart = echarts.init(document.getElementById('trend-chart'))
  trendChart.setOption({
    backgroundColor: 'transparent',
    tooltip: { trigger: 'axis' },
    grid: { left: '3%', right: '4%', bottom: '3%', containLabel: true },
    xAxis: {
      type: 'category',
      data: ['0时','2时','4时','6时','8时','10时','12时','14时','16时','18时','20时','22时','24时'],
      axisLine: { lineStyle: { color: '#0091ff' } },
      axisLabel: { color: '#a0cfff' }
    },
    yAxis: {
      type: 'value',
      axisLine: { lineStyle: { color: '#0091ff' } },
      axisLabel: { color: '#a0cfff' },
      splitLine: { lineStyle: { color: 'rgba(0, 145, 255, 0.1)' } }
    },
    series: [{
      data: [120, 90, 80, 100, 150, 280, 350, 320, 380, 420, 390, 280, 200],
      type: 'bar',
      itemStyle: {
        color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
          { offset: 0, color: '#00ffff' },
          { offset: 1, color: '#0091ff' }
        ])
      }
    }]
  })

  // 3. 文章分类饼图
  typeChart = echarts.init(document.getElementById('type-chart'))
  typeChart.setOption({
    backgroundColor: 'transparent',
    tooltip: { trigger: 'item' },
    legend: { bottom: '0', textStyle: { color: '#a0cfff' } },
    series: [{
      type: 'pie',
      radius: ['40%', '70%'],
      center: ['50%', '40%'],
      data: [
        { value: 320, name: '技术' },
        { value: 240, name: '后端' },
        { value: 160, name: '前端' },
        { value: 100, name: '面试' },
        { value: 80, name: '生活' }
      ],
      itemStyle: {
        color: params => ['#0091ff','#00ffff','#73a6ff','#00d889','#ff7d00'][params.dataIndex],
        borderRadius: 5
      }
    }]
  })

  // 4. 热门文章TOP
  rankChart = echarts.init(document.getElementById('rank-chart'))
  rankChart.setOption({
    backgroundColor: 'transparent',
    tooltip: { trigger: 'axis' },
    grid: { left: '3%', right: '4%', bottom: '3%', containLabel: true },
    xAxis: {
      type: 'value',
      axisLine: { lineStyle: { color: '#0091ff' } },
      axisLabel: { color: '#a0cfff' }
    },
    yAxis: {
      type: 'category',
      data: ['Vue入门','SpringBoot','MySQL优化','Redis实战','Java面试','MyBatis','Git教程'],
      inverse: true,
      axisLine: { lineStyle: { color: '#0091ff' } },
      axisLabel: { color: '#a0cfff' }
    },
    series: [{
      data: [320, 302, 287, 260, 241, 238, 220],
      type: 'bar',
      itemStyle: {
        color: new echarts.graphic.LinearGradient(1, 0, 0, 0, [
          { offset: 0, color: '#0091ff' },
          { offset: 1, color: '#00ffff' }
        ])
      }
    }]
  })

  // 5. 访问来源环形图
  sourceChart = echarts.init(document.getElementById('source-chart'))
  sourceChart.setOption({
    backgroundColor: 'transparent',
    tooltip: { trigger: 'item' },
    series: [{
      type: 'pie',
      radius: ['50%', '70%'],
      data: [
        { value: 42, name: '直接访问' },
        { value: 28, name: '搜索引擎' },
        { value: 15, name: '社交媒体' },
        { value: 10, name: '外链跳转' },
        { value: 5, name: '其他' }
      ],
      itemStyle: {
        color: params => ['#0091ff','#00ffff','#73a6ff','#00d889','#ff7d00'][params.dataIndex]
      },
      label: { color: '#fff', fontSize: 12 }
    }]
  })

  // 6. 访问趋势预警
  warnChart = echarts.init(document.getElementById('warn-chart'))
  warnChart.setOption({
    backgroundColor: 'transparent',
    tooltip: { trigger: 'axis' },
    grid: { left: '3%', right: '4%', bottom: '3%', containLabel: true },
    xAxis: {
      type: 'category',
      data: ['周一','周二','周三','周四','周五','周六','周日'],
      axisLine: { lineStyle: { color: '#0091ff' } },
      axisLabel: { color: '#a0cfff' }
    },
    yAxis: {
      type: 'value',
      axisLine: { lineStyle: { color: '#0091ff' } },
      axisLabel: { color: '#a0cfff' },
      splitLine: { lineStyle: { color: 'rgba(0, 145, 255, 0.1)' } }
    },
    series: [
      {
        name: '访问量',
        type: 'line',
        smooth: true,
        data: [120, 132, 151, 142, 165, 188, 200],
        itemStyle: { color: '#00ffff' },
        lineStyle: { width: 2 }
      },
      {
        name: '预警线',
        type: 'line',
        smooth: true,
        data: [180, 180, 180, 180, 180, 180, 180],
        itemStyle: { color: '#ff4d4f' },
        lineStyle: { type: 'dashed', width: 1 },
        symbol: 'none'
      }
    ]
  })
}

// 访客滚动动画
const startAnimation = () => {
  setInterval(() => {
    const first = visitorList.value.shift()
    visitorList.value.push(first)
  }, 3000)
}
</script>

<template>
  <div class="screen-container">
    <div class="stars"></div>
    <div class="stars2"></div>

    <div class="header">
      <div class="header-border left"></div>
      <h1 class="title">🚀 WeBlog 全站运营航天中控大屏</h1>
      <div class="header-border right"></div>
      <div class="header-total">
        <span>全站累计访问量</span>
        <span class="num">{{ coreData.totalView.toLocaleString() }}</span>
      </div>
    </div>

    <div class="main-layout">
      <div class="left-panel">
        <div class="card-group">
          <div class="core-card">
            <p class="card-label">当前在线用户</p>
            <h3 class="card-num">{{ coreData.onlineUser }}</h3>
          </div>
          <div class="core-card">
            <p class="card-label">累计注册用户</p>
            <h3 class="card-num">{{ coreData.totalUser.toLocaleString() }}</h3>
          </div>
          <div class="core-card">
            <p class="card-label">全站文章总数</p>
            <h3 class="card-num">{{ coreData.totalArticle }}</h3>
          </div>
          <div class="core-card">
            <p class="card-label">今日访问量</p>
            <h3 class="card-num">{{ coreData.todayView.toLocaleString() }}</h3>
          </div>
        </div>

        <div class="chart-card">
          <div class="card-header"><span class="card-title">>> 24小时访问量趋势 <<</span></div>
          <div id="trend-chart" class="chart"></div>
        </div>

        <div class="chart-card">
          <div class="card-header"><span class="card-title">>> 文章分类占比分布 <<</span></div>
          <div id="type-chart" class="chart"></div>
        </div>
      </div>

      <div class="center-panel">
        <div class="map-card">
          <div class="map-header"><span class="map-title">全国用户访问分布地图</span></div>
          <div id="map-chart" class="map-chart"></div>
          <div class="map-center-data">
            <div class="center-num">{{ coreData.todayView.toLocaleString() }}</div>
            <div class="center-label">今日总访问</div>
          </div>
        </div>

        <div class="visitor-card">
          <div class="card-header"><span class="card-title">>> 实时访客追踪 <<</span></div>
          <div class="visitor-table">
            <div class="visitor-header">
              <span>访问时间</span>
              <span>IP地址</span>
              <span>归属地</span>
              <span>访问页面</span>
              <span>来源</span>
            </div>
            <div class="visitor-body">
              <div v-for="(item, index) in visitorList" :key="index" class="visitor-row">
                <span>{{ item.time }}</span>
                <span>{{ item.ip }}</span>
                <span>{{ item.area }}</span>
                <span>{{ item.page }}</span>
                <span>{{ item.source }}</span>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="right-panel">
        <div class="chart-card">
          <div class="card-header"><span class="card-title">>> 历史访问趋势预警 <<</span></div>
          <div id="warn-chart" class="chart"></div>
        </div>
        <div class="chart-card">
          <div class="card-header"><span class="card-title">>> 热门文章TOP排行 <<</span></div>
          <div id="rank-chart" class="chart"></div>
        </div>
        <div class="chart-card">
          <div class="card-header"><span class="card-title">>> 访问来源分布 <<</span></div>
          <div id="source-chart" class="chart"></div>
        </div>
        <div class="warn-card">
          <div class="card-header"><span class="card-title">>> 系统异常预警 <<</span></div>
          <div class="warn-list">
            <div class="warn-item danger">
              <span class="warn-dot"></span>
              <span>【高风险】检测到异常IP高频访问，已拦截</span>
            </div>
            <div class="warn-item warning">
              <span class="warn-dot"></span>
              <span>【中风险】服务器CPU使用率超过80%</span>
            </div>
            <div class="warn-item normal">
              <span class="warn-dot"></span>
              <span>【正常】数据库连接池状态正常</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
* { margin: 0; padding: 0; box-sizing: border-box; }
.screen-container {
  width: 100vw;
  height: 100vh;
  background: #030c20;
  overflow: hidden;
  position: relative;
  color: #fff;
  font-family: "Microsoft YaHei", sans-serif;
}
.stars,.stars2{position:absolute;top:0;left:0;width:100%;height:100%;background-image:radial-gradient(2px 2px at 20px 30px,#fff,transparent),radial-gradient(2px 2px at 60px 70px,#00ffff,transparent),radial-gradient(1px 1px at 50px 160px,#fff,transparent),radial-gradient(1px 1px at 130px 80px,#0091ff,transparent),radial-gradient(2px 2px at 90px 10px,#fff,transparent);background-repeat:repeat;background-size:200px 200px;animation:starMove 100s linear infinite;z-index:0;}
.stars2{background-size:300px 300px;animation:starMove 150s linear infinite reverse;opacity:0.6;}
@keyframes starMove{from{transform:translateY(0);}to{transform:translateY(-1000px);}}
.header{width:100%;height:80px;display:flex;align-items:center;justify-content:center;position:relative;z-index:10;}
.header-border{width:30%;height:2px;background:linear-gradient(90deg,transparent,#0091ff,transparent);}
.header-border.left{margin-right:20px;}
.header-border.right{margin-left:20px;}
.title{font-size:28px;font-weight:bold;background:linear-gradient(90deg,#00ffff,#0091ff);-webkit-background-clip:text;background-clip:text;color:transparent;}
.header-total{position:absolute;right:40px;top:50%;transform:translateY(-50%);display:flex;flex-direction:column;align-items:flex-end;}
.header-total span:first-child{font-size:14px;color:#a0cfff;}
.header-total .num{font-size:24px;font-weight:bold;color:#00ffff;letter-spacing:2px;}
.main-layout{width:100%;height:calc(100vh - 100px);display:flex;gap:15px;padding:0 15px;position:relative;z-index:10;}
.left-panel,.right-panel{width:24%;display:flex;flex-direction:column;gap:15px;}
.center-panel{width:52%;display:flex;flex-direction:column;gap:15px;}
.card-group{display:grid;grid-template-columns:1fr 1fr;gap:12px;}
.core-card{background:linear-gradient(135deg,rgba(0,145,255,0.15),rgba(0,255,255,0.1));border:1px solid rgba(0,145,255,0.4);border-radius:8px;padding:15px;position:relative;}
.core-card::before,.core-card::after{content:'';position:absolute;width:15px;height:15px;border:2px solid #00ffff;}
.core-card::before{top:-2px;left:-2px;border-right:none;border-bottom:none;}
.core-card::after{bottom:-2px;right:-2px;border-left:none;border-top:none;}
.card-label{font-size:14px;color:#a0cfff;margin:0 0 8px;}
.card-num{font-size:24px;font-weight:bold;color:#00ffff;margin:0;text-shadow:0 0 10px rgba(0,255,255,0.5);}
.chart-card,.map-card,.visitor-card,.warn-card{background:linear-gradient(135deg,rgba(0,145,255,0.1),rgba(0,145,255,0.05));border:1px solid rgba(0,145,255,0.3);border-radius:8px;padding:15px;flex:1;position:relative;}
.chart-card::before,.map-card::before,.visitor-card::before,.warn-card::before{content:'';position:absolute;top:0;left:0;width:30%;height:2px;background:linear-gradient(90deg,#00ffff,transparent);}
.card-header{margin-bottom:10px;}
.card-title{font-size:16px;color:#00ffff;font-weight:bold;}
.chart{width:100%;height:calc(100% - 30px);}
.map-card{height:65%;position:relative;}
.map-header{text-align:center;margin-bottom:10px;}
.map-title{font-size:18px;font-weight:bold;background:linear-gradient(90deg,#00ffff,#0091ff);-webkit-background-clip:text;background-clip:text;color:transparent;}
.map-chart{width:100%;height:100%;}
.map-center-data{position:absolute;top:50%;left:50%;transform:translate(-50%,-50%);text-align:center;pointer-events:none;}
.center-num{font-size:36px;font-weight:bold;color:#00ffff;text-shadow:0 0 20px rgba(0,255,255,0.8);}
.center-label{font-size:14px;color:#a0cfff;margin-top:5px;}
.visitor-card{height:35%;}
.visitor-table{width:100%;height:calc(100% - 30px);display:flex;flex-direction:column;}
.visitor-header{display:grid;grid-template-columns:1fr 1.2fr 1fr 2fr 0.8fr;padding:8px 0;border-bottom:1px solid rgba(0,145,255,0.3);color:#00ffff;font-size:14px;font-weight:bold;}
.visitor-body{flex:1;overflow:hidden;}
.visitor-row{display:grid;grid-template-columns:1fr 1.2fr 1fr 2fr 0.8fr;padding:10px 0;border-bottom:1px solid rgba(0,145,255,0.1);color:#a0cfff;font-size:13px;}
.warn-list{height:calc(100% - 30px);display:flex;flex-direction:column;gap:10px;padding-top:5px;}
.warn-item{display:flex;align-items:center;gap:10px;padding:10px;background:rgba(0,145,255,0.1);border-radius:4px;font-size:13px;color:#a0cfff;}
.warn-item.danger{background:rgba(255,77,79,0.15);border-left:3px solid #ff4d4f;}
.warn-item.warning{background:rgba(255,125,0,0.15);border-left:3px solid #ff7d00;}
.warn-item.normal{background:rgba(0,216,137,0.15);border-left:3px solid #00d889;}
.warn-dot{width:8px;height:8px;border-radius:50%;background:#00ffff;}
.warn-item.danger .warn-dot{background:#ff4d4f;}
.warn-item.warning .warn-dot{background:#ff7d00;}
.warn-item.normal .warn-dot{background:#00d889;}
</style>