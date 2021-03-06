## View渲染

route-coc的默认引擎为nunjucks，文件后缀为.njk， 官网文档地址为：<https://mozilla.github.io/nunjucks/>。

### 多引擎支持

route-coc对多引擎的支持做法是：~~借用express的API。~~

v1.3.2版本后，可以使用stage.engine实例方法来设置多引擎。同时也支持express app.engine方式。一个项目有多个stage实例且各个stage需要不同模板引擎时，只能通过stage.engine来设置。

用swig示例：
  ```
  const express = require('express');
  const coc = require('route-coc');
  const swig = require('swig');

  const app = express();
  // 注册swig后缀使用swig的渲染方法
  app.engine('swig', swig.renderFile);
  
  const stage = coc(app);
  const port = 8080;
  app.listen(port, () => {
    const startInfo = `server run at http:\/\/localhost:${port}`;
  });
  ```
  
然后router配置的view需指定后缀名：
```
  module.exports = {
    '/hello, /hello/:name': {
      'get': {
        handle(data, req) {
          return {
            'username': req.param.name
          };
        },
        view: 'hello.swig' // 这里不能省略后缀名
      }
    }
  };
```

这里要提一个模板引擎：[Marko](http://markojs.com/)。其语法既支持普通的html又支持类pug(jade)的简洁语法，很厉害。最强大的是支持UI Components，我觉得是个亮点。这么看起来非常不错的引擎，使用方法却有点奇葩，不走express规范的那种render api。
我觉得有必要在这里介绍下如何简单把marko模板引擎添加到route-coc。

做法不难，如下所示(基于Marko v4+，且使用stage.engine来注册)：

```
require('marko/node-require').install();
stage.engine('marko', (filePath, data, callback) => {
  const template = require(filePath); // eslint-disable-line

  template.renderToString(data, callback);
});
```

### 用其他引擎取代nunjucks作为默认引擎

若不想router配置的view指定后缀名，则需取代nunjucks作为默认引擎，还是用swig示例：
```
  ...
 
  const app = express();
  const stage = coc(app);
  
  // 注册swig后缀使用swig的渲染方法
  stage.engine('swig', swig.renderFile);
  // 设置默认引擎后缀
  stage.set('view engine', 'swig');
  
  ...
```

### 默认index页面

route-coc支持目录访问，渲染index页面。

例如有一个模板文件为： `/views/dir/index.njk`， 则 访问`/view/dir`会渲染index.njk到浏览器。

index页面文件的后缀名，取决于所设置的默认引擎后缀， 默认是njk。

### 模板内置对象
在模板中可以直接使用以下对象属性：

```
{{ request }} // express req对象引用
{{ request.ua }} // userAgent解析后的对象
{{ request.moduleName }} // 根据请求路径得到的模块名
```

ua对象是使用 [ua-parser-js](https://github.com/faisalman/ua-parser-js) 库解析的结果，详情请查看官方文档<https://github.com/faisalman/ua-parser-js>。

moduleName由请求路径的首位目录决定，例如请求 /news/:id, 则其moduleName为 news。若访问的是 / 首页，则moduleName默认为home。

### 渲染结果

执行渲染后，根据条件返回以下结果的其中一种：

1. 匹配到router，并且router设置了view： 正常响应模板内容，Content-Type为text/html。
2. 未得到view，但是检测到是ajax请求（req.xhr）： 将res.apiData作为json返回。

一个Router，既要响应浏览器请求渲染页面，又想响应ajax请求得到json，有两种做法：

1. routerMeta.handle方法中用req.xhr判断，return req.xhr ? res.json(data) : data;
2. routerMeta.view 设置为function类型，return req.xhr ? null : 'html/view/path';