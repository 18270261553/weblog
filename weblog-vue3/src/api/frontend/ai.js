import axios from "@/axios"

// 发送聊天消息 - 修正路径
export const sendChatMessage = (data) => {
    return axios.post("/api/ai/chat", data)  // 改成 /api/ai/chat
}

// 流式响应 - 路径已经正确，保持不变
export const sendChatMessageStream = async (data, onMessage, onError, onComplete) => {
    try {
        const response = await fetch('/api/ai/chat/stream', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(data)
        })
        // ... 其余代码不变
    } catch (error) {
        onError && onError(error)
    }
}