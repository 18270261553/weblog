import axios from "@/axios"

// 发布评论
export function publishComment(data) {
    return axios.post("/admin/comment/publish", data)
}

// 查询评论列表（分页）
export function getCommentPageList(data) {
    return axios.post("/admin/comment/list", data)
}

// 删除评论
export function deleteComment(commentId) {
    return axios.post("/admin/comment/delete", { commentId })
}