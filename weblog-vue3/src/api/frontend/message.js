import axios from "@/axios"

/**
 * 发表留言
 * data: { username, email, content, parentId }
 */
export function publishMessage(data) {
    return axios.post("/api/message/publish", data)
}

/**
 * 获取留言列表（前台展示）
 */
export function getMessageList() {
    return axios.get("/api/message/list")
}

/**
 * 留言点赞
 * @param {number} id 留言ID
 */
export function likeMessage(id) {
    return axios.post(`/api/message/like/${id}`)
}