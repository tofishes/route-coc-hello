# 验证码图片转发或外部接口代理

路由配置：
 ```
  '/register/captcha': {
    'get': {
      'api': '/backend/register/captcha',
      'proxy': true
    }
  }
  ```
  api返回的是二进制图片数据，通过设置proxy:true直接转发给前端页面，前端页面展示标签为
  `<img src="/register/captcha" alt=""/>`
  
  想把接口数据原样返回给前端浏览器，只需要设置proxy即可。