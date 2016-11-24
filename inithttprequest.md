### initHttpRequest

初始化用于接口请求的request库。

initHttpRequest流程产生结果为 初始化 req.apisTask。

查看结果：
```
const stage = coc(app);
stage.after('matchRouter', (req, res, next) => {
  console.log(req.router, req.apisTask);
  next();
});
```