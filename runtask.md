### runTask

执行req.apisTask任务。

产生结果： req.apiData, req.apiInfo。

查看结果：
```
const stage = coc(app);
stage.after('runTask', (req, res, next) => {
  console.log(req.apiData, req.apiInfo);
  next();
});
```