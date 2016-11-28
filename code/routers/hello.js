module.exports = {
  '/hello, /hello/:name': {
    'get': {
      handle(data, req) {
        return {
          'username': req.param.name
        };
      },
      view: 'hello'
    }
  }
};
