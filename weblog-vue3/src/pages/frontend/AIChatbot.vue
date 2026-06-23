<template>
  <div class="min-h-screen bg-gray-50 dark:bg-gray-900">
    <!-- 头部 -->
    <Header></Header>

    <div class="container mx-auto max-w-screen-xl mt-5 px-4">
      <div class="grid grid-cols-4 gap-6">
        <!-- 左侧：历史对话列表 -->
        <div class="col-span-4 md:col-span-1">
          <div class="bg-white dark:bg-gray-800 rounded-lg shadow-sm border border-gray-200 dark:border-gray-700 sticky top-21">
            <div class="p-4 border-b border-gray-200 dark:border-gray-700">
              <div class="flex items-center justify-between">
                <h2 class="font-bold text-gray-900 dark:text-white flex items-center">
                  <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                          d="M8 12h.01M12 12h.01M16 12h.01M21 12c0 4.418-4.03 8-9 8a9.863 9.863 0 01-4.255-.949L3 20l1.395-3.72C3.512 15.042 3 13.574 3 12c0-4.418 4.03-8 9-8s9 3.582 9 8z"></path>
                  </svg>
                  历史对话
                </h2>
                <button @click="newConversation"
                        class="text-blue-600 hover:text-blue-700 text-sm flex items-center">
                  <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                          d="M12 4v16m8-8H4"></path>
                  </svg>
                  新建
                </button>
              </div>
            </div>
            <div class="p-2 space-y-1 max-h-[calc(100vh-200px)] overflow-y-auto">
              <div v-for="(conv, idx) in conversations" :key="idx"
                   @click="switchConversation(idx)"
                   :class="['p-3 rounded-lg cursor-pointer transition-colors',
                                          currentConversation === idx
                                              ? 'bg-blue-50 dark:bg-blue-900/30 border-l-4 border-blue-500'
                                              : 'hover:bg-gray-100 dark:hover:bg-gray-700']">
                <div class="flex items-center justify-between">
                  <p class="text-sm font-medium text-gray-900 dark:text-white truncate flex-1">
                    {{ conv.title || '新对话' }}
                  </p>
                  <button v-if="conversations.length > 1"
                          @click.stop="deleteConversation(idx)"
                          class="text-gray-400 hover:text-red-500">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                            d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path>
                    </svg>
                  </button>
                </div>
                <p class="text-xs text-gray-500 dark:text-gray-400 mt-1 truncate">
                  {{ conv.lastMessage || '暂无消息' }}
                </p>
                <p class="text-xs text-gray-400 dark:text-gray-500 mt-1">
                  {{ formatDate(conv.updateTime) }}
                </p>
              </div>
              <div v-if="conversations.length === 0" class="text-center py-8 text-gray-400">
                暂无对话记录
              </div>
            </div>
          </div>
        </div>

        <!-- 右侧：AI 问答主区域 -->
        <div class="col-span-4 md:col-span-3">
          <div class="bg-white dark:bg-gray-800 rounded-lg shadow-sm border border-gray-200 dark:border-gray-700 overflow-hidden">

            <!-- 头部提示 -->
            <div class="p-4 border-b border-gray-200 dark:border-gray-700 bg-gradient-to-r from-blue-50 to-indigo-50 dark:from-blue-900/20 dark:to-indigo-900/20">
              <div class="flex items-center justify-between">
                <div>
                  <h1 class="text-xl font-bold text-gray-900 dark:text-white flex items-center">
                    <svg class="w-6 h-6 mr-2 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                            d="M9.663 17h4.673M12 3v1m6.364 1.636l-.707.707M21 12h-1M4 12H3m3.343-5.657l-.707-.707m2.828 9.9a5 5 0 117.072 0l-.548.547A3.374 3.374 0 0014 18.469V19a2 2 0 11-4 0v-.531c0-.895-.356-1.754-.988-2.386l-.548-.547z"></path>
                    </svg>
                    AI 智能问答
                  </h1>
                  <p class="text-sm text-gray-600 dark:text-gray-400 mt-1">
                    基于DeepSeek，为你提供智能问答服务
                  </p>
                </div>
                <div class="flex items-center space-x-2">
                                    <span class="text-xs bg-green-100 text-green-800 dark:bg-green-900 dark:text-green-300 px-2 py-1 rounded-full">
                                        在线
                                    </span>
                </div>
              </div>
            </div>

            <!-- 消息列表 -->
            <div ref="messagesContainer" class="h-[calc(100vh-350px)] overflow-y-auto p-6 space-y-4">
              <div v-for="(msg, idx) in currentMessages" :key="idx"
                   :class="msg.role === 'user' ? 'flex justify-end' : 'flex justify-start'">

                <!-- 头像 -->
                <div class="flex-shrink-0 mr-3" v-if="msg.role !== 'user'">
                  <div class="w-8 h-8 rounded-full bg-blue-100 dark:bg-blue-900 flex items-center justify-center">
                    <svg class="w-5 h-5 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                            d="M9.663 17h4.673M12 3v1m6.364 1.636l-.707.707M21 12h-1M4 12H3m3.343-5.657l-.707-.707m2.828 9.9a5 5 0 117.072 0l-.548.547A3.374 3.374 0 0014 18.469V19a2 2 0 11-4 0v-.531c0-.895-.356-1.754-.988-2.386l-.548-.547z"></path>
                    </svg>
                  </div>
                </div>

                <div :class="msg.role === 'user'
                                            ? 'bg-blue-600 text-white rounded-2xl rounded-tr-sm'
                                            : 'bg-gray-100 dark:bg-gray-700 text-gray-800 dark:text-white rounded-2xl rounded-tl-sm'"
                     class="max-w-[70%] p-4">

                  <div class="text-sm leading-relaxed" v-html="formatMessage(msg.content)"></div>

                  <!-- ========== 引用来源 ========== -->
                  <div v-if="msg.role === 'assistant' && msg.references && msg.references.length > 0"
                       class="mt-3 pt-2 border-t border-gray-200 dark:border-gray-600">
                    <p class="text-xs text-gray-400 dark:text-gray-500 mb-1">📚 参考来源：</p>
                    <div v-for="ref in msg.references" :key="ref.id || ref.title" class="text-xs">
                      <!-- ✅ 有 ID 且大于 0 才显示超链接 -->
                      <a v-if="ref.id && ref.id > 0"
                         :href="'/#/article/detail?articleId=' + ref.id"
                         target="_blank"
                         class="text-blue-500 hover:text-blue-700 hover:underline dark:text-blue-400 dark:hover:text-blue-300">
                        {{ ref.title }}
                      </a>
                      <!-- ❌ 没有 ID 只显示文本 -->
                      <span v-else class="text-gray-500 dark:text-gray-400">
                        {{ ref.title }}
                      </span>
                    </div>
                    <!-- 小提示 -->
                    <p class="text-xs text-gray-400 dark:text-gray-500 mt-1">
                      <span v-if="msg.references.some(r => r.id > 0)">🔗 蓝色标题可点击跳转</span>
                      <span v-if="msg.references.some(r => !r.id || r.id === 0)" class="ml-2">📄 灰色标题为通用推荐</span>
                    </p>
                  </div>

                  <!-- 操作按钮（仅AI消息） -->
                  <div v-if="msg.role === 'assistant' && !msg.isError" class="flex items-center space-x-3 mt-3 pt-2 border-t border-gray-200 dark:border-gray-600">
                    <button @click="copyMessage(msg.content)" class="text-xs opacity-70 hover:opacity-100 flex items-center">
                      <svg class="w-3 h-3 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M8 5H6a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2v-1M8 5a2 2 0 002 2h2a2 2 0 002-2M8 5a2 2 0 012-2h2a2 2 0 012 2m0 0h2a2 2 0 012 2v3m2 4H10m0 0l3-3m-3 3l3 3"></path>
                      </svg>
                      复制
                    </button>
                    <button @click="regenerateMessage(idx)" class="text-xs opacity-70 hover:opacity-100 flex items-center">
                      <svg class="w-3 h-3 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15"></path>
                      </svg>
                      重新生成
                    </button>
                  </div>
                </div>

                <!-- 用户头像 -->
                <div class="flex-shrink-0 ml-3" v-if="msg.role === 'user'">
                  <div class="w-8 h-8 rounded-full bg-gray-300 dark:bg-gray-600 flex items-center justify-center">
                    <svg class="w-5 h-5 text-gray-600 dark:text-gray-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                            d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
                    </svg>
                  </div>
                </div>
              </div>

              <!-- 打字指示器 -->
              <div v-if="isTyping" class="flex justify-start">
                <div class="flex-shrink-0 mr-3">
                  <div class="w-8 h-8 rounded-full bg-blue-100 dark:bg-blue-900 flex items-center justify-center">
                    <svg class="w-5 h-5 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                            d="M9.663 17h4.673M12 3v1m6.364 1.636l-.707.707M21 12h-1M4 12H3m3.343-5.657l-.707-.707m2.828 9.9a5 5 0 117.072 0l-.548.547A3.374 3.374 0 0014 18.469V19a2 2 0 11-4 0v-.531c0-.895-.356-1.754-.988-2.386l-.548-.547z"></path>
                    </svg>
                  </div>
                </div>
                <div class="bg-gray-100 dark:bg-gray-700 rounded-2xl rounded-tl-sm p-4">
                  <div class="flex space-x-1">
                    <div class="w-2 h-2 bg-gray-400 rounded-full animate-bounce"></div>
                    <div class="w-2 h-2 bg-gray-400 rounded-full animate-bounce" style="animation-delay: 0.2s"></div>
                    <div class="w-2 h-2 bg-gray-400 rounded-full animate-bounce" style="animation-delay: 0.4s"></div>
                  </div>
                </div>
              </div>

              <!-- 推荐问题 -->
              <div v-if="currentMessages.length === 1 && !isTyping" class="mt-6">
                <p class="text-sm text-gray-500 dark:text-gray-400 mb-3">💡 你可以试试这样问：</p>
                <div class="flex flex-wrap gap-2">
                  <button v-for="question in recommendQuestions" :key="question"
                          @click="sendQuickQuestion(question)"
                          class="text-sm bg-gray-100 dark:bg-gray-700 hover:bg-gray-200 dark:hover:bg-gray-600 text-gray-700 dark:text-gray-300 px-3 py-2 rounded-lg transition">
                    {{ question }}
                  </button>
                </div>
              </div>
            </div>

            <!-- 输入区域 -->
            <div class="border-t border-gray-200 dark:border-gray-700 p-4 bg-white dark:bg-gray-800">
              <div class="flex items-end space-x-3">
                <div class="flex-1 relative">
                                    <textarea
                                        v-model="inputMessage"
                                        @keydown.enter="handleEnter"
                                        :disabled="isTyping"
                                        placeholder="输入你的问题... (Enter 发送，Shift+Enter 换行)"
                                        rows="1"
                                        ref="textareaRef"
                                        class="w-full p-3 border border-gray-300 dark:border-gray-600 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent resize-none dark:bg-gray-700 dark:text-white"
                                    ></textarea>
                </div>
                <button
                    @click="sendMessage"
                    :disabled="!inputMessage.trim() || isTyping"
                    class="bg-blue-600 hover:bg-blue-700 disabled:opacity-50 disabled:cursor-not-allowed text-white px-6 py-2 rounded-lg transition flex items-center space-x-2">
                  <span>发送</span>
                  <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                          d="M12 19l9 2-9-18-9 18 9-2zm0 0v-8"></path>
                  </svg>
                </button>
              </div>
              <div class="mt-2 text-xs text-gray-400 dark:text-gray-500">
                支持多轮对话，AI会记住上下文
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive, watch, nextTick, onMounted } from 'vue'
import Header from '@/layouts/components/Header.vue'
import { sendChatMessage } from '@/api/frontend/ai.js'

