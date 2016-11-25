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
```

#### 属性：
* req.pathname 同req.path
* res.apiData 接口数据