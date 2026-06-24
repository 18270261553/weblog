<template>
  <div class="min-h-screen bg-gradient-to-b from-blue-50 to-indigo-50 dark:from-gray-900 dark:to-gray-800 relative overflow-hidden">
    <!-- ========== 樱花飘落画布 ========== -->
    <canvas ref="sakuraCanvas" class="sakura-canvas"></canvas>

    <!-- 头部 -->
    <Header></Header>

    <div class="container mx-auto max-w-4xl mt-8 px-4 relative z-10">
      <!-- ==================== 信封样式 - 发表留言 ==================== -->
      <div class="envelope-wrapper mb-8">
        <!-- 信封封面 -->
        <div class="envelope-cover">
          <div class="envelope-cover-image">
            <span class="envelope-cover-emoji">🌸</span>
          </div>
          <div class="envelope-cover-text">
            <h2 class="envelope-title">💬 留下你想说的话</h2>
            <p class="envelope-subtitle">你的每一条留言，都是我们前进的动力</p>
          </div>
        </div>

        <!-- 信笺内容 -->
        <div class="letter-content">
          <el-form :model="publishForm" ref="publishFormRef" :rules="publishRules" label-position="top">
            <div class="grid grid-cols-2 gap-4">
              <el-form-item label="🌟 昵称" prop="username">
                <el-input v-model="publishForm.username" placeholder="请输入你的昵称" maxlength="20" />
              </el-form-item>
              <el-form-item label="📧 邮箱（可选）" prop="email">
                <el-input v-model="publishForm.email" placeholder="请输入邮箱（用于接收回复通知）" maxlength="100" />
              </el-form-item>
            </div>
            <el-form-item label="✍️ 留言内容" prop="content">
              <el-input
                  v-model="publishForm.content"
                  type="textarea"
                  :rows="4"
                  placeholder="有什么想说的？有什么想问的？尽情写下来吧..."
                  maxlength="500"
                  show-word-limit
              />
            </el-form-item>
            <el-form-item>
              <el-button type="primary" @click="handlePublish" :loading="publishing" class="publish-btn">
                <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 19l9 2-9-18-9 18 9-2zm0 0v-8" />
                </svg>
                寄出留言
              </el-button>
              <el-button @click="handleReset">清空</el-button>
            </el-form-item>
          </el-form>
        </div>

        <!-- 信封底部 -->
        <div class="envelope-bottom">
          <span class="envelope-bottom-text">✉️ 你的留言会被认真对待</span>
        </div>
      </div>

      <!-- ==================== 留言列表 ==================== -->
      <div class="messages-wrapper">
        <div class="messages-header">
          <h2 class="messages-title">
            <svg class="w-6 h-6 mr-2 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 12h.01M12 12h.01M16 12h.01M21 12c0 4.418-4.03 8-9 8a9.863 9.863 0 01-4.255-.949L3 20l1.395-3.72C3.512 15.042 3 13.574 3 12c0-4.418 4.03-8 9-8s9 3.582 9 8z" />
            </svg>
            全部留言
          </h2>
          <span class="messages-count">{{ messageList.length }} 条留言</span>
        </div>

        <!-- 加载中 -->
        <div v-if="loading" class="text-center py-10">
          <el-skeleton :rows="3" animated />
        </div>

        <!-- 空状态 -->
        <div v-else-if="messageList.length === 0" class="empty-state">
          <div class="empty-state-icon">📭</div>
          <p class="empty-state-text">还没有留言，快来抢沙发吧！</p>
        </div>

        <!-- 留言列表 -->
        <div v-else class="space-y-4">
          <div
              v-for="item in messageList"
              :key="item.id"
              class="message-item"
          >
            <div class="message-item-inner">
              <!-- 头像 -->
              <div class="message-avatar">
                <el-avatar :size="44" :src="getAvatar(item)" class="avatar-img">
                  {{ item.username?.charAt(0)?.toUpperCase() || '?' }}
                </el-avatar>
              </div>

              <!-- 内容 -->
              <div class="message-body">
                <div class="message-meta">
                  <span class="message-username">{{ item.username || '匿名' }}</span>
                  <span class="message-time">{{ item.createTime }}</span>
                  <span v-if="item.status === 0" class="status-tag status-pending">⏳ 待审核</span>
                  <span v-if="item.status === 2" class="status-tag status-rejected">🚫 已拒绝</span>
                </div>
                <div class="message-content">{{ item.content }}</div>
                <div class="message-actions">
                  <button @click="handleLike(item)" class="action-btn like-btn" :class="{ liked: item.isLiked }">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z" />
                    </svg>
                    <span>{{ item.likeCount || 0 }}</span>
                  </button>
                  <button @click="handleReply(item)" class="action-btn reply-btn">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 10h10a8 8 0 018 8v2M3 10l6 6m-6-6l6-6" />
                    </svg>
                    回复
                  </button>
                </div>

                <!-- 回复列表 -->
                <div v-if="item.replies && item.replies.length > 0" class="replies-wrapper">
                  <div
                      v-for="reply in item.replies"
                      :key="reply.id"
                      class="reply-item"
                  >
                    <el-avatar :size="28" :src="getAvatar(reply)" class="reply-avatar">
                      {{ reply.username?.charAt(0)?.toUpperCase() || '?' }}
                    </el-avatar>
                    <div class="reply-body">
                      <div class="reply-meta">
                        <span class="reply-username">{{ reply.username || '匿名' }}</span>
                        <span class="reply-time">{{ reply.createTime }}</span>
                        <span v-if="reply.status === 0" class="status-tag status-pending">⏳ 待审核</span>
                        <span v-if="reply.status === 2" class="status-tag status-rejected">🚫 已拒绝</span>
                      </div>
                      <div class="reply-content">{{ reply.content }}</div>
                      <div class="reply-actions">
                        <button @click="handleLike(reply)" class="action-btn like-btn" :class="{ liked: reply.isLiked }">
                          <svg class="w-3 h-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z" />
                          </svg>
                          <span>{{ reply.likeCount || 0 }}</span>
                        </button>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted, nextTick } from 'vue'
