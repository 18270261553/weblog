<template>
  <Header></Header>

  <div class="mt-5 mb-3 relative">
    <div class="grid grid-cols-12 gap-4">

      <!-- 左侧：文章大纲（固定悬浮） -->
      <div class="hidden lg:block col-span-3 sticky top-20 h-[calc(100vh-80px)] overflow-y-auto sidebar-no-scrollbar" style="margin-left: 20px">
        <div class="bg-white border border-gray-200 p-4 rounded-lg dark:bg-gray-800 dark:border-gray-700 w-full">
          <h2 class="mb-3 font-bold text-gray-900 uppercase dark:text-white">文章目录</h2>
          <div class="text-sm">
            <div
                v-for="(item, index) in tocList"
                :key="index"
                class="toc-item cursor-pointer py-1.5 px-2 rounded hover:bg-blue-50 dark:hover:bg-gray-700"
                :class="activeTocIndex === index ? 'text-blue-600 font-medium bg-blue-100' : 'text-gray-600 dark:text-gray-300'"
                :style="{ paddingLeft: `${item.level * 12 + 8}px` }"
                @click="scrollToTitle(item)"
            >
              {{ item.title }}
            </div>
            <div v-if="tocList.length === 0" class="text-gray-400 text-sm italic">
              暂无目录
            </div>
          </div>
        </div>
      </div>

      <!-- 中间：文章内容 -->
      <div class="col-span-12 lg:col-span-6 px-2">
        <div class="bg-white border border-gray-200 p-5 rounded-lg dark:bg-gray-800 dark:border-gray-700">
          <!-- 面包屑 -->
          <nav class="flex mb-4" aria-label="Breadcrumb">
            <ol class="inline-flex items-center space-x-1 md:space-x-3">
              <li class="inline-flex items-center">
                <a @click="router.push('/')"
                   class="cursor-pointer inline-flex items-center text-sm font-medium text-gray-500 hover:text-blue-600 dark:text-gray-400 dark:hover:text-white">
                  <svg class="w-3 h-3 mr-2.5" aria-hidden="true" xmlns="http://www.w3.org/2000/svg"
                       fill="currentColor" viewBox="0 0 20 20">
                    <path
                        d="m19.707 9.293-2-2-7-7a1 1 0 0 0-1.414 0l-7 7-2 2a1 1 0 0 0 1.414 1.414L2 10.414V18a2 2 0 0 0 2 2h3a1 1 0 0 0 1-1v-4a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1v4a1 1 0 0 0 1 1h3a2 2 0 0 0 2-2v-7.586l.293.293a1 1 0 0 0 1.414-1.414Z" />
                  </svg>
                  首页
                </a>
              </li>
              <li aria-current="page">
                <div class="flex items-center text-gray-400">
                  /
                  <span
                      class="ml-1 text-sm font-medium text-gray-500 md:ml-4 dark:text-gray-400">正文</span>
                </div>
              </li>
            </ol>
          </nav>

          <!-- 文章主体 -->
          <article>
            <h1 class="title mt-2">{{ article.title }}</h1>
            <div class="text-gray-400 text-sm flex items-center article-mata">
              <svg class="inline w-3 h-3 mr-2 text-gray-400 dark:white" aria-hidden="true"
                   xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 20 20">
                <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                      d="M5 1v3m5-3v3m5-3v3M1 7h18M5 11h10M2 3h16a1 1 0 0 1 1 1v14a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1V4a1 1 0 0 1 1-1Z" />
              </svg>
              发表于 {{ article.updateTime }}

              <svg class="inline w-3 h-3 ml-5 mr-2 text-gray-400 dark:white" aria-hidden="true"
                   xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 18 18">
                <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                      d="M1 5v11a1 1 0 0 0 1 1h14a1 1 0 0 0 1-1V6a1 1 0 0 0-1-1H1Zm0 0V2a1 1 0 0 1 1-1h5.443a1 1 0 0 1 .8.4l2.7 3.6H1Z" />
              </svg>
              分类于&nbsp;
              <a @click="goCatagoryArticleListPage(article.categoryId, article.categoryName)"
                 class="text-gray-500 hover:underline">{{ article.categoryName }}</a>

              <svg class="inline w-3 h-3 ml-5 mr-2 text-gray-400 dark:white" aria-hidden="true"
                   xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 20 14">
                <g stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2">
                  <path d="M10 10a3 3 0 1 0 0-6 3 3 0 0 0 0 6Z" />
                  <path d="M10 13c4.97 0 9-2.686 9-6s-4.03-6-9-6-9 2.686-9 6 4.03 6 9 6Z" />
                </g>
              </svg> 阅读量 {{ article.readNum }}
            </div>

            <div class="article-content" v-viewer v-html="article.content" v-highlight>
            </div>

            <!-- 点赞 + 评论按钮 -->
            <div class="flex justify-end items-center mt-6 mb-4 gap-5 text-sm">
              <button @click="handleLikeArticle" class="flex items-center gap-1.5 transition-colors">
                <span style="font-size: 16px;" :class="isLiked ? 'text-red-500' : 'gray-400'">❤️</span>
                <span :class="isLiked ? 'text-red-500' : 'gray-500'">点赞 ({{ likeCount }})</span>
              </button>
              <button @click="showCommentPanel = true" class="flex items-center gap-1.5 text-gray-500 hover:text-blue-500 transition-colors">
                <el-icon size="16"><ChatDotRound /></el-icon>
                <span>评论 ({{ commentCount }})</span>
              </button>
            </div>

            <!-- 标签 -->
            <div class="mt-5 mb-5">
              <div @click="goTagArticleListPage(item.id, item.name)" v-for="(item, index) in article.tags"
                   :key="index"
                   class="inline-block rounded-full bg-green-100 text-green-800 text-sm font-medium mr-3 mb-2 px-2.5 py-0.5 rounded dark:bg-green-900 dark:text-green-300 hover:bg-green-200 hover:text-green-900">
                # {{ item.name }}
              </div>
            </div>
          </article>

          <!-- 上下篇 -->
          <div class="article-footer flex justify-between">
            <div class="cursor-pointer">
              <a v-if="article.preArticleId" @click="goArticleDetail(article.preArticleId)">
                <span class="desc"><svg class="inline w-2 h-2 mr-1 mb-3px text-gray-500" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 8 14"><path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 1 1.3 6.326a.91.91 0 0 0 0 1.348L7 13" /></svg>上一篇</span>
                <span class="hover:text-blue-700 block">{{ article.preArticleTitle }}</span>
              </a>
            </div>
            <div class="cursor-pointer text-right">
              <a v-if="article.nextArticleId" @click="goArticleDetail(article.nextArticleId)">
                <span class="desc">下一篇 <svg class="inline w-2 h-2 ml-1 mb-3px text-gray-500" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 8 14"><path stroke="currentColor" stroke-linejoin="round" stroke-width="2" d="m1 13 5.7-5.326a.909.909 0 0 0 0-1.348L1 1" /></svg></span>
                <span class="hover:text-blue-700 block">{{ article.nextArticleTitle }}</span>
              </a>
            </div>
          </div>
        </div>
      </div>

      <!-- 右侧：分类 + 标签 -->
      <div class="hidden lg:block col-span-3 sticky top-20 h-[calc(100vh-80px)] overflow-y-auto sidebar-no-scrollbar">
        <!-- 文章分类 -->
        <div class="mb-3 w-full font-medium p-5 bg-white border border-gray-200 rounded-lg dark:bg-gray-800 dark:border-gray-700">
          <h2 class="mb-2 font-bold text-gray-900 uppercase dark:text-white">分类</h2>
          <div class="text-sm font-medium text-gray-900 bg-white rounded-lg dark:bg-gray-700">
            <a @click="goCatagoryArticleListPage(item.id, item.name)" v-for="(item, index) in categories" :key="index"
               class="flex items-center px-4 py-2 rounded-lg cursor-pointer hover:bg-gray-100 hover:text-blue-700">
              <svg class="w-4 h-4 mr-2 text-gray-800" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 21 18">
                <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="0.9" d="M2.539 17h12.476l4-9H5m-2.461 9a1 1 0 0 1-.914-1.406L5 8m-2.461 9H2a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h5.443a1 1 0 0 1 .8.4l2.7 3.6H16a1 1 0 0 1 1 1v2H5" />
              </svg>
              {{ item.name }}
            </a>
          </div>
        </div>

        <!-- 文章标签 -->
        <div class="mb-3 w-full font-medium p-5 bg-white border border-gray-200 rounded-lg dark:bg-gray-800 dark:border-gray-700">
          <h2 class="mb-2 font-bold text-gray-900 uppercase dark:text-white">标签</h2>
          <div class="flex flex-wrap gap-1">
            <div @click="goTagArticleListPage(item.id, item.name)" v-for="(item, index) in tags" :key="index"
                 class="text-xs bg-green-100 text-green-800 px-2.5 py-0.5 rounded dark:bg-green-900 dark:text-green-300 hover:bg-green-200 cursor-pointer">
              {{ item.name }}
            </div>
          </div>
        </div>
      </div>

    </div>

    <!-- 评论面板 -->
    <div class="comment-panel" :class="{ show: showCommentPanel }">
      <div class="comment-header">
        <h3>全部评论（{{ commentCount }}）</h3>
        <span class="close-btn" @click="showCommentPanel = false">×</span>
      </div>

      <div class="comment-list-wrap">
        <div v-for="comment in rootComments" :key="comment.id" class="comment-item">
          <div class="comment-user">
            <el-avatar :src="getUserAvatar(comment.userId)" />
            <div class="info">
              <div class="nickname">{{ comment.nickname }}</div>
              <div class="time">{{ comment.createTime }}</div>
            </div>
          </div>
          <div class="content">{{ comment.content }}</div>
          <div class="comment-actions">
            <button @click="handleCommentLike(comment)">
              ❤️ {{ comment.isCommentLiked ? '取消点赞' : '点赞' }} ({{ comment.likeNum }})
            </button>
            <button @click="replyToComment(comment)">回复</button>
          </div>

          <div class="child-comments" v-if="comment.children && comment.children.length">
            <div v-for="child in comment.children" :key="child.id" class="child-comment">
              <el-avatar :src="getUserAvatar(child.userId)" size="small" />
              <div class="child-text">
                <span class="child-nickname">{{ child.nickname }}</span>
                <span class="child-content">{{ child.content }}</span>
              </div>
              <div class="child-actions">
                <button @click="handleCommentLike(child)">❤️ ({{ child.likeNum }})</button>
              </div>
            </div>
          </div>
        </div>

        <div v-if="commentList.length === 0" class="no-comment">暂无评论</div>
      </div>

      <!-- 输入框区域（带回复提示） -->
      <div class="comment-input-wrap">
        <div v-if="replyingComment" class="reply-tip">
          回复 @{{ replyingComment.nickname }}
          <span class="cancel-reply" @click="cancelReply()">×</span>
        </div>
        <el-input
            v-model="commentContent"
            type="textarea"
            rows="2"
            placeholder="写下你的评论..."
        />
        <div class="text-right mt-2">
          <el-button type="primary" @click="handleSubmitComment">发表评论</el-button>
        </div>
      </div>
    </div>

    <div class="comment-mask" :class="{ show: showCommentPanel }" @click="showCommentPanel = false"></div>
  </div>
  <Footer></Footer>