// 对话数据结构
const conversations = ref([])
const currentConversation = ref(0)
const isTyping = ref(false)
const inputMessage = ref('')
const messagesContainer = ref(null)
const textareaRef = ref(null)

// 推荐问题
const recommendQuestions = [
  '最近有什么热门文章？',
  '推荐几篇Java相关的技术文章',
  '如何优化网站性能？',
  'Spring Boot 和 Spring Cloud 的区别',
  '前端开发有哪些最佳实践？'
]

// 当前对话的消息列表
const currentMessages = ref([
  {
    role: 'assistant',
    content: '你好！我是博客AI智能助手 👋<br><br>我可以帮你：<br>• 查找和推荐相关文章<br>• 解答技术问题<br>• 分析代码问题<br>• 提供学习建议<br><br>有什么我可以帮你的吗？',
    timestamp: new Date()
  }
])

// 加载历史对话
const loadConversations = () => {
  const saved = localStorage.getItem('ai_conversations')
  if (saved) {
    const parsed = JSON.parse(saved)
    conversations.value = parsed
    if (parsed.length > 0) {
      currentConversation.value = 0
      currentMessages.value = parsed[0].messages
    }
  }
}

// 保存对话
const saveConversations = () => {
  localStorage.setItem('ai_conversations', JSON.stringify(conversations.value))
}