import Header from '@/layouts/components/Header.vue'
import { publishMessage, getMessageList, likeMessage } from '@/api/frontend/message'
import { ElMessage } from 'element-plus'

// ==================== 樱花动画 ====================
const sakuraCanvas = ref(null)
let animationId = null
let petals = []

class Petal {
  constructor(canvas) {
    this.canvas = canvas
    this.ctx = canvas.getContext('2d')
    this.reset()
    this.y = Math.random() * canvas.height // 初始随机位置
  }

  reset() {
    const canvas = this.canvas
    this.x = Math.random() * canvas.width
    this.y = -20
    this.size = Math.random() * 12 + 6
    this.speedY = Math.random() * 1.2 + 0.6
    this.speedX = (Math.random() - 0.5) * 0.8
    this.rotation = Math.random() * 360
    this.rotationSpeed = (Math.random() - 0.5) * 0.03
    this.opacity = Math.random() * 0.4 + 0.5
    // 樱花颜色：粉色系
    this.color = `hsla(${330 + Math.random() * 30}, 80%, ${70 + Math.random() * 25}%, ${this.opacity})`
    // 飘落摆动幅度
    this.waveAmplitude = Math.random() * 20 + 10
    this.waveFrequency = Math.random() * 0.02 + 0.01
    this.phase = Math.random() * Math.PI * 2
  }

  update() {
    this.y += this.speedY
    this.x += this.speedX + Math.sin(this.phase) * 0.3
    this.phase += this.waveFrequency
    this.rotation += this.rotationSpeed

    // 超出底部或左右边界则重置
    if (this.y > this.canvas.height + 20 || this.x < -50 || this.x > this.canvas.width + 50) {
      this.reset()
    }
  }

  draw() {
    const ctx = this.ctx
    ctx.save()
    ctx.translate(this.x, this.y)
    ctx.rotate(this.rotation)
    ctx.globalAlpha = this.opacity

    // 绘制花瓣（五瓣樱花）
    const size = this.size
    for (let i = 0; i < 5; i++) {
      const angle = (i / 5) * Math.PI * 2 - Math.PI / 2
      const petalSize = size * 0.7
      ctx.beginPath()
      ctx.ellipse(
          Math.cos(angle) * size * 0.6,
          Math.sin(angle) * size * 0.6,
          petalSize * 0.8,
          petalSize * 0.5,
          angle,
          0,
          Math.PI * 2
      )
      ctx.fillStyle = this.color
      ctx.fill()
      ctx.shadowColor = 'rgba(255, 150, 200, 0.2)'
      ctx.shadowBlur = 4
    }

    // 花蕊
    ctx.beginPath()
    ctx.arc(0, 0, size * 0.2, 0, Math.PI * 2)
    ctx.fillStyle = 'rgba(255, 220, 220, 0.6)'
    ctx.fill()

    ctx.restore()
  }
}

