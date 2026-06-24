<template>
  <div class="message-board-container">
    <!-- 查询区域 -->
    <el-card shadow="never" :body-style="{ padding: '20px' }" class="mb-5 border-1">
      <el-form :inline="true" :model="searchForm" class="demo-form-inline">
        <el-form-item label="状态">
          <el-select v-model="searchForm.status" placeholder="全部" clearable @change="handleSearch">
            <el-option label="待审核" :value="0" />
            <el-option label="已通过" :value="1" />
            <el-option label="已拒绝" :value="2" />
          </el-select>
        </el-form-item>
        <el-form-item label="发布时间">
          <el-date-picker
              v-model="dateRange"
              type="daterange"
              range-separator="至"
              start-placeholder="开始时间"
              end-placeholder="结束时间"
              value-format="YYYY-MM-DD HH:mm:ss"
              @change="handleDateChange"
          />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" :icon="Search" @click="handleSearch">查询</el-button>
          <el-button :icon="RefreshRight" @click="handleReset">重置</el-button>
        </el-form-item>
      </el-form>
    </el-card>

    <!-- 表格区域 -->
    <el-card shadow="never" class="border-1">
      <el-table :data="tableData" stripe style="width: 100%" v-loading="loading">
        <el-table-column prop="id" label="ID" width="80" align="center" />
        <el-table-column prop="username" label="昵称" width="120" />
        <el-table-column prop="content" label="留言内容" min-width="200" show-overflow-tooltip />
        <el-table-column prop="likeCount" label="点赞数" width="100" align="center" />
        <el-table-column label="状态" width="120" align="center">
          <template #default="scope">
            <el-tag :type="getStatusType(scope.row.status)" size="small">
              {{ getStatusText(scope.row.status) }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="createTime" label="发布时间" width="180" />
        <el-table-column label="操作" width="240" align="center" fixed="right">
          <template #default="scope">
            <!-- 待审核状态显示审核按钮 -->
            <template v-if="scope.row.status === 0">
              <el-button size="small" type="success" @click="handleApprove(scope.row)">
                <el-icon class="mr-1"><Check /></el-icon>
                通过
              </el-button>
              <el-button size="small" type="danger" @click="handleReject(scope.row)">
                <el-icon class="mr-1"><Close /></el-icon>
                拒绝
              </el-button>
            </template>
            <!-- 其他状态显示删除按钮 -->
            <template v-else>
              <el-button size="small" type="danger" @click="handleDelete(scope.row)">
                <el-icon class="mr-1"><Delete /></el-icon>
                删除
              </el-button>
            </template>
          </template>
        </el-table-column>
      </el-table>

      <!-- 分页 -->
      <div class="mt-5 flex item-center justify-center">
        <el-pagination
            v-model:current-page="page.current"
            v-model:page-size="page.size"
            :page-sizes="[10, 20, 50]"
            background
            layout="total, sizes, prev, pager, next, jumper"
            :total="page.total"
            @size-change="handleSizeChange"
            @current-change="getTableData"
        />
      </div>
    </el-card>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { getMessagePageList, updateMessageStatus, deleteMessage } from '@/api/admin/message'
import { ElMessage, ElMessageBox } from 'element-plus'
import { Search, RefreshRight, Check, Close, Delete } from '@element-plus/icons-vue'

// ===================== 搜索表单 =====================
const searchForm = reactive({
  status: null,
  startDate: '',
  endDate: ''
})

const dateRange = ref([])

// ===================== 分页 =====================
const page = reactive({
  current: 1,
  size: 10,
  total: 0
})

// ===================== 表格数据 =====================
const tableData = ref([])
const loading = ref(false)

// ===================== 状态映射 =====================
const statusMap = {
  0: { text: '待审核', type: 'warning' },
  1: { text: '已通过', type: 'success' },
  2: { text: '已拒绝', type: 'danger' }
}

const getStatusText = (status) => statusMap[status]?.text || '未知'
const getStatusType = (status) => statusMap[status]?.type || 'info'

// ===================== 获取数据 =====================
const getTableData = async () => {
  loading.value = true
  try {
    const res = await getMessagePageList({
      current: page.current,
      size: page.size,
      status: searchForm.status,
      startDate: searchForm.startDate,
      endDate: searchForm.endDate
    })
    if (res.success) {
      tableData.value = res.data || []
      page.total = res.total || 0
      page.current = res.current || 1
    }
  } catch (error) {
    console.error('获取留言列表失败:', error)
    ElMessage.error('获取留言列表失败')
  } finally {
    loading.value = false
  }
}

// ===================== 搜索 =====================
const handleSearch = () => {
  page.current = 1
  getTableData()
}

// ===================== 重置 =====================
const handleReset = () => {
  searchForm.status = null
  searchForm.startDate = ''
  searchForm.endDate = ''
  dateRange.value = []
  page.current = 1
  getTableData()
}

// ===================== 日期选择 =====================
const handleDateChange = (val) => {
  if (val && val.length === 2) {
    searchForm.startDate = val[0]
    searchForm.endDate = val[1]
  } else {
    searchForm.startDate = ''
    searchForm.endDate = ''
  }
}

// ===================== 分页 =====================
const handleSizeChange = (val) => {
  page.size = val
  getTableData()
}

// ===================== 审核通过 =====================
const handleApprove = async (row) => {
  try {
    await ElMessageBox.confirm(`确定要通过留言 " ${row.content.slice(0, 20)}${row.content.length > 20 ? '...' : ''} " 吗？`, '提示', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'info'
    })
    const res = await updateMessageStatus({ id: row.id, status: 1 })
    if (res.success) {
      ElMessage.success('审核通过')
      getTableData()
    } else {
      ElMessage.error(res.message || '操作失败')
    }
  } catch (error) {
    if (error !== 'cancel') {
      console.error('审核失败:', error)
      ElMessage.error('操作失败')
    }
  }
}

