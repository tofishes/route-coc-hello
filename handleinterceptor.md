### handleInterceptor

根据请求路径匹配interceptors。默认情况下不匹配带 . 符号的路径资源（意为排除静态资源路径），除非interceptor配置了匹配 . 路径。

产生结果：req.interceptors。