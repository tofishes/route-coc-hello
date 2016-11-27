## 默认APP设置及扩展的属性方法


#### app默认已设置
```
// parse application/x-www-form-urlencoded
app.use(bodyParser.urlencoded({ extended: false }));
// parse application/json
app.use(bodyParser.json());
app.use(cookieParser());
// nginx代理转发后，要获取正确host需要：
app.set('trust proxy', 'loopback');
app.set('query parser', 'extended');
```

以下属性和方法，是coc框架运行所需，请勿覆盖。

#### 属性
* req.stageIndex 流程索引
* req.pathname 默认等于req.path, 使用req.forward功能后则不相等，req.path始终为原始请求地址
* req.param  路由参数
* req.router 匹配到的router配置
* req.interceptors 匹配到的拦截器
* req.apisTask 接口任务
* req.httpRequest 接口请求client
* 
* res.apiData 接口数据
* res.apiInfo 接口信息
* res.forwardSent forward跳转后，值为true
* res.hasSent 代理转发后，值为true
* res.viewPath 视图模板相对路径
* res.viewExt 视图模板后缀
* res.viewFile 视图模板物理文件地址;
* res.locals.request = req
* res.locals.app = req.app

#### 方法
* res.forward(routePath) 
  服务器内跳转，例如 res.forward('/news/100')，内部会跳转到 '/news/:id' 的route
* next(error)
  下一个流程，是对express next的一个封装。stage内使用这个next()跳转流程。
  next.origin() 是 express next()。