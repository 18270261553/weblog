import axios from "@/axios"


export function getArchives(data) {
    return axios.post("/archive/list", data)
}

export function getArchiveArticles(data) {
    return axios.post("/archive/list", data)
}