// 新建对话
const newConversation = () => {
  const newConv = {
    id: Date.now(),
    title: '新对话',
    messages: [
      {
        role: 'assistant',
        content: '你好！我是博客AI智能助手 👋<br><br>有什么我可以帮你的吗？',
        timestamp: new Date()
      }
    ],
    lastMessage: '',
    updateTime: new Date()
  }
  conversations.value.unshift(newConv)
  currentConversation.value = 0
  currentMessages.value = newConv.messages
  saveConversations()
}

// 切换对话
const switchConversation = (idx) => {
  currentConversation.value = idx
  currentMessages.value = conversations.value[idx].messages
  scrollToBottom()
}

// 删除对话
const deleteConversation = (idx) => {
  if (confirm('确定删除这个对话吗？')) {
    conversations.value.splice(idx, 1)
    if (conversations.value.length === 0) {
      newConversation()
    } else {
      currentConversation.value = 0
      currentMessages.value = conversations.value[0].messages
    }
    saveConversations()
  }
}

// 更新对话标题
const updateConversationTitle = () => {
  const conv = conversations.value[currentConversation.value]
  if (conv && conv.messages.length > 1) {
    const firstUserMsg = conv.messages.find(m => m.role === 'user')
    if (firstUserMsg && conv.title === '新对话') {
      conv.title = firstUserMsg.content.slice(0, 20) + (firstUserMsg.content.length > 20 ? '...' : '')
      conv.updateTime = new Date()
      saveConversations()
    }
  }
}
// ========== 提取引用文章信息 ==========
const extractReferences = (content) => {
  console.log('🔍 原始内容:', content)
  const references = []

  // ✅ 匹配 "标题 (ID: 数字)" 格式
  const pattern = /《?([^》]+)》?\s*\(ID[：:]\s*(\d+)\)/g
  let match
  while ((match = pattern.exec(content)) !== null) {
    const title = match[1].trim()
    const id = parseInt(match[2])
    console.log('✅ 匹配到:', title, 'ID:', id)
    if (title && id && !references.find(r => r.id === id)) {
      references.push({ id, title })
    }
  }

  // 如果没有匹配到 (ID: 数字) 格式，再尝试只匹配标题
  if (references.length === 0) {
    const fallbackPattern = /《([^》]+)》/g
    let fallbackMatch
    while ((fallbackMatch = fallbackPattern.exec(content)) !== null) {
      const title = fallbackMatch[1].trim()
      if (title && !references.find(r => r.title === title)) {
        references.push({ id: 0, title })
      }
    }
  }

  console.log('📚 提取结果:', references)
  return references
}

