import axios from "@/axios"

export function searchArticles(data) {
    return axios.post("/index/article/search", data)
}