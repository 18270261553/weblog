<template>
  <!-- 全局背景装饰层 -->
  <div class="relative min-h-screen bg-[#050507] text-gray-200 overflow-hidden font-sans">
    <!-- 网格背景 -->
    <div class="fixed inset-0 z-0 pointer-events-none opacity-20" style="background-image: radial-gradient(#2f2f3d 1px, transparent 1px); background-size: 30px 30px;"></div>
    <!-- 渐变光晕 -->
    <div class="fixed top-[-10%] left-[-10%] w-[40%] h-[40%] bg-purple-900/20 blur-[120px] rounded-full"></div>
    <div class="fixed bottom-[-10%] right-[-10%] w-[40%] h-[40%] bg-blue-900/20 blur-[120px] rounded-full"></div>

    <!-- 顶部导航Header 完整保留 -->
    <Header></Header>

    <div class="relative z-10 w-[95vw] max-w-[1440px] h-[calc(90vh-64px)] mx-auto mt-5 flow-border-container">
      <div class="flow-border-inner shadow-2xl overflow-hidden flex relative">
        <!-- 左侧：历史对话侧边栏（玻璃UI + 原有对话逻辑） -->
        <aside class="sidebar-transition w-[280px] h-full flex flex-col border-r border-white/5 glass-panel" id="sidebar">
          <div class="p-6 flex items-center justify-between">
            <div class="flex items-center space-x-3 transition-opacity duration-300" id="logo-text">
              <div class="w-10 h-10 rounded-xl bg-gradient-to-br from-purple-500 to-blue-500 flex items-center justify-center shadow-lg shadow-purple-500/30">
                <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 12h.01M12 12h.01M16 12h.01M21 12c0 4.418-4.03 8-9 8a9.863 9.863 0 01-4.255-.949L3 20l1.395-3.72C3.512 15.042 3 13.574 3 12c0-4.418 4.03-8 9-8s9 3.582 9 8z"></path>
                </svg>
              </div>
              <span class="text-xl font-bold tracking-wider bg-clip-text text-transparent bg-gradient-to-r from-white to-gray-400">历史对话</span>
            </div>
            <button @click="newConversation" class="p-2 hover:bg-white/10 rounded-lg transition-colors" title="新建对话">
              <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path>
              </svg>
            </button>
          </div>

          <div class="flex-1 overflow-y-auto px-4 py-4 scrollbar-hide space-y-2">
            <div v-for="(conv, idx) in conversations" :key="idx"
                 @click="switchConversation(idx)"
                 :class="[
                   'p-3 rounded-xl glass-card cursor-pointer transition-all flex flex-col',
                   currentConversation === idx ? 'border-purple-500/50 bg-white/10' : ''
                 ]">
              <div class="flex items-center justify-between w-full">
                <p class="text-sm font-medium text-gray-200 truncate flex-1 sidebar-label">{{ conv.title || '新对话' }}</p>
                <button v-if="conversations.length > 1" @click.stop="deleteConversation(idx)" class="text-gray-400 hover:text-red-400 ml-2">
                  <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path>
                  </svg>
                </button>
              </div>
              <p class="text-xs text-gray-400 mt-1 truncate sidebar-label">{{ conv.lastMessage || '暂无消息' }}</p>
              <p class="text-xs text-gray-500 mt-1 sidebar-label">{{ formatDate(conv.updateTime) }}</p>
            </div>
            <div v-if="conversations.length === 0" class="text-center py-8 text-gray-500 sidebar-label">暂无对话记录</div>
          </div>

          <!-- 侧边栏底部 -->
          <div class="p-4 mt-auto border-t border-white/5">
            <div class="flex items-center space-x-3 p-2">
              <div class="w-10 h-10 rounded-full bg-gradient-to-tr from-indigo-600 to-purple-600 flex items-center justify-center text-xs font-bold ring-2 ring-white/10">USER</div>
              <div class="sidebar-label flex-1 overflow-hidden transition-all duration-300">
                <p class="text-sm font-semibold truncate">当前用户</p>
                <p class="text-xs text-gray-500 truncate">AI问答助手</p>
              </div>
            </div>
          </div>
        </aside>

        <!-- 右侧主聊天区域 -->
        <main class="flex-1 flex flex-col h-full relative overflow-hidden bg-gradient-to-b from-[#0a0a0c] to-[#0d0d12]">
          <!-- 顶部头部 -->
          <header class="h-16 flex items-center justify-between px-8 border-b border-white/5 glass-panel z-20">
            <div class="flex items-center space-x-4">
              <div class="relative">
                <div class="w-10 h-10 rounded-full bg-blue-500/20 flex items-center justify-center border border-blue-500/30 overflow-hidden">
                  <svg class="w-6 h-6 text-blue-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9.663 17h4.673M12 3v1m6.364 1.636l-.707.707M21 12h-1M4 12H3m3.343-5.657l-.707-.707m2.828 9.9a5 5 0 117.072 0l-.548.547A3.374 3.374 0 0014 18.469V19a2 2 0 11-4 0v-.531c0-.895-.356-1.754-.988-2.386l-.548-.547z"></path>
                  </svg>
                </div>
                <div class="absolute bottom-0 right-0 w-3 h-3 bg-green-500 rounded-full border-2 border-[#0a0a0c] animate-pulse"></div>
              </div>
              <div>
                <h2 class="text-lg font-bold">AI 智能问答</h2>
                <p class="text-xs text-green-500/80">在线 · 基于DeepSeek大模型</p>
              </div>
            </div>
            <div class="flex items-center space-x-4">
              <!-- 工具箱触发按钮 -->
              <button @click="toolboxOpen = !toolboxOpen" class="p-2 text-gray-400 hover:text-white transition-colors" title="灵动工具箱">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 4a2 2 0 112 2v2m-2 0a2 2 0 10-2 2v2m4 0a2 2 0 112 2v2m-4 0a2 2 0 10-2 2v2m10-10a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                </svg>
              </button>
              <span class="text-xs bg-green-100/20 text-green-300 px-2 py-1 rounded-full">在线</span>
            </div>
          </header>

          <!-- 消息容器 -->
          <div ref="messagesContainer" class="flex-1 overflow-y-auto p-8 space-y-6 scrollbar-hide scroll-smooth" id="chat-container">
            <!-- 消息循环 -->
            <div v-for="(msg, idx) in currentMessages" :key="idx" class="flex message-bubble" :class="msg.role === 'user' ? 'justify-end' : 'justify-start'">
              <div class="flex items-end space-x-3 space-x-reverse" :class="msg.role === 'user' ? 'flex-row-reverse' : 'flex-row'">
                <!-- AI头像 -->
                <div v-if="msg.role !== 'user'" class="flex-none w-10 h-10 rounded-full flex items-center justify-center text-[10px] font-bold ring-2 ring-white/10 bg-gradient-to-br from-blue-500 to-indigo-600">AI</div>
                <!-- 用户头像 -->
                <div v-if="msg.role === 'user'" class="flex-none w-10 h-10 rounded-full flex items-center justify-center text-[10px] font-bold ring-2 ring-white/10 bg-gradient-to-br from-purple-500 to-pink-600">YOU</div>

                <div class="flex flex-col space-y-1" :class="msg.role === 'user' ? 'items-end' : 'items-start'">
                  <!-- 消息气泡 -->
                  <div class="px-5 py-3 rounded-2xl border max-w-[75%]"
                       :class="msg.role === 'user'
                       ? 'user-gradient-bg text-white rounded-br-none border-white/20 shadow-lg'
                       : 'glass-card text-gray-200 rounded-bl-none ai-gradient-bg'">
                    <div class="text-sm leading-relaxed" v-html="formatMessage(msg.content)"></div>

                    <!-- 参考来源 -->
                    <div v-if="msg.role === 'assistant' && msg.references && msg.references.length > 0" class="mt-3 pt-2 border-t border-white/10">
                      <p class="text-xs text-gray-400 mb-1">📚 参考来源：</p>
                      <div v-for="ref in msg.references" :key="ref.id || ref.title" class="text-xs">
                        <a v-if="ref.id && ref.id > 0" :href="'/#/article/detail?articleId=' + ref.id" target="_blank" class="text-blue-400 hover:text-blue-300 hover:underline">
                          {{ ref.title }}
                        </a>
                        <span v-else class="text-gray-500">{{ ref.title }}</span>
                      </div>
                      <p class="text-xs text-gray-500 mt-1 text-gray-600">
                        <span v-if="msg.references.some(r => r.id > 0)">🔗 蓝色标题可点击跳转</span>
                        <span v-if="msg.references.some(r => !r.id || r.id === 0)" class="ml-2">📄 灰色标题为通用推荐</span>
                      </p>
                    </div>

                    <!-- AI操作按钮 -->
                    <div v-if="msg.role === 'assistant' && !msg.isError" class="flex items-center space-x-3 mt-3 pt-2 border-t border-white/10">
                      <button @click="copyMessage(msg.content)" class="text-xs opacity-70 hover:opacity-100 flex items-center">
                        <svg class="w-3 h-3 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 5H6a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2v-1M8 5a2 2 0 002 2h2a2 2 0 002-2M8 5a2 2 0 012-2h2a2 2 0 012 2m0 0h2a2 2 0 012 2v3m2 4H10m0 0l3-3m-3 3l3 3"></path>
                        </svg>复制
                      </button>
                      <button @click="regenerateMessage(idx)" class="text-xs opacity-70 hover:opacity-100 flex items-center">
                        <svg class="w-3 h-3 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15"></path>
                        </svg>重新生成
                      </button>
                    </div>
                  </div>
                  <span class="text-[10px] text-gray-500 px-1">{{ formatDate(msg.timestamp) }}</span>
                </div>
              </div>
            </div>

            <!-- AI打字动画 -->
            <div v-if="isTyping" class="flex justify-start message-bubble">
              <div class="flex items-end space-x-3">
                <div class="flex-none w-10 h-10 rounded-full flex items-center justify-center text-[10px] font-bold ring-2 ring-white/10 bg-gradient-to-br from-blue-500 to-indigo-600">AI</div>
                <div class="px-5 py-3 rounded-2xl border glass-card rounded-bl-none ai-gradient-bg">
                  <div class="flex space-x-1">
                    <div class="w-2 h-2 bg-gray-400 rounded-full animate-bounce"></div>
                    <div class="w-2 h-2 bg-gray-400 rounded-full animate-bounce" style="animation-delay: 0.2s"></div>
                    <div class="w-2 h-2 bg-gray-400 rounded-full animate-bounce" style="animation-delay: 0.4s"></div>
                  </div>
                </div>
              </div>
            </div>

            <!-- 推荐提问 -->
            <div v-if="currentMessages.length === 1 && !isTyping" class="mt-6">
              <p class="text-sm text-gray-500 mb-3">💡 你可以试试这样问：</p>
              <div class="flex flex-wrap gap-2">
                <button v-for="question in recommendQuestions" :key="question" @click="sendQuickQuestion(question)"
                        class="text-sm glass-card px-3 py-2 rounded-lg transition hover:border-purple-500/50">
                  {{ question }}
                </button>
              </div>
            </div>
          </div>

          <!-- 底部输入框区域 -->
          <div class="p-8 pt-2">
            <div class="relative max-w-4xl mx-auto group">
              <div class="absolute -inset-1 bg-gradient-to-r from-purple-600/20 to-blue-600/20 blur opacity-40 group-focus-within:opacity-100 transition-opacity"></div>
              <div class="relative flex items-end space-x-4 glass-panel p-3 rounded-2xl border border-white/10 shadow-xl">
                <button class="p-3 text-gray-400 hover:text-white transition-colors opacity-60 cursor-not-allowed">
                  <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path></svg>
                </button>
                <textarea
                    v-model="inputMessage"
                    @keydown.enter="handleEnter"
                    :disabled="isTyping"
                    placeholder="输入你的问题... (Enter 发送，Shift+Enter 换行)"
                    rows="1"
                    ref="textareaRef"
                    class="flex-1 bg-transparent border-none focus:ring-0 text-white placeholder-gray-500 py-3 resize-none max-h-40 scrollbar-hide leading-relaxed"
                ></textarea>
                <div class="flex items-center space-x-2 pb-1">
                  <button class="p-3 text-gray-400 hover:text-white transition-colors opacity-60 cursor-not-allowed">
                    <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14.828 14.828a4 4 0 01-5.656 0M9 10h.01M15 10h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                  </button>
                  <button
                      @click="sendMessage"
                      :disabled="!inputMessage.trim() || isTyping"
                      class="pulse-btn flex items-center justify-center w-12 h-12 rounded-xl bg-gradient-to-br from-purple-500 to-indigo-600 text-white shadow-lg shadow-purple-500/20 hover:scale-105 transition-transform active:scale-95 disabled:opacity-40 disabled:cursor-not-allowed disabled:scale-100"
                  >
                    <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 19l9 2-9-18-9 18 9-2zm0 0v-8"></path>
                    </svg>
                  </button>
                </div>
              </div>
            </div>
            <p class="text-center text-[10px] text-gray-600 mt-4 tracking-wider uppercase">AI 回答仅供参考，请核实重要信息</p>
          </div>
        </main>

        <!-- ===================== 右侧抽屉：灵动工具箱 ===================== -->
        <div
            :class="[
            'absolute top-0 right-0 h-full w-[320px] glass-panel border-l border-white/5 z-30 transition-all duration-500 ease-in-out flex flex-col',
            toolboxOpen ? 'translate-x-0' : 'translate-x-full'
          ]"
        >
          <!-- 工具箱头部 -->
          <div class="p-6 flex items-center justify-between border-b border-white/5">
            <div class="flex items-center gap-3">
              <div class="w-10 h-10 rounded-xl bg-gradient-to-br from-purple-500 to-blue-500 flex items-center justify-center shadow-lg shadow-purple-500/30">
                <svg class="w-6 h-6 text-white" viewBox="0 0 24 24" fill="currentColor">
                  <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 18c-4.41 0-8-3.59-8-8s3.59-8 8-8 8 3.59 8 8-3.59 8-8 8zm-1-13h2v6h-2zm0 8h2v2h-2z"/>
                </svg>
              </div>
              <h2 class="text-2xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-white to-gray-400">灵动工具箱</h2>
            </div>
            <button @click="toolboxOpen = false" class="p-2 hover:bg-white/10 rounded-lg transition-colors">
              <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
              </svg>
            </button>
          </div>

          <!-- 工具箱内容区域 -->
          <div class="flex-1 overflow-y-auto p-4 space-y-8 scrollbar-hide">
            <!-- 多媒体创意生成 -->
            <section class="space-y-3">
              <h3 class="text-xs font-semibold text-gray-500 uppercase tracking-widest px-2">多媒体创意生成</h3>
              <div class="space-y-2">
                <button @click="handleTool('image')" class="w-full flex items-center space-x-3 p-3 rounded-xl glass-card text-left group">
                  <div class="w-8 h-8 rounded-lg bg-purple-500/20 flex items-center justify-center">
                    <svg class="w-5 h-5 text-purple-400" fill="currentColor" viewBox="0 0 24 24">
                      <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-1 17.93c-3.95-.49-7-3.85-7-7.93 0-.62.08-1.21.21-1.79L9 15v1c0 1.1.9 2 2 2v1.93zm6.9-2.54c-.26-.81-1-1.39-1.9-1.39h-1v-3c0-.55-.45-1-1-1H8v-2h2c.55 0 1-.45 1-1V7h2c1.1 0 2-.9 2-2v-.41c2.93 1.19 5 4.06 5 7.41 0 2.08-.8 3.97-2.1 5.39z"/>
                    </svg>
                  </div>
                  <span class="flex-1 text-sm font-medium">文生图</span>
                  <svg class="w-4 h-4 opacity-0 group-hover:opacity-100 transition-opacity text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"></path>
                  </svg>
                </button>
                <button @click="handleTool('voice')" class="w-full flex items-center space-x-3 p-3 rounded-xl glass-card text-left group">
                  <div class="w-8 h-8 rounded-lg bg-blue-500/20 flex items-center justify-center">
                    <svg class="w-5 h-5 text-blue-400" fill="currentColor" viewBox="0 0 24 24">
                      <path d="M12 15c1.66 0 2.99-1.34 2.99-3L15 6c0-1.66-1.34-3-3-3S9 4.34 9 6v6c0 1.66 1.34 3 3 3zm5.3-3c0 3-2.54 5.1-5.3 5.1S6.7 15 6.7 12H5c0 3.42 2.72 6.23 6 6.72V22h2v-3.28c3.28-.48 6-3.3 6-6.72h-1.7z"/>
                    </svg>
                  </div>
                  <span class="flex-1 text-sm font-medium">语音转换</span>
                  <svg class="w-4 h-4 opacity-0 group-hover:opacity-100 transition-opacity text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"></path>
                  </svg>
                </button>
                <button @click="handleTool('emoji')" class="w-full flex items-center space-x-3 p-3 rounded-xl glass-card text-left group">
                  <div class="w-8 h-8 rounded-lg bg-yellow-500/20 flex items-center justify-center">
                    <svg class="w-5 h-5 text-yellow-400" fill="currentColor" viewBox="0 0 24 24">
                      <path d="M11.99 2C6.47 2 2 6.48 2 12s4.47 10 9.99 10C17.52 22 22 17.52 22 12S17.52 2 11.99 2zM12 20c-4.42 0-8-3.58-8-8s3.58-8 8-8 8 3.58 8 8-3.58 8-8 8zm3.5-9c.83 0 1.5-.67 1.5-1.5S16.33 8 15.5 8 14 8.67 14 9.5s.67 1.5 1.5 1.5zm-7 0c.83 0 1.5-.67 1.5-1.5S9.33 8 8.5 8 7 8.67 7 9.5 7.67 11 8.5 11zm3.5 6.5c2.33 0 4.31-1.46 5.11-3.5H6.89c.8 2.04 2.78 3.5 5.11 3.5z"/>
                    </svg>
                  </div>
                  <span class="flex-1 text-sm font-medium">表情包联想</span>
                  <svg class="w-4 h-4 opacity-0 group-hover:opacity-100 transition-opacity text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"></path>
                  </svg>
                </button>
              </div>
            </section>

            <!-- 情感化交互 -->
            <section class="space-y-3">
              <h3 class="text-xs font-semibold text-gray-500 uppercase tracking-widest px-2">情感化交互</h3>
              <div class="space-y-2">
                <button @click="toggleMoodPicker" class="w-full flex items-center space-x-3 p-3 rounded-xl glass-card text-left group">
                  <div class="w-8 h-8 rounded-lg bg-red-500/20 flex items-center justify-center">
                    <svg class="w-5 h-5 text-red-400" fill="currentColor" viewBox="0 0 24 24">
                      <path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"/>
                    </svg>
                  </div>
                  <span class="flex-1 text-sm font-medium">心情反馈</span>
                  <svg class="w-4 h-4 opacity-0 group-hover:opacity-100 transition-opacity text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"></path>
                  </svg>
                </button>
                <button @click="toggleQuickGreeting" class="w-full flex items-center space-x-3 p-3 rounded-xl glass-card text-left group">
                  <div class="w-8 h-8 rounded-lg bg-teal-500/20 flex items-center justify-center">
                    <svg class="w-5 h-5 text-teal-400" fill="currentColor" viewBox="0 0 24 24">
                      <path d="M18 8h-1V6c0-1.1-.9-2-2-2H9c-1.1 0-2 .9-2 2v2H6c-1.1 0-2 .9-2 2v10c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V10c0-1.1-.9-2-2-2zm-6 9c-1.1 0-2-.9-2-2s.9-2 2-2 2 .9 2 2-.9 2-2 2zm3.5-9h-7V6h7v2z"/>
                    </svg>
                  </div>
                  <span class="flex-1 text-sm font-medium">快捷问候</span>
                  <svg class="w-4 h-4 opacity-0 group-hover:opacity-100 transition-opacity text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"></path>
                  </svg>
                </button>
                <button @click="toggleVoiceEffect" class="w-full flex items-center space-x-3 p-3 rounded-xl glass-card text-left group">
                  <div class="w-8 h-8 rounded-lg bg-orange-500/20 flex items-center justify-center">
                    <svg class="w-5 h-5 text-orange-400" fill="currentColor" viewBox="0 0 24 24">
                      <path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/>
                    </svg>
                  </div>
                  <span class="flex-1 text-sm font-medium">趣味变声</span>
                  <svg class="w-4 h-4 opacity-0 group-hover:opacity-100 transition-opacity text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"></path>
                  </svg>
                </button>
              </div>
            </section>
          </div>
        </div>

        <!-- 心情选择弹窗 -->
        <div v-if="showMoodPicker" class="absolute right-[340px] bottom-20 w-64 glass-panel rounded-2xl p-4 shadow-2xl border border-white/10 z-40 animate-slide-in">
          <h4 class="text-xs font-bold text-gray-400 mb-3 uppercase tracking-tighter">你现在的心情是？</h4>
          <div class="grid grid-cols-3 gap-2">
            <button @click="sendMood('开心 💖')" class="flex flex-col items-center p-2 rounded-xl hover:bg-white/10 transition-colors">
              <span class="text-2xl mb-1">😊</span><span class="text-[10px]">开心</span>
            </button>
            <button @click="sendMood('平静 🍃')" class="flex flex-col items-center p-2 rounded-xl hover:bg-white/10 transition-colors">
              <span class="text-2xl mb-1">😌</span><span class="text-[10px]">平静</span>
            </button>
            <button @click="sendMood('疑惑 🤔')" class="flex flex-col items-center p-2 rounded-xl hover:bg-white/10 transition-colors">
              <span class="text-2xl mb-1">🧐</span><span class="text-[10px]">疑惑</span>
            </button>
            <button @click="sendMood('惊喜 ✨')" class="flex flex-col items-center p-2 rounded-xl hover:bg-white/10 transition-colors">
              <span class="text-2xl mb-1">🤩</span><span class="text-[10px]">惊喜</span>
            </button>
            <button @click="sendMood('难过 💧')" class="flex flex-col items-center p-2 rounded-xl hover:bg-white/10 transition-colors">
              <span class="text-2xl mb-1">🥺</span><span class="text-[10px]">难过</span>
            </button>
            <button @click="sendMood('疲惫 ☕')" class="flex flex-col items-center p-2 rounded-xl hover:bg-white/10 transition-colors">
              <span class="text-2xl mb-1">🥱</span><span class="text-[10px]">疲惫</span>
            </button>
          </div>
        </div>

        <!-- 变声选择弹窗 -->
        <div v-if="showVoicePicker" class="absolute right-[340px] bottom-20 w-64 glass-panel rounded-2xl p-4 shadow-2xl border border-white/10 z-40 animate-slide-in">
          <h4 class="text-xs font-bold text-gray-400 mb-3 uppercase tracking-tighter">选择变声效果</h4>
          <div class="space-y-2">
            <button @click="setVoice('甜美萝莉 👧')" class="w-full text-left p-2 rounded-lg hover:bg-white/5 flex items-center justify-between text-sm">
              <span>👧 甜美萝莉</span><div class="w-1.5 h-1.5 rounded-full bg-pink-500"></div>
            </button>
            <button @click="setVoice('磁性大叔 🧔')" class="w-full text-left p-2 rounded-lg hover:bg-white/5 flex items-center justify-between text-sm">
              <span>🧔 磁性大叔</span><div class="w-1.5 h-1.5 rounded-full bg-blue-500"></div>
            </button>
            <button @click="setVoice('赛博机器人 🤖')" class="w-full text-left p-2 rounded-lg hover:bg-white/5 flex items-center justify-between text-sm">
              <span>🤖 赛博机器人</span><div class="w-1.5 h-1.5 rounded-full bg-purple-500"></div>
            </button>
            <button @click="setVoice('迷幻电音 💿')" class="w-full text-left p-2 rounded-lg hover:bg-white/5 flex items-center justify-between text-sm">
              <span>💿 迷幻电音</span><div class="w-1.5 h-1.5 rounded-full bg-green-500"></div>
            </button>
          </div>
        </div>

        <!-- 快捷问候弹窗 -->
        <div v-if="showGreetingPicker" class="absolute right-[340px] bottom-20 w-64 glass-panel rounded-2xl p-4 shadow-2xl border border-white/10 z-40 animate-slide-in">
          <h4 class="text-xs font-bold text-gray-400 mb-3 uppercase tracking-tighter">快捷发送问候</h4>
          <div class="flex flex-wrap gap-2">
            <button @click="sendGreeting('早安！开启美好的一天 ☀️')" class="px-3 py-1.5 rounded-full bg-white/5 hover:bg-white/10 text-xs transition-colors border border-white/5">☀️ 早安</button>
            <button @click="sendGreeting('晚安，做个好梦 🌙')" class="px-3 py-1.5 rounded-full bg-white/5 hover:bg-white/10 text-xs transition-colors border border-white/5">🌙 晚安</button>
            <button @click="sendGreeting('辛苦啦，记得休息下 ☕')" class="px-3 py-1.5 rounded-full bg-white/5 hover:bg-white/10 text-xs transition-colors border border-white/5">☕ 辛苦了</button>
            <button @click="sendGreeting('加油！你是最棒的 💪')" class="px-3 py-1.5 rounded-full bg-white/5 hover:bg-white/10 text-xs transition-colors border border-white/5">💪 加油</button>
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

