## 场景实践

1. **错误捕捉处理**
  ```
  const domain = require('domain');
  // 先设置该中间件
  app.use((req, res, next) => {
    const reqDomain = domain.create();
    // next抛出的异常在这里被捕获,触发此事件
    reqDomain.on('error', e => renderError(e, req, res));

    return reqDomain.run(next);
  });
  
  const stage = coc(app);
  
  app.listen(port);
  ```

2. **API地址预处理。**
  例如，有接口地址为 http://domain/comment/list, http://domain/product/list等。 在router配置里可以设置为：
  ```
  {
    '/page/comments': {
      'get': {
         'api': '/comment/list',
         ...
      }
    },
    '/page/product': {
      'get': {
        'api': '/comment/list',
        ...
      }
    }
  }
  ```
  coc调用时设置handleAPI参数为：
  ```
  coc(app, {
    handleAPI(url) {
      return 'http://domain' + url;
    }
  })
  ```
3. **验证码图片转发、外部接口代理**
  ```
  '/register/captcha': {
    'get': {
      'api': '/front/reg/getVerifyCode',
      'proxy': true
    }
  }
  ```
  api返回的是二进制图片数据，通过设置proxy:true直接转发给前端页面，前端页面展示标签为
  `<img src="/register/captcha" alt=""/>`
  
  想把接口数据原样返回给前端浏览器，只需要设置proxy即可。
4. **接口数据统计**
   ```
   const stage = coc(app);
   
   stage.before('render', (req, res, next) => {
     console.log(res.apiInfo);
   });
   ```
   通过在after('runTask')或before('render')设置过滤器，拿取apiInfo来展示接口请求情况。
   每个接口信息包含：headers(接口响应headers), consumeTime(耗时), resBody(原始接口响应体), query, body, method, api等信息。
  
5. **loadModule，方便的代码管理方式**
  ```
  function loadModule(dir, callback) {
    const files = glob.sync(`${dir}/**/*.js`);
    files.forEach(file => {
      const mod = require(file); // eslint-disable-line global-require
      callback(mod);
    });
  }
  ```
  用以上方法载入指定目录下的js模块。比如 stage filters定义到一个目录中，用上述方法自动载入。
  ```
  // use coc
  const cocer = coc(app);

  loadModule(`${__dirname}/libs/stage-filters`, mod => {
    mod(cocer);
  });
  ```
6. **接口数据缓存**
  若某个api返回相对固定的数据结构，例如分类信息，省市区信息，可以设置router.cache|router.api.cache为true，这样可以将这些数据第一次请求之后缓存起来，不用每次都请求接口。
  coc options可以设置缓存方法apiDataCache，默认缓存到内存中。
  
7. ** 接入到已有项目中 **
  假如已有一个线上项目的express实现，想部分功能使用coc，可以利用coc options.mount指定某些功能路径使用coc。
  例如：
  ```
  // coc可以执行多次
  const productStage = coc(app, {
    'mount': '/product'  // 产品模块使用coc
  });
  const newsStage = coc(app, {
    'mount': '/news'  // 新闻模块使用coc
  });
  ```