<script setup>
import { ref, onMounted, onBeforeUnmount } from 'vue'

// ============ 流星样式生成 ============
const meteorStyles = ref([])

const generateMeteorStyles = () => {
  const styles = []
  for (let i = 0; i < 19; i++) {
    const top = Math.random() * 100
    const left = Math.random() * 100
    const duration = 3 + Math.random() * 6
    const delay = Math.random() * 8
    const size = 1 + Math.random() * 2
    const opacity = 0.3 + Math.random() * 0.5
    styles.push({
      top: top + '%',
      left: left + '%',
      animationDuration: duration + 's',
      animationDelay: delay + 's',
      width: size + 'px',
      height: size + 'px',
      opacity: opacity,
    })
  }
  return styles
}

onMounted(() => {
  meteorStyles.value = generateMeteorStyles()
})

// ============ 个人数据 ============
const profile = ref({
  name: 'Tsundere',
  nickname: '小鲤鱼',
  title: '全栈开发 · AI 爱好者 · 内容创作者',
  location: '🌏 中国 · 江苏',
  email: '2111477010@qq.com',
  github: 'github.com/tsundere',
  wechat: 'Tsundere_blog',
})

const skills = ref([
  { name: 'Vue.js / React', level: 90, icon: '⚡' },
  { name: 'Java / Agent', level: 85, icon: '🚀' },
  { name: 'UI/UX 设计', level: 75, icon: '🎨' },
  { name: 'AI / 机器学习', level: 70, icon: '🤖' },
  { name: 'DevOps / Docker', level: 65, icon: '🐳' },
  { name: '摄影 / 剪辑', level: 60, icon: '📷' },
])

const experiences = ref([
  {
    period: '2023 - 至今',
    title: '资深全栈开发工程师',
    company: '某科技公司 · 远程',
    description: '负责 AI 产品的前后端架构设计、核心模块开发与团队技术指导。',
    tags: ['Vue3', 'Node.js', 'Java', 'AI'],
  },
  {
    period: '2021 - 2023',
    title: '前端开发工程师',
    company: '某互联网大厂 · 北京',
    description: '参与千万级用户产品的研发，主导组件库建设与性能优化。',
    tags: ['React', 'TypeScript', 'Webpack', '微前端'],
  },
  {
    period: '2019 - 2021',
    title: '独立开发者 / 自由职业',
    company: 'Self-Employed',
    description: '开发并运营个人项目，涵盖博客系统、AI 工具、开源库等。',
    tags: ['Vue2', 'Flask', 'Docker', '开源'],
  },
])

const blogStats = ref([
  { label: '总文章', value: '128+' },
  { label: '总字数', value: '50w+' },
  { label: '总访问量', value: '10w+' },
  { label: '开源项目', value: '12' },
])

const socialLinks = ref([
  { name: 'GitHub', icon: '🐙', url: '#' },
  { name: '掘金', icon: '💎', url: '#' },
  { name: '知乎', icon: '📘', url: '#' },
  { name: 'B站', icon: '📺', url: '#' },
  { name: '微博', icon: '📱', url: '#' },
  { name: '公众号', icon: '💬', url: '#' },
])

const recentWorks = ref([
  { title: 'AI 智能写作助手', desc: '基于 GPT 的写作辅助工具', tag: 'AI' },
  { title: '个人博客系统', desc: '全栈自研博客平台', tag: '开源' },
  { title: '数据可视化仪表盘', desc: '实时数据监控面板', tag: '项目' },
  { title: '图像识别工具集', desc: '深度学习图像处理', tag: 'AI' },
])
</script>

