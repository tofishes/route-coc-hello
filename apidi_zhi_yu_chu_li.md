### API地址预处理

例如，有接口地址为 http://domain/comment/list, http://domain/product/list等。 在router配置里可以设置为：
  ```
  {
    '/page/comments': {
      'get': {
         'api': '/comment/list',
         ...
      }
    },
    '/page/product': {
      'get': {
        'api': '/comment/list',
        ...
      }
    }
  }
  ```
  coc调用时设置handleAPI参数为：
  ```
  coc(app, {
    handleAPI(url) {
      return 'http://domain' + url;
    }
  })
  ```