// ===================== 审核拒绝 =====================
const handleReject = async (row) => {
  try {
    await ElMessageBox.confirm(`确定要拒绝留言 " ${row.content.slice(0, 20)}${row.content.length > 20 ? '...' : ''} " 吗？`, '提示', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning'
    })
    const res = await updateMessageStatus({ id: row.id, status: 2 })
    if (res.success) {
      ElMessage.success('已拒绝')
      getTableData()
    } else {
      ElMessage.error(res.message || '操作失败')
    }
  } catch (error) {
    if (error !== 'cancel') {
      console.error('拒绝失败:', error)
      ElMessage.error('操作失败')
    }
  }
}

// ===================== 删除 =====================
const handleDelete = async (row) => {
  try {
    await ElMessageBox.confirm(`确定要删除留言 " ${row.content.slice(0, 20)}${row.content.length > 20 ? '...' : ''} " 吗？此操作不可恢复！`, '警告', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'error'
    })
    const res = await deleteMessage({ id: row.id })
    if (res.success) {
      ElMessage.success('删除成功')
      getTableData()
    } else {
      ElMessage.error(res.message || '删除失败')
    }
  } catch (error) {
    if (error !== 'cancel') {
      console.error('删除失败:', error)
      ElMessage.error('操作失败')
    }
  }
}

// ===================== 初始化 =====================
onMounted(() => {
  getTableData()
})
</script>

<style scoped>
.message-board-container {
  padding: 0;
}

.border-1 {
  border: 1px solid var(--el-border-color-light);
}

.mb-5 {
  margin-bottom: 20px;
}

.mt-5 {
  margin-top: 20px;
}

.mr-1 {
  margin-right: 4px;
}

.flex {
  display: flex;
}

.item-center {
  align-items: center;
}

.justify-center {
  justify-content: center;
}
</style>