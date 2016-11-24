### initHttpRequest

初始化用于接口请求的request库及api任务。

initHttpRequest流程产生结果为 req.apisTask（空对象）。

查看结果：
```
const stage = coc(app);
stage.after('initHttpRequest', (req, res, next) => {
  console.log(req.router, req.apisTask);
  next();
});
```