### initHttpRequest

初始化用于接口请求的request库及api任务。

产生结果：req.httpRequest, req.apisTask（空对象）。

使用stage.before('initHttpRequest')产生req.httpRequestConfig，用于配置request参数。

查看结果：
```
const stage = coc(app);
stage.after('initHttpRequest', (req, res, next) => {
  console.log(req.httpRequest, req.apisTask);
  next();
});
```

设置request参数(可用参数参见[request文档](https://github.com/request/request))：
```
// 演示https接口，自定义header等
const requestDefaults = {
  'cert': fs.readFileSync(certFile), // 设置https证书
  'strictSSL': false,
  'timeout': 20 * 1000, // milliseconds
  'json': true
};
stage.before('initHttpRequest', (req, res, next) => {
  const headers = {
    'x-version': 1,
    'x-token': 'some token' // or get it from req.cookies
  };
  
  requestDefaults.headers = headers;
  req.httpRequestConfig = requestDefaults;

  next();
});
```