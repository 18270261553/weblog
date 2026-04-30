import { createRouter, createWebHashHistory } from 'vue-router';
import AdminIndex from '@/pages/admin/index.vue';
import About from '@/pages/about.vue';
import NotFound from '@/pages/404.vue';
import AdminLogin from '@/pages/admin/login.vue';
import AdminRegister from '@/pages/admin/register.vue';
import Admin from '@/layouts/admin.vue'
import AdminArticleList from '@/pages/admin/article-list.vue'
import AdminCategoryList from '@/pages/admin/category-list.vue'
import AdminTagList from '@/pages/admin/tag-list.vue'
import AdminBlogSetting from '@/pages/admin/blog-setting.vue'
import Index from '@/pages/frontend/index.vue'
import ArticleDetail from '@/pages/frontend/article-detail.vue'
import CategoryList from '@/pages/frontend/category-list.vue'
import TagList from '@/pages/frontend/tag-list.vue'
import CategoryArticleList from '@/pages/frontend/category-article-list.vue'
import TagArticleList from '@/pages/frontend/tag-article-list.vue'
import ArchiveList from '@/pages/frontend/archive-list.vue'
import CommentList from "@/pages/admin/comment-list.vue";

const routes = [
    {
        path: '/admin',
        component: Admin,
        children: [{
            path: '/admin',
            component: AdminIndex,
            meta: {
                title: '仪表盘'
            }
        }, {
            path: '/admin/article/list',
            component: AdminArticleList,
            meta: {
                title: '文章管理'
            }
        }, {
            path: '/admin/category/list',
            component: AdminCategoryList,
            meta: {
                title: '分类管理'
            }
        }, {
            path: '/admin/tag/list',
            component: AdminTagList,
            meta: {
                title: '标签管理'
            }
        }, {
            path: '/admin/blog/setting',
            component: AdminBlogSetting,
            meta: {
                title: '博客设置'
            }
        }
        , {
            path: '/admin/comment/list',
            component: CommentList,
            meta: {
                title: '评论管理'
            }
        }
        ]

    },
    {
        path: '/about',
        component: About
    },
    {
        path: '/:pathMatch(.*)*',
        name: 'NotFound',
        component: NotFound
    },
    {
        path: '/login',
        component: AdminLogin,
        meta: {
            title: '登录页'
        }
    },
    {
        path: '/register',
        component: AdminRegister,
        meta: {
            title: '注册页'
        }
    },
    {
        path: '/',
        component: Index,
        meta: {
            title: 'WeBlog首页'
        }
    },
    {
        path: '/article/detail',
        component: ArticleDetail,
        meta: {
            title: '文章详情页'
        },
    },
    {
        path: '/category',
        component: CategoryList,
        meta: {
            title: '分类'
        },
    },
    {
        path: '/tag',
        component: TagList,
        meta: {
            title: '标签'
        },
    },
    {
        path: '/category/list',
        component: CategoryArticleList,
        meta: {
            title: '分类文章列表'
        },
    },
    {
        path: '/tag/list',
        component: TagArticleList,
        meta: {
            title: '标签文章列表'
        },
    },
    {
        path: '/archive',
        name: 'Archive',
        component: () => import('@/pages/frontend/archive.vue'),
        meta: { title: '归档' }
    },
    {
        path: '/aiChatbot',
        name: 'aiChatbot',
        component: () => import('@/pages/frontend/aiChatbot.vue'),
        meta: { title: 'AI搜索' }
    },
    {
        path: '/search',
        name: 'Search',
        component: () => import('@/pages/frontend/search.vue'),
        meta: { title: '搜索结果' }
    }
]

const router = createRouter({
    history: createWebHashHistory(),
    routes,
})

export default router
