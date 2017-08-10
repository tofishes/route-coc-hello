## 场景实践

1. **错误捕捉处理。**
  

2. **API地址预处理。**

  
3. **验证码图片转发、外部接口代理。**
 
4. **接口数据统计。**

5. **loadModule，方便的代码管理方式。**
 
6. **接口数据缓存。**

  若某个api返回相对固定的数据结构，例如分类信息，省市区信息，可以设置router.cache|router.api.cache为true，这样可以将这些数据第一次请求之后缓存起来，不用每次都请求接口。
  coc options可以设置缓存方法apiDataCache，默认缓存到内存中。
  
7. ** 接入到已有项目中。**

  假如已有一个线上项目的express实现，想部分功能使用coc，可以利用coc options.mount指定某些功能路径使用coc。
  例如：
  ```
  // coc可以执行多次
  const productStage = coc(app, {
    'mount': '/product'  // 产品模块使用coc
  });
  const newsStage = coc(app, {
    'mount': '/news'  // 新闻模块使用coc
  });
  ```
 
8. ** 利用stage filter扩展router配置项增强功能 **

  在接口调用的过程中，往往有些参数前端不传递时，可以有个默认值。而利用filter可以很方便扩展router的一个配置项，增加默认值。实现过程如下：
  ```
  stage.after('matchRouter', (req, res, next) => {
    const defaultParam = (req.router || {}).defaultParam;

    // 为配置项增加默认参数的配置
    if (defaultParam) {
      req.param = Object.assign({}, defaultParam, req.param);
      Object.assign(req.query, req.param);
      Object.assign(req.body, req.param);
    }

    next();
  });
  ```
  
  这样，在Router路由配置章节所提及的**routerMeta**，就可以增加一项配置：routerMeta.defaultParam，类型为一个对象，将作为默认参数提供给接口。
  
  同样的做法，可以实现其他个性化用途的配置定制，需熟悉Stage下的每个章节所介绍的过程及产出物。
  
9. ** 当请求接口为get方式，且参数中有数组格式，灵活设置数组序列化的方式 **

  本框架内部使用request.js为请求接口的库，该库默认使用qs模块格式化get参数，其中qs对数组类型的序列化有以下3中方式：
  ```
  qs.stringify({ a: ['b', 'c'] }, { arrayFormat: 'indices' })
  // 'a[0]=b&a[1]=c'
  qs.stringify({ a: ['b', 'c'] }, { arrayFormat: 'brackets' })
  // 'a[]=b&a[]=c'
  qs.stringify({ a: ['b', 'c'] }, { arrayFormat: 'repeat' })
  // 'a=b&a=c'
  ```
  详见qs文档：[https://github.com/ljharb/qs#stringifying]
  
  request.js默认使用第一种 `indices` 方式。如果不适用于自己的项目，则可配置request参数来改变序列化方式。在本文档的章节 [coc -> Stage -> initHttpRequest](inithttprequest.md) 中有讲如何配置request，那么设置qs序列化方式的配置如下即可：
  
  ```
  cocer.before('initHttpRequest', (req, res, next) => {
    req.httpRequestConfig = {
      'qsStringifyOptions': {
        'arrayFormat': 'brackets'
      }
    };

    next();
  });
  ```
  
  `arrayFormat`的值可以是 indices | brackets | repeat  三种。