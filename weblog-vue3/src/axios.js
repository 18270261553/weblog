import axios from "axios";
import { notification, showMessage } from '@/composables/util'
import { getToken } from '@/composables/auth'
import store from "@/store";

const instance = axios.create({
    baseURL: import.meta.env.VITE_APP_BASE_API,
    timeout: 7000,
    headers: {
        'Content-Type': 'application/json;charset=UTF-8'
    },
    withCredentials: true  // ← 关键：允许携带 Cookie
});

// 添加请求拦截器
instance.interceptors.request.use(function (config) {
    const token = getToken()
    if (token) {
        config.headers['Authorization'] = 'Bearer ' + token
    }
    return config;
}, function (error) {
    return Promise.reject(error);
});

// 添加响应拦截器
instance.interceptors.response.use(function (response) {
    return response.data;
}, function (error) {
    let status = error.response?.status
    if (status == 401 || status == 402) {
        store.dispatch('logout').finally(() => location.reload())
    }

    let isSuccess = error.response?.data?.success
    if (!isSuccess) {
        let message = error.response?.data?.message || '请求失败'
        showMessage(message, 'error')
    }

    return Promise.reject(error);
});

export default instance;