### pageInfo

获取并设置一些页面信息。可以使用stage.before|after增加信息。

pageInfo流程产生以下结果：

```
res.locals.request = req;
res.locals.app = req.app;
req.browser; // 浏览器信息
req.moduleName; // 根据请求路径产生的模块名
```

以上结果用于在swig模板中调用：
```
请求参数：{{ request.query }} {{ request.body }} {{ request.param }}
```

