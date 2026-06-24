<template>
  <div class="designer-portfolio">
    <!-- 动态背景层 -->
    <div class="background-layer">
      <img
          src="@/assets/10.jpg"
          alt="Futuristic Interior"
          class="bg-image"
      />
      <div class="overlay-gradient"></div>
      <div class="tech-grid"></div>

      <!-- 🌠 流星雨动态层 -->
      <div class="meteor-shower">
        <div v-for="n in 19" :key="n" class="meteor" :style="meteorStyles[n-1]"></div>
      </div>
    </div>

    <!-- 顶部导航栏 (固定常驻显示) -->
    <header class="navbar">
      <div class="logo">
        <span class="logo-icon">◈</span>
        <span class="logo-text">Tsundere <span class="highlight">小鲤鱼Blog</span></span>
      </div>
      <nav class="nav-links">
        <router-link to="/index" class="nav-item">首页</router-link>
        <!-- ===== AI 作品库 - 点击跳转到 AI 标签页 ===== -->
        <a href="#" class="nav-item" @click.prevent="goToAITagPage">AI 作品库</a>
        <a href="#" class="nav-item" @click.prevent="goToDeepLearningPage">深度学习</a>
        <router-link to="/about" class="nav-item">关于我</router-link>
      </nav>
      <div class="nav-actions">
        <button class="icon-btn">🔍</button>
        <button class="icon-btn">👤</button>
      </div>
    </header>

    <!-- 主体内容区 -->
    <main class="hero-section">
      <div class="content-wrapper">
        <div class="tag-pill">
          <span class="pulse-dot"></span>
          Deep Learning
        </div>

        <h1 class="main-title">
          <span class="line line-1">重塑空间</span>
          <span class="line line-2">探索未来</span>
        </h1>

        <p class="subtitle">
          融合深度学习算法与极致美学，为您呈现超越想象的空间设计方案。
          <br>
          <span class="typewriter-text">Initializing Neural Network...</span>
        </p>

        <div class="action-group">
          <button class="btn primary-btn">
            <router-link to="/explore">
              <span class="btn-icon">⚡</span>
              开始探索</router-link>
          </button>
          <button class="btn secondary-btn">
              <router-link to="/index">
                <span class="btn-icon">📂</span>
                查看案例
              </router-link>
          </button>
        </div>

        <!-- 底部数据展示 -->
        <div class="stats-bar">
          <div class="stat-item">
            <span class="stat-value">10K+</span>
            <span class="stat-label">模型训练</span>
          </div>
          <div class="stat-divider"></div>
          <div class="stat-item">
            <span class="stat-value">98%</span>
            <span class="stat-label">客户满意度</span>
          </div>
          <div class="stat-divider"></div>
          <div class="stat-item">
            <span class="stat-value">∞</span>
            <span class="stat-label">创意可能</span>
          </div>
        </div>
      </div>
    </main>

    <!-- 右侧浮动工具栏 -->
    <aside class="floating-tools">
      <div class="tool-item" title="切换主题">🌗</div>
      <div class="tool-item" title="设置">⚙️</div>
    </aside>
  </div>
</template>

<script setup>
import { useRouter } from 'vue-router'

const router = useRouter()

// ===== 跳转到 AI 标签页 =====
const goToAITagPage = () => {
  router.push({
    path: '/tag/list',
    query: {
      id: 4,      // AI 标签的 ID（请确认你的数据库中 AI 标签的实际 ID）
      name: 'AI'
    }
  })
}

// ===== 跳转到深度学习标签页 =====
const goToDeepLearningPage = () => {
  router.push({
    path: '/tag/list',
    query: {
      id: 4,      // 如果"深度学习"也有对应的标签，可以改成对应的 ID
      name: '深度学习'
    }
  })
}

// 预计算流星样式参数
const meteorStyles = Array.from({ length: 15 }, (_, i) => ({
  animationDelay: `${(i * 1.7) % 12}s`,
  animationDuration: `${3 + (i % 4)}s`,
  top: `${(i * 13) % 85}%`,
  left: `${15 + (i * 31) % 85}%`,
  opacity: 0.5 + (i % 3) * 0.25
}))
</script>

<style scoped>
@import url('https://fonts.googleapis.com/css2?family=Orbitron:wght@400;700;900&family=Noto+Sans+SC:wght@300;400;700&display=swap');