</template>


<script setup>
import Header from '@/layouts/components/Header.vue'
import Footer from '@/layouts/components/Footer.vue'
import { useRoute, useRouter } from 'vue-router';
import { getArticleDetail } from '@/api/frontend/article';
import { ref, reactive, onMounted, computed, onUnmounted } from 'vue'
import { getCategories } from '@/api/frontend/category'
import { getTags } from '@/api/frontend/tag'
import { ChatDotRound } from '@element-plus/icons-vue'

import { getArticleLikeCount, likeArticle, cancelLikeArticle, getArticleIsLike } from '@/api/admin/articleLike'
import { getCommentPageList, publishComment } from '@/api/admin/comment'
import { likeComment, cancelLikeComment, getCommentIsLike } from '@/api/admin/commentLike'
import { marked } from 'marked'

const router = useRouter()
const route = useRoute()
// const articleId = Number(route.query.articleId)
const articleId = Number(route.query.id || route.query.articleId)
const isLiked = ref(false);
const likeCount = ref(0);

const article = reactive({
  title: '',
  content: '',
  updateTime: '',
  readNum: 0,
  categoryId: null,
  categoryName: '',
  preArticleId: null,
  preArticleTitle: '',
  nextArticleId: null,
  nextArticleTitle: '',
  tags: [],
})

