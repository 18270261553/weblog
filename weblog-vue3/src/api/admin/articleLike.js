import axios from "@/axios"

// 文章点赞
export function likeArticle(data) {
    return axios.post("/admin/article/like/add", data)
}

// 取消文章点赞
export function cancelLikeArticle(data) {
    return axios.post("/admin/article/like/cancel", data)
}

// 获取文章点赞数
export function getArticleLikeCount(data) {  // 这里改成 data！！！
    return axios.post("/admin/article/like/count", data)
}

// 查询当前用户是否已点赞文章
export function getArticleIsLike(data) {  // 这里改成 data！！！
    return axios.post("/admin/article/like/isLike", data)
}