const initSakura = () => {
  const canvas = sakuraCanvas.value
  if (!canvas) return

  const resize = () => {
    canvas.width = window.innerWidth
    canvas.height = window.innerHeight
  }
  resize()
  window.addEventListener('resize', resize)

  // 创建花瓣
  const petalCount = Math.min(60, Math.floor((window.innerWidth * window.innerHeight) / 20000))
  for (let i = 0; i < petalCount; i++) {
    const petal = new Petal(canvas)
    petal.y = Math.random() * canvas.height // 初始随机分布
    petals.push(petal)
  }

  const animate = () => {
    const ctx = canvas.getContext('2d')
    ctx.clearRect(0, 0, canvas.width, canvas.height)

    petals.forEach(petal => {
      petal.update()
      petal.draw()
    })

    animationId = requestAnimationFrame(animate)
  }

  animate()
}

// ==================== 发表留言 ====================
const publishFormRef = ref(null)
const publishing = ref(false)

const publishForm = reactive({
  username: '',
  email: '',
  content: ''
})

const publishRules = {
  username: [
    { required: true, message: '请输入昵称', trigger: 'blur' },
    { max: 20, message: '昵称不能超过20个字符', trigger: 'blur' }
  ],
  content: [
    { required: true, message: '请输入留言内容', trigger: 'blur' },
    { max: 500, message: '内容不能超过500个字符', trigger: 'blur' }
  ],
  email: [
    { type: 'email', message: '请输入正确的邮箱格式', trigger: 'blur' }
  ]
}

// ==================== 留言列表 ====================
const loading = ref(false)
const messageList = ref([])

// ==================== 发表留言 ====================
const handlePublish = async () => {
  if (!publishFormRef.value) return

  await publishFormRef.value.validate(async (valid) => {
    if (!valid) return

    publishing.value = true
    try {
      const res = await publishMessage({
        username: publishForm.username,
        email: publishForm.email || '',
        content: publishForm.content
      })

      if (res.success) {
        ElMessage.success(res.message || '留言寄出成功，等待审核')
        handleReset()
        await loadMessageList()
      } else {
        ElMessage.error(res.message || '寄出失败')
      }
    } catch (error) {
      console.error('发表留言失败:', error)
      ElMessage.error('寄出失败，请稍后重试')
    } finally {
      publishing.value = false
    }
  })
}

const handleReset = () => {
  publishForm.username = ''
  publishForm.email = ''
  publishForm.content = ''
  publishFormRef.value?.resetFields()
}

// ==================== 获取留言列表 ====================
const loadMessageList = async () => {
  loading.value = true
  try {
    const res = await getMessageList()
    if (res.success) {
      messageList.value = (res.data || []).map(item => ({
        ...item,
        isLiked: false,
        replies: (item.replies || []).map(reply => ({
          ...reply,
          isLiked: false
        }))
      }))
    }
  } catch (error) {
    console.error('获取留言列表失败:', error)
    ElMessage.error('获取留言列表失败')
  } finally {
    loading.value = false
  }
}

// ==================== 点赞 ====================
const handleLike = async (item) => {
  if (item.isLiked) {
    ElMessage.warning('已经点过赞了')
    return
  }

  try {
    const res = await likeMessage(item.id)
    if (res.success) {
      item.isLiked = true
      item.likeCount = (item.likeCount || 0) + 1
      ElMessage.success('点赞成功')
    } else {
      ElMessage.error(res.message || '点赞失败')
    }
  } catch (error) {
    console.error('点赞失败:', error)
    ElMessage.error('点赞失败，请稍后重试')
  }
}

// ==================== 回复 ====================
const handleReply = (item) => {
  publishForm.content = `@${item.username} `
  const textarea = document.querySelector('textarea.el-textarea__inner')
  if (textarea) {
    textarea.focus()
  }
  ElMessage.info(`正在回复 ${item.username}`)
}

// ==================== 头像 ====================
const getAvatar = (item) => {
  if (item.avatar) return item.avatar
  const colors = ['#5B8FF9', '#61DDAA', '#F6BD16', '#F4664A', '#7265E6', '#FF9845']
  const index = (item.userId || 0) % colors.length
  return `https://ui-avatars.com/api/?name=${encodeURIComponent(item.username || '?')}&background=${colors[index].replace('#', '')}&color=fff&size=40`
}

// ==================== 初始化 ====================
onMounted(() => {
  loadMessageList()
  nextTick(() => {
    initSakura()
  })
})

// 组件卸载时清理动画
import { onBeforeUnmount } from 'vue'
onBeforeUnmount(() => {
  if (animationId) {
    cancelAnimationFrame(animationId)
  }
  window.removeEventListener('resize', () => {})
})
</script>

<style scoped>
@import '@/assets/fronted/message-board.css';
</style>