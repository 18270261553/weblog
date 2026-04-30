import axios from "@/axios"

// 评论点赞
export function likeComment(data) {
    return axios.post("/admin/comment/like/add", data)
}

// 取消评论点赞
export function cancelLikeComment(data) {
    return axios.post("/admin/comment/like/cancel", data)
}

// 获取评论点赞数量
export function getCommentLikeCount(commentId) {
    return axios.post("/admin/comment/like/count", { commentId })
}

// 查询当前用户是否已点赞评论
export function getCommentIsLike(commentId) {
    return axios.post("/admin/comment/like/isLike", {commentId} )
}