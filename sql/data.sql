/*
 Navicat Premium Dump SQL

 Source Server         : 段国强
 Source Server Type    : MySQL
 Source Server Version : 80041 (8.0.41)
 Source Host           : localhost:3306
 Source Schema         : data

 Target Server Type    : MySQL
 Target Server Version : 80041 (8.0.41)
 File Encoding         : 65001

 Date: 25/06/2026 09:36:58
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_article
-- ----------------------------
DROP TABLE IF EXISTS `t_article`;
CREATE TABLE `t_article`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '文章id',
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '文章标题',
  `title_image` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '文章题图',
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '文章描述',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后一次更新时间',
  `is_deleted` tinyint NOT NULL DEFAULT 0 COMMENT '删除标志位：0：未删除 1：已删除',
  `read_num` int UNSIGNED NOT NULL DEFAULT 1 COMMENT '被阅读次数',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 66 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '文章表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_article
-- ----------------------------
INSERT INTO `t_article` VALUES (16, 'Java 线程池原理详解', 'https://picsum.photos/800/400?random=16', 'Java 高并发必备，从入门到精通', '2026-04-18 18:34:12', '2026-04-18 18:34:12', 0, 1222);
INSERT INTO `t_article` VALUES (17, 'MySQL 索引优化实战', 'https://picsum.photos/800/400?random=17', '数据库性能优化必备', '2026-04-18 18:34:12', '2026-04-18 18:34:12', 0, 3344);
INSERT INTO `t_article` VALUES (18, 'Vue3 组合式 API 最佳实践', 'https://picsum.photos/800/400?random=18', 'Vue3 最新语法', '2026-04-18 18:34:12', '2026-04-18 18:34:12', 0, 5566);
INSERT INTO `t_article` VALUES (19, 'Redis 缓存三大问题', 'https://picsum.photos/800/400?random=19', '穿透、击穿、雪崩', '2026-04-18 18:34:12', '2026-04-18 18:34:12', 0, 7795);
INSERT INTO `t_article` VALUES (20, 'SpringBoot 接口统一返回', 'https://picsum.photos/800/400?random=20', '后端接口规范', '2026-04-18 18:34:12', '2026-04-18 18:34:12', 0, 9900);
INSERT INTO `t_article` VALUES (21, 'MyBatis-Plus 快速入门', 'https://picsum.photos/800/400?random=21', '简化 CRUD', '2026-04-18 18:34:12', '2026-04-18 18:34:12', 0, 1122);
INSERT INTO `t_article` VALUES (22, 'Nginx 反向代理配置', 'https://picsum.photos/800/400?random=22', '高性能网关', '2026-04-18 18:34:12', '2026-04-18 18:34:12', 0, 3344);
INSERT INTO `t_article` VALUES (23, 'Docker 部署 SpringBoot', 'https://picsum.photos/800/400?random=23', '一键部署', '2026-04-18 18:34:12', '2026-04-18 18:34:12', 0, 5566);
INSERT INTO `t_article` VALUES (24, 'Vue3 组件通信全解', 'https://picsum.photos/800/400?random=24', '父子/跨级/全局通信', '2026-04-18 18:34:12', '2026-04-18 18:34:12', 0, 7788);
INSERT INTO `t_article` VALUES (25, 'MySQL 事务隔离级别', 'https://picsum.photos/800/400?random=25', 'ACID、脏读、不可重复读', '2026-04-18 18:34:12', '2026-04-18 18:34:12', 0, 9900);
INSERT INTO `t_article` VALUES (26, 'Java 线程池参数与实战原理', 'https://picsum.photos/800/400?random=26', '讲解线程池七大核心参数、拒绝策略、使用场景', '2026-04-18 18:36:13', '2026-04-18 18:36:13', 0, 1297);
INSERT INTO `t_article` VALUES (27, 'MySQL索引失效场景全总结', 'https://picsum.photos/800/400?random=27', '最左匹配、隐式转换、函数操作、范围查询等索引失效原因', '2026-04-18 18:36:13', '2026-04-18 18:36:13', 0, 2437);
INSERT INTO `t_article` VALUES (28, 'Vue3 setup 语法糖完全指南', 'https://picsum.photos/800/400?random=28', 'ref/reactive/watch/computed 组合式 API 实战', '2026-04-18 18:36:13', '2026-04-19 13:39:32', 0, 3679);
INSERT INTO `t_article` VALUES (29, 'Redis 缓存三大问题解决方案', 'https://picsum.photos/800/400?random=29', '缓存穿透、击穿、雪崩的成因与解决方案总结', '2026-04-18 18:36:13', '2026-04-18 18:36:13', 0, 4193);
INSERT INTO `t_article` VALUES (30, 'SpringBoot 全局统一异常处理', 'https://picsum.photos/800/400?random=30', '统一返回体、全局异常、参数校验、国际化封装', '2026-04-18 18:36:13', '2026-04-21 17:07:07', 0, 5798);
INSERT INTO `t_article` VALUES (31, 'dgq同学个人技术履历与 AI 智能博客开源项目全介绍', 'http://127.0.0.1:9000/weblog/9fe6b2d3c12147a3bd79c44577b68385.png', '开发者dgq同学技术栈涵盖 Java 底层、JVM 调优、并发编程、SpringBoot 微服务、SpringSecurity 分布式鉴权、MySQL 优化、Redis 多级缓存、消息队列、Elasticsearch 检索；核心方向为 AI 大模型 RAG 应用开发，基于 PGVector 实现完整向量检索链路，落地 AI 智能博客系统，配套 Docker 容器化、CI/CD 自动化部署。', '2026-06-22 10:37:41', '2026-06-22 11:14:16', 0, 6);
INSERT INTO `t_article` VALUES (61, 'LangChain4j 与 Spring Boot 深度融合：构建企业级 LLM 应用实践', 'https://picsum.photos/seed/langchain/800/450', '本文系统讲解 LangChain4j 框架与 Spring Boot 的集成方案，涵盖对话模型管理、RAG 检索增强、Function Calling 工具调用等核心能力，助力 Java 开发者快速构建生产级大模型应用。', '2026-06-24 10:00:00', '2026-06-24 10:00:00', 0, 156);
INSERT INTO `t_article` VALUES (62, 'RAG 检索增强生成技术深度解析：从向量检索到智能问答系统落地', 'https://picsum.photos/seed/rag/800/450', 'RAG 技术已成为大模型应用的核心范式。本文从架构设计、向量数据库选型、检索优化、生成增强四个维度，深度剖析 RAG 系统的完整实现路径，并提供生产级代码示例。', '2026-06-24 10:00:00', '2026-06-24 10:00:00', 0, 236);
INSERT INTO `t_article` VALUES (63, 'AI Agent 智能体设计模式全景解析：从 ReAct 到多智能体协作', 'https://picsum.photos/seed/agent/800/450', 'AI Agent 正在重塑自动化与决策的边界。本文系统梳理 Agent 的核心架构、主流设计模式（ReAct、CoT、ToT）、工具调用机制与记忆系统，并结合 LangChain4j 实现完整的 Agent 框架。', '2026-06-24 10:00:00', '2026-06-24 10:00:00', 0, 190);
INSERT INTO `t_article` VALUES (64, 'Spring AI 框架实战：函数调用、向量检索与模型适配全攻略', 'https://picsum.photos/seed/springai/800/450', 'Spring AI 作为 Spring 生态的 AI 开发基石，提供了统一的模型抽象与工具链。本文从 Function Calling、Vector Store、Prompt Template 三个核心模块入手，带你构建完整的 AI 应用。', '2026-06-24 10:00:00', '2026-06-24 10:00:00', 0, 269);
INSERT INTO `t_article` VALUES (65, '大模型微调技术全景：从 PEFT/LoRA 到 QLoRA 的高效参数优化实践', 'https://picsum.photos/seed/finetune/800/450', '大模型微调是迈向垂直领域应用的关键一步。本文深入对比全参数微调、LoRA、QLoRA、P-Tuning 等主流技术，剖析其数学原理与工程实现，并提供完整的训练与部署代码。', '2026-06-24 10:00:00', '2026-06-24 10:00:00', 0, 201);

-- ----------------------------
-- Table structure for t_article_category_rel
-- ----------------------------
DROP TABLE IF EXISTS `t_article_category_rel`;
CREATE TABLE `t_article_category_rel`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'id',
  `article_id` bigint UNSIGNED NOT NULL COMMENT '文章id',
  `category_id` bigint UNSIGNED NOT NULL COMMENT '分类id',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uni_article_id`(`article_id` ASC) USING BTREE,
  INDEX `idx_category_id`(`category_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 72 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '文章所属分类映射表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_article_category_rel
-- ----------------------------
INSERT INTO `t_article_category_rel` VALUES (8, 16, 13);
INSERT INTO `t_article_category_rel` VALUES (9, 17, 9);
INSERT INTO `t_article_category_rel` VALUES (10, 18, 7);
INSERT INTO `t_article_category_rel` VALUES (11, 19, 21);
INSERT INTO `t_article_category_rel` VALUES (12, 20, 8);
INSERT INTO `t_article_category_rel` VALUES (13, 21, 6);
INSERT INTO `t_article_category_rel` VALUES (14, 22, 4);
INSERT INTO `t_article_category_rel` VALUES (15, 23, 4);
INSERT INTO `t_article_category_rel` VALUES (16, 24, 6);
INSERT INTO `t_article_category_rel` VALUES (17, 25, 16);
INSERT INTO `t_article_category_rel` VALUES (28, 26, 19);
INSERT INTO `t_article_category_rel` VALUES (29, 27, 5);
INSERT INTO `t_article_category_rel` VALUES (31, 29, 1);
INSERT INTO `t_article_category_rel` VALUES (35, 28, 19);
INSERT INTO `t_article_category_rel` VALUES (38, 30, 2);
INSERT INTO `t_article_category_rel` VALUES (40, 31, 18);
INSERT INTO `t_article_category_rel` VALUES (67, 61, 4);
INSERT INTO `t_article_category_rel` VALUES (68, 62, 4);
INSERT INTO `t_article_category_rel` VALUES (69, 63, 4);
INSERT INTO `t_article_category_rel` VALUES (70, 64, 2);
INSERT INTO `t_article_category_rel` VALUES (71, 65, 4);

-- ----------------------------
-- Table structure for t_article_content
-- ----------------------------
DROP TABLE IF EXISTS `t_article_content`;
CREATE TABLE `t_article_content`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '文章内容id',
  `article_id` bigint NOT NULL COMMENT '文章id',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '正文内容',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_article_id`(`article_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 65 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '文章内容表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_article_content
-- ----------------------------
INSERT INTO `t_article_content` VALUES (6, 16, '<h1>Java 线程池原理详解</h1><p>这是文章的详细内容，自动生成的测试文本。</p>');
INSERT INTO `t_article_content` VALUES (7, 17, '<h1>MySQL 索引优化实战</h1><p>这是文章的详细内容，自动生成的测试文本。</p>');
INSERT INTO `t_article_content` VALUES (8, 18, '<h1>Vue3 组合式 API 最佳实践</h1><p>这是文章的详细内容，自动生成的测试文本。</p>');
INSERT INTO `t_article_content` VALUES (9, 19, '<h1>Redis 缓存三大问题</h1><p>这是文章的详细内容，自动生成的测试文本。</p>');
INSERT INTO `t_article_content` VALUES (10, 20, '<h1>SpringBoot 接口统一返回</h1><p>这是文章的详细内容，自动生成的测试文本。</p>');
INSERT INTO `t_article_content` VALUES (11, 21, '<h1>MyBatis-Plus 快速入门</h1><p>这是文章的详细内容，自动生成的测试文本。</p>');
INSERT INTO `t_article_content` VALUES (12, 22, '<h1>Nginx 反向代理配置</h1><p>这是文章的详细内容，自动生成的测试文本。</p>');
INSERT INTO `t_article_content` VALUES (13, 23, '<h1>Docker 部署 SpringBoot</h1><p>这是文章的详细内容，自动生成的测试文本。</p>');
INSERT INTO `t_article_content` VALUES (14, 24, '<h1>Vue3 组件通信全解</h1><p>这是文章的详细内容，自动生成的测试文本。</p>');
INSERT INTO `t_article_content` VALUES (15, 25, '<h1>MySQL 事务隔离级别</h1><p>这是文章的详细内容，自动生成的测试文本。</p>');
INSERT INTO `t_article_content` VALUES (21, 22, '<h1>Java 线程池原理详解</h1><h2>一、线程池核心参数</h2><p>corePoolSize：核心线程数，一直存活</p><p>maximumPoolSize：最大线程数</p><p>keepAliveTime：非核心线程存活时间</p><p>workQueue：阻塞队列</p><h2>二、拒绝策略</h2><p>Abort、CallerRuns、DiscardOldest、Discard</p><h2>三、生产最佳实践</h2><p>禁止使用 Executors，手动创建 ThreadPoolExecutor</p>');
INSERT INTO `t_article_content` VALUES (22, 23, '<h1>MySQL 索引失效场景总结</h1><h2>1. 违反最左匹配原则</h2><p>复合索引必须按顺序使用</p><h2>2. 使用函数或运算</h2><p>where substr(name,1,2) = \'xx\' 失效</p><h2>3. 隐式类型转换</h2><p>字符串加单引号，否则索引失效</p><h2>4. 模糊查询以 % 开头</h2><p>like \'%abc\' 无法命中索引</p>');
INSERT INTO `t_article_content` VALUES (23, 24, '<h1>Vue3 setup 语法糖实战</h1><h2>一、响应式基础</h2><p>ref：基本类型响应式</p><p>reactive：对象类型响应式</p><h2>二、计算属性与监听</h2><p>computed 缓存值</p><p>watch 深度监听</p><h2>三、组件通信</h2><p>defineProps / defineEmits</p><p>defineExpose 对外暴露方法</p>');
INSERT INTO `t_article_content` VALUES (24, 25, '<h1>Redis 缓存三大问题</h1><h2>1. 缓存穿透</h2><p>查不存在的数据 → 大量访问数据库</p><p>解决方案：布隆过滤器、缓存空值</p><h2>2. 缓存击穿</h2><p>热点 key 过期 → 大量请求打库</p><p>解决方案：互斥锁、永不过期</p><h2>3. 缓存雪崩</h2><p>大量 key 同时过期</p><p>解决方案：随机过期时间、集群高可用</p>');
INSERT INTO `t_article_content` VALUES (25, 26, '<h1>SpringBoot 全局统一异常处理</h1><h2>一、统一返回结果</h2><p>code、msg、data 封装</p><h2>二、全局异常捕获</h2><p>@RestControllerAdvice + @ExceptionHandler</p><h2>三、常见异常处理</h2><p>参数校验异常、空指针、业务异常</p><h2>四、统一响应格式</h2><p>前端可统一判断状态码，简化交互</p>');
INSERT INTO `t_article_content` VALUES (26, 27, 'Test');
INSERT INTO `t_article_content` VALUES (27, 28, 'script setup 语法糖\n新的 setup 选项是在组件创建之前, props 被解析之后执行，是组合式 API 的入口。\n\nWARNING\n在 setup 中你应该避免使用 this，因为它不会找到组件实例。setup 的调用发生在 data property、computed property 或 methods 被解析之前，所以它们无法>在 setup 中被获取。\n\nsetup 选项是一个接收 props 和 context 的函数，我们将在之后进行讨论。此外，我们将 setup 返回的所有内容都暴露给组件的其余部分 (计算属性、方法、生命周期钩子等等) 以及组件的模板。\n它是 Vue3 的一个新语法糖，在 setup 函数中。所有 ES 模块导出都被认为是暴露给上下文的值，并包含在 setup() 返回对象中。相对于之前的写法，使用后，语法也变得更简单。\n\n在添加了setup的script标签中，我们不必声明和方法，这种写法会自动将所有顶级变量、函数，均会自动暴露给模板（template）使用\n这里强调一句 “暴露给模板，跟暴露给外部不是一回事”\n\n使用方式极其简单，仅需要在 script 标签加上 setup 关键字即可。示例：\nhtml 体验AI代码助手 代码解读复制代码<script setup></script>\n\n该setup功能是新的组件选项。它是组件内部暴露出所有的属性和方法的统一API。\n使用后意味着，script标签内的内容相当于原本组件声明中setup()的函数体，不过也有一定的区别。\n使用 script setup 语法糖，组件只需引入不用注册，属性和方法也不用返回，也不用写setup函数，也不用写export default ，甚至是自定义指令也可以在我们的template中自动获得。基本语法\n调用时机\n创建组件实例，然后初始化 props ，紧接着就调用setup 函数。从生命周期钩子的视角来看，它会在 beforeCreate 钩子之前被调用.\n模板中使用\n如果 setup 返回一个对象，则对象的属性将会被合并到组件模板的渲染上下文\nhtml 体验AI代码助手 代码解读复制代码<template>\n    <div>\n    {{ count }} {{ object.foo }}\n    </div>\n</template>\n\nsetup 参数\n\n「props」 第一个参数接受一个响应式的props，这个props指向的是外部的props。如果你没有定义props选项，setup中的第一个参数将为undifined。props和vue2.x并无什么不同,仍然遵循以前的原则；\n\n\n不要在子组件中修改props；如果你尝试修改，将会给你警告甚至报错。\n不要结构props。结构的props会失去响应性。\n\n2.「context」 第二个参数提供了一个上下文对象，从原来 2.x 中 this 选择性地暴露了一些 property。\nhtml 体验AI代码助手 代码解读复制代码<script setup=\"props, context\" lang=\"ts\">\n context.attrs\n context.slots\n context.emit \n<script>\n\n\n像这样，只要在setup处声明即可自动导入，同时也支持解构语法：\nhtml 体验AI代码助手 代码解读复制代码<script setup=\"props, { emit }\" lang=\"ts\">\n \n<script>\n\n\n组件自动注册\n导入 component 或 directive 直接import即可，无需额外声明\njs 体验AI代码助手 代码解读复制代码import { MyButton } from \"@/components\"\nimport { directive as clickOutside } from \'v-click-outside\'\n\n与原先一样，模板中也支持使用kabab-case来创建组件，如\n在 script setup 中，引入的组件可以直接使用，无需再通过components进行注册，并且无法指定当前组件的名字，它会自动以文件名为主，也就是不用再写name属性了。示例：\nhtml 体验AI代码助手 代码解读复制代码<template>\n    <HelloWorld />\n</template>\n\n<script setup>\nimport HelloWorld from \"./components/HelloWorld.vue\"; //此处使用 Vetur 插件会报红\n</script>\n\n如果需要定义类似 name 的属性，可以再加个平级的 script 标签，在里面实现即可。\n组件核心 API 的使用\n定义组件的 props\n通过defineProps指定当前 props 类型，获得上下文的props对象。示例：\nhtml 体验AI代码助手 代码解读复制代码\n<script setup lang=\"ts\"> \nimport { defineProps } from \'vue\';\n\nconst props = defineProps([\"title\"]);\n</script>\n<!-- 或者 -->\n<script setup>\n  import { defineProps } from \'vue\';\n\n  const props = defineProps({\n    title: String, // 可以设置传来值的类型\n  })\n</script>\n<!-- 或者 -->\n<script setup>\n  import { defineProps } from \'vue\';\n\n  const props = defineProps({\n    // 可以设置传来值的类型和默认值\n    title: {\n        type:String,\n        default: \'\'\n    }\n  })\n</script>\n<!-- 或者 -->\n<script setup>\n  import { defineProps } from \'vue\';\n\n  const props = defineProps({\n    title: [String,Number] // 可以设置传来值的多种类型\n  })\n</script>\n<!-- 或者 -->\n<script setup lang=\"ts\"> \n    import { ref,defineProps } from \'vue\';\n    \n    type Props={ \n        title:string \n    }\n    defineProps<Props>(); \n</script>\n\n定义 emit\n使用defineEmit定义当前组件含有的事件，并通过返回的上下文去执行 emit。示例：\nhtml 体验AI代码助手 代码解读复制代码<script setup>\n  import { defineEmits } from \'vue\'\n  // 定义两个方法 change 和 delete\n  const emit = defineEmits([\'change\', \'delete\'])\n  \n  const handleClick=()=>{\n    emit(\'change\', 5); // 传给父组件的值的方法\n  }\n  \n  const handleClickDel=()=>{\n    emit(\'delete\', 8); // 传给父组件的值的方法\n  }\n</script>\n\n父子组件通信\n\n在Vue3中父子组件传值、方法是通过defineProps, defineEmits实现的。\ndefineProps 和 defineEmits 都是只在 <script setup> 中才能使用的。\n它们不需要导入就会随着 <script setup> 被一同处理编译。\ndefineProps 接收与 props 选项相同的值， defineEmits 也接收 emits 选项 相同的值。\n\ndefineProps 用来接收父组件传来的 props ; defineEmits 用来声明触发的事件。\nhtml 体验AI代码助手 代码解读复制代码//父组件\n<template>\n  <my-son foo=\"🚀🚀🚀🚀🚀🚀\" @childClick=\"childClick\" />\n</template>\n\n<script lang=\"ts\" setup>\nimport MySon from \"./MySon.vue\";\n\nlet childClick = (e: any):void => {\n  console.log(\'from son：\',e);  //🚀🚀🚀🚀🚀🚀\n};\n</script>\n\n\n//子组件\n<template>\n  <span @click=\"sonToFather\">信息:{{ props.foo }}</span>\n</template>\n\n<script lang=\"ts\" setup>\nimport { defineEmits, defineProps} from \"vue\";\n\nconst emit = defineEmits([\"childClick\"]);     // 声明触发事件 childClick\nconst props = defineProps({ foo: String });   // 获取props\n\nconst sonToFather = () =>{\n    emit(\'childClick\' , props.foo)\n}\n</script>\n\n子组件通过 defineProps 接收父组件传过来的数据，子组件通过 defineEmits 定义事件发送信息给父组件\n增强的props类型定义：\njs 体验AI代码助手 代码解读复制代码const props = defineProps<{\n  foo: string\n  bar?: number\n}>()\n\nconst emit = defineEmit<(e: \'update\' | \'delete\', id: number) => void>()\n\n不过注意，采用这种方法将无法使用props默认值。\n父组件调用子组件事件\n父组件\nxml 体验AI代码助手 代码解读复制代码<!-- 父组件 app.vue -->\n<template>\n  <div class=\"par\">\n    <!-- 使用 ref 指令关联子组件 -->\n    <child ref=\"childRef\"/>\n    <button @click=\"handleClick\">提交</button>\n  </div>\n</template>\n<script setup>\nimport { reactive, ref } from \"vue\";\nimport child from \"./child.vue\";\n//定义子组件实例，名称要和上面的ref相同\nconst childRef = ref(null);\n \n//访问demo组件的方法或对象\nconst handleClick = () => {\n  //获取到子组件的 title 数据 \n  let title = childRef.value.state.title;\n  //调用子组件的 play方法\n  childRef.value.submit();\n};\n</script>\n\n子组件\n子组件通过defineExpose暴露对象和方法\nxml 体验AI代码助手 代码解读复制代码<!--子组件名称  child.vue -->\n<template>\n  <div class=\"child\">\n    {{ state.title }}\n  </div>\n</template>\n<script setup>\nimport { ref, reactive } from \"vue\";\n//定义一个变量\nconst state = reactive({\n  title: \"标题\",\n});\n//定义一个方法\nconst submit = () => {\n  state.title = \"你调用了子组件的方法\";\n};\n \n//暴露state和play方法\ndefineExpose({\n  state,\n  submit\n});\n</script>\n\n定义响应变量、函数、监听、计算属性computed\nhtml 体验AI代码助手 代码解读复制代码<script setup lang=\"ts\"> \nimport { ref,computed,watchEffect } from \'vue\';\n\nconst count = ref(0); //不用 return ，直接在 templete 中使用\n\nconst addCount=()=>{ //定义函数，使用同上 \n    count.value++; \n} \n\n//定义计算属性，使用同上\nconst howCount=computed(()=>\"现在count值为：\"+count.value);\n\n//定义监听，使用同上 //...some code else \nwatchEffect(()=>console.log(count.value)); \n</script>\n\nwatchEffect\n用于有副作用的操作，会自动收集依赖。\n和watch区别\n无需区分deep，immediate，只要依赖的数据发生变化，就会调用\nreactive\n此时name只会在初次创建的时候进行赋值，如果中间想要改变name的值，那么需要借助composition   api 中的reactive。\nhtml 体验AI代码助手 代码解读复制代码<script setup lang=\"ts\">\nimport { reactive, onUnmounted } from \'vue\'\n\nconst state = reactive({\n    counter: 0\n})\n// 定时器 每秒都会更新数据\nconst timer = setInterval(() => {\n    state.counter++\n}, 1000);\n\nonUnmounted(() => {\n    clearInterval(timer);\n})\n</script>\n<template>\n    <div>{{state.counter}}</div>\n</template>\n\n使用ref也能达到我们预期的\'counter\',并且在模板中,vue进行了处理，我们可以直接使用counter而不用写counter.value.\nref和reactive的关系:\nref是一个{value:\'xxxx\'}的结构，value是一个reactive对象\nref 暴露变量到模板\n曾经的提案中，如果需要暴露变量到模板，需要在变量前加入export声明：\njs 体验AI代码助手 代码解读复制代码export const count = ref(0)\n\n不过在新版的提案中，无需export声明，编译器会自动寻找模板中使用的变量，只需像下面这样简单的声明，即可在模板中使用该变量\nhtml 体验AI代码助手 代码解读复制代码<script setup lang=\"ts\">\nimport { ref } from \'vue\'\n\nconst counter = ref(0);//不用 return ，直接在 templete 中使用\n\nconst timer = setInterval(() => {\n    counter.value++\n}, 1000)\n\nonUnmounted(() => {\n    clearInterval(timer);\n})\n</script>\n<template>\n    <div>{{counter}}</div>\n</template>\n\n生命周期方法\n因为 setup 是围绕 beforeCreate 和 created 生命周期钩子运行的，所以不需要显式地定义它们。换句话说，在这些钩子中编写的任何代码都应该直接在 setup 函数中编写。\n可以通过在生命周期钩子前面加上 “on” 来访问组件的生命周期钩子。官网：生命周期钩子\n下表包含如何在 setup () 内部调用生命周期钩子：\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n选项式 APIHook inside setupbeforeCreateNot needed*createdNot needed*beforeMountonBeforeMountmountedonMountedbeforeUpdateonBeforeUpdateupdatedonUpdatedbeforeUnmountonBeforeUnmountunmountedonUnmountederrorCapturedonErrorCapturedrenderTrackedonRenderTrackedrenderTriggeredonRenderTriggeredactivatedonActivateddeactivatedonDeactivated\nhtml 体验AI代码助手 代码解读复制代码<script setup lang=\"ts\"> \nimport { onMounted } from \'vue\';\n\nonMounted(() => { console.log(\'mounted!\'); });\n\n</script>\n\n获取 slots 和 attrs\n\n注：useContext API 被弃用，取而代之的是更加细分的 api。\n\n可以通过useContext从上下文中获取 slots 和 attrs。不过提案在正式通过后，废除了这个语法，被拆分成了useAttrs和useSlots。\n\nuseAttrs：见名知意，这是用来获取 attrs 数据，但是这和 vue2 不同，里面包含了 class、属性、方法。\n\nhtml 体验AI代码助手 代码解读复制代码<template>\n    <component v-bind=\'attrs\'></component>\n</template>\n<srcipt setup lang=\'ts\'>\n   const attrs = useAttrs();\n<script>\n\n\nuseSlots: 顾名思义，获取插槽数据。\n\n使用示例：\nhtml 体验AI代码助手 代码解读复制代码// 旧\n<script setup>\n  import { useContext } from \'vue\'\n\n  const { slots, attrs } = useContext()\n</script>\n\n// 新\n<script setup>\n  import { useAttrs, useSlots } from \'vue\'\n\n  const attrs = useAttrs()\n  const slots = useSlots()\n</script>\n\n其他 Hook Api\n\nuseCSSModule：CSS Modules 是一种 CSS 的模块化和组合系统。vue-loader 集成 CSS Modules，可以作为模拟 scoped CSS。允许在单个文件组件的setup中访问CSS模块。此 api 本人用的比较少，不过多做介绍。\nuseCssVars: 此 api 暂时资料比较少。介绍v-bind in styles时提到过。\nuseTransitionState: 此 api 暂时资料比较少。\nuseSSRContext: 此 api 暂时资料比较少。\n\ndefineExpose API\n传统的写法，我们可以在父组件中，通过 ref 实例的方式去访问子组件的内容，但在 script setup 中，该方法就不能用了，setup 相当于是一个闭包，除了内部的 template模板，谁都不能访问内部的数据和方法。\n如果需要对外暴露 setup 中的数据和方法，需要使用 defineExpose API。示例：\njs 体验AI代码助手 代码解读复制代码const a = 1\nconst b = ref(2)\ndefineExpose({ a, b, })\n\n\n注意：目前发现defineExpose暴露出去的属性以及方法都是 unknown 类型，如果有修正类型的方法，欢迎评论区补充。\n\nhtml 体验AI代码助手 代码解读复制代码//父组件\n\n<template>\n  <Daughter ref=\"daughter\" />\n</template>\n\n<script lang=\"ts\" setup>\nimport { ref } from \"vue\";\nimport Daughter from \"./Daughter.vue\";\n\nconst daughter = ref(null)\nconsole.log(\'🚀🚀🚀🚀~daughter\',daughter)\n</script>\n\n\n//子组件\n\n<template>\n  <div>妾身{{ msg }}</div>\n</template>\n\n<script lang=\"ts\" setup>\nimport { ref ,defineExpose} from \"vue\";\nconst msg = ref(\'貂蝉\')\ndefineExpose({\n    msg\n})\n</script>\n\n一、父组件调用子组件方法\n子组件需要使用defineExpose对外暴露方法，父组件才可以调用。\n子组件\njs 体验AI代码助手 代码解读复制代码<template>\n    <div>子组件</div>\n</template>\n \n<script setup lang=\"ts\">\n    // 第一步：定义子组件的方法\n    const handleSubmit = (str: string) => {\n            console.log(\'子组件的hello方法执行了--\' + str)\n    }\n    // 第二部：暴露方法\n    defineExpose({\n        handleSubmit\n    })\n</script>\n\n父组件\njs 体验AI代码助手 代码解读复制代码<template>\n    <button @click=\"handleChild\">触发子组件方法</button>\n    <!-- 一：定义 ref -->\n    <Child ref=\"childRef\"></Child>\n</template>\n \n<script lang=\"ts\" setup>\n    import { ref } from \'vue\';\n    import Child from \'../../components/child.vue\';\n\n    // 二：定义与 ref 同名变量\n    const childRef = ref <any> ()\n\n    // 三、函数\n    const handleChild = () => {\n        // 调用子组件的方法或者变量，通过value\n        childRef.value.hello(\"hello world！\");\n    }\n</script>\n\n\n\n参考网址：cn.vuejs.org/api/sfc-scr…\n属性和方法无需返回，直接使用！\n这可能是带来的较大便利之一，在以往的写法中，定义数据和方法，都需要在结尾 return 出去，才能在模板中使用。在 script setup 中，定义的属性和方法无需返回，可以直接使用！示例：\nhtml 体验AI代码助手 代码解读复制代码<template>\n  <div>\n   	<p>My name is {{name}}</p>\n  </div>\n</template>\n\n<script setup>\nimport { ref } from \'vue\';\n\nconst name = ref(\'Sam\')\n</script>\n\n支持 async await 异步\n注意在vue3的源代码中，setup执行完毕，函数 getCurrentInstance 内部的有个值会释放对 currentInstance 的引用，await 语句会导致后续代码进入异步执行的情况。所以上述例子中最后一个 getCurrentInstance() 会返回 null，建议使用变量保存第一个 getCurrentInstance() 返回的引用.\nhtml 体验AI代码助手 代码解读复制代码<script setup>\n  const post = await fetch(`/api/post/1`).then((r) => r.json())\n</script>\n\n<script setup> 中可以使用顶层 await。结果代码会被编译成 async setup()：\nhtml 体验AI代码助手 代码解读复制代码<script setup>\nconst post = await fetch(`/api/post/1`).then(r => r.json())\n</script>\n\n另外，await 的表达式会自动编译成在 await 之后保留当前组件实例上下文的格式。\n\n注意\nasync setup() 必须与 Suspense 组合使用，Suspense 目前还是处于实验阶段的特性。我们打算在将来的某个发布版本中开发完成并提供文档 - 如果你现在感兴趣，可以参照 tests 看它是如何工作的。\n\n定义组件其他配置\n配置项的缺失，有时候我们需要更改组件选项，在setup中我们目前是无法做到的。我们需要在上方再引入一个 script，在上方写入对应的 export即可，需要单开一个 script。\n<script setup> 可以和普通的 <script> 一起使用。普通的 <script> 在有这些需要的情况下或许会被使用到：\n\n无法在 <script setup> 声明的选项，例如 inheritAttrs 或通过插件启用的自定义的选项。\n声明命名导出。\n运行副作用或者创建只需要执行一次的对象。\n\n在script setup 外使用export default，其内容会被处理后放入原组件声明字段。\nhtml 体验AI代码助手 代码解读复制代码<script>\n// 普通 `<script>`, 在模块范围下执行(只执行一次)\nrunSideEffectOnce()\n\n// 声明额外的选项\n  export default {\n    name: \"MyComponent\",\n    inheritAttrs: false,\n    customOptions: {}\n  }\n</script>\n<script setup>\n    import HelloWorld from \'../components/HelloWorld.vue\'\n    // 在 setup() 作用域中执行 (对每个实例皆如此)\n    // your code\n</script>\n<template>\n  <div>\n    <HelloWorld msg=\"Vue3 + TypeScript + Vite\"/>\n  </div>\n</template>\n\n\n注意：Vue 3 SFC 一般会自动从组件的文件名推断出组件的 name。在大多数情况下，不需要明确的 name 声明。唯一需要的情况是当你需要 <keep-alive> 包含或排除或直接检查组件的选项时，你需要这个名字。\n\n关于 TS 与 ESLint 的不完美\n\n\n与@typescript-eslint/no-unused-vars规则不兼容，此规则含义为定义了，未进行使用。该规则其实影响不大，关闭即可。\n\n\n与导入的类型声明不兼容，当你通过解构的方式去导入类型，setup sugar 会进行自动导出。这时候，你就会收到 TS 的一条报错：此为类型，但被当作值使用。解决办法：类型导出使用export default导出或者引入时使用import * as xx来进行引入，也可以使用 import type { test } from \"./test\";解决。\n\n\n语法糖实现\nvue文件代码\nhtml 体验AI代码助手 代码解读复制代码<template>\n  <div>{{ msg }}</div>\n</template>\n<script setup>\n  const msg = \'Hello!\'\n</script>\n\n编译后的js代码：\njs 体验AI代码助手 代码解读复制代码export default {\n  setup() {\n    const msg = \'Hello!\'\n\n    return function render() {\n      // has access to everything inside setup() scope\n      // 在函数 setup 作用域，函数 render 能访问 setup 的一切，\n      return h(\'div\', msg)\n    }\n  }\n}\n\n注意到，即使普通变量也能作为模版被置入 template 中被编译，某些人认为这不合适，不够分离。\nvscode配套插件\nvolar 是一个vscode插件，用来增强vue编写体验，使用volar插件可以获得script setup语法的最佳支持。\n与vetur相同，volar是一个针对vue的vscode插件，不过与vetur不同的是，volar提供了更为强大的功能，让人直呼卧槽。\n安装的方式很简单，直接在vscode的插件市场搜索volar，然后点击安装就可以了。\nvscode 中使用的时候，先禁用 Vetur，再下载使用Volar\n使用习惯\n从options api切换到composition api最大的问题无异于最大的问题就是没有强制的代码分区，如果书写的人没有很好的代码习惯，那么后续的人将会看的十分难受。目前我是这么解决的：\n\n\n自我代码分区并且尽量抽离方法（写好注释），分区如下：\n\n相关引入\n响应式数据、props、emit 定义\n生命周期以及 watch 书写\n方法定义\n方法、属性暴露\n\n\n\n组件抽离：将页面拆成两个文件夹，一个为 views，一个为 components。views 和 components 文件夹下有各自的文件。views 文件夹中为页面入口，掌管数据，而 components 则为页面中一些组件抽离。如果是公共组件，再抽离到 components 文件夹下其他位置。\n\n\nhook 抽离：尽可能将逻辑抽离，并不一定要进行复用。\n\n\n写在最后\n写作不易，希望可以获得你的一个「赞」。如果文章对你有用，可以选择「关注 + 收藏」。 如有文章有错误或建议，欢迎评论指正，谢谢你。❤️\n\n作者：Gaby\n链接：https://juejin.cn/post/7009282373476941831\n来源：稀土掘金\n著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。');
INSERT INTO `t_article_content` VALUES (28, 29, 'Test');
INSERT INTO `t_article_content` VALUES (29, 30, '在 Spring Boot 中配置全局异常处理器，是实现统一错误响应、提升系统健壮性和可维护性的关键手段。核心使用两个注解：@ControllerAdvice 和 @ExceptionHandler。\n\n下面从 原理、步骤、完整示例、最佳实践 四个方面详细说明。\n\n# 一、核心原理\n@ControllerAdvice\n是一个组合注解（包含 @Component），作用于类上，表示该类是一个全局的控制器增强器。它会自动被 Spring 容器扫描并注册为 Bean，并对所有 @Controller 或 @RestController 中抛出的异常进行拦截。\n\n@ExceptionHandler\n作用于方法上，用于指定该方法处理哪些类型的异常。可以精确到具体异常类（如 NullPointerException），也可以处理通用异常（如 Exception）。\n\n💡 执行流程：\nController 抛出异常 → Spring MVC 的 DispatcherServlet 捕获 → 查找匹配的 @ControllerAdvice 中的 @ExceptionHandler 方法 → 执行并返回结果。\n\n# 二、配置步骤（5 步）\n✅ 第 1 步：创建全局异常处理类\n复制代码\npackage com.example.demo.exception;\n\nimport org.springframework.web.bind.annotation.ExceptionHandler;\nimport org.springframework.web.bind.annotation.RestControllerAdvice;\n\n// @RestControllerAdvice = @ControllerAdvice + @ResponseBody\n@RestControllerAdvice\npublic class GlobalExceptionHandler {\n\n    // 处理特定异常\n    @ExceptionHandler(NullPointerException.class)\n    public Result handleNpe(NullPointerException e) {\n        return Result.error(\"空指针异常: \" + e.getMessage());\n    }\n\n    // 处理自定义业务异常\n    @ExceptionHandler(BusinessException.class)\n    public Result handleBusiness(BusinessException e) {\n        return Result.error(e.getCode(), e.getMessage());\n    }\n\n    // 兜底处理所有未捕获异常\n    @ExceptionHandler(Exception.class)\n    public Result handleGeneral(Exception e) {\n        // 生产环境建议不暴露具体异常信息\n        return Result.error(500, \"服务器内部错误\");\n    }\n}\n复制代码\n \n\n🔔 注意：\n\n使用 @RestControllerAdvice 而不是 @ControllerAdvice，是为了让返回值自动转为 JSON（相当于每个方法都加了 @ResponseBody）。\n如果你返回的是 HTML 页面，则用 @ControllerAdvice。\n✅ 第 2 步：定义统一返回格式（推荐）\n复制代码\npackage com.example.demo.common;\n\nimport lombok.Data;\n\n@Data\npublic class Result<T> {\n    private int code;\n    private String message;\n    private T data;\n\n    public static <T> Result<T> success(T data) {\n        Result<T> result = new Result<>();\n        result.code = 200;\n        result.message = \"success\";\n        result.data = data;\n        return result;\n    }\n\n    public static <T> Result<T> error(String message) {\n        return error(500, message);\n    }\n\n    public static <T> Result<T> error(int code, String message) {\n        Result<T> result = new Result<>();\n        result.code = code;\n        result.message = message;\n        return result;\n    }\n}\n复制代码\n \n\n✅ 第 3 步：（可选）定义自定义业务异常\n复制代码\npackage com.example.demo.exception;\n\npublic class BusinessException extends RuntimeException {\n    private int code;\n\n    public BusinessException(int code, String message) {\n        super(message);\n        this.code = code;\n    }\n\n    // getter...\n}\n复制代码\n \n\n在业务代码中抛出：\n\nif (user == null) {\n    throw new BusinessException(1001, \"用户不存在\");\n}\n \n\n✅ 第 4 步：确保包路径被扫描到\n全局异常处理类必须位于 Spring Boot 主启动类所在包或其子包下。\n否则需显式指定扫描路径：\n复制代码\n@SpringBootApplication(scanBasePackages = \"com.example\")\npublic class DemoApplication {\n    public static void main(String[] args) {\n        SpringApplication.run(DemoApplication.class, args);\n    }\n}\n复制代码\n \n\n✅ 第 5 步：（重要）启用异常转发（处理 404）\n默认情况下，访问不存在的 URL 不会抛出异常，而是返回 404 页面。若想让 404 也被全局处理器捕获，需在 application.properties 中添加：\n 当没有找到处理器时，抛出 NoHandlerFoundException\nspring.mvc.throw-exception-if-no-handler-found=true\n禁用静态资源映射（避免干扰）\nspring.web.resources.add-mappings=false\n \n\n然后在全局处理器中添加：\n\n@ExceptionHandler(NoHandlerFoundException.class)\npublic Result handle404() {\n    return Result.error(404, \"接口不存在\");\n}\n \n\n# 三、完整示例结构\nsrc/main/java/com/example/demo/\n├── DemoApplication.java\n├── controller/\n│   └── UserController.java\n├── exception/\n│   ├── GlobalExceptionHandler.java\n│   └── BusinessException.java\n└── common/\n    └── Result.java\n# 四、最佳实践建议\n场景	建议\n开发阶段	可在 handleGeneral 中返回 e.getMessage() 便于调试\n生产环境	隐藏具体异常信息，只返回友好提示，避免信息泄露\n异常分类	优先处理具体异常（如 ValidationException, IllegalArgumentException），最后用 Exception 兜底\n日志记录	在 @ExceptionHandler 方法中加入 log.error(\"异常:\", e);\nHTTP 状态码	可结合 ResponseEntity 返回不同状态码：\nreturn ResponseEntity.status(400).body(Result.error(...));\n# 五、常见问题排查\n全局异常处理器没生效？\n\n检查是否被 Spring 扫描到（包路径问题）\n检查是否缺少 spring-boot-starter-web 依赖\n404 无法被捕获？\n\n必须配置 spring.mvc.throw-exception-if-no-handler-found=true\n返回的是 HTML 而不是 JSON？\n\n确保使用的是 @RestControllerAdvice，而不是 @ControllerAdvice\n✅ 总结\n通过 @RestControllerAdvice + @ExceptionHandler，你可以：\n\n统一错误格式\n避免在每个 Controller 中写 try-catch\n提升 API 友好性和安全性\n集中记录异常日志\n这是 Spring Boot 项目必备的基础配置之一。');
INSERT INTO `t_article_content` VALUES (30, 31, '# 基础个人信息\n姓名：段国强\n年龄：22 岁\n性别：男\n院校：江苏理工学院\n专业：网络工程（本科）\n联系方式：18270261553\n邮箱：2111477010@qq.com\n# 一、核心技术能力体系\n## 1. Java 基础与底层原理\n精通 Java8 至 Java26 全系列新特性，熟练使用 Hutool、Lombok 等主流工具开发库；\n吃透 JVM 核心底层：内存分区模型、类完整加载流程、对象实例化机制，熟练掌握 CMS、G1、ZGC 多款垃圾回收器原理、调优参数与线上调优方案；\n精通 HashMap 底层数组 + 链表 + 红黑树完整结构，掌握哈希冲突解决、自动扩容、树化阈值、并发场景线程不安全底层根源；\n精通 Java 并发编程体系，吃透 CAS 无锁乐观锁、AQS 同步器底层实现，熟练应用 ReentrantLock、CountDownLatch、自定义线程池，具备完整线程安全落地经验。\n## 2. AI 大模型与 RAG 智能应用开发\n掌握 SpringAI、LangChain4j Java AI 开发框架，独立完成企业级智能体项目，落地 RAG 知识库、函数工具调用、MCP 协议、多 Agent 协同开发；\n精通 Prompt 工程优化技巧，基于 PGVector 向量数据库搭建完整 RAG 链路：文档 ETL 清洗、文本向量化存储、语义相似度检索、查询重排增强全流程落地；\n熟练使用 Cursor、Claude Code、GitHub Copilot AI 辅助开发工具，掌握 MCP Server 服务、Agent 自定义技能开发与发布流程。\n## 3. 前后端开发框架\n后端：基于 SpringBoot3 + MyBatis-Plus 独立开发单体业务系统；精通 SpringCloud 微服务全套组件，可完成大型项目微服务拆分、治理、灰度发布；\n权限鉴权：深耕 SpringSecurity、Sa-Token 两大权限框架，落地 SpringSecurity/Sa-Token + JWT + Redis 鉴权方案，拥有单体、分布式两套完整用户认证授权实战经验；\n前端：熟练 Vue2、Vue3、ElementUI/ElementPlus，精通 setup 语法糖，可独立完成管理后台、博客前台页面开发。\n### 4. MySQL 数据库性能优化\n精通 MySQL 数据表设计规范，熟练编写高性能 SQL，掌握索引优化、分库分表、读写分离分布式方案；\n基于 Druid 监控慢 SQL、执行计划分析，解决线上慢查询问题；\n吃透 MVCC 多版本并发控制、四大事务隔离级别、undo 日志、redo 日志底层原理，清晰理解事务 ACID 实现机制。\n5. 缓存、消息队列与检索中间件\nRedis：熟练搭建单机 / 哨兵集群，落地多级缓存（Caffeine 本地缓存 + Redis 分布式缓存），解决缓存雪崩、缓存穿透、缓存击穿三大问题，实现分布式锁；\nRabbitMQ/Kafka：熟练消息队列异步解耦、流量削峰，掌握消息持久化、重试机制、死信队列业务落地；\nElasticsearch：搭建全站全文检索服务，实现中文分词、关键词高亮、多维度聚合统计，大幅提升检索性能。\n6. 容器化部署、运维监控\nDocker：编写 Dockerfile 打包前后端项目，容器化部署，支持快速迁移至任意服务器；搭配 Nginx 反向代理、负载均衡；\n监控体系：搭建 Prometheus + Grafana + 阿里云 ARMS 全链路监控，覆盖 JVM 指标、接口耗时、系统资源实时观测；\nCI/CD：基于 GitLab 流水线实现项目自动构建、测试、部署，自动化发布流程。\n\n## 三、核心开源项目：AI 智能博客平台\n在线访问地址：**********\nGitHub 开源地址：**********\n技术栈\nSpringBoot3 + SpringAI + LangChain4j RAG 向量知识库 + SpringSecurity + Redis + Elasticsearch + RabbitMQ + Vue3 + Docker + PGVector\n项目核心业务功能\nAI 智能问答与内容增强：依托 SpringAI、LangChain4j 搭建 RAG 知识库，支持多 Agent 协作、自定义工具调用，实现博客文章智能问答、文章自动润色、个性化内容推荐；\n向量检索 RAG 系统：基于 PGVector 向量数据库完成文档 ETL 清洗、文本向量化存储、语义相似度检索，精准匹配知识库内容回答用户提问；\nRedis 多级缓存优化：缓存首页文章、分类、标签、登录用户信息、阅读点赞计数，数据库访问压力降低 90% 以上，大幅提升接口响应速度；\nElasticsearch 全文检索：全站文章分词检索、关键词高亮展示，对比原生 MySQL 模糊查询，搜索性能提升 80%；\nRabbitMQ 异步消息队列：异步处理邮件通知、评论推送、文章数据同步，实现流量削峰，隔离非核心业务，保障高并发稳定性；\nVue3 可视化前端：响应式博客前台 + 管理后台，集成 ECharts 数据大屏，展示文章阅读趋势、用户访问统计、评论互动数据；配套 SEO、TDK、GEO 优化，提升搜索引擎收录与 AI 分发推荐权重；\nCI/CD 自动化部署：GitLab 流水线自动构建、打包、发布；前后端全部 Docker 容器化，一键部署，跨服务器快速迁移启动。');
INSERT INTO `t_article_content` VALUES (60, 61, '<h1>LangChain4j 与 Spring Boot 深度融合：构建企业级 LLM 应用实践</h1>\r\n\r\n<h2>📌 摘要</h2>\r\n<p>LangChain4j 是专为 Java 生态打造的 LLM 应用开发框架，它填补了 Java 在大模型应用领域的空白。本文将从实际项目角度出发，详细讲解如何在 Spring Boot 项目中集成 LangChain4j，涵盖对话模型管理、RAG 检索增强、Function Calling 工具调用等核心能力。通过本文，你将掌握一套完整的企业级 LLM 应用开发方案，并能够快速落地到实际业务中。</p>\r\n\r\n<h2>🏷️ 关键词</h2>\r\n<p>LangChain4j · Spring Boot · LLM · RAG · Function Calling · 对话记忆</p>\r\n\r\n<h2>📖 一、引言</h2>\r\n<p>过去两年，以 ChatGPT 为代表的大语言模型引发了技术范式的深刻变革。Python 生态凭借 LangChain、LlamaIndex 等框架迅速占领了 AI 应用开发的高地。然而，对于庞大的 Java 开发者群体而言，如何在熟悉的 Spring 生态中构建 LLM 应用，一直是一个被忽视却亟待解决的痛点。</p>\r\n<p>LangChain4j 的出现改变了这一局面。它由 Java 开发者社区驱动，提供了与 LangChain 类似的核心抽象，同时深度拥抱 Java 的设计哲学——类型安全、接口清晰、与 Spring Boot 无缝集成。本文不是简单的 API 罗列，而是从真实的业务场景出发，带你逐步构建一个完整的智能问答应用。</p>\r\n\r\n<h2>🏗️ 二、技术架构总览</h2>\r\n<p>在开始编码之前，我们先定义系统的整体架构。一个典型的企业级 LLM 应用包含以下五层：</p>\r\n<ul>\r\n<li><strong>接入层</strong>：RESTful API 和 WebSocket 接口，支持同步与流式两种响应模式。</li>\r\n<li><strong>编排层</strong>：核心是 LangChain4j 的 Chain 和 Agent 机制，负责任务分解与执行顺序编排。</li>\r\n<li><strong>能力层</strong>：封装 ChatLanguageModel（对话）、EmbeddingModel（向量化）、Tool（工具）等核心组件。</li>\r\n<li><strong>数据层</strong>：包含向量数据库（用于 RAG）、关系型数据库（存储业务数据）和 Redis（缓存与会话）。</li>\r\n<li><strong>治理层</strong>：日志审计、Token 用量监控、成本控制与安全过滤。</li>\r\n</ul>\r\n\r\n<h2>🔧 三、核心实现：从依赖到代码</h2>\r\n\r\n<h3>3.1 项目依赖配置</h3>\r\n<pre><code>dependencies {\r\n    // Spring Boot 3.x 基础\r\n    implementation \'org.springframework.boot:spring-boot-starter-web\'\r\n    \r\n    // LangChain4j 核心与 Spring Boot 集成\r\n    implementation \'dev.langchain4j:langchain4j-spring-boot-starter:0.33.0\'\r\n    implementation \'dev.langchain4j:langchain4j-open-ai:0.33.0\'\r\n    \r\n    // 向量数据库（本文使用 PGVector）\r\n    implementation \'dev.langchain4j:langchain4j-pgvector:0.33.0\'\r\n    \r\n    // 工具类\r\n    implementation \'org.apache.commons:commons-lang3\'\r\n}</code></pre>\r\n\r\n<h3>3.2 对话模型配置</h3>\r\n<pre><code>@Configuration\r\npublic class LLMConfig {\r\n    @Value(\"${openai.api-key}\")\r\n    private String apiKey;\r\n    \r\n    @Bean\r\n    public ChatLanguageModel chatModel() {\r\n        return OpenAiChatModel.builder()\r\n            .apiKey(apiKey)\r\n            .modelName(\"gpt-4-turbo\")\r\n            .temperature(0.7)\r\n            .maxTokens(2048)\r\n            .build();\r\n    }\r\n    \r\n    @Bean\r\n    public EmbeddingModel embeddingModel() {\r\n        return new OpenAiEmbeddingModel(\r\n            OpenAiEmbeddingModel.builder()\r\n                .apiKey(apiKey)\r\n                .modelName(\"text-embedding-3-small\")\r\n                .build()\r\n        );\r\n    }\r\n}</code></pre>\r\n<p>这里，我们配置了两个核心 Bean：ChatLanguageModel 用于对话生成，EmbeddingModel 用于文本向量化，两者是构建 RAG 和 Agent 的基础。</p>\r\n\r\n<h3>3.3 实现 RAG 检索增强</h3>\r\n<p>RAG 是目前企业落地 LLM 最成熟的技术路径。其核心思想是：在模型生成答案之前，先从外部知识库中检索与问题最相关的文档片段，将这些片段作为上下文注入到 Prompt 中，从而让模型基于私有数据回答。</p>\r\n<pre><code>@Service\r\npublic class RagService {\r\n    private final ChatLanguageModel chatModel;\r\n    private final EmbeddingStore<TextSegment> vectorStore;\r\n    \r\n    public String ask(String question) {\r\n        // 1. 将问题向量化\r\n        Embedding queryEmbedding = embeddingModel.embed(question).content();\r\n        \r\n        // 2. 在向量数据库中检索 Top-K 相关文档\r\n        List<EmbeddingMatch<TextSegment>> matches = vectorStore.findRelevant(\r\n            queryEmbedding, 5, 0.75\r\n        );\r\n        \r\n        // 3. 构建增强 Prompt\r\n        String context = matches.stream()\r\n            .map(m -> m.embedded().text())\r\n            .collect(Collectors.joining(\"\n\n\"));\r\n            \r\n        String prompt = \"\"\"\r\n            请基于以下参考资料回答用户的问题。\r\n            参考资料：\r\n            %s\r\n            \r\n            用户问题：%s\r\n            \"\"\".formatted(context, question);\r\n            \r\n        // 4. 生成回复\r\n        return chatModel.chat(prompt);\r\n    }\r\n}</code></pre>\r\n\r\n<h3>3.4 工具调用机制</h3>\r\n<p>Function Calling 让 LLM 能够调用外部 API，是 Agent 能力的关键。下面示例演示如何让 LLM 查询实时天气：</p>\r\n<pre><code>@Tool\r\npublic class WeatherTool {\r\n    @ToolMethod(\"获取指定城市的实时天气信息\")\r\n    public String getWeather(@P(\"城市名称，如：北京、上海\") String city) {\r\n        // 调用第三方天气 API\r\n        return weatherApi.fetch(city);\r\n    }\r\n}\r\n\r\n// 在 Agent 中注册工具\r\nList<ToolSpecification> tools = ToolSpecifications.toolSpecificationsFrom(weatherTool);\r\nString response = chatModel.chat(messages, tools);</code></pre>\r\n<p>工具调用打通了 LLM 与业务系统之间的\"最后一公里\"，让 AI 真正具备了行动能力。</p>\r\n\r\n<h2>📊 四、性能优化与生产级考量</h2>\r\n<p>在生产环境中运行 LLM 应用，以下几个维度需要特别关注：</p>\r\n<ul>\r\n<li><strong>Token 成本控制</strong>：通过限制 maxTokens、使用更经济的模型（如 gpt-3.5-turbo）和缓存常用查询来降低成本。</li>\r\n<li><strong>向量检索延迟</strong>：建议使用 HNSW 或 IVF 索引，并合理设置 Top-K 值（通常 3-5 即可）。</li>\r\n<li><strong>流式响应</strong>：对前端交互友好的场景，务必启用流式输出，SSE 或 WebSocket 均可。</li>\r\n<li><strong>安全防护</strong>：对用户输入进行清洗，防止 Prompt Injection 攻击；对输出进行内容安全过滤。</li>\r\n</ul>\r\n\r\n<h2>✅ 五、总结与展望</h2>\r\n<p>LangChain4j 与 Spring Boot 的结合，为 Java 开发者提供了一条低门槛、高生产力的 LLM 应用开发路径。本文从架构设计、核心实现到生产优化，系统性地介绍了构建企业级智能应用的完整流程。随着大模型技术的持续演进，LangChain4j 也在快速迭代——对多模态模型、本地部署方案的支持正在逐步完善。Java 生态在 AI 时代的潜力才刚刚开始释放，未来可期。</p>');
INSERT INTO `t_article_content` VALUES (61, 62, '<h1>RAG 检索增强生成技术深度解析：从向量检索到智能问答系统落地</h1>\r\n\r\n<h2>📌 摘要</h2>\r\n<p>RAG（Retrieval-Augmented Generation）已成为大模型时代最具影响力的技术范式之一，它通过将外部知识检索与参数化生成相结合，从根本上解决了大模型的\"幻觉\"问题和知识时效性不足的缺陷。本文将从技术原理、系统架构、核心组件选型、性能调优四个维度，对 RAG 技术进行深度剖析，并结合开源工具链提供完整的落地实现方案，帮助读者在企业场景中成功构建 RAG 应用。</p>\r\n\r\n<h2>🏷️ 关键词</h2>\r\n<p>RAG · 向量检索 · 知识库问答 · 嵌入模型 · 检索优化</p>\r\n\r\n<h2>📖 一、为什么需要 RAG</h2>\r\n<p>大语言模型（LLM）基于海量公开数据进行预训练，这赋予了它强大的语言理解和生成能力。然而，这种能力也伴随着两个先天缺陷：一是知识截止日期（Knowledge Cutoff），模型无法获取训练数据截止时间之后的信息；二是\"幻觉\"（Hallucination），模型可能在不确定时编造看似合理但事实错误的回答。在医疗、金融、法律等对准确性要求极高的垂直领域，这两个问题足以让大模型的应用价值大打折扣。</p>\r\n<p>RAG 提供了一种优雅的解决方案：它不再要求模型\"记住\"所有知识，而是让模型学会\"查询\"知识。每当用户提问时，RAG 系统先从外部知识库中检索最相关的文档片段，然后将这些片段与问题一起交给模型生成答案。这种\"先检索，后生成\"的架构，既保证了答案的时效性和准确性，又大幅降低了模型的训练和部署成本。</p>\r\n\r\n<h2>🏗️ 二、RAG 系统核心架构</h2>\r\n<p>一个完整的 RAG 系统由\"离线索引管道\"和\"在线查询管道\"两部分构成，两者协同工作形成闭环。</p>\r\n<ul>\r\n<li><strong>离线索引管道</strong>：负责知识库的构建。包括文档加载与解析（支持 PDF、Word、Markdown、HTML 等格式）、文本分块（Chunking）、向量化（Embedding）和向量存储（Vector Store）四个环节。</li>\r\n<li><strong>在线查询管道</strong>：负责实时响应。包括查询理解（Query Understanding）、向量检索（Vector Search）、重排序（Reranking）、上下文增强（Context Augmentation）和答案生成（Answer Generation）五个环节。</li>\r\n</ul>\r\n\r\n<h2>🔧 三、核心组件选型与实战</h2>\r\n\r\n<h3>3.1 文本分块策略</h3>\r\n<p>分块（Chunking）是 RAG 系统中容易被忽视却影响深远的一环。分块过小，语义不完整；分块过大，检索精度下降且 Token 消耗增加。实践中，我们通常采用以下策略：</p>\r\n<ul>\r\n<li><strong>固定大小分块</strong>：按固定 Token 数切分（如 512 tokens），简单易行，适合通用场景。</li>\r\n<li><strong>语义分块</strong>：按句子边界、段落边界或 Markdown 标题层级进行切分，语义完整性更好。</li>\r\n<li><strong>滑动窗口分块</strong>：在分块之间设置重叠区域（如 10%-20%），有效避免跨块语义断裂。</li>\r\n</ul>\r\n<p>经过多轮实验，我们推荐在技术文档场景下使用\"按标题层级分块 + 10% 滑动窗口\"的组合策略，分块大小控制在 300-500 tokens 之间。</p>\r\n\r\n<h3>3.2 向量数据库选型对比</h3>\r\n<p>向量数据库是 RAG 系统的核心存储引擎，当前主流方案各有优劣：</p>\r\n<ul>\r\n<li><strong>PGVector</strong>：PostgreSQL 扩展，与关系型数据同库存储，运维成本最低，适合中小规模场景。</li>\r\n<li><strong>Milvus</strong>：分布式向量数据库，支持十亿级向量检索，适合大规模生产环境。</li>\r\n<li><strong>Qdrant</strong>：Rust 编写的高性能向量数据库，API 友好，社区活跃。</li>\r\n<li><strong>Elasticsearch</strong>：老牌搜索引擎，支持向量与倒排索引混合检索，适合已有 ES 技术栈的团队。</li>\r\n</ul>\r\n\r\n<h3>3.3 检索优化：从向量到 Reranking</h3>\r\n<p>纯粹的向量检索往往不够完美，以下技术能显著提升检索质量：</p>\r\n<ul>\r\n<li><strong>HyDE (Hypothetical Document Embeddings)</strong>：让 LLM 针对用户问题生成一个\"假设性答案\"，然后用这个答案的向量去检索相似文档。实验表明，HyDE 在 open-domain 问答场景下可将 Recall@5 提升 15%-20%。</li>\r\n<li><strong>查询改写 (Query Rewriting)</strong>：用 LLM 对用户问题进行多角度改写，生成多个查询变体进行检索，然后合并结果。特别适合口语化、模糊的查询。</li>\r\n<li><strong>重排序 (Reranking)</strong>：在向量检索召回 Top-N（如 50 条）后，使用更精密的 Cross-Encoder 模型重新打分，选出最终的 Top-K（如 5 条）。此步骤虽增加延迟，但准确性提升显著。</li>\r\n</ul>\r\n\r\n<h2>⚡ 四、性能优化与生产部署</h2>\r\n<p>在生产环境中部署 RAG 系统，以下实践建议值得参考：</p>\r\n<ul>\r\n<li><strong>索引策略</strong>：对向量字段建立 HNSW 或 IVF 索引，检索延迟可降低 80% 以上。</li>\r\n<li><strong>缓存策略</strong>：对高频查询进行缓存（建议使用 Redis），命中率可达 30%-50%。</li>\r\n<li><strong>异步索引</strong>：文档更新采用异步队列处理（如 RabbitMQ），避免阻塞在线查询。</li>\r\n<li><strong>监控告警</strong>：重点监控向量检索延迟、Token 消耗、召回准确率和用户满意度。</li>\r\n</ul>\r\n\r\n<h2>✅ 五、总结与展望</h2>\r\n<p>RAG 技术正在从\"有没有\"走向\"好不好\"，从简单的\"检索-生成\"两段式演进到包含查询理解、多路召回、重排序、上下文压缩、生成增强的复杂管道。未来，RAG 将与 Agent 技术深度融合——检索不再是孤立的步骤，而是 Agent 主动规划和调用的工具之一。对于开发者而言，深入理解 RAG 的每一个环节、持续优化检索质量，是构建下一代智能应用的关键能力。</p>');
INSERT INTO `t_article_content` VALUES (62, 63, '<h1>AI Agent 智能体设计模式全景解析：从 ReAct 到多智能体协作</h1>\r\n\r\n<h2>📌 摘要</h2>\r\n<p>AI Agent（智能体）被广泛视为继 LLM 之后的下一座技术里程碑。它让大模型从被动应答的\"聊天机器人\"进化为主动规划、调用工具、与环境交互的\"自主行动者\"。本文将从认知架构出发，系统梳理 AI Agent 的核心设计模式——包括 ReAct、CoT、ToT、Reflection 等，深入解析工具调用、记忆管理、多智能体协作等关键机制，并结合 LangChain4j 提供可落地的代码实现，帮助开发者在实际项目中构建稳定、可控的 Agent 系统。</p>\r\n\r\n<h2>🏷️ 关键词</h2>\r\n<p>AI Agent · ReAct · 工具调用 · 记忆系统 · 多智能体协作</p>\r\n\r\n<h2>📖 一、Agent 的本质与认知架构</h2>\r\n<p>Agent 的本质是\"能够自主感知环境、做出决策并执行行动以达成目标的实体\"。在 AI 语境下，Agent 的核心是一组精心设计的 Prompt 和决策循环，它赋予 LLM 以下三个关键能力：</p>\r\n<ul>\r\n<li><strong>推理能力</strong>：能够分析复杂问题，分解子目标，制定执行计划。</li>\r\n<li><strong>行动能力</strong>：能够调用外部工具（API、数据库、计算引擎），执行具体的操作。</li>\r\n<li><strong>反思能力</strong>：能够观察行动结果，评估是否达成目标，并根据反馈调整策略。</li>\r\n</ul>\r\n<p>这种\"思考-行动-观察-再思考\"的闭环，是 Agent 区别于传统 LLM 应用的标志性特征。以下公式可以简洁地概括 Agent 的工作模式：</p>\r\n<p><code>Agent = LLM + 规划 + 工具 + 记忆</code></p>\r\n\r\n<h2>🏗️ 二、Agent 核心设计模式</h2>\r\n\r\n<h3>2.1 ReAct 模式：推理与行动的协同</h3>\r\n<p>ReAct（Reasoning + Acting）是目前最基础、应用最广泛的 Agent 设计模式。其核心思想是：在每一步中，Agent 先输出一段\"思考\"（Reasoning），再输出一个\"行动\"（Acting），然后接收环境的\"观察\"（Observation），如此循环往复，直到完成任务。</p>\r\n<pre><code>// ReAct 模式的伪代码表示\r\nwhile (not done) {\r\n    thought = LLM.generate(history + \"思考下一步该做什么\")\r\n    action = parseAction(thought)  // 提取工具名称和参数\r\n    observation = executeTool(action)\r\n    history += (thought + action + observation)\r\n}</code></pre>\r\n<p>ReAct 的设计哲学是\"让思考过程可见\"，这不仅提升了决策的透明度，还允许开发者在中间步骤介入调试，极大地增强了系统的可解释性和可控性。</p>\r\n\r\n<h3>2.2 CoT 与 ToT：复杂推理的进化</h3>\r\n<p>Chain of Thought（思维链）通过引导 LLM 输出中间推理步骤，显著提升了模型在数学推理和逻辑问题上的表现。Tree of Thoughts（思维树）则更进一步——它不满足于一条推理链，而是探索多条路径，通过搜索算法（如 BFS 或 DFS）找到最优解，适合处理开放性问题。</p>\r\n\r\n<h3>2.3 Reflection 与自我修正</h3>\r\n<p>Reflection 模式让 Agent 能够对自身输出进行批判性审视。典型流程是：Agent 先生成初始答案，然后另一个\"反思者\"角色对其进行批评，指出错误或不足，最后原 Agent 根据反馈进行修正。这种\"生成-批评-修正\"循环能显著提升输出质量，尤其是在代码生成和写作任务中。</p>\r\n\r\n<h2>🔧 三、工具调用与记忆管理</h2>\r\n\r\n<h3>3.1 Function Calling 深度解析</h3>\r\n<p>工具调用是 Agent 行动能力的核心。当前主流的 LLM（GPT-4、Claude 3、Qwen 等）都已原生支持 Function Calling。在实现时，最关键的是两个环节：</p>\r\n<ul>\r\n<li><strong>工具描述</strong>：用 JSON Schema 清晰定义工具的输入参数类型、格式和约束。</li>\r\n<li><strong>错误处理</strong>：当工具调用失败或返回异常时，Agent 应具备重试或降级能力，而非直接崩溃。</li>\r\n</ul>\r\n\r\n<h3>3.2 记忆系统：短期与长期记忆</h3>\r\n<p>记忆是 Agent 持续学习和个性化的重要基础。合理的记忆设计应包含三个层次：</p>\r\n<ul>\r\n<li><strong>短期记忆</strong>：即当前会话的历史消息，通常采用滑动窗口（最近 N 轮）或 Token 预算截断。</li>\r\n<li><strong>长期记忆</strong>：使用向量数据库存储重要事实、用户偏好和历史决策，供未来查询使用。</li>\r\n<li><strong>工作记忆</strong>：存储当前任务的状态信息，如已完成的子任务、待办列表等。</li>\r\n</ul>\r\n\r\n<h2>✅ 四、总结</h2>\r\n<p>AI Agent 正在从学术概念快速走向工业落地。无论你选择哪种设计模式，成功的核心要素始终是：清晰的工具定义、鲁棒的异常处理、可观测的决策过程和可控的安全边界。随着多智能体协作框架的成熟，Agent 将在软件开发、自动化运营、科学研究等领域释放更大的潜能。</p>');
INSERT INTO `t_article_content` VALUES (63, 64, '<h1>Spring AI 框架实战：函数调用、向量检索与模型适配全攻略</h1>\r\n\r\n<h2>📌 摘要</h2>\r\n<p>Spring AI 是 VMware 官方推出的 AI 应用开发框架，它遵循 Spring 的设计哲学，为 Java 开发者提供了统一、类型安全的大模型集成体验。本文从实战角度出发，系统讲解 Spring AI 的核心模块：Function Calling（函数调用）实现业务 API 与 LLM 的打通、Vector Store 抽象层对接多种向量数据库、Prompt Template 实现提示工程的结构化。通过完整的代码示例和架构设计，帮助读者快速掌握 Spring AI 的核心能力，并能够将其整合到现有的 Spring Boot 项目中。</p>\r\n\r\n<h2>🏷️ 关键词</h2>\r\n<p>Spring AI · Function Calling · 向量检索 · 模型适配 · Prompt Engineering</p>\r\n\r\n<h2>📖 一、Spring AI 的设计哲学</h2>\r\n<p>在 Spring AI 出现之前，Java 开发者若要集成大模型，往往需要直接调用各厂商的 SDK，面对的是截然不同的 API 风格、参数命名和错误处理方式。Spring AI 的核心价值在于\"抽象\"——它定义了一套统一的接口规范，屏蔽了底层模型（OpenAI、Azure、Ollama、HuggingFace 等）的差异，让开发者能够以一致的方式切换模型，同时保留了各模型的高级特性。</p>\r\n<p>Spring AI 的整体架构分为三层：</p>\r\n<ul>\r\n<li><strong>抽象层</strong>：定义 ChatModel、EmbeddingModel、VectorStore 等核心接口。</li>\r\n<li><strong>实现层</strong>：针对 OpenAI、Azure、Ollama 等提供具体实现。</li>\r\n<li><strong>集成层</strong>：与 Spring Boot、Spring Cloud、Spring Data 等无缝对接。</li>\r\n</ul>\r\n\r\n<h2>🔧 二、核心功能实战</h2>\r\n\r\n<h3>2.1 Function Calling：让 LLM 调用你的业务 API</h3>\r\n<p>Function Calling 是 Spring AI 最实用的功能之一。通过定义 Java 函数并标注 @Tool 注解，LLM 就能在对话中自动识别并调用这些函数。</p>\r\n<pre><code>@Service\r\npublic class OrderService {\r\n    @Tool(description = \"查询指定订单号的订单状态和详情\")\r\n    public OrderInfo getOrder(@ToolParam(description = \"订单号，格式为 ORD-xxxxxx\") String orderId) {\r\n        return orderRepository.findById(orderId);\r\n    }\r\n}\r\n\r\n@Configuration\r\npublic class AIConfig {\r\n    @Bean\r\n    public ChatClient chatClient(ChatModel model, OrderService orderService) {\r\n        return ChatClient.builder(model)\r\n            .defaultTools(orderService)\r\n            .build();\r\n    }\r\n}</code></pre>\r\n<p>在调用时，当用户提问\"我的订单 ORD-123456 现在什么状态？\"，LLM 会自动识别需要调用 getOrder 函数，提取参数 orderId，执行查询并返回结果。整个过程的实现成本极低，但效果惊人——它让对话系统真正具备了\"办事\"的能力。</p>\r\n\r\n<h3>2.2 向量检索与 RAG 集成</h3>\r\n<p>Spring AI 对向量数据库提供了统一的抽象，目前支持 Milvus、PGVector、Qdrant、Elasticsearch 等主流方案。以下代码展示了如何使用 PGVector 构建 RAG 检索：</p>\r\n<pre><code>@Service\r\npublic class KnowledgeBaseService {\r\n    private final VectorStore vectorStore;\r\n    private final ChatModel chatModel;\r\n    \r\n    public String query(String question) {\r\n        // 语义检索\r\n        List<Document> docs = vectorStore.similaritySearch(\r\n            SearchRequest.builder()\r\n                .query(question)\r\n                .topK(4)\r\n                .similarityThreshold(0.7)\r\n                .build()\r\n        );\r\n        \r\n        // 构建上下文\r\n        String context = docs.stream()\r\n            .map(Document::getText)\r\n            .collect(Collectors.joining(\"\n---\n\"));\r\n            \r\n        // 生成答案\r\n        String prompt = \"\"\"\r\n            你是一位知识渊博的助手。请基于以下参考资料回答用户问题。\r\n            \r\n            参考资料：\r\n            %s\r\n            \r\n            用户问题：%s\r\n            \"\"\".formatted(context, question);\r\n            \r\n        return chatModel.call(prompt);\r\n    }\r\n}</code></pre>\r\n\r\n<h3>2.3 Prompt 模板与结构化输出</h3>\r\n<p>Spring AI 提供了 Prompt 模板支持，帮助开发者将提示工程从 Java 代码中分离出来，便于版本管理和迭代优化：</p>\r\n<pre><code>// src/main/resources/prompts/qa.st\r\n// 模板内容：\r\n// 你是一位{{ role }}专家。请根据以下信息回答问题。\r\n// 信息：{{ context }}\r\n// 问题：{{ question }}\r\n// 回答格式：{{ format }}\r\n\r\nPromptTemplate template = new PromptTemplate(\"classpath:prompts/qa.st\");\r\nString result = template.render(Map.of(\r\n    \"role\", \"技术架构师\",\r\n    \"context\", context,\r\n    \"question\", question,\r\n    \"format\", \"分点列举，每点不超过50字\"\r\n));</code></pre>\r\n\r\n<h2>📊 三、生产级配置与最佳实践</h2>\r\n<p>在将 Spring AI 应用部署到生产环境时，以下配置和经验值得关注：</p>\r\n<ul>\r\n<li><strong>超时配置</strong>：LLM 调用通常较慢，建议设置合理的连接超时（15s）和读取超时（60s）。</li>\r\n<li><strong>重试机制</strong>：网络波动或模型限流时，采用指数退避策略重试（最多 3 次）。</li>\r\n<li><strong>Token 预算</strong>：为每次调用设置 maxTokens 上限，防止成本失控。</li>\r\n<li><strong>日志审计</strong>：记录每次调用的输入、输出和 Token 消耗，用于成本分析和问题排查。</li>\r\n</ul>\r\n\r\n<h2>✅ 四、总结</h2>\r\n<p>Spring AI 凭借其统一的抽象层、类型安全的 API 和与 Spring 生态的深度集成，正在成为 Java 开发者构建 LLM 应用的首选框架。本文介绍的 Function Calling、Vector Store 和 Prompt 模板是其最核心的三个功能模块，掌握了它们，就能覆盖 80% 以上的 LLM 应用场景。</p>');
INSERT INTO `t_article_content` VALUES (64, 65, '<h1>大模型微调技术全景：从 PEFT/LoRA 到 QLoRA 的高效参数优化实践</h1>\r\n\r\n<h2>📌 摘要</h2>\r\n<p>大语言模型的参数量已从数十亿跃升至万亿级别，全参数微调对绝大多数开发者和企业来说不再是一个可行的选项。PEFT（Parameter-Efficient Fine-Tuning）技术的兴起改变了这一局面——它通过冻结原模型、仅训练少量附加参数，以极低成本实现接近全参数微调的效果。本文将系统梳理 LoRA、QLoRA、P-Tuning、Adapter 等主流 PEFT 方法，剖析其数学原理与适用场景，并提供完整的 LoRA 微调实战代码，涵盖数据准备、训练、评估与推理部署的全流程。</p>\r\n\r\n<h2>🏷️ 关键词</h2>\r\n<p>LoRA · QLoRA · PEFT · 大模型微调 · 参数高效</p>\r\n\r\n<h2>📖 一、为什么需要参数高效微调</h2>\r\n<p>GPT-3 的 1750 亿参数已经令人惊叹，而 GPT-4 和 Llama 3 的参数量还在持续增长。对普通开发者而言，全参数微调面临着三重困境：</p>\r\n<ul>\r\n<li><strong>算力瓶颈</strong>：微调 70B 模型需要至少 8 张 A100 显卡，成本高达数十万元。</li>\r\n<li><strong>数据门槛</strong>：高质量的微调数据获取困难，尤其是垂直领域数据。</li>\r\n<li><strong>部署复杂</strong>：全参数微调后，每个任务都需要保存一份完整的模型副本，存储成本极高。</li>\r\n</ul>\r\n<p>PEFT 技术的核心思想是\"冻结预训练模型的全部参数，仅在模型的关键位置插入少量可训练参数\"。这种方法将训练参数量从百亿级骤降至百万级，GPU 显存需求降低 90% 以上，同时性能损耗控制在 3% 以内——这被视为大模型私有化部署的\"破局之道\"。</p>\r\n\r\n<h2>🔬 二、主流 PEFT 技术对比</h2>\r\n\r\n<h3>2.1 LoRA：低秩适配</h3>\r\n<p>LoRA（Low-Rank Adaptation）是目前最受欢迎的 PEFT 方法。其核心数学原理是利用矩阵的低秩分解来近似权重更新：</p>\r\n<p><code>ΔW = B × A</code></p>\r\n<p>其中，A 和 B 是两个低秩矩阵（rank r 通常为 4-16），远小于原始权重矩阵 W 的维度。训练时只更新 A 和 B，推理时将 ΔW 加回 W 中，不增加推理延迟。这种设计的精妙之处在于：低秩假设被证实在大模型微调中完全成立，也就是说，适应新任务所需的\"知识增量\"可以用极少的参数来承载。</p>\r\n\r\n<h3>2.2 QLoRA：量化 + LoRA 的双重优化</h3>\r\n<p>QLoRA（Quantized LoRA）在 LoRA 的基础上引入了 4-bit 量化技术。它将预训练模型量化为 4-bit 精度，在此基础上应用 LoRA 进行微调。这一技术使得在单张 24GB 显存的消费级显卡（如 RTX 4090）上微调 70B 模型成为可能，极大地降低了硬件门槛。</p>\r\n\r\n<h3>2.3 其他方案对比</h3>\r\n<ul>\r\n<li><strong>P-Tuning v2</strong>：在 Transformer 的每一层添加可训练的连续提示向量，适合多任务场景。</li>\r\n<li><strong>Adapter</strong>：在 Transformer 层之间插入小型适配器模块，参数量略大于 LoRA。</li>\r\n<li><strong>IA3</strong>：学习向量缩放激活值，参数量极小，适合简单任务。</li>\r\n</ul>\r\n\r\n<h2>🧪 三、LoRA 微调完整实战</h2>\r\n\r\n<h3>3.1 环境准备</h3>\r\n<pre><code># 安装依赖\r\npip install transformers peft accelerate bitsandbytes datasets trl</code></pre>\r\n\r\n<h3>3.2 数据准备与预处理</h3>\r\n<p>微调数据的质量直接决定最终效果。以指令微调（Instruction Tuning）为例，推荐使用 Alpaca 格式：</p>\r\n<pre><code>{\r\n  \"instruction\": \"将以下英文翻译为中文\",\r\n  \"input\": \"Artificial Intelligence is transforming the world.\",\r\n  \"output\": \"人工智能正在改变世界。\"\r\n}</code></pre>\r\n\r\n<h3>3.3 LoRA 配置与训练代码</h3>\r\n<pre><code>from peft import LoraConfig, get_peft_model\r\nfrom transformers import AutoModelForCausalLM, AutoTokenizer, TrainingArguments, Trainer\r\n\r\n# 加载基座模型\r\nmodel = AutoModelForCausalLM.from_pretrained(\"Qwen/Qwen-7B\")\r\ntokenizer = AutoTokenizer.from_pretrained(\"Qwen/Qwen-7B\")\r\n\r\n# LoRA 配置\r\nlora_config = LoraConfig(\r\n    r=8,                    # 低秩矩阵的维度\r\n    lora_alpha=32,          # 缩放因子\r\n    target_modules=[\"q_proj\", \"v_proj\", \"k_proj\", \"o_proj\"],\r\n    lora_dropout=0.1,\r\n    bias=\"none\",\r\n    task_type=\"CAUSAL_LM\"\r\n)\r\n\r\n# 应用 LoRA\r\nmodel = get_peft_model(model, lora_config)\r\nmodel.print_trainable_parameters()  # 可训练参数仅占 0.8%\r\n\r\n# 训练参数\r\ntraining_args = TrainingArguments(\r\n    output_dir=\"./lora-output\",\r\n    per_device_train_batch_size=4,\r\n    gradient_accumulation_steps=8,\r\n    num_train_epochs=3,\r\n    learning_rate=2e-4,\r\n    logging_steps=10,\r\n    save_steps=100,\r\n    fp16=True\r\n)\r\n\r\ntrainer = Trainer(\r\n    model=model,\r\n    args=training_args,\r\n    train_dataset=dataset\r\n)\r\ntrainer.train()\r\n\r\n# 保存 LoRA 权重（仅 30MB）\r\nmodel.save_pretrained(\"./lora-adaptor\")</code></pre>\r\n\r\n<h3>3.4 推理与部署</h3>\r\n<pre><code># 加载基座模型 + LoRA 权重\r\nmodel = AutoModelForCausalLM.from_pretrained(\"Qwen/Qwen-7B\")\r\nmodel = PeftModel.from_pretrained(model, \"./lora-adaptor\")\r\nmodel.eval()\r\n\r\n# 推理\r\noutputs = model.generate(\r\n    tokenizer.encode(\"翻译以下内容：Hello, world!\", return_tensors=\"pt\"),\r\n    max_new_tokens=128\r\n)\r\nprint(tokenizer.decode(outputs[0]))</code></pre>\r\n\r\n<h2>📊 四、微调效果评估与经验总结</h2>\r\n<p>经过大量实验，我们总结出以下经验：</p>\r\n<ul>\r\n<li><strong>rank 值选择</strong>：对于简单任务（如分类），r=4-8 即可；复杂任务（如代码生成）建议 r=16-32。</li>\r\n<li><strong>学习率策略</strong>：LoRA 的学习率通常比全参数微调高一个数量级（1e-4 左右），建议搭配 warm-up 和余弦退火。</li>\r\n<li><strong>数据质量优先于数据数量</strong>：500 条高质量的指令数据往往比 5000 条噪音数据效果更好。</li>\r\n<li><strong>多任务合并</strong>：多个 LoRA 适配器可以合并为一个，推理时无需切换，效率更高。</li>\r\n</ul>\r\n\r\n<h2>✅ 五、总结与展望</h2>\r\n<p>PEFT 技术正在深刻改变大模型的落地范式。它不再是大型科技公司的专属，而是每一个开发者、每一家企业都能触手可及的能力。随着 QLoRA、GaLore 等新技术的不断涌现，微调的硬件门槛还在持续降低。对于开发者而言，掌握 LoRA 微调不再是一种\"附加技能\"，而是构建垂直领域 AI 应用的基本功。未来，我们很可能看到\"基座模型 + LoRA 微调 + RAG 增强\"成为大模型应用的标准架构。</p>');

-- ----------------------------
-- Table structure for t_article_like
-- ----------------------------
DROP TABLE IF EXISTS `t_article_like`;
CREATE TABLE `t_article_like`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `article_id` bigint NOT NULL COMMENT '文章ID',
  `user_id` bigint NOT NULL DEFAULT 0 COMMENT '用户ID',
  `ip_address` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT 'IP',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uni_article_user`(`article_id` ASC, `user_id` ASC, `ip_address` ASC) USING BTREE,
  INDEX `idx_article_id`(`article_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 58 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '文章点赞表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_article_like
-- ----------------------------
INSERT INTO `t_article_like` VALUES (1, 1, 1, '192.168.1.101', '2026-04-18 20:29:38');
INSERT INTO `t_article_like` VALUES (2, 1, 1, '192.168.1.102', '2026-04-18 20:29:38');
INSERT INTO `t_article_like` VALUES (3, 16, 1, '192.168.1.101', '2026-04-19 13:49:44');
INSERT INTO `t_article_like` VALUES (4, 16, 1, '192.168.1.102', '2026-04-19 13:49:44');
INSERT INTO `t_article_like` VALUES (5, 17, 1, '192.168.1.101', '2026-04-19 13:49:44');
INSERT INTO `t_article_like` VALUES (6, 18, 1, '192.168.1.103', '2026-04-19 13:49:44');
INSERT INTO `t_article_like` VALUES (7, 19, 1, '192.168.1.104', '2026-04-19 13:49:44');
INSERT INTO `t_article_like` VALUES (8, 20, 1, '192.168.1.105', '2026-04-19 13:49:44');
INSERT INTO `t_article_like` VALUES (9, 21, 1, '192.168.1.101', '2026-04-19 13:49:44');
INSERT INTO `t_article_like` VALUES (10, 22, 1, '192.168.1.102', '2026-04-19 13:49:44');
INSERT INTO `t_article_like` VALUES (11, 23, 1, '192.168.1.103', '2026-04-19 13:49:44');
INSERT INTO `t_article_like` VALUES (12, 24, 1, '192.168.1.104', '2026-04-19 13:49:44');
INSERT INTO `t_article_like` VALUES (13, 25, 1, '192.168.1.105', '2026-04-19 13:49:44');
INSERT INTO `t_article_like` VALUES (14, 26, 1, '192.168.1.101', '2026-04-19 13:49:44');
INSERT INTO `t_article_like` VALUES (15, 27, 1, '192.168.1.102', '2026-04-19 13:49:44');
INSERT INTO `t_article_like` VALUES (19, 16, 1, '192.168.1.111', '2026-04-19 13:52:11');
INSERT INTO `t_article_like` VALUES (20, 17, 1, '192.168.1.112', '2026-04-19 13:52:11');
INSERT INTO `t_article_like` VALUES (21, 18, 1, '192.168.1.113', '2026-04-19 13:52:11');
INSERT INTO `t_article_like` VALUES (22, 19, 1, '192.168.1.114', '2026-04-19 13:52:11');
INSERT INTO `t_article_like` VALUES (23, 20, 1, '192.168.1.115', '2026-04-19 13:52:11');
INSERT INTO `t_article_like` VALUES (24, 26, 1, '192.168.1.116', '2026-04-19 13:52:11');
INSERT INTO `t_article_like` VALUES (25, 27, 1, '192.168.1.117', '2026-04-19 13:52:11');
INSERT INTO `t_article_like` VALUES (28, 30, 0, '192.168.1.120', '2026-04-19 13:52:11');
INSERT INTO `t_article_like` VALUES (52, 29, 1, '', '2026-04-21 13:15:28');
INSERT INTO `t_article_like` VALUES (55, 28, 1, '', '2026-04-30 14:52:10');
INSERT INTO `t_article_like` VALUES (56, 30, 1, '', '2026-06-21 22:37:04');
INSERT INTO `t_article_like` VALUES (57, 31, 1, '', '2026-06-22 11:14:47');

-- ----------------------------
-- Table structure for t_article_tag_rel
-- ----------------------------
DROP TABLE IF EXISTS `t_article_tag_rel`;
CREATE TABLE `t_article_tag_rel`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'id',
  `article_id` bigint UNSIGNED NOT NULL COMMENT '文章id',
  `tag_id` bigint UNSIGNED NOT NULL COMMENT '标签id',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_article_id`(`article_id` ASC) USING BTREE,
  INDEX `idx_tag_id`(`tag_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 274 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '文章对应标签映射表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_article_tag_rel
-- ----------------------------
INSERT INTO `t_article_tag_rel` VALUES (71, 16, 14);
INSERT INTO `t_article_tag_rel` VALUES (72, 16, 14);
INSERT INTO `t_article_tag_rel` VALUES (73, 16, 14);
INSERT INTO `t_article_tag_rel` VALUES (74, 17, 11);
INSERT INTO `t_article_tag_rel` VALUES (75, 17, 1);
INSERT INTO `t_article_tag_rel` VALUES (76, 17, 11);
INSERT INTO `t_article_tag_rel` VALUES (77, 18, 10);
INSERT INTO `t_article_tag_rel` VALUES (78, 18, 2);
INSERT INTO `t_article_tag_rel` VALUES (79, 18, 10);
INSERT INTO `t_article_tag_rel` VALUES (80, 19, 13);
INSERT INTO `t_article_tag_rel` VALUES (81, 19, 6);
INSERT INTO `t_article_tag_rel` VALUES (82, 19, 5);
INSERT INTO `t_article_tag_rel` VALUES (83, 20, 6);
INSERT INTO `t_article_tag_rel` VALUES (84, 20, 3);
INSERT INTO `t_article_tag_rel` VALUES (85, 20, 8);
INSERT INTO `t_article_tag_rel` VALUES (86, 21, 1);
INSERT INTO `t_article_tag_rel` VALUES (87, 21, 11);
INSERT INTO `t_article_tag_rel` VALUES (88, 21, 8);
INSERT INTO `t_article_tag_rel` VALUES (89, 22, 9);
INSERT INTO `t_article_tag_rel` VALUES (90, 22, 4);
INSERT INTO `t_article_tag_rel` VALUES (91, 22, 5);
INSERT INTO `t_article_tag_rel` VALUES (92, 23, 2);
INSERT INTO `t_article_tag_rel` VALUES (93, 23, 7);
INSERT INTO `t_article_tag_rel` VALUES (94, 23, 1);
INSERT INTO `t_article_tag_rel` VALUES (95, 24, 9);
INSERT INTO `t_article_tag_rel` VALUES (96, 24, 3);
INSERT INTO `t_article_tag_rel` VALUES (97, 24, 14);
INSERT INTO `t_article_tag_rel` VALUES (98, 25, 7);
INSERT INTO `t_article_tag_rel` VALUES (99, 25, 4);
INSERT INTO `t_article_tag_rel` VALUES (100, 25, 11);
INSERT INTO `t_article_tag_rel` VALUES (102, 16, 3);
INSERT INTO `t_article_tag_rel` VALUES (103, 16, 3);
INSERT INTO `t_article_tag_rel` VALUES (104, 16, 5);
INSERT INTO `t_article_tag_rel` VALUES (105, 17, 7);
INSERT INTO `t_article_tag_rel` VALUES (106, 17, 7);
INSERT INTO `t_article_tag_rel` VALUES (107, 17, 5);
INSERT INTO `t_article_tag_rel` VALUES (108, 18, 5);
INSERT INTO `t_article_tag_rel` VALUES (109, 18, 9);
INSERT INTO `t_article_tag_rel` VALUES (110, 18, 7);
INSERT INTO `t_article_tag_rel` VALUES (111, 19, 9);
INSERT INTO `t_article_tag_rel` VALUES (112, 19, 2);
INSERT INTO `t_article_tag_rel` VALUES (113, 19, 3);
INSERT INTO `t_article_tag_rel` VALUES (114, 20, 9);
INSERT INTO `t_article_tag_rel` VALUES (115, 20, 7);
INSERT INTO `t_article_tag_rel` VALUES (116, 20, 6);
INSERT INTO `t_article_tag_rel` VALUES (117, 21, 10);
INSERT INTO `t_article_tag_rel` VALUES (118, 21, 9);
INSERT INTO `t_article_tag_rel` VALUES (119, 21, 4);
INSERT INTO `t_article_tag_rel` VALUES (120, 22, 4);
INSERT INTO `t_article_tag_rel` VALUES (121, 22, 9);
INSERT INTO `t_article_tag_rel` VALUES (122, 22, 2);
INSERT INTO `t_article_tag_rel` VALUES (123, 23, 4);
INSERT INTO `t_article_tag_rel` VALUES (124, 23, 1);
INSERT INTO `t_article_tag_rel` VALUES (125, 23, 3);
INSERT INTO `t_article_tag_rel` VALUES (126, 24, 2);
INSERT INTO `t_article_tag_rel` VALUES (127, 24, 9);
INSERT INTO `t_article_tag_rel` VALUES (128, 24, 8);
INSERT INTO `t_article_tag_rel` VALUES (129, 25, 4);
INSERT INTO `t_article_tag_rel` VALUES (130, 25, 3);
INSERT INTO `t_article_tag_rel` VALUES (131, 25, 4);
INSERT INTO `t_article_tag_rel` VALUES (132, 26, 1);
INSERT INTO `t_article_tag_rel` VALUES (133, 26, 3);
INSERT INTO `t_article_tag_rel` VALUES (134, 26, 9);
INSERT INTO `t_article_tag_rel` VALUES (135, 27, 8);
INSERT INTO `t_article_tag_rel` VALUES (136, 27, 1);
INSERT INTO `t_article_tag_rel` VALUES (137, 27, 10);
INSERT INTO `t_article_tag_rel` VALUES (141, 29, 2);
INSERT INTO `t_article_tag_rel` VALUES (142, 29, 7);
INSERT INTO `t_article_tag_rel` VALUES (143, 29, 10);
INSERT INTO `t_article_tag_rel` VALUES (165, 28, 8);
INSERT INTO `t_article_tag_rel` VALUES (166, 28, 10);
INSERT INTO `t_article_tag_rel` VALUES (167, 28, 7);
INSERT INTO `t_article_tag_rel` VALUES (174, 30, 10);
INSERT INTO `t_article_tag_rel` VALUES (175, 30, 6);
INSERT INTO `t_article_tag_rel` VALUES (176, 30, 3);
INSERT INTO `t_article_tag_rel` VALUES (179, 31, 5);
INSERT INTO `t_article_tag_rel` VALUES (180, 31, 4);
INSERT INTO `t_article_tag_rel` VALUES (259, 61, 4);
INSERT INTO `t_article_tag_rel` VALUES (260, 61, 2);
INSERT INTO `t_article_tag_rel` VALUES (261, 61, 12);
INSERT INTO `t_article_tag_rel` VALUES (262, 62, 4);
INSERT INTO `t_article_tag_rel` VALUES (263, 62, 13);
INSERT INTO `t_article_tag_rel` VALUES (264, 62, 11);
INSERT INTO `t_article_tag_rel` VALUES (265, 63, 4);
INSERT INTO `t_article_tag_rel` VALUES (266, 63, 11);
INSERT INTO `t_article_tag_rel` VALUES (267, 63, 26);
INSERT INTO `t_article_tag_rel` VALUES (268, 64, 4);
INSERT INTO `t_article_tag_rel` VALUES (269, 64, 2);
INSERT INTO `t_article_tag_rel` VALUES (270, 64, 12);
INSERT INTO `t_article_tag_rel` VALUES (271, 65, 4);
INSERT INTO `t_article_tag_rel` VALUES (272, 65, 13);
INSERT INTO `t_article_tag_rel` VALUES (273, 65, 10);

-- ----------------------------
-- Table structure for t_blog_setting
-- ----------------------------
DROP TABLE IF EXISTS `t_blog_setting`;
CREATE TABLE `t_blog_setting`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'id',
  `blog_name` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '博客名称',
  `author` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '作者名',
  `introduction` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '介绍语',
  `avatar` varchar(160) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '作者头像',
  `github_home` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'GitHub 主页访问地址',
  `csdn_home` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'CSDN 主页访问地址',
  `gitee_home` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'Gitee 主页访问地址',
  `zhihu_home` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '知乎主页访问地址',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '博客设置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_blog_setting
-- ----------------------------
INSERT INTO `t_blog_setting` VALUES (1, '我的博客', 'Tsundere', '技术爱好者', 'http://127.0.0.1:9000/weblog/b0337f5b39a6420c834e3a3af6db0107.png', 'https://github.com', 'https://csdn.net', 'https://gitee.com', 'https://zhihu.com');

-- ----------------------------
-- Table structure for t_category
-- ----------------------------
DROP TABLE IF EXISTS `t_category`;
CREATE TABLE `t_category`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '标签id',
  `name` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '分类名称',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后一次更新时间',
  `is_deleted` tinyint NOT NULL DEFAULT 0 COMMENT '删除标志位：0：未删除 1：已删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uni_name`(`name` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '文章分类表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_category
-- ----------------------------
INSERT INTO `t_category` VALUES (1, 'Java', '2026-03-27 19:21:49', '2026-03-27 19:21:49', 0);
INSERT INTO `t_category` VALUES (2, 'SpringBoot', '2026-03-27 19:21:49', '2026-03-27 19:21:49', 0);
INSERT INTO `t_category` VALUES (3, 'MySQL', '2026-03-27 19:21:49', '2026-03-27 19:21:49', 0);
INSERT INTO `t_category` VALUES (4, '深度学习', '2026-04-16 09:58:47', '2026-04-16 09:58:47', 0);
INSERT INTO `t_category` VALUES (5, '机器学习', '2026-04-16 09:58:54', '2026-04-16 09:58:54', 0);
INSERT INTO `t_category` VALUES (6, '知识蒸馏', '2026-04-16 09:59:15', '2026-04-16 09:59:15', 0);
INSERT INTO `t_category` VALUES (17, '技术随笔', '2026-04-18 18:18:17', '2026-04-18 18:18:17', 0);
INSERT INTO `t_category` VALUES (18, '后端开发', '2026-04-18 18:18:17', '2026-04-18 18:18:17', 0);
INSERT INTO `t_category` VALUES (19, '前端进阶', '2026-04-18 18:18:17', '2026-04-18 18:18:17', 0);
INSERT INTO `t_category` VALUES (20, '数据库优化', '2026-04-18 18:18:17', '2026-04-18 18:18:17', 0);
INSERT INTO `t_category` VALUES (21, '缓存实战', '2026-04-18 18:18:17', '2026-04-18 18:18:17', 0);
INSERT INTO `t_category` VALUES (22, '微服务', '2026-04-18 18:18:17', '2026-04-18 18:18:17', 0);
INSERT INTO `t_category` VALUES (23, '面试总结', '2026-04-18 18:18:17', '2026-04-18 18:18:17', 0);
INSERT INTO `t_category` VALUES (24, '工具效率', '2026-04-18 18:18:17', '2026-04-18 18:18:17', 0);
INSERT INTO `t_category` VALUES (25, '部署运维', '2026-04-18 18:18:17', '2026-04-18 18:18:17', 0);
INSERT INTO `t_category` VALUES (26, '架构设计', '2026-04-18 18:18:17', '2026-04-18 18:18:17', 0);

-- ----------------------------
-- Table structure for t_comment
-- ----------------------------
DROP TABLE IF EXISTS `t_comment`;
CREATE TABLE `t_comment`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '评论ID',
  `article_id` bigint NOT NULL COMMENT '文章ID',
  `user_id` bigint NOT NULL DEFAULT 0 COMMENT '用户ID（0=游客）',
  `parent_id` bigint NOT NULL DEFAULT 0 COMMENT '父评论ID 0=一级评论',
  `content` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '评论内容',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_deleted` tinyint NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_article_id`(`article_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '文章评论表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_comment
-- ----------------------------
INSERT INTO `t_comment` VALUES (1, 16, 1, 0, '这篇文章写得太棒了，受益匪浅！', '2026-04-18 20:29:32', '2026-04-18 20:29:32', 0);
INSERT INTO `t_comment` VALUES (2, 17, 1, 1, '同意楼上，知识点讲得非常清晰', '2026-04-18 20:29:32', '2026-04-18 20:29:32', 0);
INSERT INTO `t_comment` VALUES (3, 16, 1, 0, '非常实用，感谢！', '2026-04-19 13:52:17', '2026-04-19 13:52:17', 0);
INSERT INTO `t_comment` VALUES (4, 18, 1, 0, '学习了，写得很清晰', '2026-04-19 13:52:17', '2026-04-19 13:52:17', 0);
INSERT INTO `t_comment` VALUES (5, 28, 1, 0, 'setup语法糖这篇太强了', '2026-04-19 13:52:17', '2026-04-19 13:52:17', 0);
INSERT INTO `t_comment` VALUES (6, 30, 1, 0, '全局异常处理很标准', '2026-04-19 13:52:17', '2026-04-19 13:52:17', 0);
INSERT INTO `t_comment` VALUES (7, 28, 0, 0, 'text1', '2026-04-19 14:19:02', '2026-04-19 14:19:02', 0);
INSERT INTO `t_comment` VALUES (8, 30, 0, 0, '我学废了！谢谢', '2026-04-19 14:22:32', '2026-04-19 14:22:32', 0);
INSERT INTO `t_comment` VALUES (9, 27, 0, 0, '讲解的非常详细，谢谢！', '2026-04-19 14:24:42', '2026-04-19 14:24:42', 0);
INSERT INTO `t_comment` VALUES (10, 28, 0, 0, 'text2', '2026-04-19 15:52:27', '2026-04-19 15:52:27', 0);
INSERT INTO `t_comment` VALUES (11, 29, 1, 0, '终于学会了', '2026-04-21 13:15:58', '2026-04-21 13:15:58', 0);
INSERT INTO `t_comment` VALUES (12, 29, 1, 0, '讲解精辟，点赞！\n', '2026-04-21 13:27:49', '2026-04-21 13:27:49', 0);
INSERT INTO `t_comment` VALUES (13, 29, 1, 0, 'test', '2026-04-21 13:43:45', '2026-04-21 13:43:45', 0);
INSERT INTO `t_comment` VALUES (14, 30, 1, 8, 'test', '2026-04-21 15:18:39', '2026-04-21 15:18:39', 0);
INSERT INTO `t_comment` VALUES (15, 30, 1, 14, 'hello', '2026-04-21 18:01:03', '2026-04-21 18:01:03', 0);
INSERT INTO `t_comment` VALUES (16, 30, 1, 6, '1', '2026-04-21 18:01:19', '2026-04-21 18:01:19', 0);
INSERT INTO `t_comment` VALUES (17, 30, 1, 14, '1111', '2026-04-21 18:01:25', '2026-04-21 18:01:25', 0);
INSERT INTO `t_comment` VALUES (18, 30, 1, 6, '666', '2026-04-21 18:29:13', '2026-04-21 18:29:13', 0);
INSERT INTO `t_comment` VALUES (19, 30, 1, 0, '1', '2026-04-21 18:29:23', '2026-04-21 18:29:23', 0);
INSERT INTO `t_comment` VALUES (20, 30, 1, 19, '2', '2026-04-21 18:49:58', '2026-04-21 18:49:58', 0);
INSERT INTO `t_comment` VALUES (21, 30, 1, 0, '666', '2026-04-21 21:41:18', '2026-04-21 21:41:18', 0);
INSERT INTO `t_comment` VALUES (22, 31, 1, 0, '双鸡666', '2026-06-22 11:15:08', '2026-06-22 11:15:08', 0);

-- ----------------------------
-- Table structure for t_comment_like
-- ----------------------------
DROP TABLE IF EXISTS `t_comment_like`;
CREATE TABLE `t_comment_like`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `comment_id` bigint NOT NULL COMMENT '评论ID',
  `user_id` bigint NOT NULL DEFAULT 0 COMMENT '用户ID',
  `ip_address` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT 'IP',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uni_comment_user`(`comment_id` ASC, `user_id` ASC, `ip_address` ASC) USING BTREE,
  INDEX `idx_comment_id`(`comment_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 70 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '评论点赞表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_comment_like
-- ----------------------------
INSERT INTO `t_comment_like` VALUES (1, 1, 0, '192.168.1.101', '2026-04-18 20:29:45');
INSERT INTO `t_comment_like` VALUES (2, 1, 0, '192.168.1.102', '2026-04-18 20:29:45');
INSERT INTO `t_comment_like` VALUES (8, 1, 0, '192.168.1.111', '2026-04-19 13:50:55');
INSERT INTO `t_comment_like` VALUES (9, 1, 0, '192.168.1.112', '2026-04-19 13:50:55');
INSERT INTO `t_comment_like` VALUES (10, 2, 0, '192.168.1.113', '2026-04-19 13:50:55');
INSERT INTO `t_comment_like` VALUES (11, 2, 1, '192.168.1.114', '2026-04-19 13:50:55');
INSERT INTO `t_comment_like` VALUES (12, 1, 1, '192.168.1.115', '2026-04-19 13:50:55');
INSERT INTO `t_comment_like` VALUES (13, 10, 1, '', '2026-04-19 18:20:16');
INSERT INTO `t_comment_like` VALUES (35, 11, 1, '', '2026-04-21 14:14:42');
INSERT INTO `t_comment_like` VALUES (36, 12, 1, '', '2026-04-21 14:14:43');
INSERT INTO `t_comment_like` VALUES (37, 13, 1, '', '2026-04-21 14:14:44');
INSERT INTO `t_comment_like` VALUES (42, 8, 4, '', '2026-04-21 15:34:44');
INSERT INTO `t_comment_like` VALUES (43, 14, 4, '', '2026-04-21 15:34:44');
INSERT INTO `t_comment_like` VALUES (45, 6, 4, '', '2026-04-21 15:34:46');
INSERT INTO `t_comment_like` VALUES (49, 16, 1, '', '2026-04-21 18:02:27');
INSERT INTO `t_comment_like` VALUES (64, 19, 1, '', '2026-04-21 18:49:52');
INSERT INTO `t_comment_like` VALUES (66, 8, 1, '', '2026-04-21 18:59:33');
INSERT INTO `t_comment_like` VALUES (67, 20, 1, '', '2026-04-21 21:39:10');
INSERT INTO `t_comment_like` VALUES (68, 21, 1, '', '2026-04-21 21:41:22');
INSERT INTO `t_comment_like` VALUES (69, 22, 1, '', '2026-06-22 11:15:23');

-- ----------------------------
-- Table structure for t_message
-- ----------------------------
DROP TABLE IF EXISTS `t_message`;
CREATE TABLE `t_message`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '留言ID',
  `user_id` bigint UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户ID（0=游客）',
  `username` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '留言人名称',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '邮箱（可选）',
  `content` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '留言内容',
  `parent_id` bigint UNSIGNED NOT NULL DEFAULT 0 COMMENT '父留言ID（0=顶级留言，支持楼中楼回复）',
  `status` tinyint NOT NULL DEFAULT 0 COMMENT '状态：0-待审核，1-已通过，2-已拒绝',
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'IP地址',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint NOT NULL DEFAULT 0 COMMENT '删除标志位：0-未删除，1-已删除',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '头像URL',
  `website` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '个人网站',
  `like_count` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '点赞数',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_parent_id`(`parent_id` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '留言板表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_message
-- ----------------------------
INSERT INTO `t_message` VALUES (1, 1, 'admin', 'admin@example.com', '欢迎来到我的博客！有什么问题都可以在这里留言～', 0, 1, '127.0.0.1', '2026-06-23 10:24:21', '2026-06-23 16:27:02', 0, '', '', 5);
INSERT INTO `t_message` VALUES (2, 0, '游客小明', 'xiaoming@example.com', '博主你好，请问有关于 Spring Boot 的入门教程吗？', 0, 1, '192.168.1.100', '2026-06-23 10:24:21', '2026-06-23 11:10:45', 0, '', '', 1);
INSERT INTO `t_message` VALUES (3, 1, 'admin', '', '有的，可以看看分类里的 SpringBoot 专题', 0, 1, '127.0.0.1', '2026-06-23 10:24:21', '2026-06-23 10:24:21', 0, '', '', 0);
INSERT INTO `t_message` VALUES (4, 0, '小红', '', '留言板太棒了，支持博主！', 0, 0, '192.168.1.101', '2026-06-23 10:24:21', '2026-06-23 10:24:21', 0, '', '', 0);
INSERT INTO `t_message` VALUES (5, 1, 'admin', '2111477010@qq.com', 'I will be your savior', 0, 1, '0:0:0:0:0:0:0:1', '2026-06-23 11:04:22', '2026-06-23 16:27:01', 0, '', '', 2);
INSERT INTO `t_message` VALUES (6, 1, 'admin', '2111477010@qq.com', '专科的时候看博主，现在都考研了哈哈哈哈', 0, 0, '0:0:0:0:0:0:0:1', '2026-06-23 11:21:21', '2026-06-23 11:21:21', 0, '', '', 0);

-- ----------------------------
-- Table structure for t_statistics_article_pv
-- ----------------------------
DROP TABLE IF EXISTS `t_statistics_article_pv`;
CREATE TABLE `t_statistics_article_pv`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'id',
  `pv_date` date NOT NULL COMMENT '被统计的日期',
  `pv_count` bigint UNSIGNED NOT NULL COMMENT 'pv浏览量',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后一次更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uni_pv_date`(`pv_date` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '统计表 - 文章 PV' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_statistics_article_pv
-- ----------------------------
INSERT INTO `t_statistics_article_pv` VALUES (1, '2026-03-27', 2, '2026-03-27 19:22:03', '2026-03-27 19:22:03');
INSERT INTO `t_statistics_article_pv` VALUES (2, '2026-04-16', 9, '2026-04-16 09:48:43', '2026-04-16 09:48:43');
INSERT INTO `t_statistics_article_pv` VALUES (3, '2026-04-18', 11, '2026-04-18 13:08:43', '2026-04-18 13:08:42');
INSERT INTO `t_statistics_article_pv` VALUES (4, '2026-04-19', 131, '2026-04-19 12:31:05', '2026-04-19 12:31:05');
INSERT INTO `t_statistics_article_pv` VALUES (5, '2026-04-21', 198, '2026-04-21 13:00:10', '2026-04-21 13:00:09');
INSERT INTO `t_statistics_article_pv` VALUES (6, '2026-04-22', 1, '2026-04-22 08:07:05', '2026-04-22 08:07:05');
INSERT INTO `t_statistics_article_pv` VALUES (7, '2026-04-30', 7, '2026-04-30 14:51:03', '2026-04-30 14:51:02');
INSERT INTO `t_statistics_article_pv` VALUES (8, '2026-05-18', 3, '2026-05-18 10:04:13', '2026-05-18 10:04:12');
INSERT INTO `t_statistics_article_pv` VALUES (9, '2026-06-19', 2, '2026-06-19 22:46:32', '2026-06-19 22:46:32');
INSERT INTO `t_statistics_article_pv` VALUES (10, '2026-06-21', 6, '2026-06-21 22:36:50', '2026-06-21 22:36:49');
INSERT INTO `t_statistics_article_pv` VALUES (11, '2026-06-22', 13, '2026-06-22 00:27:48', '2026-06-22 00:27:48');
INSERT INTO `t_statistics_article_pv` VALUES (12, '2026-06-23', 1, '2026-06-23 09:46:32', '2026-06-23 09:46:31');
INSERT INTO `t_statistics_article_pv` VALUES (13, '2026-06-24', 11, '2026-06-24 08:25:35', '2026-06-24 08:25:34');

-- ----------------------------
-- Table structure for t_tag
-- ----------------------------
DROP TABLE IF EXISTS `t_tag`;
CREATE TABLE `t_tag`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '标签id',
  `name` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '标签名称',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后一次更新时间',
  `is_deleted` tinyint NOT NULL DEFAULT 0 COMMENT '删除标志位：0：未删除 1：已删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uni_name`(`name` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '标签表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_tag
-- ----------------------------
INSERT INTO `t_tag` VALUES (1, 'Java基础', '2026-03-27 19:21:49', '2026-03-27 19:21:49', 0);
INSERT INTO `t_tag` VALUES (2, 'Spring', '2026-03-27 19:21:49', '2026-03-27 19:21:49', 0);
INSERT INTO `t_tag` VALUES (3, '数据库', '2026-03-27 19:21:49', '2026-03-27 19:21:49', 0);
INSERT INTO `t_tag` VALUES (4, 'AI', '2026-04-16 09:49:48', '2026-04-16 09:49:48', 0);
INSERT INTO `t_tag` VALUES (5, '随笔', '2026-04-18 18:19:02', '2026-04-18 18:19:02', 0);
INSERT INTO `t_tag` VALUES (6, '技巧', '2026-04-18 18:19:02', '2026-04-18 18:19:02', 0);
INSERT INTO `t_tag` VALUES (7, '经验', '2026-04-18 18:19:02', '2026-04-18 18:19:02', 0);
INSERT INTO `t_tag` VALUES (8, '总结', '2026-04-18 18:19:02', '2026-04-18 18:19:02', 0);
INSERT INTO `t_tag` VALUES (9, '学习', '2026-04-18 18:19:02', '2026-04-18 18:19:02', 0);
INSERT INTO `t_tag` VALUES (10, '进阶', '2026-04-18 18:19:02', '2026-04-18 18:19:02', 0);
INSERT INTO `t_tag` VALUES (11, '深度', '2026-04-18 18:19:02', '2026-04-18 18:19:02', 0);
INSERT INTO `t_tag` VALUES (12, '实战', '2026-04-18 18:19:02', '2026-04-18 18:19:02', 0);
INSERT INTO `t_tag` VALUES (13, '原理', '2026-04-18 18:19:02', '2026-04-18 18:19:02', 0);
INSERT INTO `t_tag` VALUES (14, '源码', '2026-04-18 18:19:02', '2026-04-18 18:19:02', 0);

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'id',
  `username` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户名',
  `password` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '密码',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后一次更新时间',
  `is_deleted` tinyint NOT NULL DEFAULT 0 COMMENT '删除标志位：0：未删除 1：已删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE,
  INDEX `idx_username`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES (1, 'admin', '$2a$10$aGGgbab8HdmfxixuTwIYnOZxPH9hzrQuq1oRfLa91mVzSaRfgmtcu', '2026-03-27 19:26:29', '2026-03-27 19:26:29', 0);
INSERT INTO `t_user` VALUES (2, 'aaa', '$2a$10$DOvL5xpmTw0ysro.G43uF..l10CROsIQylp7dVRy3Vcb7MuM2l6pG', '2026-04-15 09:26:17', '2026-04-15 09:26:17', 0);
INSERT INTO `t_user` VALUES (3, 'bbb', '$2a$10$2SoyNY0veyhWV.ud2uiYRuOvKvfu.MjnP/CDTyRz0xIBMrrXykb4S', '2026-04-15 09:28:23', '2026-04-15 09:28:23', 0);
INSERT INTO `t_user` VALUES (4, 'ccc', '$2a$10$NSxMrOccMLBm0Mx6FyJyMuLJvbzxs.XSYJak3bsu6Wd9sXUBA.E/2', '2026-04-16 09:16:32', '2026-04-16 09:16:32', 0);

-- ----------------------------
-- Table structure for t_user_role
-- ----------------------------
DROP TABLE IF EXISTS `t_user_role`;
CREATE TABLE `t_user_role`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'id',
  `username` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户名',
  `role` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_username`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户角色表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_user_role
-- ----------------------------
INSERT INTO `t_user_role` VALUES (1, 'admin', 'ROLE_ADMIN', '2026-03-27 19:26:29');
INSERT INTO `t_user_role` VALUES (3, 'ccc', 'ROLE_USER', '2026-04-16 09:16:32');

-- ----------------------------
-- Table structure for t_visitor_record
-- ----------------------------
DROP TABLE IF EXISTS `t_visitor_record`;
CREATE TABLE `t_visitor_record`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `visitor` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'agent',
  `ip_address` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '127.0.0.1',
  `ip_region` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '未知',
  `visit_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '访问时间',
  `is_notify` tinyint UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ip_visit_time`(`ip_address` ASC, `visit_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 154 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '访客记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_visitor_record
-- ----------------------------
INSERT INTO `t_visitor_record` VALUES (1, 'agent', '0:0:0:0:0:0:0:1', '外太空', '2026-03-27 19:04:12', 0);
INSERT INTO `t_visitor_record` VALUES (2, 'agent', '0:0:0:0:0:0:0:1', '外太空', '2026-03-27 19:28:20', 0);
INSERT INTO `t_visitor_record` VALUES (3, 'agent', '0:0:0:0:0:0:0:1', '外太空', '2026-03-27 20:00:59', 0);
INSERT INTO `t_visitor_record` VALUES (4, 'agent', '0:0:0:0:0:0:0:1', '外太空', '2026-04-15 09:25:43', 0);
INSERT INTO `t_visitor_record` VALUES (5, 'agent', '0:0:0:0:0:0:0:1', '外太空', '2026-04-16 09:16:25', 0);
INSERT INTO `t_visitor_record` VALUES (6, 'agent', '0:0:0:0:0:0:0:1', '外太空', '2026-04-16 09:44:45', 0);
INSERT INTO `t_visitor_record` VALUES (7, 'agent', '0:0:0:0:0:0:0:1', '外太空', '2026-04-16 09:46:58', 0);
INSERT INTO `t_visitor_record` VALUES (8, 'agent', '0:0:0:0:0:0:0:1', '外太空', '2026-04-16 10:49:46', 0);
INSERT INTO `t_visitor_record` VALUES (9, 'agent', '0:0:0:0:0:0:0:1', '外太空', '2026-04-16 10:50:40', 0);
INSERT INTO `t_visitor_record` VALUES (10, 'agent', '0:0:0:0:0:0:0:1', '外太空', '2026-04-18 13:01:56', 0);
INSERT INTO `t_visitor_record` VALUES (11, 'agent', '0:0:0:0:0:0:0:1', '外太空', '2026-04-18 13:03:53', 0);
INSERT INTO `t_visitor_record` VALUES (12, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-04-18 13:08:23', 0);
INSERT INTO `t_visitor_record` VALUES (13, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-04-18 15:05:39', 0);
INSERT INTO `t_visitor_record` VALUES (14, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-04-18 15:32:07', 0);
INSERT INTO `t_visitor_record` VALUES (15, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-04-18 15:35:58', 0);
INSERT INTO `t_visitor_record` VALUES (16, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-04-18 15:45:36', 0);
INSERT INTO `t_visitor_record` VALUES (17, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-04-18 15:57:03', 0);
INSERT INTO `t_visitor_record` VALUES (18, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-04-18 16:30:42', 0);
INSERT INTO `t_visitor_record` VALUES (19, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-04-18 16:40:54', 0);
INSERT INTO `t_visitor_record` VALUES (20, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-04-18 16:42:53', 0);
INSERT INTO `t_visitor_record` VALUES (21, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-04-18 16:54:19', 0);
INSERT INTO `t_visitor_record` VALUES (22, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-04-18 22:20:38', 0);
INSERT INTO `t_visitor_record` VALUES (23, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-04-19 10:22:46', 0);
INSERT INTO `t_visitor_record` VALUES (24, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-04-19 11:06:36', 0);
INSERT INTO `t_visitor_record` VALUES (25, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-04-19 11:20:34', 0);
INSERT INTO `t_visitor_record` VALUES (26, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-04-19 11:22:29', 0);
INSERT INTO `t_visitor_record` VALUES (27, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-04-19 11:26:12', 0);
INSERT INTO `t_visitor_record` VALUES (28, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-04-19 11:29:00', 0);
INSERT INTO `t_visitor_record` VALUES (29, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-04-19 12:29:20', 0);
INSERT INTO `t_visitor_record` VALUES (30, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-04-19 13:24:50', 0);
INSERT INTO `t_visitor_record` VALUES (31, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-04-19 13:24:50', 0);
INSERT INTO `t_visitor_record` VALUES (32, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-04-19 14:13:08', 0);
INSERT INTO `t_visitor_record` VALUES (33, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-04-19 14:14:41', 0);
INSERT INTO `t_visitor_record` VALUES (34, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-04-19 14:47:27', 0);
INSERT INTO `t_visitor_record` VALUES (35, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-04-19 14:49:54', 0);
INSERT INTO `t_visitor_record` VALUES (36, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-04-19 14:49:54', 0);
INSERT INTO `t_visitor_record` VALUES (37, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-04-19 15:05:17', 0);
INSERT INTO `t_visitor_record` VALUES (38, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-04-19 15:05:17', 0);
INSERT INTO `t_visitor_record` VALUES (39, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-04-19 15:05:17', 0);
INSERT INTO `t_visitor_record` VALUES (40, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-04-19 16:07:06', 0);
INSERT INTO `t_visitor_record` VALUES (41, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-04-19 16:22:43', 0);
INSERT INTO `t_visitor_record` VALUES (42, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-04-19 16:22:43', 0);
INSERT INTO `t_visitor_record` VALUES (43, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-04-19 16:22:43', 0);
INSERT INTO `t_visitor_record` VALUES (44, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-04-19 16:22:43', 0);
INSERT INTO `t_visitor_record` VALUES (45, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-04-19 16:22:43', 0);
INSERT INTO `t_visitor_record` VALUES (46, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-04-19 16:22:43', 0);
INSERT INTO `t_visitor_record` VALUES (47, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-04-19 16:32:29', 0);
INSERT INTO `t_visitor_record` VALUES (48, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-04-19 17:14:16', 0);
INSERT INTO `t_visitor_record` VALUES (49, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-04-19 17:16:18', 0);
INSERT INTO `t_visitor_record` VALUES (50, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-04-19 17:30:36', 0);
INSERT INTO `t_visitor_record` VALUES (51, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-04-19 17:35:31', 0);
INSERT INTO `t_visitor_record` VALUES (52, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-04-19 17:35:51', 0);
INSERT INTO `t_visitor_record` VALUES (53, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-04-19 17:50:57', 0);
INSERT INTO `t_visitor_record` VALUES (54, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-04-19 17:57:24', 0);
INSERT INTO `t_visitor_record` VALUES (55, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-04-19 17:57:55', 0);
INSERT INTO `t_visitor_record` VALUES (56, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-04-19 18:19:16', 0);
INSERT INTO `t_visitor_record` VALUES (57, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-04-19 18:19:49', 0);
INSERT INTO `t_visitor_record` VALUES (58, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-04-21 13:00:09', 0);
INSERT INTO `t_visitor_record` VALUES (59, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-04-21 13:39:58', 0);
INSERT INTO `t_visitor_record` VALUES (60, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-04-21 13:39:58', 0);
INSERT INTO `t_visitor_record` VALUES (61, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-04-21 13:42:19', 0);
INSERT INTO `t_visitor_record` VALUES (62, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-04-21 14:41:04', 0);
INSERT INTO `t_visitor_record` VALUES (63, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-04-21 14:43:17', 0);
INSERT INTO `t_visitor_record` VALUES (64, 'agent', '180.98.44.194', '中国-江苏省-南京市-电信', '2026-04-21 21:01:41', 0);
INSERT INTO `t_visitor_record` VALUES (65, 'agent', '180.98.44.194', '中国-江苏省-南京市-电信', '2026-04-21 21:09:49', 0);
INSERT INTO `t_visitor_record` VALUES (66, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-04-21 21:38:05', 0);
INSERT INTO `t_visitor_record` VALUES (67, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-04-22 08:06:45', 0);
INSERT INTO `t_visitor_record` VALUES (68, 'agent', '169.254.167.123', '中国-浙江省-杭州市-HDU', '2026-04-22 08:51:06', 0);
INSERT INTO `t_visitor_record` VALUES (69, 'agent', '169.254.167.123', '中国-浙江省-杭州市-HDU', '2026-04-22 08:51:06', 0);
INSERT INTO `t_visitor_record` VALUES (70, 'agent', '169.254.120.193', '中国-浙江省-杭州市-HDU', '2026-04-22 08:51:17', 0);
INSERT INTO `t_visitor_record` VALUES (71, 'agent', '169.254.120.193', '中国-浙江省-杭州市-HDU', '2026-04-22 08:51:17', 0);
INSERT INTO `t_visitor_record` VALUES (72, 'agent', '169.254.120.193', '中国-浙江省-杭州市-HDU', '2026-04-22 08:51:17', 0);
INSERT INTO `t_visitor_record` VALUES (73, 'agent', '169.254.120.193', '中国-浙江省-杭州市-HDU', '2026-04-22 08:51:17', 0);
INSERT INTO `t_visitor_record` VALUES (74, 'agent', '169.254.120.193', '中国-浙江省-杭州市-HDU', '2026-04-22 08:51:17', 0);
INSERT INTO `t_visitor_record` VALUES (75, 'agent', '169.254.120.193', '中国-浙江省-杭州市-HDU', '2026-04-22 08:51:17', 0);
INSERT INTO `t_visitor_record` VALUES (76, 'agent', '169.254.120.193', '中国-浙江省-杭州市-HDU', '2026-04-22 08:51:17', 0);
INSERT INTO `t_visitor_record` VALUES (77, 'agent', '169.254.120.193', '中国-浙江省-杭州市-HDU', '2026-04-22 08:51:17', 0);
INSERT INTO `t_visitor_record` VALUES (78, 'agent', '169.254.120.193', '中国-浙江省-杭州市-HDU', '2026-04-22 08:51:17', 0);
INSERT INTO `t_visitor_record` VALUES (79, 'agent', '169.254.120.193', '中国-浙江省-杭州市-HDU', '2026-04-22 08:51:17', 0);
INSERT INTO `t_visitor_record` VALUES (80, 'agent', '169.254.120.193', '中国-浙江省-杭州市-HDU', '2026-04-22 08:51:17', 0);
INSERT INTO `t_visitor_record` VALUES (81, 'agent', '169.254.120.193', '中国-浙江省-杭州市-HDU', '2026-04-22 08:51:17', 0);
INSERT INTO `t_visitor_record` VALUES (82, 'agent', '169.254.120.193', '中国-浙江省-杭州市-HDU', '2026-04-22 08:51:17', 0);
INSERT INTO `t_visitor_record` VALUES (83, 'agent', '169.254.120.193', '中国-浙江省-杭州市-HDU', '2026-04-22 08:51:17', 0);
INSERT INTO `t_visitor_record` VALUES (84, 'agent', '169.254.120.193', '中国-浙江省-杭州市-HDU', '2026-04-22 08:51:17', 0);
INSERT INTO `t_visitor_record` VALUES (85, 'agent', '169.254.120.193', '中国-浙江省-杭州市-HDU', '2026-04-22 08:51:17', 0);
INSERT INTO `t_visitor_record` VALUES (86, 'agent', '169.254.120.193', '中国-浙江省-杭州市-HDU', '2026-04-22 08:51:17', 0);
INSERT INTO `t_visitor_record` VALUES (87, 'agent', '169.254.120.193', '中国-浙江省-杭州市-HDU', '2026-04-22 08:51:17', 0);
INSERT INTO `t_visitor_record` VALUES (88, 'agent', '169.254.120.193', '中国-浙江省-杭州市-HDU', '2026-04-22 08:51:17', 0);
INSERT INTO `t_visitor_record` VALUES (89, 'agent', '169.254.120.193', '中国-浙江省-杭州市-HDU', '2026-04-22 08:51:17', 0);
INSERT INTO `t_visitor_record` VALUES (90, 'agent', '169.254.120.193', '中国-浙江省-杭州市-HDU', '2026-04-22 08:51:17', 0);
INSERT INTO `t_visitor_record` VALUES (91, 'agent', '169.254.120.193', '中国-浙江省-杭州市-HDU', '2026-04-22 08:51:17', 0);
INSERT INTO `t_visitor_record` VALUES (92, 'agent', '169.254.120.193', '中国-浙江省-杭州市-HDU', '2026-04-22 08:51:17', 0);
INSERT INTO `t_visitor_record` VALUES (93, 'agent', '169.254.120.193', '中国-浙江省-杭州市-HDU', '2026-04-22 08:51:17', 0);
INSERT INTO `t_visitor_record` VALUES (94, 'agent', '169.254.120.193', '中国-浙江省-杭州市-HDU', '2026-04-22 08:51:17', 0);
INSERT INTO `t_visitor_record` VALUES (95, 'agent', '169.254.120.193', '中国-浙江省-杭州市-HDU', '2026-04-22 08:51:17', 0);
INSERT INTO `t_visitor_record` VALUES (96, 'agent', '169.254.120.193', '中国-浙江省-杭州市-HDU', '2026-04-22 08:51:17', 0);
INSERT INTO `t_visitor_record` VALUES (97, 'agent', '169.254.120.193', '中国-浙江省-杭州市-HDU', '2026-04-22 08:51:17', 0);
INSERT INTO `t_visitor_record` VALUES (98, 'agent', '169.254.120.193', '中国-浙江省-杭州市-HDU', '2026-04-22 08:51:17', 0);
INSERT INTO `t_visitor_record` VALUES (99, 'agent', '169.254.120.193', '中国-浙江省-杭州市-HDU', '2026-04-22 08:51:17', 0);
INSERT INTO `t_visitor_record` VALUES (100, 'agent', '169.254.120.193', '中国-浙江省-杭州市-HDU', '2026-04-22 08:51:17', 0);
INSERT INTO `t_visitor_record` VALUES (101, 'agent', '169.254.120.193', '中国-浙江省-杭州市-HDU', '2026-04-22 08:51:17', 0);
INSERT INTO `t_visitor_record` VALUES (102, 'agent', '169.254.120.193', '中国-浙江省-杭州市-HDU', '2026-04-22 08:51:17', 0);
INSERT INTO `t_visitor_record` VALUES (103, 'agent', '169.254.120.193', '中国-浙江省-杭州市-HDU', '2026-04-22 08:51:17', 0);
INSERT INTO `t_visitor_record` VALUES (104, 'agent', '169.254.120.193', '中国-浙江省-杭州市-HDU', '2026-04-22 08:51:17', 0);
INSERT INTO `t_visitor_record` VALUES (105, 'agent', '169.254.120.193', '中国-浙江省-杭州市-HDU', '2026-04-22 08:51:17', 0);
INSERT INTO `t_visitor_record` VALUES (106, 'agent', '169.254.120.193', '中国-浙江省-杭州市-HDU', '2026-04-22 08:51:17', 0);
INSERT INTO `t_visitor_record` VALUES (107, 'agent', '169.254.120.193', '中国-浙江省-杭州市-HDU', '2026-04-22 08:51:17', 0);
INSERT INTO `t_visitor_record` VALUES (108, 'agent', '169.254.120.193', '中国-浙江省-杭州市-HDU', '2026-04-22 08:51:17', 0);
INSERT INTO `t_visitor_record` VALUES (109, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-04-30 14:48:19', 0);
INSERT INTO `t_visitor_record` VALUES (110, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-05-18 10:03:56', 0);
INSERT INTO `t_visitor_record` VALUES (111, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-06-19 21:09:08', 0);
INSERT INTO `t_visitor_record` VALUES (112, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-06-19 22:42:05', 0);
INSERT INTO `t_visitor_record` VALUES (113, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-06-19 22:45:54', 0);
INSERT INTO `t_visitor_record` VALUES (114, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-06-21 20:40:52', 0);
INSERT INTO `t_visitor_record` VALUES (115, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-06-21 20:55:52', 0);
INSERT INTO `t_visitor_record` VALUES (116, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-06-21 22:00:41', 0);
INSERT INTO `t_visitor_record` VALUES (117, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-06-21 22:36:46', 0);
INSERT INTO `t_visitor_record` VALUES (118, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-06-21 22:49:38', 0);
INSERT INTO `t_visitor_record` VALUES (119, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-06-21 22:49:38', 0);
INSERT INTO `t_visitor_record` VALUES (120, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-06-21 23:02:03', 0);
INSERT INTO `t_visitor_record` VALUES (121, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-06-21 23:05:44', 0);
INSERT INTO `t_visitor_record` VALUES (122, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-06-21 23:11:28', 0);
INSERT INTO `t_visitor_record` VALUES (123, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-06-21 23:13:54', 0);
INSERT INTO `t_visitor_record` VALUES (124, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-06-21 23:17:32', 0);
INSERT INTO `t_visitor_record` VALUES (125, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-06-21 23:21:21', 0);
INSERT INTO `t_visitor_record` VALUES (126, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-06-22 00:00:40', 0);
INSERT INTO `t_visitor_record` VALUES (127, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-06-22 00:27:24', 0);
INSERT INTO `t_visitor_record` VALUES (128, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-06-22 08:55:03', 0);
INSERT INTO `t_visitor_record` VALUES (129, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-06-22 09:11:51', 0);
INSERT INTO `t_visitor_record` VALUES (130, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-06-22 09:18:50', 0);
INSERT INTO `t_visitor_record` VALUES (131, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-06-22 09:43:08', 0);
INSERT INTO `t_visitor_record` VALUES (132, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-06-22 10:27:55', 0);
INSERT INTO `t_visitor_record` VALUES (133, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-06-22 10:36:37', 0);
INSERT INTO `t_visitor_record` VALUES (134, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-06-22 10:41:54', 0);
INSERT INTO `t_visitor_record` VALUES (135, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-06-22 10:43:41', 0);
INSERT INTO `t_visitor_record` VALUES (136, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-06-22 10:45:20', 0);
INSERT INTO `t_visitor_record` VALUES (137, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-06-22 10:58:07', 0);
INSERT INTO `t_visitor_record` VALUES (138, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-06-22 11:09:21', 0);
INSERT INTO `t_visitor_record` VALUES (139, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-06-22 11:11:07', 0);
INSERT INTO `t_visitor_record` VALUES (140, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-06-22 11:11:22', 0);
INSERT INTO `t_visitor_record` VALUES (141, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-06-22 11:11:51', 0);
INSERT INTO `t_visitor_record` VALUES (142, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-06-22 11:13:52', 0);
INSERT INTO `t_visitor_record` VALUES (143, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-06-23 08:31:07', 0);
INSERT INTO `t_visitor_record` VALUES (144, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-06-23 10:54:57', 0);
INSERT INTO `t_visitor_record` VALUES (145, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-06-23 15:31:31', 0);
INSERT INTO `t_visitor_record` VALUES (146, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-06-23 21:54:22', 0);
INSERT INTO `t_visitor_record` VALUES (147, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-06-24 08:04:04', 0);
INSERT INTO `t_visitor_record` VALUES (148, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-06-24 08:47:11', 0);
INSERT INTO `t_visitor_record` VALUES (149, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-06-24 09:01:29', 0);
INSERT INTO `t_visitor_record` VALUES (150, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-06-24 09:01:29', 0);
INSERT INTO `t_visitor_record` VALUES (151, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-06-24 22:56:15', 0);
INSERT INTO `t_visitor_record` VALUES (152, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-06-24 23:03:34', 0);
INSERT INTO `t_visitor_record` VALUES (153, 'agent', '0:0:0:0:0:0:0:1', '本地访问', '2026-06-25 08:30:59', 0);

SET FOREIGN_KEY_CHECKS = 1;
