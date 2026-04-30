<template>
  <div>
    <div class="grid grid-cols-6 h-screen bg-white">
      <!-- 左边栏 -->
      <div class="col-span-6 md:col-span-3 sm:col-span-6">
        <div class="login-container-left flex justify-center items-center flex-col">
          <div class="animate__animated animate__bounceInLeft items-center flex flex-col">
            <h2 class="font-bold text-4xl mb-7 text-white">Weblog 博客{{ isRegister ? '注册' : '登录' }}</h2>
            <p class="text-white">一款由 Spring Boot + Mybaits Plus + Vue 3.2 + Vite 4 开发的前后端分离博客。</p>
            <img src="@/assets/developer.png" class="login-image">
          </div>
        </div>
      </div>
      <!-- 右边栏 -->
      <div class="col-span-6 px-3 md:col-span-3 sm:col-span-3">
        <div
            class="login-container-right flex justify-center items-center flex-col animate__animated animate__bounceInRight animate__fast">
          <h2 class="font-bold text-3xl text-gray-800 mt-5">欢迎{{ isRegister ? '注册' : '回来' }}</h2>
          <div class="flex items-center justify-center my-5 text-gray-400 space-x-2">
            <span class="h-[1px] w-16 bg-gray-200"></span>
            <span>{{ isRegister ? '新用户注册' : '账号密码登录' }}</span>
            <span class="h-[1px] w-16 bg-gray-200"></span>
          </div>
          <div>
            <el-form ref="formRef" :rules="rules" :model="form" class="w-[300px]">
              <el-form-item prop="username">
                <el-input v-model="form.username" :prefix-icon="User" placeholder="请输入用户名" size="large" clearable/>
              </el-form-item>
              <el-form-item prop="password">
                <el-input v-model="form.password" type="password" autocomplete="off" :prefix-icon="Lock"
                          placeholder="请输入密码" show-password size="large" clearable/>
              </el-form-item>

              <!-- 注册时显示确认密码 -->
              <el-form-item v-if="isRegister" prop="repeatPassword">
                <el-input v-model="form.repeatPassword" type="password" autocomplete="off" :prefix-icon="Lock"
                          placeholder="请确认密码" show-password size="large" clearable/>
              </el-form-item>

              <el-form-item>
                <el-button round type="primary" @click="isRegister ? onRegister() : onSubmit()" :loading="loading"
                           class="w-[300px] login-btn mt-4" size="large">
                  {{ isRegister ? '注 册' : '登 录' }}
                </el-button>
              </el-form-item>
            </el-form>

            <!-- 切换登录/注册 -->
            <div class="text-center text-gray-500 mt-3">
              <span @click="toggleMode" class="cursor-pointer text-blue-500">
                {{ isRegister ? '已有账号？立即登录' : '没有账号？立即注册' }}
              </span>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { reactive, ref, onMounted, onBeforeUnmount } from 'vue'
import { login, register } from '@/api/admin/user';
import { showMessage } from '@/composables/util'
import { useRouter } from 'vue-router'
import { useStore } from 'vuex'
import { setToken } from '@/composables/auth'
import { User, Lock } from '@element-plus/icons-vue'

const router = useRouter()
const store = useStore()

// 切换登录/注册
const isRegister = ref(false)

const form = reactive({
  username: '',
  password: '',
  repeatPassword: ''
})

const validateRepeatPassword = (rule, value, callback) => {
  if (value === '') {
    callback(new Error('请再次输入密码'))
  } else if (value !== form.password) {
    callback(new Error('两次输入的密码不一致'))
  } else {
    callback()
  }
}

const rules = {
  username: [
    { required: true, message: '用户名不能为空', trigger: 'blur' },
    { min: 3, max: 20, message: '用户名长度在 3 到 20 个字符', trigger: 'blur' }
  ],
  password: [
    { required: true, message: '密码不能为空', trigger: 'blur' },
    { min: 3, max: 20, message: '密码长度在 6 到 20 个字符', trigger: 'blur' }
  ],
  repeatPassword: [
    { validator: validateRepeatPassword, trigger: 'blur' }
  ]
}

const formRef = ref(null)
const loading = ref(false)

// 登录
const onSubmit = () => {
  formRef.value.validate((valid) => {
    if (!valid) return
    loading.value = true
    login(form.username, form.password)
        .then(res => {
          if (res.success) {
            showMessage('登录成功', 'success')
            setToken(res.data.token)
            router.push('/admin')
          } else {
            showMessage(res.message, 'error')
          }
        }).finally(() => {
      loading.value = false
    })
  })
}

// 注册
const onRegister = () => {
  formRef.value.validate((valid) => {
    if (!valid) return

    loading.value = true
    register({
      username: form.username,
      password: form.password,
      repeatPassword: form.repeatPassword
    }).then(res => {
      if (res.success) {
        showMessage('注册成功！请登录', 'success')
        isRegister.value = false
        // 清空表单
        form.username = ''
        form.password = ''
        form.repeatPassword = ''
      } else {
        showMessage(res.message, 'error')
      }
    }).catch(() => {
      showMessage('注册失败，请稍后重试', 'error')
    }).finally(() => {
      loading.value = false
    })
  })
}

// 切换模式
const toggleMode = () => {
  isRegister.value = !isRegister.value
  // 清空表单
  form.username = ''
  form.password = ''
  form.repeatPassword = ''
  // 清除验证
  setTimeout(() => {
    formRef.value?.clearValidate()
  }, 100)
}

function onKeyUp(e) {
  if (e.key == 'Enter') {
    isRegister.value ? onRegister() : onSubmit()
  }
}

onMounted(() => {
  document.addEventListener('keyup', onKeyUp)
})

onBeforeUnmount(() => {
  document.removeEventListener('keyup', onKeyUp)
})
</script>

<style>
:deep([type='text']:focus) {
  border-color: transparent !important;
}

.login-container-left {
  height: 100%;
  background: #001428;
  color: #fff;
}

.login-container-right {
  height: 100%;
}

.login-image {
  height: 450px;
}
</style>
