## Router路由配置

### 配置清单
```
'/route/:param': {
  'get': {
    'api': 'post:http://localhost:8080/api/comment/list'
    'name': 'comments',
    'cache': true,
    query() {
      return {
        'pageSize': 20,
        'sort': 1,
        'isNewDetail': 1,
        'itemId': '1jzbype',
        'type': 1
      };
    },
    'cache': false,
    'timeout': 1000
    handle(data) {
      return data.getList('data.list');
    }
  }
}
```