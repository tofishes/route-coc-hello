### getViewPath

从req.router或req.pathname获取视图模板路径。

产生结果：res.viewPath, res.viewExt, res.viewFile。

查看结果：
```
const stage = coc(app);
stage.after('getViewPath', (req, res, next) => {
  // 模板路径，后缀等信息
  console.log(res.viewPath, res.viewExt, res.viewFile);
  next();
});
```