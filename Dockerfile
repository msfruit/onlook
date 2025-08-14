# 使用官方 Bun 镜像作为基础镜像
FROM oven/bun:1.2.13-alpine AS base

# 设置工作目录
WORKDIR /app

# 安装必要的系统依赖
RUN apk add --no-cache libc6-compat

# 安装依赖阶段
FROM base AS deps

# 复制整个项目以保证 workspace 结构
COPY . .

# 安装依赖
RUN bun install

# 构建阶段
FROM deps AS builder

# 设置环境变量跳过环境变量验证（构建时）
ENV SKIP_ENV_VALIDATION=1
ENV NODE_ENV=production

# 构建 client 应用
RUN bun --filter @onlook/web-client build

# 生产运行阶段
FROM base AS runner

# 设置环境变量
ENV NODE_ENV=production
ENV NEXT_TELEMETRY_DISABLED=1

# 创建非root用户
RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs

# 复制整个项目（包含构建产物）
COPY --from=builder --chown=nextjs:nodejs /app ./

# 切换到非root用户
USER nextjs

# 暴露端口
EXPOSE 3000

# 设置环境变量
ENV PORT=3000
ENV HOSTNAME="0.0.0.0"

# 启动 client 应用
CMD ["bun", "--filter", "@onlook/web-client", "start"]
