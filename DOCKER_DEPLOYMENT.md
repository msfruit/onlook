# 健康检查端点建议

为了让 Docker 健康检查正常工作，建议在 Next.js 应用中添加一个健康检查端点。

## 创建健康检查 API 路由

在 `apps/web/client/src/app/api/health/route.ts` 中创建以下内容：

```typescript
export async function GET() {
  return Response.json(
    { 
      status: 'ok', 
      timestamp: new Date().toISOString(),
      version: process.env.npm_package_version || '0.1.0'
    },
    { status: 200 }
  );
}
```

## 使用方法

1. 复制 `.env.production.template` 为 `.env.production`
2. 填写必要的环境变量
3. 构建并运行：

```bash
# 构建镜像
docker-compose -f docker-compose.prod.yml build

# 启动服务
docker-compose -f docker-compose.prod.yml up -d

# 查看日志
docker-compose -f docker-compose.prod.yml logs -f

# 停止服务
docker-compose -f docker-compose.prod.yml down
```

## 环境变量优先级

1. 系统环境变量（最高优先级）
2. `.env.production` 文件
3. docker-compose.yml 中的默认值（最低优先级）

## 生产环境建议

1. 使用外部数据库服务（如 Supabase、AWS RDS 等）
2. 配置 HTTPS 反向代理（如 Nginx、Traefik）
3. 设置日志聚合和监控
4. 定期备份环境变量配置
5. 使用密钥管理服务存储敏感信息
