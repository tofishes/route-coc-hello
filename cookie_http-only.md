## cookie httpOnly

简单方法，重写res.cookie，写个过滤器，然后加入一下代码：

```
const cookie = res.cookie;

// httpOnly安全防护
res.cookie = (name, value, opts) => {
  const options = Object.assign({
    httpOnly: true
  }, opts);

  if (!value || value === 'undefined') {
    return;
  }

  cookie.call(res, name, value, options);
};

next();
```



