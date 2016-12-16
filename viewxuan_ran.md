# View渲染

鉴于swig渲染引擎已经deprecated，原作者也不再继续维护，因此route-coc更换默认引擎为nunjucks，官网地址为：<https://mozilla.github.io/nunjucks/>。

nunjucks具有和swig相似的语法，能够比较好的过渡。

### 多引擎支持

route-coc对多引擎的支持做法是：借用express的API。