const commentCount = ref(0)
const showCommentPanel = ref(false)
const commentContent = ref('')
const commentList = ref([])
const replyingComment = ref(null);

// 头像
const getUserAvatar = (userId) => {
  const avatarMap = {
    0: "https://picsum.photos/id/1/200/200",
    1: "https://picsum.photos/id/2/200/200",
    2: "https://picsum.photos/id/3/200/200",
    3: "https://picsum.photos/id/4/200/200",
  };
  return avatarMap[userId] || avatarMap[0];
};

// 点赞
const loadLikeCount = async () => {
  try {
    const res = await getArticleLikeCount({ articleId });
    likeCount.value = res.data || 0;
  } catch (e) {
    likeCount.value = 0;
  }
};
const handleLikeArticle = async () => {
  try {
    if (isLiked.value) {
      await cancelLikeArticle({ articleId });
      isLiked.value = false;
      likeCount.value = Math.max(0, likeCount.value - 1);
      ElMessage.success("取消点赞");
    } else {
      await likeArticle({ articleId });
      isLiked.value = true;
      likeCount.value += 1;
      ElMessage.success("点赞成功");
    }
  } catch (e) {
    ElMessage.warning("操作失败");
  }
};
const loadArticleIsLike = async () => {
  try {
    const res = await getArticleIsLike({ articleId });
    isLiked.value = res.data;
  } catch (e) {
    isLiked.value = false;
  }
};