// 工具箱状态
const toolboxOpen = ref(false)
const showMoodPicker = ref(false)
const showVoicePicker = ref(false)
const showGreetingPicker = ref(false)

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
    content: '你好！我是博客AI智能助手 👋<br><br>我可以帮你：<br>• 查找和推荐相关文章<br>• 解答技术问题<br>• 分析代码问题<br>• 提供学习建议<br><br>点击右上角工具箱，体验更多趣味功能！',
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
        content: '你好！我是博客AI智能助手 👋<br><br>点击右上角工具箱，体验文生图、心情反馈等趣味功能，有什么我可以帮你的吗？',
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
      .replace(/```(\w*)\n([\s\S]*?)```/g, '<pre class="bg-black/40 text-white p-3 rounded-lg overflow-x-auto my-2"><code>$2</code></pre>')
      .replace(/`([^`]+)`/g, '<code class="bg-white/10 px-1 py-0.5 rounded text-sm">$1</code>')
      .replace(/(https?:\/\/[^\s]+)/g, '<a href="$1" target="_blank" class="text-blue-400 underline">$1</a>')
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

// ===================== 工具箱交互方法 =====================
// 关闭所有弹窗
const closeAllPopover = () => {
  showMoodPicker.value = false
  showVoicePicker.value = false
  showGreetingPicker.value = false
}

// 多媒体工具处理
const handleTool = (type) => {
  closeAllPopover()
  toolboxOpen.value = false
  if (type === 'image') {
    inputMessage.value = '帮我生成一张创意AI绘画图片，描述你想要的画面风格和元素即可'
  } else if (type === 'voice') {
    inputMessage.value = '开启语音转换功能，你可以输入文字，我为你生成对应的语音文案'
  } else if (type === 'emoji') {
    inputMessage.value = '根据我的需求联想匹配趣味表情包，告诉我场景即可'
  }
  sendMessage()
}

// 心情反馈弹窗
const toggleMoodPicker = () => {
  showMoodPicker.value = !showMoodPicker.value
  showVoicePicker.value = false
  showGreetingPicker.value = false
}
const sendMood = (mood) => {
  closeAllPopover()
  toolboxOpen.value = false
  inputMessage.value = '我现在的心情：' + mood
  sendMessage()
}

// 快捷问候弹窗
const toggleQuickGreeting = () => {
  showGreetingPicker.value = !showGreetingPicker.value
  showMoodPicker.value = false
  showVoicePicker.value = false
}
const sendGreeting = (text) => {
  closeAllPopover()
  toolboxOpen.value = false
  inputMessage.value = text
  sendMessage()
}

// 变声效果弹窗
const toggleVoiceEffect = () => {
  showVoicePicker.value = !showVoicePicker.value
  showMoodPicker.value = false
  showGreetingPicker.value = false
}
const setVoice = (voice) => {
  closeAllPopover()
  toolboxOpen.value = false
  inputMessage.value = '切换变声风格：' + voice + '，之后你的回复使用该声线风格输出'
  sendMessage()
}

// 点击空白关闭弹窗
document.addEventListener('click', (e) => {
  const toolboxDom = document.querySelector('[class*="translate-x-full"]')
  const moodBtn = document.querySelector('[@click="toggleMoodPicker"]')
  const voiceBtn = document.querySelector('[@click="toggleVoiceEffect"]')
  const greetBtn = document.querySelector('[@click="toggleQuickGreeting"]')
  if (!toolboxDom?.contains(e.target)) closeAllPopover()
})

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
/* 新UI全局动画样式 */
@keyframes rotate {
  from { transform: rotate(0deg); }
  to { transform: rotate(360deg); }
}

@keyframes pulse-glow {
  0%, 100% { opacity: 0.6; box-shadow: 0 0 15px rgba(139, 92, 246, 0.3); }
  50% { opacity: 1; box-shadow: 0 0 30px rgba(139, 92, 246, 0.6); }
}

@keyframes slide-in {
  from { opacity: 0; transform: translateY(20px); }
  to { opacity: 1; transform: translateY(0); }
}

@keyframes blink {
  0%, 100% { opacity: 1; }
  50% { opacity: 0; }
}

.flow-border-container {
  position: relative;
  padding: 2px;
  overflow: hidden;
  border-radius: 1.5rem;
}

.flow-border-container::before {
  content: '';
  position: absolute;
  top: -50%;
  left: -50%;
  width: 200%;
  height: 200%;
  background: conic-gradient(
      transparent,
      rgba(139, 92, 246, 0.8),
      rgba(59, 130, 246, 0.8),
      transparent 30%
  );
  animation: rotate 6s linear infinite;
  z-index: 0;
}

.flow-border-inner {
  position: relative;
  z-index: 1;
  background: #0a0a0c;
  border-radius: calc(1.5rem - 2px);
  height: 100%;
  display: flex;
}

.glass-panel {
  background: rgba(15, 15, 20, 0.7);
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
  border: 1px solid rgba(255, 255, 255, 0.1);
}

.glass-card {
  background: rgba(255, 255, 255, 0.05);
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.1);
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.glass-card:hover {
  background: rgba(255, 255, 255, 0.1);
  border-color: rgba(139, 92, 246, 0.5);
  transform: translateY(-2px);
}

.message-bubble {
  animation: slide-in 0.4s ease-out forwards;
}

.scrollbar-hide::-webkit-scrollbar {
  display: none;
}

.pulse-btn {
  animation: pulse-glow 3s infinite;
}

.sidebar-transition {
  transition: width 0.4s cubic-bezier(0.4, 0, 0.2, 1);
}

.ai-gradient-bg {
  background: linear-gradient(135deg, rgba(139, 92, 246, 0.2) 0%, rgba(59, 130, 246, 0.2) 100%);
}

.user-gradient-bg {
  background: linear-gradient(135deg, rgba(139, 92, 246, 0.6) 0%, rgba(124, 58, 237, 0.6) 100%);
}

.animate-slide-in {
  animation: slide-in 0.3s ease-out forwards;
}

/* 原有滚动条美化补充 */
.overflow-y-auto::-webkit-scrollbar {
  width: 6px;
}
.overflow-y-auto::-webkit-scrollbar-track {
  background: #121218;
  border-radius: 3px;
}
.overflow-y-auto::-webkit-scrollbar-thumb {
  background: #475569;
  border-radius: 3px;
}
.overflow-y-auto::-webkit-scrollbar-thumb:hover {
  background: #94a3b8;
}

pre {
  white-space: pre-wrap;
  word-wrap: break-word;
}
</style>