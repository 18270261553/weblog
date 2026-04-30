<template>
  <div class="app-container">
    <div class="filter-container">
      <el-input
          v-model="queryParams.articleId"
          placeholder="请输入文章ID"
          style="width: 200px"
          clearable
          @keyup.enter="getList"
      />

      <el-button icon="Search" type="primary" @click="getList">
        搜索
      </el-button>
    </div>

    <el-table
        v-loading="listLoading"
        :data="list"
        border
        style="width:100%;margin-top:10px;"
    >
      <el-table-column label="评论ID" prop="id" width="100" />
      <el-table-column label="文章ID" prop="articleId" width="100" />
      <el-table-column label="评论内容" min-width="350">
        <template #default="scope">
          <div class="text">{{ scope.row.content }}</div>
        </template>
      </el-table-column>
      <el-table-column label="父评论ID" prop="parentId" width="100" />
      <el-table-column label="创建时间" prop="createTime" width="180" />
      <el-table-column label="操作" width="120">
        <template #default="scope">
          <el-button
              type="danger"
              icon="Delete"
              size="small"
              @click="handleDelete(scope.row.id)"
          >
            删除
          </el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 分页兼容你的项目 -->
    <el-pagination
        v-show="total > 0"
        :current-page="queryParams.pageNum"
        :page-size="queryParams.pageSize"
        :total="total"
        layout="total, prev, pager, next"
        @size-change="getList"
        @current-change="handleCurrentChange"
    />
  </div>
</template>

<script setup>
import { getCommentPageList, deleteComment } from "@/api/admin/comment";
import { ElMessage, ElMessageBox } from "element-plus";
import { ref, reactive } from "vue";

const list = ref([]);
const total = ref(0);
const listLoading = ref(false);

const queryParams = reactive({
  articleId: null,
  pageNum: 1,
  pageSize: 10,
});
const getList = async () => {
  listLoading.value = true;
  try {
    const res = await getCommentPageList(queryParams);
    const resData = res.data || {};
    const data = resData.records || [];
    list.value = data;
    total.value = resData.total || 0;
  } catch (err) {
    list.value = [];
    total.value = 0;
  } finally {
    listLoading.value = false;
  }
};
// 切换页码
const handleCurrentChange = (page) => {
  queryParams.pageNum = page;
  getList();
};

// 删除
const handleDelete = async (commentId) => {
  await ElMessageBox.confirm("确定要删除该评论吗？", "提示", {
    type: "warning",
  });

  await deleteComment(commentId);
  ElMessage.success("删除成功！");
  getList();
};

// 初始化
getList();
</script>

<style scoped>
.text {
  word-break: break-all;
  white-space: pre-wrap;
  line-height: 1.5;
}
</style>