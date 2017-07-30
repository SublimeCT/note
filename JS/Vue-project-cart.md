# Vue.js 购物车项目[慕课网]
    2017-07-30 17:40:35

-----------

## 使用 vue-resourse 操作 json
#### 1. 引入
```html
    <script src="https://unpkg.com/vue/dist/vue.js"></script>
    <script src="js/lib/vue-resource.js"></script>
    <script src="js/cart.js"></script>
```

#### 2. 创建 Vue 实例
```javascript
    var vm = new Vue({
        el: '#app',
        data: {

        },
        filters: {

        },
        // 相当于 jQuery 中的 ready 
        mounted: function(){

        },
        methods: {

        }
    });
```

#### 3. 使用 vue-resource 获取数据
``` javascript
        methods: {
            cartView: function(){
                var _this = this;
                this.$http.get('data/cartData.json', { id: 123 }).then(function(response){
                    _this.productList = response.data.result.list;
                    _this.totalMoney = response.data.result.totalMoney;
                });
            }
        }
```

#### 4. 金额计算


