# 接入已有项目

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
 