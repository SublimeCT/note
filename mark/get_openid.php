<?php 
/**
 * 扫码获取用户openid
 * @authors Sc (hellosc@qq.com)
 * @date    2017-03-13 17:10:59
 * @version 1.0
 */

// 绑定openid
define('IN_ECS', true);
require(dirname(__FILE__) . '/includes/init.php');
include_once(ROOT_PATH . 'includes/lib_supplier_common.php');

if (isset($_GET['code']) && isset($_GET['state'])) {

    $wechat_config = get_wechat_config();

    if (isset($wechat_config['AppId']) && !empty($wechat_config['AppId']) && isset($wechat_config['AppSecret']) && !empty($wechat_config['AppSecret'])) {
        $get_token_url = 'https://api.weixin.qq.com/sns/oauth2/access_token?appid='.$wechat_config['AppId'].'&secret='.$wechat_config['AppSecret'].'&code='.$_GET['code'].'&grant_type=authorization_code';
        $res = json_decode(file_get_contents($get_token_url), true);

        // 获取openid成功
        if (!isset($res['errcode']) && isset($res['openid'])) {
            $openid = $res['openid'];
            $supplier_id = $_GET['state'];
            set_supplier_wechat_openid($supplier_id, $openid);
            // exit('<script>alert("绑定成功");</script><input type="button" value="关闭本窗口" onclick="WeixinJSBridge.call(\'closeWindow\');" />');
            $smarty->display('get_openid.dwt');
        }
    }
}else if (isset($_GET['get']) && is_numeric($_GET['get']) && intval($_GET['get'])>0) {
    // 获取openid
    echo get_supplier_wechat_openid($_GET['get']);
}