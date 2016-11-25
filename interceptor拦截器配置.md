## Interceptor拦截器配置

### 配置清单
```
// 一个interceptor配置文件
moudle.exports = {
  '/route/*, /member/profile': {
    'api': 'post:http://localhost:8080/api/comment/list'
    'name': 'comments',
    'cache': false,
    'timeout': 1000,
    'series': false,
    query(req, res) {
      return {
        'pageSize': 20,
        'type': 1
      };
    },
    body(req, res) {
      return {};
    },
    handle(data, req, res) {
      return data.getList('data.list');
    }
  }
}
```

以上为一个标准的配置清单。下面逐一介绍：

1. `'/route/*, /member/profile'`

  拦截器匹配路径，与router.route配置可以相同，但通常使用通配符 * 或 指定明确的路径。
  
2. router配置需指定请求方法，但是拦截器不需要，拦截器适应于所有请求方式。
3. 剩下的interceptor配置和**routerMeta**基本一致。不一样的是，由于interceptor的特殊性，routerMeta.handle配置对routerMeta.api.routerMeta无效。