// 评论
const loadCommentList = async () => {
  try {
    const res = await getCommentPageList({ articleId, current: 1, size: 100 });
    let list = res.data.records || [];
    for (let item of list) {
      try {
        const r = await getCommentIsLike(item.id);
        item.isCommentLiked = r.data;
      } catch (e) {
        item.isCommentLiked = false;
      }
      item.likeNum = item.likeNum || 0;
    }
    commentList.value = [...list];
    commentCount.value = res.data.total || 0;
  } catch (e) {
    commentList.value = [];
    commentCount.value = 0;
  }
};
const rootComments = computed(() => {
  const roots = commentList.value.filter(c => c.parentId === 0);
  roots.forEach(root => {
    root.children = commentList.value.filter(c => c.parentId === root.id);
  });
  return roots;
});
const getReplyNickname = (parentId) => {
  const p = commentList.value.find(c => c.id === parentId);
  return p ? p.nickname : '楼主';
};
const replyToComment = (item) => {
  replyingComment.value = item;
};
const cancelReply = () => {
  replyingComment.value = null;
};
const handleCommentLike = async (comment) => {
  try {
    if (comment.isCommentLiked) {
      await cancelLikeComment({ commentId: comment.id });
      comment.isCommentLiked = false;
      comment.likeNum = Math.max(0, (comment.likeNum || 0) - 1);
      ElMessage.success("取消点赞");
    } else {
      await likeComment({ commentId: comment.id });
      comment.isCommentLiked = true;
      comment.likeNum = (comment.likeNum || 0) + 1;
      ElMessage.success("点赞成功");
    }
  } catch (e) {
    ElMessage.warning("操作失败");
  }
};
const handleSubmitComment = async () => {
  if (!commentContent.value) {
    ElMessage.warning('请输入评论内容');
    return;
  }
  try {
    await publishComment({
      articleId,
      content: commentContent.value,
      userId: 1,
      parentId: replyingComment.value ? replyingComment.value.id : 0,
    });
    ElMessage.success('评论发表成功');
    commentContent.value = '';
    replyingComment.value = null;
    loadCommentList();
  } catch (e) {
    ElMessage.error('评论发表失败');
  }
};

// 文章详情
// 查询文章详情（你原来正常的版本！）
const queryArticleDetail = async (id) => {
  const res = await getArticleDetail(id);
  const data = res.data;

  article.content = data.content;

  article.title = data.title;
  article.updateTime = data.updateTime;
  article.readNum = data.readNum;
  article.categoryId = data.categoryId;
  article.categoryName = data.categoryName;
  article.tags = data.tags;

  article.preArticleId = data.preArticle?.id || null;
  article.preArticleTitle = data.preArticle?.title || '';
  article.nextArticleId = data.nextArticle?.id || null;
  article.nextArticleTitle = data.nextArticle?.title || '';
};
// 路由跳转
const goArticleDetail = (id) => {
  router.push({ path: '/article/detail', query: { articleId: id } });
};
const categories = ref([]);
getCategories().then(res => categories.value = res.data);
const tags = ref([]);
getTags().then(res => tags.value = res.data);
const goCatagoryArticleListPage = (id, name) => {
  router.push({ path: '/category/list', query: { id, name } });
};
const goTagArticleListPage = (id, name) => {
  router.push({ path: '/tag/list', query: { id, name } });
};

// ====================== 文章目录 ======================
const tocList = ref([])
const activeTocIndex = ref(0)

const parseToc = () => {
  const content = article.content || ''
  if (!content) return
  const div = document.createElement('div')
  div.innerHTML = content
  const headings = div.querySelectorAll('h1, h2, h3')
  const list = []
  headings.forEach((el, index) => {
    const title = el.innerText?.trim()
    if (!title) return
    let level = 2
    if (el.tagName === 'H1') level = 1
    if (el.tagName === 'H3') level = 3
    el.setAttribute('id', `heading-${index}`)
    list.push({ title, level, id: `heading-${index}` })
  })
  tocList.value = list
  article.content = div.innerHTML
}

const scrollToTitle = (item) => {
  const el = document.getElementById(item.id)
  if (el) {
    el.scrollIntoView({ behavior: 'smooth', block: 'start' })
  }
}

const handleScroll = () => {
  const list = tocList.value
  if (list.length === 0) return
  let currentIndex = 0
  for (let i = list.length - 1; i >= 0; i--) {
    const el = document.getElementById(list[i].id)
    if (el && el.getBoundingClientRect().top <= 100) {
      currentIndex = i
      break
    }
  }
  activeTocIndex.value = currentIndex
}

// 生命周期
onMounted(async () => {
  await queryArticleDetail(articleId);
  parseToc();
  await loadLikeCount();
  await loadArticleIsLike();
  await loadCommentList();
  window.addEventListener('scroll', handleScroll);
});

onUnmounted(() => {
  window.removeEventListener('scroll', handleScroll);
});

</script>
<style scoped>
@import '@/assets/fronted/article-detail.css';

</style>