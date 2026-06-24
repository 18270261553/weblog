<template>
  <div class="explore-page">
    <!-- 动态背景层 -->
    <div class="background-layer">
      <img
          src="@/assets/10.jpg"
          alt="Futuristic Background"
          class="bg-image"
      />
      <div class="overlay-gradient"></div>
      <div class="tech-grid"></div>

      <!-- 🌠 流星雨动态层 -->
      <div class="meteor-shower">
        <div v-for="n in 19" :key="n" class="meteor" :style="meteorStyles[n-1]"></div>
      </div>
    </div>

    <!-- 顶部导航栏 (与Home页一致) -->
    <header class="navbar">
      <div class="logo">
        <span class="logo-icon">◈</span>
        <span class="logo-text">Tsundere <span class="highlight">小鲤鱼Blog</span></span>
      </div>
      <nav class="nav-links">
        <router-link to="/index" class="nav-item">首页</router-link>
        <a href="#" class="nav-item" @click.prevent="goToAITagPage">AI 作品库</a>
        <a href="#" class="nav-item" @click.prevent="goToDeepLearningPage">深度学习</a>
        <router-link to="/about" class="nav-item">关于我</router-link>
      </nav>
      <div class="nav-actions">
        <button class="icon-btn">🔍</button>
        <button class="icon-btn">👤</button>
      </div>
    </header>

    <!-- 主体内容 -->
    <main class="explore-content">
      <div class="container">
        <!-- 页面标题 -->
        <div class="page-header">
          <div class="tag-pill">
            <span class="pulse-dot"></span>
            EXPLORE
          </div>
          <h1 class="page-title">
            <span class="title-line-1">开始探索</span>
            <span class="title-line-2">Tsundere 小鲤鱼Blog</span>
          </h1>
          <p class="page-subtitle">
            一个融合技术分享、AI 探索与创意表达的博客空间
          </p>
        </div>

        <!-- 项目介绍 -->
        <section class="section-card glass-card">
          <div class="section-header">
            <span class="section-icon">🚀</span>
            <h2 class="section-title">项目介绍</h2>
          </div>
          <div class="section-body">
            <p>
              <strong>Tsundere 小鲤鱼Blog</strong> 是一个个人技术博客与创意分享平台，
              致力于记录技术成长、分享 AI 探索心得，并连接志同道合的朋友。
            </p>
            <p>
              本站采用 <strong>Spring Boot 3 + Vue 3</strong> 全栈架构，
              深度整合了 <strong>LangChain4j</strong>、<strong>Spring AI</strong> 等前沿技术，
              为你带来流畅的阅读体验和智能的交互能力。
            </p>
            <div class="tech-tags">
              <span class="tech-tag">Spring Boot 3</span>
              <span class="tech-tag">Vue 3</span>
              <span class="tech-tag">LangChain4j</span>
              <span class="tech-tag">Spring AI</span>
              <span class="tech-tag">Tailwind CSS</span>
              <span class="tech-tag">MySQL</span>
            </div>
          </div>
        </section>

        <!-- 核心功能 -->
        <section class="section-card glass-card">
          <div class="section-header">
            <span class="section-icon">⚡</span>
            <h2 class="section-title">核心功能</h2>
          </div>
          <div class="features-grid">
            <div class="feature-item">
              <div class="feature-icon">📝</div>
              <h3 class="feature-title">技术博客</h3>
              <p class="feature-desc">分享 Java、AI、前端等领域的深度技术文章</p>
            </div>
            <div class="feature-item">
              <div class="feature-icon">🤖</div>
              <h3 class="feature-title">AI 作品库</h3>
              <p class="feature-desc">展示 AI 相关项目与研究成果</p>
            </div>
            <div class="feature-item">
              <div class="feature-icon">💬</div>
              <h3 class="feature-title">智能搜索</h3>
              <p class="feature-desc">基于 AI 的智能文章检索与推荐</p>
            </div>
            <div class="feature-item">
              <div class="feature-icon">🌐</div>
              <h3 class="feature-title">交流社区</h3>
              <p class="feature-desc">加入 QQ 群，与技术爱好者共同成长</p>
            </div>
          </div>
        </section>

        <!-- 使用指引 -->
        <section class="section-card glass-card">
          <div class="section-header">
            <span class="section-icon">📖</span>
            <h2 class="section-title">使用指引</h2>
          </div>
          <div class="guide-list">
            <div class="guide-item">
              <div class="guide-step">01</div>
              <div class="guide-content">
                <h3 class="guide-title">浏览文章</h3>
                <p class="guide-desc">在首页或分类/标签页面浏览你感兴趣的技术文章</p>
              </div>
            </div>
            <div class="guide-item">
              <div class="guide-step">02</div>
              <div class="guide-content">
                <h3 class="guide-title">智能搜索</h3>
                <p class="guide-desc">使用顶部搜索框，通过关键词或 AI 语义检索找到相关内容</p>
              </div>
            </div>
            <div class="guide-item">
              <div class="guide-step">03</div>
              <div class="guide-content">
                <h3 class="guide-title">互动交流</h3>
                <p class="guide-desc">在文章下方留言评论，或加入 QQ 群与博主和其他读者交流</p>
              </div>
            </div>
            <div class="guide-item">
              <div class="guide-step">04</div>
              <div class="guide-content">
                <h3 class="guide-title">AI 探索</h3>
                <p class="guide-desc">访问 AI 作品库和 AI 搜索，体验大模型技术的应用</p>
              </div>
            </div>
          </div>
        </section>

        <!-- 用户须知 -->
        <section class="section-card glass-card">
          <div class="section-header">
            <span class="section-icon">📋</span>
            <h2 class="section-title">用户须知</h2>
          </div>
          <div class="notice-list">
            <div class="notice-item">
              <span class="notice-icon">✅</span>
              <span class="notice-text">本站内容均为原创，转载需注明出处</span>
            </div>
            <div class="notice-item">
              <span class="notice-icon">✅</span>
              <span class="notice-text">评论区请文明交流，禁止发布违法违规内容</span>
            </div>
            <div class="notice-item">
              <span class="notice-icon">✅</span>
              <span class="notice-text">AI 相关功能处于持续迭代中，欢迎反馈建议</span>
            </div>
            <div class="notice-item">
              <span class="notice-icon">✅</span>
              <span class="notice-text">本站部分内容涉及 AI 生成，请理性看待</span>
            </div>
          </div>
        </section>

        <!-- 交流讨论 - QQ群 -->
        <section class="section-card glass-card qq-group-section">
          <div class="section-header">
            <span class="section-icon">💬</span>
            <h2 class="section-title">交流讨论</h2>
          </div>
          <div class="qq-group-wrapper">
            <div class="qq-group-info">
              <h3 class="qq-group-title">📚 计算机技术互助小屋</h3>
              <p class="qq-group-desc">
                这里是一群热爱技术、热爱分享的小伙伴。
                无论你是技术小白还是资深大佬，都欢迎加入！
              </p>
              <div class="qq-group-detail">
                <span class="qq-group-number">🐧 群号：<strong>702414688</strong></span>
                <span class="qq-group-tip">扫描下方二维码即可加入</span>
              </div>
              <div class="qq-group-actions">
                <a href="https://qm.qq.com/q/702414688" target="_blank" class="btn-join-qq">
                  <span>🚀</span> 立即加群
                </a>
                <button class="btn-copy-qq" @click="copyQQNumber">
                  📋 复制群号
                </button>
              </div>
            </div>
            <div class="qq-group-qrcode">
              <div class="qrcode-wrapper">
                <img
                    src="@/assets/qq群.jpeg"
                    alt="QQ群二维码"
                    class="qrcode-image"
                />
                <div class="qrcode-label">扫一扫，加入群聊</div>
              </div>
              <div class="qrcode-platform">QQ</div>
            </div>
          </div>
        </section>

        <!-- 底部 -->
        <footer class="explore-footer">
          <p>© 2024 Tsundere 小鲤鱼Blog · 用 ❤️ 和 ☕ 驱动</p>
        </footer>
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
import { ref } from 'vue'
import { ElMessage } from 'element-plus'