<template>
  <div class="about-page">
    <!-- ===== 动态背景层 ===== -->
    <div class="background-layer">
      <img
          src="@/assets/10.jpg"
          alt="Futuristic Background"
          class="bg-image"
      />
      <div class="overlay-gradient"></div>
      <div class="tech-grid"></div>

      <!-- 流星雨动态层 -->
      <div class="meteor-shower">
        <div v-for="(style, index) in meteorStyles" :key="index" class="meteor" :style="style"></div>
      </div>
    </div>

    <!-- ===== 主要内容 ===== -->
    <div class="content-wrapper">
      <!-- 导航栏 -->
      <header class="navbar">
        <div class="logo">
          <span class="logo-icon">◈</span>
          <span class="logo-text">Tsundere <span class="highlight">小鲤鱼Blog</span></span>
        </div>
        <nav class="nav-links">
          <a href="#" class="nav-item">首页</a>
          <a href="#" class="nav-item">AI 作品库</a>
          <a href="#" class="nav-item">深度学习</a>
          <a href="#" class="nav-item active">关于我</a>
        </nav>
        <div class="nav-actions">
          <button class="icon-btn">🔍</button>
          <button class="icon-btn">👤</button>
        </div>
      </header>

      <!-- ===== 关于我主体 ===== -->
      <main class="main-content">
        <!-- 个人简介卡片 -->
        <section class="profile-card glass-card">
          <div class="profile-header">
            <div class="avatar-wrapper">
              <div class="avatar-ring">
                <img
                    src="@/assets/02.jpg"
                    alt="Avatar"
                    class="avatar"
                />
              </div>
              <div class="status-dot"></div>
            </div>
            <div class="profile-info">
              <h1 class="profile-name">{{ profile.name }}</h1>
              <p class="profile-nickname">「{{ profile.nickname }}」</p>
              <p class="profile-title">{{ profile.title }}</p>
              <p class="profile-location">{{ profile.location }}</p>
              <div class="profile-contact">
                <span class="contact-item">📧 {{ profile.email }}</span>
                <span class="contact-item">🐙 {{ profile.github }}</span>
                <span class="contact-item">💬 {{ profile.wechat }}</span>
              </div>
            </div>
          </div>

          <!-- 统计数字 -->
          <div class="stats-grid">
            <div v-for="stat in blogStats" :key="stat.label" class="stat-item">
              <span class="stat-value">{{ stat.value }}</span>
              <span class="stat-label">{{ stat.label }}</span>
            </div>
          </div>
        </section>

        <!-- 技能 -->
        <section class="section-card glass-card">
          <h2 class="section-title">🛠️ 技术栈</h2>
          <div class="skills-grid">
            <div v-for="skill in skills" :key="skill.name" class="skill-item">
              <div class="skill-header">
                <span class="skill-icon">{{ skill.icon }}</span>
                <span class="skill-name">{{ skill.name }}</span>
                <span class="skill-level">{{ skill.level }}%</span>
              </div>
              <div class="skill-bar">
                <div class="skill-progress" :style="{ width: skill.level + '%' }"></div>
              </div>
            </div>
          </div>
        </section>

        <!-- 个人简介文字 -->
        <section class="section-card glass-card">
          <h2 class="section-title">📖 关于我</h2>
          <div class="bio-content">
            <p>
              你好！我是 <strong>Tsundere</strong>（小鲤鱼），一名热爱技术的全栈开发者。
              从大学开始接触编程，一路走来，我始终保持着对新技术的好奇心和学习热情。
            </p>
            <p>
              我坚信 <strong>「技术是工具，创造是目的」</strong>。
              除了写代码，我还喜欢摄影、旅行、阅读和写作。
              这个博客是我的个人空间，用来记录技术思考、生活感悟和一切有趣的事物。
            </p>
            <p>
              如果你也对技术、AI 或创意感兴趣，欢迎与我交流！
            </p>
            <div class="bio-tags">
              <span class="bio-tag"># 全栈开发</span>
              <span class="bio-tag"># AI 爱好者</span>
              <span class="bio-tag"># 开源精神</span>
              <span class="bio-tag"># 终身学习</span>
              <span class="bio-tag"># 摄影</span>
              <span class="bio-tag"># 旅行</span>
            </div>
          </div>
        </section>

        <!-- 经历 -->
        <section class="section-card glass-card">
          <h2 class="section-title">💼 工作经历</h2>
          <div class="timeline">
            <div v-for="(exp, index) in experiences" :key="index" class="timeline-item">
              <div class="timeline-dot"></div>
              <div class="timeline-content">
                <div class="timeline-header">
                  <span class="timeline-period">{{ exp.period }}</span>
                  <span class="timeline-title">{{ exp.title }}</span>
                  <span class="timeline-company">{{ exp.company }}</span>
                </div>
                <p class="timeline-desc">{{ exp.description }}</p>
                <div class="timeline-tags">
                  <span v-for="tag in exp.tags" :key="tag" class="timeline-tag">{{ tag }}</span>
                </div>
              </div>
            </div>
          </div>
        </section>

        <!-- 近期作品 -->
        <section class="section-card glass-card">
          <h2 class="section-title">🚀 近期作品</h2>
          <div class="works-grid">
            <div v-for="work in recentWorks" :key="work.title" class="work-item">
              <div class="work-icon">📌</div>
              <div class="work-info">
                <h4 class="work-title">{{ work.title }}</h4>
                <p class="work-desc">{{ work.desc }}</p>
                <span class="work-tag">{{ work.tag }}</span>
              </div>
            </div>
          </div>
        </section>

        <!-- 社交链接 -->
        <section class="section-card glass-card">
          <h2 class="section-title">🔗 找到我</h2>
          <div class="social-grid">
            <a v-for="link in socialLinks" :key="link.name" :href="link.url" class="social-link" target="_blank">
              <span class="social-icon">{{ link.icon }}</span>
              <span class="social-name">{{ link.name }}</span>
            </a>
          </div>
        </section>

        <!-- 底部 -->
        <footer class="footer">
          <p>© 2024 Tsundere 小鲤鱼Blog · 用 ❤️ 和 ☕ 驱动</p>
        </footer>
      </main>
    </div>
  </div>
