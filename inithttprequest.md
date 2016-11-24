### initHttpRequest

初始化用于接口请求的request库。

matchRouter流程产生结果为 req.router，req.apisTask。

查看结果：
```
const stage = coc(app);
stage.after('matchRouter', (req, res, next) => {
  console.log(req.router, req.apisTask);
  next();
});
```