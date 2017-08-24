### upload

当请求的Content-Type为multipart/form-data时，解析上传的参数，并保存文件到指定目录下后得到文件路径。

产生结果：将解析的参数和上传后的文件路径信息合并到req.body。

查看结果：
```
const stage = coc(app);
stage.after('matchRouter', (req, res, next) => {
  console.log(req.router, req.param);
  next();
});
```