</template>

<style scoped>
/* ========== 页面基础 ========== */
.about-page {
  position: relative;
  min-height: 100vh;
  overflow-x: hidden;
  font-family: 'Inter', system-ui, -apple-system, sans-serif;
}

/* ========== 动态背景 ========== */
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
}

.overlay-gradient {
  position: absolute;
  inset: 0;
  background: linear-gradient(180deg,
  rgba(0, 0, 0, 0.7) 0%,
  rgba(0, 0, 0, 0.4) 50%,
  rgba(0, 0, 0, 0.8) 100%);
}

.tech-grid {
  position: absolute;
  inset: 0;
  background-image:
      linear-gradient(rgba(255, 255, 255, 0.03) 1px, transparent 1px),
      linear-gradient(90deg, rgba(255, 255, 255, 0.03) 1px, transparent 1px);
  background-size: 40px 40px;
}

/* ========== 流星雨 ========== */
.meteor-shower {
  position: absolute;
  inset: 0;
  pointer-events: none;
  overflow: hidden;
}

.meteor {
  position: absolute;
  background: linear-gradient(to right, rgba(255, 255, 255, 0), rgba(255, 255, 255, 0.8));
  border-radius: 50%;
  box-shadow: 0 0 20px rgba(255, 255, 255, 0.3);
  animation: meteorShoot linear infinite;
}

@keyframes meteorShoot {
  0% {
    transform: translate(0, 0) rotate(-45deg) scale(1);
    opacity: 0;
  }
  10% {
    opacity: 1;
  }
  80% {
    opacity: 1;
  }
  100% {
    transform: translate(300px, 300px) rotate(-45deg) scale(0.5);
    opacity: 0;
  }
}

/* ========== 内容容器 ========== */
.content-wrapper {
  position: relative;
  z-index: 1;
  min-height: 100vh;
}

