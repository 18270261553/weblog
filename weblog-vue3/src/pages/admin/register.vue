NEW_FILE_CODE
<template>
  <div>
    <div class="grid grid-cols-6 h-screen bg-white">
      <!-- 左边栏 -->
      <div class="col-span-6 md:col-span-3 sm:col-span-6">
        <div class="login-container-left flex justify-center items-center flex-col">
          <div class="animate__animated animate__bounceInLeft items-center flex flex-col">
            <h2 class="font-bold text-4xl mb-7 text-white">Weblog 博客注册</h2>
            <p class="text-white">一款由 Spring Boot + Mybaits Plus + Vue 3.2 + Vite 4 开发的前后端分离博客。</p>
            <img src="@/assets/developer.png" class="login-image">
          </div>
        </div>
      </div>
      <!-- 右边栏 -->
      <div class="col-span-6 px-3 md:col-span-3 sm:col-span-6">
        <div
            class="login-container-right flex justify-center items-center flex-col animate__animated animate__bounceInRight animate__fast">
          <h2 class="font-bold text-3xl text-gray-800 mt-5">创建账号</h2>
          <div class="flex items-center justify-center my-5 text-gray-400 space-x-2">
            <span class="h-[1px] w-16 bg-gray-200"></span>
            <span>新用户注册</span>
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
              <el-form-item prop="repeatPassword">
                <el-input v-model="form.repeatPassword" type="password" autocomplete="off" :prefix-icon="Lock"
                          placeholder="请再次输入密码" show-password size="large" clearable/>
              </el-form-item>
              <el-form-item>
                <el-button round type="primary" @click="onSubmit" :loading="loading"
                           class="w-[300px] login-btn mt-4" size="large">
                  注 册
                </el-button>
              </el-form-item>
              <el-form-item>
                <div class="text-center w-[300px]">
                  <span class="text-gray-600">已有账号？</span>
                  <el-link type="primary" @click="goToLogin" class="ml-1">立即登录</el-link>
                </div>
              </el-form-item>
            </el-form>
          </div>

        </div>
      </div>
    </div>

  </div>
</template>

<script setup>
import { reactive, ref, onMounted, onBeforeUnmount } from 'vue'
import { register } from '@/api/admin/user';
import { showMessage } from '@/composables/util'
import { useRouter } from 'vue-router'
import { User, Lock } from '@element-plus/icons-vue'

const router = useRouter()

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
    {
      required: true,
      message: '用户名不能为空',
      trigger: 'blur'
    },
    {
      min: 3,
      max: 20,
      message: '用户名长度在 3 到 20 个字符',
      trigger: 'blur'
    }
  ],
  password: [
    {
      required: true,
      message: '密码不能为空',
      trigger: 'blur',
    },
    {
      min: 3,
      max: 20,
      message: '密码长度在 3 到 20 个字符',
      trigger: 'blur'
    }
  ],
  repeatPassword: [
    {
      validator: validateRepeatPassword,
      trigger: 'blur'
    }
  ]
}

const formRef = ref(null)
const loading = ref(false)

const onSubmit = () => {
  formRef.value.validate((valid) => {
    if (!valid) {
      console.log('验证不通过')
      return false
    }
    loading.value = true
    register(form)
        .then(res => {
          if (res.success == true) {
            showMessage('注册成功，请登录', 'success')
            setTimeout(() => {
              router.push('/login')
            }, 1500)
          } else {
            let message = res.message
            showMessage(message, 'error')
          }
        }).catch(err => {
      showMessage('注册失败，请稍后重试', 'error')
    }).finally(() => {
      loading.value = false
    })
  })
}

function goToLogin() {
  router.push('/login')
}

function onKeyUp(e) {
  if (e.key == 'Enter') {
    onSubmit()
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

.login-container {
  height: 100vh;
  width: 100%;
  background-color: #fff;
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
