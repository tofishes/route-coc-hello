### loadModule代码管理方式

 ```
  function loadModule(dir, callback) {
    const files = glob.sync(`${dir}/**/*.js`);
    files.forEach(file => {
      const mod = require(file); // eslint-disable-line global-require
      callback(mod);
    });
  }
  ```
  用以上方法载入指定目录下的js模块。比如 stage filters定义到一个目录中，用上述方法自动载入。
  ```
  // use coc
  const cocer = coc(app);

  loadModule(`${__dirname}/libs/stage-filters`, mod => {
    mod(cocer);
  });
  ```