/* 全局重置与容器 */
.designer-portfolio {
  position: relative;
  width: 100%;
  height: 100vh;
  overflow: hidden;
  font-family: 'Noto Sans SC', sans-serif;
  color: #ffffff;
  background-color: #050505;
}

/* 背景层处理 */
.background-layer {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  z-index: 0;
}

.bg-image {
  width: 100%;
  height: 100%;
  object-fit: cover;
  filter: brightness(0.6) contrast(1.1) saturate(0.8);
  transform: scale(1.05);
  animation: slowZoom 20s infinite alternate;
}

@keyframes slowZoom {
  from { transform: scale(1.05); }
  to { transform: scale(1.15); }
}

.overlay-gradient {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: linear-gradient(
      180deg,
      rgba(5, 5, 5, 0.3) 0%,
      rgba(5, 5, 5, 0.6) 50%,
      rgba(5, 5, 5, 0.95) 100%
  );
}

.tech-grid {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-image:
      linear-gradient(rgba(255, 255, 255, 0.03) 1px, transparent 1px),
      linear-gradient(90deg, rgba(255, 255, 255, 0.03) 1px, transparent 1px);
  background-size: 50px 50px;
  mask-image: radial-gradient(circle at center, black 40%, transparent 80%);
  -webkit-mask-image: radial-gradient(circle at center, black 40%, transparent 80%);
}

/* ================= 🌠 流星雨动态效果 ================= */
.meteor-shower {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  z-index: 1;
  pointer-events: none;
  overflow: hidden;
}

.meteor {
  position: absolute;
  width: 140px;
  height: 1px;
  background: linear-gradient(90deg, rgba(255, 255, 255, 0.9), transparent);
  animation: meteor-fall linear infinite;
  opacity: 0;
  transform: rotate(-45deg);
  transform-origin: right center;
}

.meteor::before {
  content: '';
  position: absolute;
  width: 4px;
  height: 4px;
  border-radius: 50%;
  background: #fff;
  box-shadow:
      0 0 8px 2px rgba(0, 242, 254, 0.9),
      0 0 16px 4px rgba(0, 242, 254, 0.5);
  top: 50%;
  right: 0;
  transform: translateY(-50%);
}

@keyframes meteor-fall {
  0% {
    transform: translateX(0) translateY(0) rotate(-45deg);
    opacity: 0;
  }
  5% { opacity: 1; }
  85% { opacity: 1; }
  100% {
    transform: translateX(-150vw) translateY(150vh) rotate(-45deg);
    opacity: 0;
  }
}
/* ========================================================== */

/* 顶部导航栏 (固定常驻) */
.navbar {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 20px 60px;
  backdrop-filter: blur(12px);
  background: rgba(5, 5, 5, 0.7);
  border-bottom: 1px solid rgba(255, 255, 255, 0.08);
  z-index: 100;
  pointer-events: auto;
}

.logo {
  display: flex;
  align-items: center;
  gap: 12px;
  font-family: 'Orbitron', sans-serif;
  font-size: 20px;
  font-weight: 700;
  letter-spacing: 2px;
}

.logo-icon {
  color: #00f2fe;
  font-size: 24px;
  text-shadow: 0 0 10px rgba(0, 242, 254, 0.5);
}

.highlight {
  color: #00f2fe;
}

.nav-links {
  display: flex;
  gap: 40px;
}

.nav-item {
  text-decoration: none;
  color: rgba(255, 255, 255, 0.7);
  font-size: 14px;
  font-weight: 500;
  letter-spacing: 1px;
  transition: all 0.3s;
  position: relative;
  cursor: pointer;
}

.nav-item:hover, .nav-item.active {
  color: #ffffff;
}

.nav-item.active::after {
  content: '';
  position: absolute;
  bottom: -6px;
  left: 0;
  width: 100%;
  height: 2px;
  background: #00f2fe;
  box-shadow: 0 0 8px #00f2fe;
}

.nav-actions {
  display: flex;
  gap: 16px;
}

.icon-btn {
  background: rgba(255, 255, 255, 0.1);
  border: 1px solid rgba(255, 255, 255, 0.1);
  color: white;
  width: 40px;
  height: 40px;
  border-radius: 50%;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: all 0.3s;
}

.icon-btn:hover {
  background: rgba(0, 242, 254, 0.2);
  border-color: #00f2fe;
}

