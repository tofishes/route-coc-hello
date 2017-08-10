## 场景实践

1. **错误捕捉处理。**
  

2. **API地址预处理。**

  
3. **验证码图片转发、外部接口代理。**
 
4. **接口数据统计。**

5. **loadModule，方便的代码管理方式。**
 
6. **。**

  
  
7. ** 接入到已有项目中。**

8. 
  
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