### 错误捕捉

```
  const domain = require('domain');
  // 先设置该中间件
  app.use((req, res, next) => {
    const reqDomain = domain.create();
    // next抛出的异常在这里被捕获,触发此事件
    reqDomain.on('error', handleError(e) {
      // ... 处理错误，比如跳转到500页面
    });

    return reqDomain.run(next);
  });
  
  const stage = coc(app);
  
  app.listen(port);
  ```