// ========== 在AI回复中注入引用信息 ==========
const processAIResponse = (content) => {
  const references = extractReferences(content)
  return {
    content: content,
    references: references
  }
}

// 发送消息
const sendMessage = async () => {
  if (!inputMessage.value.trim() || isTyping.value) return

  const userMessage = {
    role: 'user',
    content: inputMessage.value,
    timestamp: new Date()
  }

  currentMessages.value.push(userMessage)
  const question = inputMessage.value
  inputMessage.value = ''
  scrollToBottom()
  autoResizeTextarea()

  const conv = conversations.value[currentConversation.value]
  if (conv) {
    conv.lastMessage = question
    conv.updateTime = new Date()
    conv.messages = currentMessages.value
    saveConversations()
  }

  isTyping.value = true

  try {
    const history = currentMessages.value.slice(-10).map(m => ({
      role: m.role,
      content: m.content.replace(/<[^>]*>/g, '')
    }))

    const response = await sendChatMessage({
      message: question,
      history: history.slice(0, -1)
    })

    if (response.success) {
      console.log('AI 回复内容:', response.data)
      const processed = processAIResponse(response.data)
      const aiMessage = {
        role: 'assistant',
        content: processed.content,
        references: processed.references,
        timestamp: new Date()
      }
      currentMessages.value.push(aiMessage)

      conv.messages = currentMessages.value
      saveConversations()
      updateConversationTitle()
    } else {
      throw new Error(response.message)
    }
  } catch (error) {
    console.error('AI回复失败:', error)
    currentMessages.value.push({
      role: 'assistant',
      content: '抱歉，我遇到了一些问题，请稍后再试。\n\n可能的原因：\n• 网络连接异常\n• AI服务暂时不可用\n• 请检查API Key配置',
      timestamp: new Date(),
      isError: true
    })
  } finally {
    isTyping.value = false
    scrollToBottom()
  }
}