const router = useRouter()

// ===== 跳转到 AI 标签页 =====
const goToAITagPage = () => {
  router.push({
    path: '/tag/list',
    query: { id: 4, name: 'AI' }
  })
}

// ===== 跳转到深度学习标签页 =====
const goToDeepLearningPage = () => {
  router.push({
    path: '/tag/list',
    query: { id: 4, name: '深度学习' }
  })
}

// ===== 复制 QQ 群号 =====
const copyQQNumber = () => {
  const qqNumber = '702414688'
  navigator.clipboard.writeText(qqNumber).then(() => {
    ElMessage.success('群号已复制，快去 QQ 搜索加入吧！')
  }).catch(() => {
    // 降级方案
    const input = document.createElement('input')
    input.value = qqNumber
    document.body.appendChild(input)
    input.select()
    document.execCommand('copy')
    document.body.removeChild(input)
    ElMessage.success('群号已复制，快去 QQ 搜索加入吧！')
  })
}

// ===== 预计算流星样式 =====
const meteorStyles = Array.from({ length: 19 }, (_, i) => ({
  animationDelay: `${(i * 1.7) % 12}s`,
  animationDuration: `${3 + (i % 4)}s`,
  top: `${(i * 13) % 85}%`,
  left: `${15 + (i * 31) % 85}%`,
  opacity: 0.5 + (i % 3) * 0.25
}))
</script>

