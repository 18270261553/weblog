FROM eclipse-temurin:17

WORKDIR /app

# 复制 jar 包
COPY target/weblog-web-*.jar app.jar

# 设置时区
ENV TZ=Asia/Shanghai

# 暴露端口
EXPOSE 8081

# 启动
ENTRYPOINT ["java", "-jar", "app.jar"]