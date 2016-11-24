### initHttpRequest

初始化用于接口请求的request库及api任务。

initHttpRequest流程产生结果为 req.httpRequest, req.apisTask（空对象）。
使用stage.before('initHttpRequest')产生req.httpRequestConfig，用于配置request参数。

查看结果：
```
const stage = coc(app);
stage.after('initHttpRequest', (req, res, next) => {
  console.log(req.httpRequest, req.apisTask);
  next();
});
```