// 重新生成消息
const regenerateMessage = async (msgIdx) => {
  if (isTyping.value) return

  const lastUserMsg = [...currentMessages.value].reverse().find(m => m.role === 'user')
  if (!lastUserMsg) return

  currentMessages.value.splice(msgIdx, 1)

  isTyping.value = true

  try {
    const history = currentMessages.value.slice(-10).map(m => ({
      role: m.role,
      content: m.content.replace(/<[^>]*>/g, '')
    }))

    const response = await sendChatMessage({
      message: lastUserMsg.content,
      history: history
    })

    if (response.success) {
      const processed = processAIResponse(response.data)
      const aiMessage = {
        role: 'assistant',
        content: processed.content,
        references: processed.references,
        timestamp: new Date()
      }
      currentMessages.value.push(aiMessage)

      const conv = conversations.value[currentConversation.value]
      conv.messages = currentMessages.value
      saveConversations()
    } else {
      throw new Error(response.message)
    }
  } catch (error) {
    currentMessages.value.push({
      role: 'assistant',
      content: '重新生成失败，请稍后再试。',
      timestamp: new Date(),
      isError: true
    })
  } finally {
    isTyping.value = false
    scrollToBottom()
  }
}

// 复制消息
const copyMessage = async (content) => {
  const text = content.replace(/<[^>]*>/g, '')
  try {
    await navigator.clipboard.writeText(text)
    alert('已复制到剪贴板')
  } catch (err) {
    console.error('复制失败:', err)
  }
}

// 快捷提问
const sendQuickQuestion = (question) => {
  inputMessage.value = question
  sendMessage()
}

// 处理回车发送
const handleEnter = (e) => {
  if (e.key === 'Enter' && !e.shiftKey) {
    e.preventDefault()
    sendMessage()
  }
}

// 自动调整文本框高度
const autoResizeTextarea = () => {
  nextTick(() => {
    if (textareaRef.value) {
      textareaRef.value.style.height = 'auto'
      textareaRef.value.style.height = Math.min(textareaRef.value.scrollHeight, 120) + 'px'
    }
  })
}

// 格式化消息
const formatMessage = (content) => {
  if (!content) return ''
  return content
      .replace(/\n/g, '<br>')
      .replace(/```(\w*)\n([\s\S]*?)```/g, '<pre class="bg-gray-800 text-white p-3 rounded-lg overflow-x-auto my-2"><code>$2</code></pre>')
      .replace(/`([^`]+)`/g, '<code class="bg-gray-200 dark:bg-gray-600 px-1 py-0.5 rounded text-sm">$1</code>')
      .replace(/(https?:\/\/[^\s]+)/g, '<a href="$1" target="_blank" class="text-blue-500 underline">$1</a>')
}

// 格式化日期
const formatDate = (date) => {
  if (!date) return ''
  const d = new Date(date)
  const now = new Date()
  const diff = now - d
  if (diff < 3600000) return `${Math.floor(diff / 60000)}分钟前`
  if (diff < 86400000) return `${Math.floor(diff / 3600000)}小时前`
  return `${d.getMonth() + 1}/${d.getDate()} ${d.getHours()}:${d.getMinutes().toString().padStart(2, '0')}`
}

// 滚动到底部
const scrollToBottom = async () => {
  await nextTick()
  if (messagesContainer.value) {
    messagesContainer.value.scrollTop = messagesContainer.value.scrollHeight
  }
}

watch(inputMessage, () => {
  autoResizeTextarea()
})

watch(currentMessages, () => {
  scrollToBottom()
}, {deep: true})

onMounted(() => {
  loadConversations()
  if (conversations.value.length === 0) {
    newConversation()
  }
  autoResizeTextarea()
})
</script>

<style scoped>
/* 动画效果 */
.slide-fade-enter-active,
.slide-fade-leave-active {
  transition: all 0.3s ease;
}

.slide-fade-enter-from,
.slide-fade-leave-to {
  transform: translateY(20px);
  opacity: 0;
}

/* 滚动条美化 */
.overflow-y-auto::-webkit-scrollbar {
  width: 6px;
}

.overflow-y-auto::-webkit-scrollbar-track {
  background: #f1f1f1;
  border-radius: 3px;
}

.overflow-y-auto::-webkit-scrollbar-thumb {
  background: #cbd5e1;
  border-radius: 3px;
}

.overflow-y-auto::-webkit-scrollbar-thumb:hover {
  background: #94a3b8;
}

.dark .overflow-y-auto::-webkit-scrollbar-track {
  background: #1f2937;
}

.dark .overflow-y-auto::-webkit-scrollbar-thumb {
  background: #475569;
}

/* 代码块样式 */
pre {
  white-space: pre-wrap;
  word-wrap: break-word;
}

/* 引用链接样式 */
.reference-link {
  color: #3b82f6;
  text-decoration: none;
}

.reference-link:hover {
  text-decoration: underline;
  color: #1d4ed8;
}
</style>