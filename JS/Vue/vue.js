1 Vue 实例
    1 属性和方法
        // 每个 Vue 实例都会代理 data 对象里所有的属性
        var data = {el:'#app', a:1};
        var vm = new Vue({
            data: data                  // 只有被代理的属性石响应的, 实例创建之后添加的属性不会触发师徒更新
        });

2 模板语法
    1 插值
        // 使用 Mustache 语法(双大括号)插值
        <span>Message: {{ message }}</span>
        // 一次性插值
        <span v-once >Message: {{ message }}</span>
        // 纯 HTML
        <span v-html >Message: {{ message }}</span>
        // Mustache 语法不能再 HTML 属性中使用, 应该使用 v-bid 指令
        <span v-bind:id='dynamicId' ></span>
        // 使用布尔值控制元素是否包含该属性
        <span v-bind:disabled='isShow' ></span>
    2 使用 JavaScript 表达式
        // 对于所有的数据绑定, Vue.js 都提供了完整的 JS 表达式支持
        {{ number+1 }}
        {{ ok ? 'YES' : 'NO' }}
        <div v-bind:id="'list-' + id"></div>
        // 普通语句和流程控制语句不是表达式, JS 代码不会生效
        {{ var a = 1 }}
        {{ if (1) {} }}
    3 指令
        /*
         *  指令以 v- 作为前缀
         *  指令的职责就是当表达式的值改变时, 将某些行为应用到 DOM 上
         *  
         */ 
        1 v-bind 响应地更新 HTML 属性
            <span v-bind:href="url"></span>
        2 v-on 监听 DOM 事件
            <span v-on:click="doSomething"></span>
        3 修饰符
            // 对于触发的事件调用 event.preventDefault()
            <span v-on.prevent:click="doSomething"></span>
        4 过滤器
            /*
             *  过滤器能够在 Mustache 绑定和 v-bind 表达式中使用
             *  可以使用自定义过滤器, 常被用作文本格式化
             *  过滤器可以传参和接受参数使用
             */ 
            {{ message | capitalize }}
            <span>{{ message | capitalize | capitalize2('prefix', 'suffix') }}</span>
            var vm = new Vue({
                el: '#app',
                data: {
                    message: 'vue.js'
                },
                filters: {
                    capitalize2: function(value, prefix, suffix){
                        if (!value) return '';
                        value = value.toString();
                        return value.charAt(0).toUpperCase() + value.slice(1);
                    },
                    capitalize: function(value){
                        return value.toString().toUpperCase();
                    }
                }
            });
        5 指令缩写
            1 v-bind
                <span :href="url"></span>
            2 v-on
                <span @click="doSomething"></span>
    4 计算属性
        1 通过 computed 声明计算属性 
            <div id="app">
                <p>Origin message: "{{ message }}"</p>
                <p>Computed reversed message: "{{ reverseMessage }}"</p>
            </div>/
            var vm = new Vue({
                el: '#app',
                data: {
                    message: 'Vue.js'
                },
                computed: {
                    /*
                     *  当 xm.message 改变时, vm.reverseMessage 的值也会改变
                     *  对比 method  
                     *      computed 属性是响应式依赖
                     *      多次访问 reverseMessage 计算属性时如果 vm.message 没有改变, 会返回之前的计算结果(缓存)
                     *  对比 watched 属性
                     *      
                     */
                    // 响应式依赖
                    reverseMessage: function(){
                        return this.message.split('').reverse().join('');
                    }
                    // 非响应式依赖, 多次调用将返回首次执行时的结果
                    now: function(){
                        return Date.now();
                    }
                }
            });
        2 计算 setter
            computed: {
                fullName: {
                    get: function(){
                        return this.firstName + '' + this.lastName;
                    },
                    // 此时, 改变 vm.fullName 的值时, vm.firstName 和 vm.lastName 的值也会改变
                    set: function(newValue){
                        var names = newValue.split(' ');
                        this.firstName = names[0];
                        this.lastName = names[names.length - 1];
                    } 
                }
            }
    5 观察 watchers
        watch: {
            question: function(newValue){
                // code ...
            }
        }
    6 Class 与 style 绑定
        1 绑定 Class
            /*
             *  通过传给 class 属性一个对象, 来动态地切换 class
             *  v-bind 可以与 class 属性共存
             */
            <h2 id="test" class="text-center" :class="{ active:isActive, 'text-danger': isDanger }">text</h2>
            // 直接绑定一个对象
            <h2 id="test" :class="classObject">text</h2>
            // 绑定返回对象的计算属性[常用]
            data: {
                isActive: true,
                error: null
            }
            computed: {
                classObject: function(){
                    return {
                        active: this.isActive && !this.error,
                        'text-danger': this.error && this.error.type === 'fatal'
                    };
                }
            }
        2 绑定内联样式
            <h2 id="test" :style="styleObject">text</h2>/
            data: { styleObject:{ fontSize:'123px' } }
    7 条件渲染
        1 v-if
            <h1 v-if="ok">Yes</h1>
            <h1 v-else-if="Math.random() > 0.5">Wait ...</h1>
            <h1 v-else>No</h1>
        2 template 包装元素 + v-if
            <template v-if="ok">
                <h1>Title</h1>
            </template>
        3 用 key 管理可复用元素/
            /*
             *  包装元素中如果包含相同的标签, 会被复用
             *  可以通过 key 属性禁止元素复用
             */
            <template v-if="loginType === 'username'">
                <label>Username</label>
                <input name="username" key="username-input">
            </template>
            // 切换时如果在 username input 中输入内容, 切换为 email input 会显示该内容, 这是因为 vue 复用了 input 元素
            // 需要通过 key 值来禁止元素复用
            <template v-else>
                <label>Email</label>
                <input name="email" key="email-input">
            </template>
        4 v-show
            // 只是控制元素的 display 属性
            <h1 v-show="ok">hello</h1>
    8 列表渲染
        1 v-for/
            <ul id="test">
                <li v-for="(item, index) in items">"
                    // 在 v-for 块中拥有对父作用域完全的访问权限
                    {{ parentMessage }} - {{ index }} - {{ item.message }}
                </li>
            </ul>
            <script type="text/javascript">
                var vm = new Vue({
                    el: '#test',
                    data: {
                        parentMessage: 'messages',
                        items: [
                            { message: 'Foo' },
                            { message: 'Bar' }
                        ]
                    }
                });
            </script>/
            // 遍历对象
            <ul id="test">
                <li v-for="(value, key, index) in object">"
                    {{ value }}                    
                </li>
            </ul>
            // 整数迭代
            <ul id="for">
                <li v-for="n in 10">{{ n }}</li>
            </ul>                                                                   ()

        2 v-for with v-else-if                                                      ()
            <ul id="for">
                // 优先执行 for
                <li v-for="todo in todos" v-if="todo!='a'">{{ todo }}</li>          ()
            </ul>/
            // 先执行 if
            <ul id="for" v-if="shouldRenderTodos">
                <li v-for="todo in todos">{{ todo }}</li>                           ()
            </ul>

        3 /key
            // 建议尽可能用 v-for 提供 key
            <div v-for="item in items" :key="item.id"></div>                        ()
        4 数组更新检测
            1 变异方法 触发视图更新
                push / pop / shift / unshift / sort / reverse
            2 重塑数组 不会改变原数组
                filter / concat / slice
            3 不能检测的数据变动
                1 arr.itmes[0] = 'newValue'
                    arr.splice(0, 1 'newValue');                // 使用 splice 方法代替
                2 arr.items.length = newLength
                    arr.splice(newLength);
        5 显示过滤/排序结果
            <ul id="test">
                <li v-for="item in items">{{ item }}</li>
            </ul>
            var vm = new Vue({
                el: '#test',
                data: {
                    number: [1, 2, 3, 4, 5]
                },
                computed: {
                    items: function(){
                        return this.number.filter(function(number){
                            return number % 2 === 0;
                        });
                    }
                }
            });
        6 事件处理器
            1 监听事件
                <div id="test">
                    <button @click="counter += 1">add 1</button> /
                    <p>click count: {{ counter }} 次</p>
                </div>
                var vm = new Vue({
                    el: '#test',
                    data: {
                        counter: 0
                    }
                });
            2 事件修饰符
                <a @click.stop="doThis">阻止单击事件冒泡</a>/
                <a @click.prevent="doThis">禁止跳转</a>/
            3 按键修饰符
                // 包含 enter tab esc delete space up down left right ctrl alt shift meta
                <input @keyup.enter="fun">
                // 当 keyCode 为 13 时调用 fun 方法
                <input @keyup.13="fun">
        7 表单控件绑定
            1 双向数据绑定
                /*
                 *  在文本区域插值并不会生效, 应该用 v-model 代替
                 */
                <input v-model="message">
                <p>{{ message }}</p>
                <input type="checkbox" id="checkBox" v-model="checked">/
                // 单个复选框被勾选时, 绑定的 checked 值为 true
                <label for="checkBox">{{ checked }}</label>                                 ()
                // 多个复选框和多选列表被勾选时, 绑定的值为数组
                <input type="checkbox" value="a" v-model="checkedNames">
                <input type="checkbox" value="b" v-model="checkedNames">
                <input type="checkbox" value="c" v-model="checkedNames">
                <p>{{ checkedNames }}</p>               // ["a", "b", "c"]/
                // 单选按钮和下拉菜单只有单个值
                <input type="radio" name="sex" value="0" v-model="sex">
                // 渲染 select 
                <form action="javascript:;" id="test">
                    <select name="data" v-model="selected">
                        <option v-for="option in options" :value="option.value">{{ option.text }}</option>()
                    </select>
                    <input type="text" :value="selected">
                </form>

            2 绑定 value 
                // 选中时 vm.toggle === vm.a
                <input type="checkbox" v-model="toggle" :true-value="a" :false-value="b">
                // 选中时 vm.sex === vm.a
                <input type="radio" v-model="sex" :value="a">
                // 选中时 vm.selected === {number:123}
                <select v-model="selected">
                    <option :value="{ number: 123 }">123</option>
                </select>
                
            3 修饰符
                1 lazy 在 change 事件中同步[默认 keyDown]
                    <input v-model.lazy="msg">
                2 number 将用户输入的值转换为 number 类型
                    <input v-model.number="age" type="number">
                3 trim 
                    <input v-model.trim="msg">
    9 组件
        1 注册
            <div id="example">
                <my-component></my-component>
            </div>
            // 注册一个全局组件
            Vue.component('my-component', {
                template: '<div>A custom component</div>'
            });
            // 创建根实例
            new Vue({el:'#example'});

            // 渲染结果
            <div id="example">
                <div>A custom component</div>
            </div>
        2 局部注册
            var Child = {
                template: '<div>A custom component</div>'
            };
            new Vue({
                components: {
                    el: '#example',
                    // 只在父模板可用
                    'my-component': Child
                }
            });
        3 绕过 HTML 限制
            /*
             *  当使用 DOM 作为模板时, 会受到 HTML 的限制
             *  包含 ul/ol/table/select ...
             *  通过 is 属性指定 组件名
             */
            <table>
                <tr is="my-row"></tr>
            </table>
        4 data 必须是函数
            <div id="example">
                <simple-counter></simple-counter>
                <simple-counter></simple-counter>
                <simple-counter></simple-counter>
            </div>
            Vue.component('simple-counter', {
                template: '<button v-on:click="counter += 1">{{ counter }}</button>',
                data: function(){
                    return {
                        counter: 0
                    };
                }
            });
            new Vue({
                el: '#example'
            });
        5 构成组件
            Parent  ----- pass props ---->   Child
            Child   ----- emit events ---->  Parent
        6 prop
            1 使用 props 属性传递数据
                <div id="example">
                    <child message="测试"></child>
                </div>
                new Vue({
                    el: '#example',
                    components: {
                        child: {
                            // 属性名需要使用短横线命名方式, 但实际 dom 元素中的属性使用短横线命名方式
                            props: ['message'],
                            template: '<span>{{ message }}</span>'
                        }
                    }
                });
            2 动态 Prop
                <div id="example">
                    <input type="text" v-model="message">
                    <child :message="message"></child>
                </div>
                new Vue({
                    el: '#example',
                    data: { message: '' },
                    components: {
                        child: {
                            props: ['message'],
                            template: '<span>{{ message }}</span>'
                        }
                    }
                });
            3 单项数据流
                /*
                 *  prop 是单项绑定的
                 *  只能是父组件属性发生变化时, 传导给子组件
                 *  但引用类型值父子组件都会更新
                 *  如果子组件内部试图修改 属性, Vue会报错
                 */
                1 应对方式
                    1 子组件想要作为局部数据使用
                        // 定义一个 局部变量 , 并用 prop 值初始化
                        props: ['initialCounter']
                        data: function(){
                            return { counter: this.initialCounter };
                        }
                    2 prop 作为初始值传入, 由子组件再进行处理
                        props: ['size'],
                        computed: {
                            normalizedSize: function(){
                                return this.szie.trim().toLowerCase();
                            }
                        }
                2 prop 验证
                    /*
                     *  为组件的 props 指定验证规格, 如果不匹配就会报错
                     */
                    Vue.component('example', {
                        props: {
                            propA: Number,
                            propB: [String, Number],
                            propC: {
                                type: String,
                                require: true,
                                default: 'shit',
                                validator: function(value){
                                    return value>10;
                                }
                            },
                            propD: {
                                default: function(){
                                    return 'shit';
                                }
                            }
                        }
                    });

            4 自定义事件
                使用 $on()    监听事件
                使用 $emit()  触发事件
                1 直接使用 v-on 绑定自定义事件
                    <div id="example">
                        <p>{{ total }}</p>
                        <button-counter @increment="incremnetTotal"></button-counter>
                        // 为组件绑定原生事件
                        <button-counter @increment="incremnetTotal" @click.native="fuck"></button-counter>
                        <button-counter @increment="incremnetTotal"></button-counter>
                    </div>  /
                    Vue.component('button-counter', {
                        template: '<button @click="increment">{{ counter }}</button>',
                        data: function(){
                            return {
                                counter: 0
                            };
                        },
                        methods: {
                            increment: function(){
                                this.counter += 1;
                                // 触发根元素的事件
                                this.$emit('increment');
                            }
                        }
                    });
                    new Vue({
                        el: '#example',
                        data: { total: 0 },
                        methods: {
                            incremnetTotal: function(){
                                this.total += 1;
                            },
                            fuck: function(){
                                console.log('fuck');
                            }
                        }
                    });
                2 绑定原生事件
                    <my-component @click.native="increment"></my-component>
            5 .sync 修饰符
                /*
                 *  在 1.x 中可以通过 .sync 修饰符将子组件对 prop 值的修改同步到父组件中, 但这样无法查看子组件何时修改了 prop 值, 会增加维护成本
                 *  在 2.0+ 中移除了 .sync
                 *  在 2.3.x 中恢复了 .sync, 仅作为编译时的语法糖
                 */
                // v2.3.x
                <my-component :foo.sync="bar"></my-component>               /
                // 会被扩展为
                <my-component :foo="bar" @update:foo="val => bar = val"></my-component>               /
                // 当子组件需要更新 foo 的值时, 会显式地触发一个更新事件
                this.$emit('update:foo', newValue);

            6 使用自定义事件的表单输入组件
                1 在组件中使用 v-model
                    <input v-model="something">
                    // v-model 语法糖
                    <input :value="something" @input="something = $event.target.value">
                    // v-model 语法糖在组件中使用
                    <custom-input :value="something" @input="something = arguments[0]"></custom-input>    /
                2 货币输入自定义控件[保留两位小数]
                    <div id="example">
                        <currency-input v-model="price"></currency-input>
                    </div>
                    var vm = new Vue({
                        el: '#example',
                        data: {
                            price: 100
                        },
                        components: {
                            'currency-input': {
                                template: '\
                                    <span>\
                                        $\
                                        <input \
                                            ref="input"\
                                            v-bind:value="value"\
                                            v-on:input="updateValue($event.target.value)" \
                                            placeholder="保留两位小数"\
                                        >\
                                    </span>\
                                ',
                                // value prop 是父组件的 v-model 属性
                                props: ['value'],
                                methods: {
                                    updateValue: function(value){
                                        // 保留两位小数
                                        var formatedValue = value.trim().slice(0, value.indexOf('.') === -1 ? value.length : value.indexOf('.')+3);
                                        this.$refs.input.value = formatedValue;
                                        this.$emit('input', Number(formatedValue));
                                    }
                                }
                            }
                        }
                    });
                3 定制组件的 v-model
                    /*
                     *  2.2.0 新增
                     *  一个组件的 v-model 默认会使用 value 属性和 input 事件
                     *  但单选框或复选框的 value 属性可能用作其他目的
                     *  可以通过 model 属性回避这种冲突
                     *  
                     */

                    // 这里的 value 属性用于其他用途
                    <my-checkbox v-model="foo" value="some value"></my-checkbox>             /

                    // 通过 model 属性处理之后
                    <my-checkbox :checked="foo" @change="val => {foo = val}" value="some value"></my-checkbox>             /

                    new Vue({
                        el: '#example',
                        data: {
                            foo: '',
                            // 需要显式声明 checked
                            checked: ''
                        }
                        components: {
                            'my-checkbox': {
                                template: '...',
                                // 通过 model 修改 v-model 默认使用的 value 属性和 input 事件
                                model: {
                                    prop: 'checked',
                                    event: 'change'
                                },
                                props: {
                                    checked: Boolean,
                                    value: String
                                }
                            }
                        }
                    });
            7 使用 slot 分发内容
                // 为了让组件可以混合, 可以使用 内容分发 混合父组件的内容和子组件的模板, 可以使用 <slot> 作为原始内容的插槽
                1 编译作用域
                    // 父组件模板的内容在父组件作用域内编译, 子组件模板的内容在子组件作用域内编译 
                    <child-component>
                        // 这里的 message 是父组件的数据
                        {{ message }}
                    </child-component>  /

                    // 不能在父组件模板内将一个指令绑定到子组件上
                    <child-component v-show="showChildProperty"></child-component>                          /

                2 单个 slot
                    // 在子组件渲染时, 当有分发内容时, slot 内将编译宿主元素; 如果没有分发内容, 将显示 slot 中的备用内容
                
                3 具名 slot 
                    // <slot> 可以用 name 属性来配置如何分发内容
                    <div id="example">
                        <test>
                            <h1 slot="header">这里可能是一个页面标题</h1>

                            <p>主要内容的一个段落</p>
                            <p>另一个主要段落</p>

                            <h2 slot="footer">这里有一些联系信息</h2>
                        </test>
                    </div>
                    
                    var vm = new Vue({
                        el: '#example',
                        data: {
                            price: 100
                        },
                        components: {
                            'test': {
                                template: '\
                                    <section>\
                                        <header>\
                                            <slot name="header"></slot>\
                                        </header>\
                                        <main>\
                                            <slot></slot>\
                                        </main>\
                                        <footer>\
                                            <slot name="footer"></slot>\
                                        </footer>\
                                    </section>\
                                ',
                            }
                        }
                    });

                4 作用域插槽
                    // 用作使用一个可重用模板替换已渲染元素

                    // 使用作用域插槽实现列表组件, 允许组件自定义应该渲染列表的每一项
                    mark
                5 动态组件
                    







