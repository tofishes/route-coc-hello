## Router路由配置

router配置定义了一个请求从浏览器端发出到服务器端响应的一套业务流程。

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
      'proxy': false,
      'pageCache': false,
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
      },
      'view': 'route/list'
    }
  }
}
```

以上为一个标准的配置清单，基本层级是router.get.routerMeta。下面逐一介绍：

1. `'/route/:param, /route, /route/two/:param'`
  
  路由路径，即 route。可以是逗号间隔的多个route。路由规则和express相同。<br>
  详见 [http://expressjs.com/en/4x/api.html#path-examples](http://expressjs.com/en/4x/api.html#path-examples)
  
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
    },
    'view': 'route/page'
  }
  ```
  
  为方便解说，以上配置单元命名为 **routerMeta**。
  
  `api` 接口地址，可以用 post:|get:|delete:|put: 开头指定该接口请求方法。默认使用 route请求方法。
  
  `name` 接口数据名，用于 res.apiData[name]来获取。
  
  `cache` 是否缓存接口数据。可以是Function，cache(req, res), 返回boolean型。
  
  `timeout` 单独指定该接口的超时时间。
 
  `series` 该接口是并行还是串行。用于多个接口的请求方式。series为true的api将优先请求，等请求完成后才会继续执行其他api接口请求。默认为false，并行接口请求。
  
  `proxy` 是否代理转发该接口。为true时，直接将接口返回的数据响应到客户端（比如浏览器）。
  
  `pageCache` 是否添加no-cache响应头，阻止浏览器缓存该页面。默认为true。
  
  `query(req, res)` 设置接口的get请求参数。
  
  `body(req, res)` 设置接口的post请求参数。
  
  `handle(data, req, res)` 处理接口返回的数据。需将处理后的数据返回。若配置了routerMeta.name，则返回的数据赋值给 res.apiData[routerMeta.name]，否则将直接赋值给 res.apiData，须注意。在数据不受到破坏的情况下，handle(data)中的data，可以拥有三种取值方法：data.getMap(), data.getList(), data.getValue()。取值方法的使用详见[node module value-chain](https://www.npmjs.com/package/value-chain) 。
  
  `view` 设置视图的模板路径。coc默认使用swig模板引擎。若是使用express app.engine()设置了其他引擎，则view路径需要带上模板的文件后缀，如 'route/page.pug'。在调用 coc(app) 之前若使用 express app.set('view engine', 'pug')，则会改变默认渲染引擎。可以配置为返回字符串路径的Function类型。
  
  ### API高级配置
  
  **routerMeta**.api 除了可以是字符串，也可以是数组。 还可以是Function，返回上述2种数据类型。
  
  若为数组类型，其每项组成结构必须是一个标准的**routerMeta**。
  
  基于routerMeta结构，可以灵活组织api的配置，但api最多支持两级配置，即可以是 routerMeta.api.routerMeta, 但不可以是 routerMeta.api.routerMeta.api.routerMeta。
  
  一级routerMeta配置的query, body, name, cache会被作为二级routerMeta相同配置的默认值。意味着 未配置routerMeta.api.routerMeta.query, 则routerMeta.api.routerMeta.query = routerMeta.api.query。
  
  一级routerMeta配置的handle方法，会整合处理多个接口合并后的数据，即res.apiData。
  
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
  
  ### Function配置类型
  一个router配置的层级为：router.get.routerMeta。
  
  其中router.get也可以配置为一个Function，返回一个标准的reouterMeta。
  
  routerMeta.api, routerMeta.cache, routerMeta.query, routerMeta.body, routerMeta.view
  均可以是一个Function。入参统一为 (req, res), this指向当前router。
  
  routerMeta.handle入参有所不同，为（data, req, res）。
  
  ### routerMeta.series规则
  上面说到series配置项决定了多个接口的请求顺序（并行还是串行）。不管是路由配置还是拦截器配置都有series项，它们遵循以下运行规则：
  
  **多个接口请求被分配为两步执行：第一步先串行执行series:true的接口请求，第二步再并行执行series:false的接口请求。**
  
  这样的规则使多个接口的请求处理更为高效，但是会带来一个意外的问题（代码的实现并未规避这个问题）：若拦截器的series=false，路由的series=true，则路由中的接口会先于拦截器的接口完成，这样可能某些场景拦截器是无法起到作用的。
  
  推荐尽量避免使用串行的方式执行接口请求。
  