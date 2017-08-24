### upload

当请求的Content-Type为multipart/form-data时，解析上传的参数，并保存文件到指定目录下后得到文件路径。

上传解析模块使用的是 multiparty。

产生结果：将解析的参数和上传后的文件路径信息合并到req.body。

使用stage.before('upload')修改req.uploadOptions，用于配置multiparty参数。
其中uploadOptions.uploadDir 默认为当前项目执行目录的uploads子目录。
const defaultUploadDir = `${process.cwd()}/uploads`;


查看结果：
```
const stage = coc(app);
stage.after('upload', (req, res, next) => {
  console.log(req.body);
  next();
});
```

设置multiparty参数(可用参数参见[multiparty文档](https://github.com/pillarjs/multiparty#multipartyform))：
