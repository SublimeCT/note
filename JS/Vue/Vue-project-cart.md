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
            /*
             *  ES6 语法
             *      箭头函数
             *          this 指向外层作用域
             *  
             */
            // this.$http.get('data/cartData.json', { id: 123 }).then(response => {
            //     this.productList = response.data.result.list;
            //     this.totalMoney = response.data.result.totalMoney;
            // });
        }
    }
```

## 金额计算

> 在 vue 2.0 中使用 mounted 钩子代替了 ready 钩子
> 为了保证 this.$el 已经插入 document 中, 应该引入 this.$nextTick

#### 1. 格式化金额

```javascript
    mounted: function(){
        this.$nextTick(function(){
            // ...
        });
    },
    filters: {
        formatMoney: function(value, type=''){
            return '￥ '+value.toFixed(2)+type;
        }
    },
```

```html
    <!-- Vue 2.0 -->
    <div class="item-price">{{ product.price | formatMoney('元') }}</div>
    <!-- Vue 1.0 -->
    <div class="item-price">{{ product.price | formatMoney '元' }}</div>
```

#### 2. 单选全选

```html
    <!-- 单选 -->
    <a href="javascript:;" class="item-check-btn" :class="{check:product.checked}" @click="selectedProduct(product, 'once')"></a>
    <!-- 全选 -->
    <span class="item-check-btn" :class="{check:isCheckAll}" @click="checkAll(true)"></span>
    <!-- 取消选择 -->
    <a href="javascript:;" class="item-del-btn" @click="checkAll(false)"></a>
```

```javascript
    /**
     * 单选
     * @param  object  product
     * @param  string  type
     * @param  boolean flag
     */
    selectedProduct: function(product, type, flag=true){
        if (typeof product.checked === 'undefined') {
            // 新增元素属性
            this.$set(product, 'checked', flag);
        } else {
            switch (type) {
                case 'once': 
                    product.checked = !product.checked;
                    break;
                case 'mulit':
                    product.checked = flag;
                    break;
            }
        }
    },
    checkAll: function(flag=true){
        this.isCheckAll = flag;
        this.productList.forEach((product, index) => {
            this.selectedProduct(product, 'mulit', flag);
        });
    }
```

#### 3. 总金额联动

```javascript
    // 在单选和初始化时调用
    setTotalMoney: function(){
        this.totalMoney = 0;
        this.productList.forEach((product, index) => {
            if (typeof product.checked === 'boolean' && product.checked) {
                this.totalMoney += product.productPrice * product.productQuantity;
            }
        });
    }
```

## 商品删除

```html
    <div class="md-modal modal-msg md-modal-transition" id="showModal" :class="{'md-show':isShowDeleteDialog}">
        <div class="md-modal-inner">
            <div class="md-top">
                <button class="md-close" @click="isShowDeleteDialog = false">关闭</button>
            </div>
            <div class="md-content">
                <div class="confirm-tips">
                    <p id="cusLanInfo">你确认删除此订单信息吗?</p>
                </div>
                <div class="btn-wrap col-2">
                    <button class="btn btn--m" id="btnModalConfirm" @click="deleteProduct">Yes</button>
                    <button class="btn btn--m btn--red" id="btnModalCancel" @click="isShowDeleteDialog = false">No</button>
                </div>
            </div>
        </div>
    </div>
    <div class="md-overlay" v-show="isShowDeleteDialog"></div>
```

```javascript
    deleteProductConfirm: function(product){
        this.currentDeleteProduct = product;
        this.isShowDeleteDialog = true;
    },
    deleteProduct: function(){
        var product = this.productList.indexOf(this.currentDeleteProduct);
        // 使用 splice 删除数组项
        this.productList.splice(product, 1);
        this.isShowDeleteDialog = false;
    }
```

## 地址列表过滤和加载

#### 1. 地址列表长度限制

> 通过 computed 来控制列表长度

```javascript
    data: {
        limitNum: 3
    }
    computed: {
        limitedAddressList: function(){
            /*
             *  slice   返回截取后的新数组
             *  splice  直接对原数组进行操作
             */
            return this.addressList.slice(0, this.limitNum);
        }
    }
```

#### 2. 加载更多

```html
    <div class="shipping-addr-more">
        <a class="addr-more-btn up-down-btn" href="javascript:;" @click="limitNum = addressList.length">
            more
            <i class="i-up-down">
                <i class="i-up-down-l"></i>
                <i class="i-up-down-r"></i>
            </i>
        </a>
    </div>
```

## 地址选中与设为默认地址

#### 1. 选中

```html
    <li v-for="(address, index) in limitedAddressList" :data-address-id="address.addressId" 
        :class="{check:currentAddressId === address.addressId}" 
        @click="checkAddress(address.addressId)">
        ...
    </li>
```

```javascript
    checkAddress: function(id){
        this.currentAddressId = id;
    }
```

#### 2. 设为默认地址

```html
    <li>
        ...
        <div class="addr-opration" v-show="!address.isDefault">
            <a href="javascript:;" class="addr-set-default-btn" @click="setDefaultAddress(address.addressId)"><i>设为默认</i></a>
        </div>
        <div class="addr-opration addr-default" v-if="address.isDefault">默认地址</div>
    </li>
```

```javascript
    setDefaultAddress: function(id){
        this.addressList.forEach(function(address, index){
            if (address.addressId === id) {
                address.isDefault = true;
            } else {
                address.isDefault = false;
            }
        });
    }
```

## 配送方式选择

```html
    <div class="shipping-method">
        <ul>
            <li :class="{check: currentShippingMethod === 1}" @click="currentShippingMethod = 1">
                <div class="name">标准配送</div>
                <div class="price">Free</div>
            </li>
            <li :class="{check: currentShippingMethod === 2}" @click="currentShippingMethod = 2">
                <div class="name">高级配送</div>
                <div class="price">180</div>
            </li>
        </ul>
    </div>
```
