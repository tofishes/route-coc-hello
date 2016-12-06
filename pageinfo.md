### pageInfo

获取并设置一些页面信息。可以使用stage.before|after增加信息。

pageInfo流程产生以下结果：

```
res.locals.request = req; // 模板中可以直接引用到req对象
res.locals.app = req.app; // 模板中可以直接引用到app对象
req.ua; // user-agent信息
req.moduleName; // 根据请求路径产生的模块名, 例如/member/center/follow, 模块名为member
```

ua对象结构请参考文档：<https://github.com/faisalman/ua-parser-js>

以上结果用于在swig模板中调用：
```
请求参数：{{ request.query }} {{ request.body }} {{ request.param }}
浏览器： {{ request.ua.browser.name }}
```

查看结果：
```
const stage = coc(app);
stage.after('pageInfo', (req, res, next) => {
  console.log(req.ua, req.moduleName);
  next();
});
```

