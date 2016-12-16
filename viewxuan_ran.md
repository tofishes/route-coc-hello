# View渲染

鉴于swig渲染引擎已经deprecated，原作者也不再继续维护，因此route-coc更换默认引擎为nunjucks，官网地址为：<https://mozilla.github.io/nunjucks/>。

nunjucks具有和swig相似的语法，能够比较好的过渡。

官方nunjucks包有一点不兼容route-coc，因此route-coc实际使用的包为 nunjucks-route-coc，此包用于适配route-coc，并且完全和官方包功能一致。

### 多引擎支持

route-coc对多引擎的支持做法是：借用express的API。

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

### 用其他引擎取代nunjucks作为默认引擎

若不想router配置的view指定后缀名，则需取代nunjucks作为默认引擎，还是用swig示例：
```
  ...
  
  const app = express();
  // 注册swig后缀使用swig的渲染方法
  app.engine('swig', swig.renderFile);
  // 设置默认引擎后缀，必须在coc(app)前设置
  app.set('view engine', 'swig');
  
  const stage = coc(app);
  
  ...
```

### 默认index页面

route-coc支持目录访问，渲染index页面。

例如有一个模板文件为： `/views/dir/index.njk`， 则 访问`/view/dir`会渲染index.njk到浏览器。

index页面文件的后缀名，取决于所设置的默认引擎后缀， 默认是njk。