/* 主体内容 */
.hero-section {
  position: relative;
  z-index: 5;
  min-height: 100vh;
  display: flex;
  align-items: center;
  padding: 100px 60px 60px; /* 顶部留出导航栏空间 */
}

.content-wrapper {
  max-width: 800px;
  width: 100%;
}

.tag-pill {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  padding: 8px 16px;
  background: rgba(0, 242, 254, 0.1);
  border: 1px solid rgba(0, 242, 254, 0.3);
  border-radius: 20px;
  font-size: 12px;
  font-family: 'Orbitron', sans-serif;
  letter-spacing: 2px;
  color: #00f2fe;
  margin-bottom: 24px;
  backdrop-filter: blur(4px);
}

.pulse-dot {
  width: 8px;
  height: 8px;
  background: #00f2fe;
  border-radius: 50%;
  animation: pulse 2s infinite;
}

@keyframes pulse {
  0% { box-shadow: 0 0 0 0 rgba(0, 242, 254, 0.7); }
  70% { box-shadow: 0 0 0 10px rgba(0, 242, 254, 0); }
  100% { box-shadow: 0 0 0 0 rgba(0, 242, 254, 0); }
}

.main-title {
  font-size: 72px;
  font-weight: 900;
  line-height: 1.1;
  margin-bottom: 24px;
  text-transform: uppercase;
  letter-spacing: -2px;
}

.line {
  display: block;
  background: linear-gradient(90deg, #ffffff, #a0a0a0);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.line-2 {
  background: linear-gradient(90deg, #00f2fe, #ffffff);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  opacity: 0.9;
}

.subtitle {
  font-size: 18px;
  color: rgba(255, 255, 255, 0.7);
  line-height: 1.6;
  margin-bottom: 40px;
  font-weight: 300;
}

.typewriter-text {
  font-family: 'Courier New', monospace;
  color: #00f2fe;
  font-size: 14px;
  opacity: 0.8;
  border-right: 2px solid #00f2fe;
  padding-right: 4px;
  animation: blink 1s step-end infinite;
}

@keyframes blink {
  50% { border-color: transparent; }
}

.action-group {
  display: flex;
  gap: 20px;
  margin-bottom: 60px;
}

.btn {
  padding: 16px 32px;
  border-radius: 4px;
  font-size: 16px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s;
  display: flex;
  align-items: center;
  gap: 10px;
  letter-spacing: 1px;
}

.primary-btn {
  background: #00f2fe;
  color: #000;
  border: none;
  box-shadow: 0 0 20px rgba(0, 242, 254, 0.3);
}

.primary-btn:hover {
  background: #fff;
  box-shadow: 0 0 30px rgba(0, 242, 254, 0.6);
  transform: translateY(-2px);
}

.secondary-btn {
  background: transparent;
  color: #fff;
  border: 1px solid rgba(255, 255, 255, 0.3);
}

.secondary-btn:hover {
  border-color: #fff;
  background: rgba(255, 255, 255, 0.1);
}

.stats-bar {
  display: flex;
  align-items: center;
  gap: 30px;
  padding-top: 30px;
  border-top: 1px solid rgba(255, 255, 255, 0.1);
}

.stat-item {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.stat-value {
  font-family: 'Orbitron', sans-serif;
  font-size: 24px;
  font-weight: 700;
  color: #fff;
}

.stat-label {
  font-size: 12px;
  color: rgba(255, 255, 255, 0.5);
  text-transform: uppercase;
  letter-spacing: 1px;
}

.stat-divider {
  width: 1px;
  height: 30px;
  background: rgba(255, 255, 255, 0.2);
}

.floating-tools {
  position: fixed;
  right: 30px;
  top: 50%;
  transform: translateY(-50%);
  display: flex;
  flex-direction: column;
  gap: 16px;
  z-index: 20;
}

.tool-item {
  width: 44px;
  height: 44px;
  background: rgba(0, 0, 0, 0.6);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.3s;
  backdrop-filter: blur(10px);
}

.tool-item:hover {
  background: rgba(0, 242, 254, 0.2);
  border-color: #00f2fe;
  transform: scale(1.1);
}

@media (max-width: 768px) {
  .navbar { padding: 16px 20px; }
  .nav-links { display: none; }
  .hero-section { padding: 90px 20px 40px; }
  .main-title { font-size: 42px; }
  .stats-bar { display: none; }
  .floating-tools { right: 15px; }
}
</style>