/* ========== 导航栏 ========== */
.navbar {
  position: fixed;
  top: 20px;
  left: 50%;
  transform: translateX(-50%);
  z-index: 100;
  display: flex;
  align-items: center;
  justify-content: space-between;
  width: 90%;
  max-width: 1200px;
  padding: 12px 28px;
  background: rgba(255, 255, 255, 0.06);
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
  border: 1px solid rgba(255, 255, 255, 0.08);
  border-radius: 16px;
  box-shadow: 0 8px 40px rgba(0, 0, 0, 0.3);
}

.logo {
  display: flex;
  align-items: center;
  gap: 10px;
}

.logo-icon {
  font-size: 22px;
  color: #60a5fa;
}

.logo-text {
  font-size: 18px;
  font-weight: 700;
  color: #fff;
  letter-spacing: 0.5px;
}

.logo-text .highlight {
  background: linear-gradient(135deg, #60a5fa, #a78bfa);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.nav-links {
  display: flex;
  gap: 8px;
}

.nav-item {
  padding: 6px 16px;
  color: rgba(255, 255, 255, 0.6);
  text-decoration: none;
  font-size: 14px;
  font-weight: 500;
  border-radius: 8px;
  transition: all 0.3s;
}

.nav-item:hover {
  color: #fff;
  background: rgba(255, 255, 255, 0.08);
}

.nav-item.active {
  color: #fff;
  background: rgba(255, 255, 255, 0.1);
}

.nav-actions {
  display: flex;
  gap: 8px;
}

.icon-btn {
  width: 38px;
  height: 38px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: rgba(255, 255, 255, 0.06);
  border: 1px solid rgba(255, 255, 255, 0.06);
  border-radius: 10px;
  color: rgba(255, 255, 255, 0.6);
  font-size: 16px;
  cursor: pointer;
  transition: all 0.3s;
}

.icon-btn:hover {
  background: rgba(255, 255, 255, 0.12);
  color: #fff;
}

/* ========== 毛玻璃卡片 ========== */
.glass-card {
  background: rgba(255, 255, 255, 0.05);
  backdrop-filter: blur(16px);
  -webkit-backdrop-filter: blur(16px);
  border: 1px solid rgba(255, 255, 255, 0.06);
  border-radius: 20px;
  padding: 32px;
  transition: all 0.3s ease;
}

.glass-card:hover {
  border-color: rgba(255, 255, 255, 0.12);
  box-shadow: 0 8px 40px rgba(0, 0, 0, 0.2);
}

/* ========== 主内容 ========== */
.main-content {
  max-width: 900px;
  margin: 0 auto;
  padding: 100px 24px 60px;
  display: flex;
  flex-direction: column;
  gap: 28px;
}

/* ========== 个人简介卡片 ========== */
.profile-card {
  padding: 40px;
}

.profile-header {
  display: flex;
  gap: 32px;
  align-items: flex-start;
}

.avatar-wrapper {
  position: relative;
  flex-shrink: 0;
}

.avatar-ring {
  width: 120px;
  height: 120px;
  border-radius: 50%;
  padding: 4px;
  background: linear-gradient(135deg, #60a5fa, #a78bfa, #f472b6);
  animation: spinRing 6s linear infinite;
}

.avatar {
  width: 100%;
  height: 100%;
  border-radius: 50%;
  object-fit: cover;
  border: 3px solid rgba(0, 0, 0, 0.8);
}

.status-dot {
  position: absolute;
  bottom: 4px;
  right: 4px;
  width: 18px;
  height: 18px;
  background: #4ade80;
  border-radius: 50%;
  border: 3px solid rgba(0, 0, 0, 0.8);
  animation: pulseDot 2s ease-in-out infinite;
}

@keyframes pulseDot {
  0%, 100% { box-shadow: 0 0 0 0 rgba(74, 222, 128, 0.4); }
  50% { box-shadow: 0 0 0 8px rgba(74, 222, 128, 0); }
}

.profile-info {
  flex: 1;
}

.profile-name {
  font-size: 32px;
  font-weight: 700;
  color: #fff;
  margin: 0;
}

.profile-nickname {
  font-size: 16px;
  color: rgba(255, 255, 255, 0.5);
  margin: 2px 0 8px;
}

.profile-title {
  font-size: 18px;
  font-weight: 500;
  color: rgba(255, 255, 255, 0.8);
  margin: 4px 0;
}

.profile-location {
  font-size: 14px;
  color: rgba(255, 255, 255, 0.4);
  margin: 4px 0 12px;
}

.profile-contact {
  display: flex;
  flex-wrap: wrap;
  gap: 12px 20px;
}

.contact-item {
  font-size: 13px;
  color: rgba(255, 255, 255, 0.5);
  font-family: monospace;
}

/* ========== 统计 ========== */
.stats-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 16px;
  margin-top: 28px;
  padding-top: 24px;
  border-top: 1px solid rgba(255, 255, 255, 0.06);
}

.stat-item {
  text-align: center;
}

.stat-value {
  display: block;
  font-size: 28px;
  font-weight: 700;
  background: linear-gradient(135deg, #60a5fa, #a78bfa);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.stat-label {
  font-size: 13px;
  color: rgba(255, 255, 255, 0.4);
  margin-top: 4px;
}

/* ========== 区块标题 ========== */
.section-title {
  font-size: 22px;
  font-weight: 600;
  color: #fff;
  margin: 0 0 20px 0;
}

/* ========== 技能 ========== */
.skills-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 16px;
}

.skill-item {
  padding: 12px 16px;
  background: rgba(255, 255, 255, 0.03);
  border-radius: 12px;
}

.skill-header {
  display: flex;
  align-items: center;
  gap: 10px;
  margin-bottom: 6px;
}

.skill-icon {
  font-size: 18px;
}

.skill-name {
  flex: 1;
  font-size: 14px;
  color: rgba(255, 255, 255, 0.8);
}

.skill-level {
  font-size: 13px;
  color: rgba(255, 255, 255, 0.4);
}

.skill-bar {
  height: 4px;
  background: rgba(255, 255, 255, 0.06);
  border-radius: 4px;
  overflow: hidden;
}

.skill-progress {
  height: 100%;
  border-radius: 4px;
  background: linear-gradient(90deg, #60a5fa, #a78bfa);
  transition: width 1s ease;
}

/* ========== 个人简介文字 ========== */
.bio-content p {
  color: rgba(255, 255, 255, 0.7);
  line-height: 1.8;
  margin: 0 0 12px 0;
  font-size: 15px;
}

.bio-content strong {
  color: rgba(255, 255, 255, 0.9);
}

.bio-tags {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
  margin-top: 16px;
}

.bio-tag {
  padding: 4px 14px;
  background: rgba(255, 255, 255, 0.06);
  border: 1px solid rgba(255, 255, 255, 0.06);
  border-radius: 20px;
  font-size: 12px;
  color: rgba(255, 255, 255, 0.5);
}

/* ========== 时间线 ========== */
.timeline {
  display: flex;
  flex-direction: column;
  gap: 20px;
  padding-left: 20px;
  border-left: 2px solid rgba(255, 255, 255, 0.06);
}

.timeline-item {
  position: relative;
  padding-left: 24px;
}

.timeline-dot {
  position: absolute;
  left: -30px;
  top: 6px;
  width: 12px;
  height: 12px;
  border-radius: 50%;
  background: linear-gradient(135deg, #60a5fa, #a78bfa);
  border: 2px solid rgba(0, 0, 0, 0.6);
}

.timeline-header {
  display: flex;
  flex-wrap: wrap;
  align-items: baseline;
  gap: 8px 16px;
}

.timeline-period {
  font-size: 12px;
  font-weight: 600;
  color: #60a5fa;
  background: rgba(96, 165, 250, 0.15);
  padding: 2px 12px;
  border-radius: 12px;
}

.timeline-title {
  font-size: 16px;
  font-weight: 600;
  color: #fff;
}

.timeline-company {
  font-size: 14px;
  color: rgba(255, 255, 255, 0.4);
}

.timeline-desc {
  font-size: 14px;
  color: rgba(255, 255, 255, 0.6);
  line-height: 1.6;
  margin: 6px 0 8px;
}

.timeline-tags {
  display: flex;
  flex-wrap: wrap;
  gap: 6px;
}

.timeline-tag {
  font-size: 11px;
  padding: 2px 10px;
  background: rgba(255, 255, 255, 0.04);
  border-radius: 10px;
  color: rgba(255, 255, 255, 0.3);
  border: 1px solid rgba(255, 255, 255, 0.04);
}

/* ========== 作品网格 ========== */
.works-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 12px;
}

.work-item {
  display: flex;
  align-items: center;
  gap: 14px;
  padding: 14px 18px;
  background: rgba(255, 255, 255, 0.03);
  border-radius: 12px;
  transition: all 0.3s;
}

.work-item:hover {
  background: rgba(255, 255, 255, 0.06);
}

.work-icon {
  font-size: 20px;
  opacity: 0.5;
}

.work-info {
  flex: 1;
  min-width: 0;
}

.work-title {
  font-size: 14px;
  font-weight: 600;
  color: #fff;
  margin: 0;
}

.work-desc {
  font-size: 12px;
  color: rgba(255, 255, 255, 0.4);
  margin: 2px 0 4px;
}

.work-tag {
  font-size: 10px;
  padding: 1px 8px;
  background: rgba(96, 165, 250, 0.15);
  color: #60a5fa;
  border-radius: 8px;
}

/* ========== 社交链接 ========== */
.social-grid {
  display: flex;
  flex-wrap: wrap;
  gap: 12px;
}

.social-link {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 8px 18px;
  background: rgba(255, 255, 255, 0.04);
  border: 1px solid rgba(255, 255, 255, 0.06);
  border-radius: 12px;
  color: rgba(255, 255, 255, 0.6);
  text-decoration: none;
  transition: all 0.3s;
  font-size: 14px;
}

.social-link:hover {
  background: rgba(255, 255, 255, 0.08);
  color: #fff;
  border-color: rgba(255, 255, 255, 0.12);
  transform: translateY(-2px);
}

.social-icon {
  font-size: 18px;
}

/* ========== 底部 ========== */
.footer {
  text-align: center;
  padding: 32px 0 16px;
  color: rgba(255, 255, 255, 0.2);
  font-size: 13px;
}

/* ========== 响应式 ========== */
@media (max-width: 768px) {
  .navbar {
    top: 12px;
    padding: 10px 16px;
    flex-wrap: wrap;
    gap: 8px;
  }

  .nav-links {
    order: 3;
    width: 100%;
    justify-content: center;
    gap: 4px;
  }

  .nav-item {
    font-size: 12px;
    padding: 4px 10px;
  }

  .logo-text {
    font-size: 14px;
  }

  .main-content {
    padding: 100px 16px 40px;
    gap: 20px;
  }

  .profile-card {
    padding: 24px;
  }

  .profile-header {
    flex-direction: column;
    align-items: center;
    text-align: center;
  }

  .profile-contact {
    justify-content: center;
  }

  .stats-grid {
    grid-template-columns: repeat(2, 1fr);
  }

  .skills-grid {
    grid-template-columns: 1fr;
  }

  .works-grid {
    grid-template-columns: 1fr;
  }

  .glass-card {
    padding: 20px;
  }
}

@media (max-width: 480px) {
  .navbar {
    top: 8px;
    padding: 8px 12px;
  }

  .logo-text {
    font-size: 12px;
  }

  .logo-icon {
    font-size: 16px;
  }

  .nav-item {
    font-size: 11px;
    padding: 3px 8px;
  }

  .profile-name {
    font-size: 24px;
  }

  .avatar-ring {
    width: 80px;
    height: 80px;
  }

  .stat-value {
    font-size: 20px;
  }
}
</style>