### 扩展属性与方法

以下属性和方法，是coc框架运行所需，请勿覆盖。

#### app设置
```
app.set('interceptorMap', interceptorMap);
app.set('interceptors', interceptors);
app.set('routerMap', routerMap);
app.set('routers', routers);
app.set('views', viewDir);
app.set('viewExclude', viewExclude);
// 设置接口数据缓存方法
app.set('apiDataCache', apiDataCache);
// 设置接口地址处理方法
app.set('handleAPI', handleAPI);
```

#### 属性
* req.stageIndex 流程索引
* req.pathname 取代req.path
* res.apiData 接口数据
* res.apiInfo 接口信息
* res.forwardSent forward跳转后，值为true
* res.hasSent 代理转发后，值为true

#### 方法
* res.forward(routePath) 
  服务器内跳转，例如 res.forward('/news/100')，内部会跳转到 '/news/:id' 的route
* next(error)
  下一个流程，是对express next的一个封装。stage内使用这个next()跳转流程。
  next.origin() 是 express next()