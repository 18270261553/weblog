import axios from "@/axios"

/**
 * 分页查询留言列表（管理端）
 */
export function getMessagePageList(data) {
    return axios.post("/admin/message/list", data)
}

/**
 * 更新留言状态（审核通过/拒绝）
 * data: { id, status }
 * status: 0-待审核，1-已通过，2-已拒绝
 */
export function updateMessageStatus(data) {
    return axios.post("/admin/message/status/update", data)
}

/**
 * 删除留言
 * data: { id }
 */
export function deleteMessage(data) {
    return axios.post("/admin/message/delete", data)
}