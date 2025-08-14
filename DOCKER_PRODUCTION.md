# Docker 生产环境部署

这是 Onlook 项目的 Docker 生产环境配置。

## 快速开始

### 1. 准备环境变量

复制环境变量模板文件：
```bash
cp .env.production.example .env.production
```

编辑 `.env.production` 文件，填入您的实际配置：
```bash
nano .env.production
```

### 2. 构建和启动

使用 Docker Compose 启动服务：
```bash
# 构建并启动（后台运行）
docker-compose -f docker-compose.prod.yml up -d --build

# 查看日志
docker-compose -f docker-compose.prod.yml logs -f

# 停止服务
docker-compose -f docker-compose.prod.yml down
```

### 3. 访问应用

应用将在以下地址可用：
- http://localhost:3000 （如果使用默认端口）
- 或您在 `.env.production` 中配置的 `NEXT_PUBLIC_SITE_URL`

## 环境配置

### 必需的环境变量

这些环境变量是应用正常运行所必需的：

- `NEXT_PUBLIC_SUPABASE_URL` - Supabase 项目 URL
- `NEXT_PUBLIC_SUPABASE_ANON_KEY` - Supabase 匿名密钥
- `SUPABASE_DATABASE_URL` - 数据库连接字符串
- `ANTHROPIC_API_KEY` - Anthropic AI API 密钥
- `CSB_API_KEY` - CodeSandbox API 密钥
- `MORPH_API_KEY` 或 `RELACE_API_KEY` - 快速应用模型 API 密钥

### 可选的环境变量

详细配置请参考 `.env.production.example` 文件。

## 自定义配置

### 端口配置

通过环境变量 `PORT` 设置端口：
```bash
export PORT=8080
docker-compose -f docker-compose.prod.yml up -d
```

### 本地覆盖配置

如果需要本地特定的配置覆盖，可以创建 `.env.local` 文件：
```bash
# .env.local - 本地覆盖配置
PORT=8080
DEBUG=true
```

## 维护

### 查看日志
```bash
docker-compose -f docker-compose.prod.yml logs -f onlook-client
```

### 重启服务
```bash
docker-compose -f docker-compose.prod.yml restart onlook-client
```

### 更新镜像
```bash
docker-compose -f docker-compose.prod.yml pull
docker-compose -f docker-compose.prod.yml up -d
```

## 故障排除

### 健康检查

服务包含健康检查，可以通过以下方式查看状态：
```bash
docker-compose -f docker-compose.prod.yml ps
```

### 进入容器调试
```bash
docker-compose -f docker-compose.prod.yml exec onlook-client sh
```

### 检查资源使用
```bash
docker stats
```