<style scoped>
@import url('https://fonts.googleapis.com/css2?family=Orbitron:wght@400;700;900&family=Noto+Sans+SC:wght@300;400;700&display=swap');

/* ========== 页面基础 ========== */
.explore-page {
  position: relative;
  width: 100%;
  min-height: 100vh;
  overflow-x: hidden;
  font-family: 'Noto Sans SC', sans-serif;
  color: #ffffff;
  background-color: #050505;
}

/* ========== 背景层 ========== */
.background-layer {
  position: fixed;
  top: 0;
  left: 0;
  width: 100vw;
  height: 100vh;
  z-index: 0;
  overflow: hidden;
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
      rgba(5, 5, 5, 0.92) 100%
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

/* ========== 流星雨 ========== */
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

/* ========== 导航栏 ========== */
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

.nav-item:hover,
.nav-item.active {
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

/* ========== 主体内容 ========== */
.explore-content {
  position: relative;
  z-index: 5;
  min-height: 100vh;
  padding: 120px 60px 40px;
}

.container {
  max-width: 1000px;
  margin: 0 auto;
}

/* ========== 页面头部 ========== */
.page-header {
  text-align: center;
  margin-bottom: 50px;
}

.tag-pill {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  padding: 8px 20px;
  background: rgba(0, 242, 254, 0.1);
  border: 1px solid rgba(0, 242, 254, 0.3);
  border-radius: 20px;
  font-size: 12px;
  font-family: 'Orbitron', sans-serif;
  letter-spacing: 2px;
  color: #00f2fe;
  margin-bottom: 20px;
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

.page-title {
  font-size: 52px;
  font-weight: 900;
  line-height: 1.2;
  margin-bottom: 12px;
  text-transform: uppercase;
  letter-spacing: 2px;
}

.title-line-1 {
  display: block;
  background: linear-gradient(90deg, #ffffff, #a0a0a0);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.title-line-2 {
  display: block;
  background: linear-gradient(90deg, #00f2fe, #ffffff);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.page-subtitle {
  font-size: 18px;
  color: rgba(255, 255, 255, 0.6);
  letter-spacing: 2px;
}

/* ========== 卡片样式 ========== */
.glass-card {
  background: rgba(255, 255, 255, 0.04);
  backdrop-filter: blur(16px);
  -webkit-backdrop-filter: blur(16px);
  border: 1px solid rgba(255, 255, 255, 0.06);
  border-radius: 20px;
  padding: 32px 36px;
  margin-bottom: 28px;
  transition: all 0.3s ease;
}

.glass-card:hover {
  border-color: rgba(255, 255, 255, 0.12);
  box-shadow: 0 8px 40px rgba(0, 0, 0, 0.3);
}

.section-header {
  display: flex;
  align-items: center;
  gap: 12px;
  margin-bottom: 18px;
}

.section-icon {
  font-size: 28px;
}

.section-title {
  font-size: 22px;
  font-weight: 700;
  color: #fff;
  margin: 0;
}

.section-body p {
  color: rgba(255, 255, 255, 0.75);
  line-height: 1.8;
  font-size: 15px;
  margin: 0 0 14px 0;
}

.section-body p:last-child {
  margin-bottom: 0;
}

/* ========== 技术标签 ========== */
.tech-tags {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
  margin-top: 16px;
}

.tech-tag {
  padding: 6px 16px;
  background: rgba(0, 242, 254, 0.08);
  border: 1px solid rgba(0, 242, 254, 0.15);
  border-radius: 20px;
  font-size: 13px;
  color: #00f2fe;
  transition: all 0.3s;
}

.tech-tag:hover {
  background: rgba(0, 242, 254, 0.15);
  border-color: rgba(0, 242, 254, 0.3);
}

/* ========== 功能网格 ========== */
.features-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 20px;
}

.feature-item {
  text-align: center;
  padding: 24px 16px;
  background: rgba(255, 255, 255, 0.03);
  border-radius: 16px;
  transition: all 0.3s;
}

.feature-item:hover {
  background: rgba(255, 255, 255, 0.06);
  transform: translateY(-4px);
}

.feature-icon {
  font-size: 36px;
  margin-bottom: 10px;
}

.feature-title {
  font-size: 16px;
  font-weight: 600;
  color: #fff;
  margin: 0 0 6px 0;
}

.feature-desc {
  font-size: 13px;
  color: rgba(255, 255, 255, 0.5);
  margin: 0;
  line-height: 1.5;
}

/* ========== 使用指引 ========== */
.guide-list {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.guide-item {
  display: flex;
  gap: 20px;
  padding: 16px 20px;
  background: rgba(255, 255, 255, 0.03);
  border-radius: 14px;
  transition: all 0.3s;
}

.guide-item:hover {
  background: rgba(255, 255, 255, 0.06);
}

.guide-step {
  flex-shrink: 0;
  width: 40px;
  height: 40px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 50%;
  background: rgba(0, 242, 254, 0.12);
  color: #00f2fe;
  font-weight: 700;
  font-size: 14px;
}

.guide-content {
  flex: 1;
}

.guide-title {
  font-size: 16px;
  font-weight: 600;
  color: #fff;
  margin: 0 0 4px 0;
}

.guide-desc {
  font-size: 14px;
  color: rgba(255, 255, 255, 0.5);
  margin: 0;
}

/* ========== 用户须知 ========== */
.notice-list {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 10px 24px;
}

.notice-item {
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 8px 0;
}

.notice-icon {
  font-size: 18px;
}

.notice-text {
  font-size: 14px;
  color: rgba(255, 255, 255, 0.7);
}

/* ========== QQ群 ========== */
.qq-group-wrapper {
  display: flex;
  gap: 40px;
  align-items: center;
}

.qq-group-info {
  flex: 1;
}

.qq-group-title {
  font-size: 20px;
  font-weight: 700;
  color: #fff;
  margin: 0 0 10px 0;
}

.qq-group-desc {
  font-size: 15px;
  color: rgba(255, 255, 255, 0.6);
  line-height: 1.7;
  margin: 0 0 16px 0;
}

.qq-group-detail {
  display: flex;
  flex-direction: column;
  gap: 4px;
  margin-bottom: 18px;
}

.qq-group-number {
  font-size: 16px;
  color: rgba(255, 255, 255, 0.8);
}

.qq-group-number strong {
  color: #00f2fe;
  font-size: 20px;
}

.qq-group-tip {
  font-size: 13px;
  color: rgba(255, 255, 255, 0.35);
}

.qq-group-actions {
  display: flex;
  gap: 12px;
  flex-wrap: wrap;
}

.btn-join-qq {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  padding: 12px 28px;
  background: linear-gradient(135deg, #00f2fe, #4facfe);
  color: #fff;
  border: none;
  border-radius: 12px;
  font-size: 15px;
  font-weight: 600;
  text-decoration: none;
  cursor: pointer;
  transition: all 0.3s;
  box-shadow: 0 4px 20px rgba(0, 242, 254, 0.3);
}

.btn-join-qq:hover {
  transform: translateY(-2px);
  box-shadow: 0 8px 30px rgba(0, 242, 254, 0.5);
}

.btn-copy-qq {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  padding: 12px 24px;
  background: rgba(255, 255, 255, 0.06);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 12px;
  color: rgba(255, 255, 255, 0.7);
  font-size: 15px;
  cursor: pointer;
  transition: all 0.3s;
}

.btn-copy-qq:hover {
  background: rgba(255, 255, 255, 0.12);
  color: #fff;
}

/* QQ群二维码 */
.qq-group-qrcode {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 8px;
  flex-shrink: 0;
}

.qrcode-wrapper {
  background: rgba(255, 255, 255, 0.06);
  border: 2px solid rgba(255, 255, 255, 0.08);
  border-radius: 16px;
  padding: 16px;
  transition: all 0.3s;
}

.qrcode-wrapper:hover {
  border-color: rgba(0, 242, 254, 0.3);
  box-shadow: 0 0 30px rgba(0, 242, 254, 0.1);
}

.qrcode-image {
  width: 180px;
  height: 210px;
  object-fit: cover;
  border-radius: 8px;
  display: block;
}

.qrcode-label {
  text-align: center;
  font-size: 13px;
  color: rgba(255, 255, 255, 0.5);
  margin-top: 8px;
}

.qrcode-platform {
  font-size: 20px;
  font-weight: 700;
  color: rgba(255, 255, 255, 0.6);
  font-family: 'Orbitron', sans-serif;
  letter-spacing: 4px;
}

/* ========== 底部 ========== */
.explore-footer {
  text-align: center;
  padding: 32px 0 16px;
  color: rgba(255, 255, 255, 0.15);
  font-size: 13px;
  letter-spacing: 1px;
}

/* ========== 浮动工具栏 ========== */
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

/* ========== 响应式 ========== */
@media (max-width: 992px) {
  .features-grid {
    grid-template-columns: repeat(2, 1fr);
  }

  .qq-group-wrapper {
    flex-direction: column;
    text-align: center;
  }

  .qq-group-actions {
    justify-content: center;
  }

  .notice-list {
    grid-template-columns: 1fr;
  }
}

@media (max-width: 768px) {
  .navbar {
    padding: 16px 20px;
  }

  .nav-links {
    display: none;
  }

  .explore-content {
    padding: 100px 16px 30px;
  }

  .page-title {
    font-size: 32px;
  }

  .glass-card {
    padding: 20px;
  }

  .features-grid {
    grid-template-columns: 1fr 1fr;
    gap: 12px;
  }

  .feature-item {
    padding: 16px 12px;
  }

  .guide-item {
    flex-direction: column;
    gap: 8px;
    padding: 14px 16px;
  }

  .qq-group-qrcode .qrcode-image {
    width: 120px;
    height: 120px;
  }

  .floating-tools {
    right: 15px;
  }

  .btn-join-qq,
  .btn-copy-qq {
    width: 100%;
    justify-content: center;
  }
}

@media (max-width: 480px) {
  .page-title {
    font-size: 26px;
  }

  .page-subtitle {
    font-size: 14px;
  }

  .features-grid {
    grid-template-columns: 1fr 1fr;
    gap: 8px;
  }

  .section-title {
    font-size: 18px;
  }

  .glass-card {
    padding: 16px;
    border-radius: 14px;
  }
}
</style>