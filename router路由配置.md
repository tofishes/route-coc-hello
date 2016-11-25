## Router路由配置

### 配置清单
```
// 一个router配置文件
moudle.exports = {
  '/route/:param, /route, /route/two/:param': {
    'get': {
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
}
```

以上为一个标准的配置清单。下面逐一介绍：

1. `'/route/:param, /route, /route/two/:param'`
  
  路由路径，即 route。可以是逗号间隔的多个route。路由规则和express相同。
  
2. `'get':`

  route请求方法，可以是get或post。
  
3. 路由单元：
  
  ```
  {
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
  ```
  
  为方便解说，以上配置单元命名为 routerMeta。
  
  `api` 接口地址，可以用 post:|get:|delete:|put: 开头指定该接口请求方法。默认使用 route请求方法。
  
  `name` 接口数据名，用于 res.apiData[name]来获取。
  
  `cache` 是否缓存接口数据。可以是Function，返回boolean型。