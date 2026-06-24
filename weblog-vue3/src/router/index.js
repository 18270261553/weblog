import { createRouter, createWebHashHistory } from 'vue-router';

const routes = [
    // ========== 后台管理 ==========
    {
        path: '/admin',
        component: () => import('@/layouts/admin.vue'),
        children: [
            {
                path: '',
                component: () => import('@/pages/admin/index.vue'),
                meta: { title: '仪表盘' }
            },
            {
                path: 'data/center',
                component: () => import('@/pages/admin/data-center.vue'),
                meta: { title: '数据中心' }
            },
            {
                path: 'screenView',
                component: () => import('@/pages/admin/screenView.vue'),
                meta: { title: '中控大屏' }
            },
            {
                path: 'article/list',
                component: () => import('@/pages/admin/article-list.vue'),
                meta: { title: '文章管理' }
            },
            {
                path: 'category/list',
                component: () => import('@/pages/admin/category-list.vue'),
                meta: { title: '分类管理' }
            },
            {
                path: 'tag/list',
                component: () => import('@/pages/admin/tag-list.vue'),
                meta: { title: '标签管理' }
            },
            {
                path: 'blog/setting',
                component: () => import('@/pages/admin/blog-setting.vue'),
                meta: { title: '博客设置' }
            },
            {
                path: 'comment/list',
                component: () => import('@/pages/admin/comment-list.vue'),
                meta: { title: '评论管理' }
            },
            {
                path: 'messageBoard',
                component: () => import('@/pages/admin/message-board.vue'),
                meta: { title: '留言管理' }
            }
        ]
    },

    // ========== 前台页面 ==========

    {
        path: '/',
        component: () => import('@/pages/frontend/home.vue'),
        meta: { title: '欢迎页' }
    },
    {
        path: '/index',
        component: () => import('@/pages/frontend/index.vue'),
        meta: { title: 'WeBlog首页' }
    },
    {
        path: '/about',
        component: () => import('@/pages/frontend/About.vue'),
        meta: { title: '关于页' }
    },
    {
        path: '/explore',
        component: () => import('@/pages/frontend/explore.vue'),
        meta: { title: '开始探索页' }
    },
    {
        path: '/about',
        component: () => import('@/pages/about.vue'),
        meta: { title: '关于' }
    },
    {
        path: '/article/detail',
        component: () => import('@/pages/frontend/article-detail.vue'),
        meta: { title: '文章详情页' }
    },
    {
        path: '/category',
        component: () => import('@/pages/frontend/category-list.vue'),
        meta: { title: '分类' }
    },
    {
        path: '/tag',
        component: () => import('@/pages/frontend/tag-list.vue'),
        meta: { title: '标签' }
    },
    {
        path: '/category/list',
        component: () => import('@/pages/frontend/category-article-list.vue'),
        meta: { title: '分类文章列表' }
    },
    {
        path: '/tag/list',
        component: () => import('@/pages/frontend/tag-article-list.vue'),
        meta: { title: '标签文章列表' }
    },
    {
        path: '/archive',
        component: () => import('@/pages/frontend/archive.vue'),
        meta: { title: '归档' }
    },
    {
        path: '/aiChatbot',
        component: () => import('@/pages/frontend/aiChatbot.vue'),
        meta: { title: 'AI搜索' }
    },
    {
        path: '/messageBoard',
        component: () => import('@/pages/frontend/message-board.vue'),
        meta: { title: '留言板' }
    },
    {
        path: '/search',
        component: () => import('@/pages/frontend/search.vue'),
        meta: { title: '搜索结果' }
    },

    // ========== 登录注册 ==========
    {
        path: '/login',
        component: () => import('@/pages/admin/login.vue'),
        meta: { title: '登录页' }
    },
    {
        path: '/register',
        component: () => import('@/pages/admin/register.vue'),
        meta: { title: '注册页' }
    },

    // ========== 404 ==========
    {
        path: '/:pathMatch(.*)*',
        name: 'NotFound',
        component: () => import('@/pages/404.vue'),
        meta: { title: '404' }
    }
]

const router = createRouter({
    history: createWebHashHistory(),
    routes,
})

export default router