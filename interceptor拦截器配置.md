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

