# Meteor Note For v1.6

***官方文档项目笔记***

> `imports` 目录外的文件将在 `Meteor服务器` 启动时自动加载，而 `imports` 目录中的文件只有在使用 `import` 语句加载时才会加载

## Meteor.methods

```javascript
// /imports/api/tasks.js
Meteor.methods({
    'task.remove' (taskId) {
        check(taskId, String)
        Tasks.remote(tasksId)
    }
})
// /imports/ui/body.js
Meteor.call('task.remote', id)
// /imports/ui/task.js
Template.task.events({
    'click .toggle-checked' () {
        Meteor.call('tasks.setChecked', this._id, !this.checked)
    }
})
```

## publish & subscribe

```javascript
// /imports/ui/task.js
if (Meteor.isServer) {
    Meteor.publish('tasks', function tasksPublication () {
        return Tash.find()
    })
}
// /imports/ui/body.js
Template.body.onCreated(function bodyOnCreated() {
    this.state = new ReactiveDict();
    Meteor.subscribe('tasks');
})
```