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
      return Object.assign({
        'pageSize': 20,
        'type': 1
      }, req.query);
    },
    body(req, res) {
      return req.body;
    },
    handle(data, req, res) {
      const list = data.getList('data.list');
      return { list };
    }
  }
  ```
  
  为方便解说，以上配置单元命名为 **routerMeta**。
  
  `api` 接口地址，可以用 post:|get:|delete:|put: 开头指定该接口请求方法。默认使用 route请求方法。
  
  `name` 接口数据名，用于 res.apiData[name]来获取。
  
  `cache` 是否缓存接口数据。可以是Function，cache(req, res), 返回boolean型。
  
  `timeout` 单独指定该接口的超时时间。
 
  `series` 该接口是并发还是串行。用于多个接口的请求方式。
  
  `query()` 设置接口的get请求参数。
  
  `body()` 设置接口的post请求参数。
  
  `handle()` 处理接口返回的数据。需将处理后的数据返回
  
  
  ### API高级配置
  
  **routerMeta**.api 除了可以是字符串，也可以是数组，或对象。 还可以是Function，返回上述3种数据类型。
  
  但不论是数组还是对象，基本组成结构必须是一个标准的**routerMeta**。
  
  基于routerMeta结构，可以灵活组织api的配置，但api最多支持两级配置，即可以是 routerMeta.api.routerMeta, 但不可以是 routerMeta.api.routerMeta.api.routerMeta。
  
  一级routerMeta配置的query, body, name, cache会被作为二级routerMeta相同配置的默认值。意味着 未配置routerMeta.api.routerMeta.query, 则routerMeta.api.routerMeta.query = routerMeta.api.query。
  
  一级routerMeta配置的handle方法，会整合处理多个接口合并后的数据，即res.apiData.
  
  示例：
  ```
  '/mixed/api-config': {
    'get': {
      api() {
        return ['http://localhost:8080/test/intercept/series/comments',
          {
            api: 'http://localhost:8080/comment/list',
            name: 'commentPage'
          },
          () => ({
            api: 'http://localhost:8080/api/comment/list',
            name: 'commentJson'
          })
        ];
      },
      name: 'real',
      handle(data, req, res) {
        const result = data.real && data.commentJson && data.commentPage;
        res.send(!!result);
      }
    }
  }
  ```