## Router路由配置

### 配置清单
```
'/route/:param': {
  'get': {
    'api': 'post:http://localhost:8080/api/comment/list'
    'name': 'comments',
    'cache': true,
    'cache': false,
    'timeout': 1000,
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