第二章 基本语法
<?php 
	echo "";					输出字符串[void]
	print "";					同上,返回值总是1[int]
	printf();					同C语言,返回值是字符个数[int]
	sprintf();					将字符串保留在内存中,返回值是本身[string]
	gettype(a);					返回a的数据类型
	settype(a,string);			将a强制转换成string,返回true/false[boolean]
	isset();					检测变量是否存在,返回true/false[boolean]
	unset();					销毁一个变量
	empty();					判断是否为空 未定义也返回true [boolean]
	is_array()/is_int()等		判断数据类型
	define("TOTAL",100);		定义常量TOTAL,常量前没有$,常量不可改变
	phpinfo();					输出php的配置信息

	访问表单变量：
		$username / $_POST["username"]				后者最常用,前者容易混淆
		$_GET["username"]							get方式传输时

第三章 操作符与控制结构
	字符串插入
		echo "$name，...";					//双引号内变量前后有中文字符时会出现问题
		echo "$name"."，...";				//解决方法,用.连接
	当用''解析字符串时,会原样解释

第四章 数学运算
	字符串与数值运算
	echo 1+'1';								//返回2
	echo 1+'a';								//返回1
	is_numeric();							//判断是否是数值
	rand(0,1)/mt_rand(0,1)					//随机生成一个0~1之间的随机数
	number_format(12345[,2,...])			//格式化数值数据,第一个参数是数值,第二个是小数保留位数[四舍五入]
	数学函数：
		abs();			//绝对值
		floor();		//直接取整
		ceil();			//进1取整
		round($a,2);	//四舍五入,2为保留位数
		min()/max()		//最值

第五章 数组
	创建数组：
		$array=array('李彦宏','马化腾','李开复');				//print_r可用于打印数组信息
		$array=range(0/'a',2/'z');								//range创建指定数组
		$array[0]='start';										//直接创建数组[5.4起支持]
	遍历数组：
		foreach($array as $key => $value){						//foreach,将指针前移
			echo $key.$value;
		};
		while(!!$element=each($array)){							//each()取得数组当前的键值对,并打包成一个新数组,
			echo $element['key'].$element['value'];
		}
		function arr_foreach ($arr){							//对多维数组的递归遍历
			if (!is_array ($arr))
				return false;
			foreach ($arr as $key => $val ) {
				if (is_array ($val))
					arr_foreach ($val);
				else 
					echo $val.'<br/>';
			}
		}
	获取数组元素个数：
		count($array);
	自定义键数组：
		$array=array('百度'=>'李彦宏','360'=>'周鸿祎');	

	list($a,$b,$c)=$array 				将数组的值赋给一些变量(list只能用于下标是数字的数组)
	reset($array);						将数组的指针指向第一个元素
	array_unique();						移除数组中的值重复的元素,形成一个新数组并返回
	array_flip();						置换数组中的键和值,形成一个新数组并返回
	数组排序：
		sort($array);					//将数组按照值的升序排列,返回boolean值
		sort($array,SORT_NUMERIC)		//按照数字大小进行排序
		sort($array,SORT_STRING)		//按照字符串大小进行排序
		asort($array[,SORT_STRING]);	//排序并保持索引关系,可选参数同sort()
		ksort($array);					//按照键的值排序
		rsort()/rasort()/rksort()		//反向...
		shuffle($array);				//随机排序
	数组的栈和队列方法
		array_push()/array_pop()		//栈
		array_push()/array_shift()		//队列
		array_unshift($array,$element)	//数组$array头部添加一个元素$element
	array_rand();		从数组中随机取出1或多个元素,返回下标
	数组的指针操作：
		reset()/prev()/current()/next()/end()			//指针操作只对each()有影响,foreach()会自动调用reset()
		最前/上一个/当前/下一个/最后
	array_count_values();				//统计数组内值的出现次数,返回key=>值value=>次数的数组
	
第六章 目录与文件
	目录操作：
		dirname();					获取路径的目录部分
		basename();					获取路径的文件名部分
		pathinfo();					获取路径的目录/文件名/基本名/扩展名,并打包成数组返回
		realpath();					将路径转换为绝对路径,失败会返回false
	磁盘/目录/文件计算：
		fileatime();				获取文件最后访问时间
		filectime();				获取文件最后改变时间
		filemtime();				获取文件最后修改时间
		filesize();					获取文件的大小,以byte表示
		disk_free_space();			获取磁盘剩余空间,路径以'C:'表示
		disk_total_space();			获取磁盘总容量,路径同上
	文件读写：
		fopen('x.php','w'[,x,y]);					[打开文件]可读写文件,返回句柄(resource)
		[只写]
			file_put_contents('x.php','sc');		[写入文件]只需路径和字符串,适用于只需要写一句话
			fwrite($f,$str[,strlen($str)]);			[写]可选参数是字符串长度,可以通过strlen()获取
			写入的字符串换行用"...\r\n..."			注意使用双引号
		[追加只写]
			fopen('x.php','a');	...
		[只读]
			fopen('x.php','r');	
			fgetc()/fgets()/fgetss()			读取一个字符/一行数据[第二个参数设置长度]/一行数据[过滤html数据],并后移指针
			fread()/fpassthru()					读取任意字节数数据/读取指针后所有数据
			file('test.txt')					按行读取路径目标文件,返回数组
			readfile('x.xxx');					直接向浏览器输出文件内容
			file_get_contents('x.xxx');			读取文件所有内容,返回字符串
			feof($f);							检测文件指针是否到了结尾
			用fgetc()结合feof()输出：
				while(!feof($f)){echo fgetc($f);}
			flie_exists('x.xxx');				判断x.xxx文件是否存在
			unlink('x.xxx');					删除x.xxx文件
			[指针操作]
				rewind('x.xxx');				将文件指针移到起始位置
				ftell('x.xxx');					返回文件指针的位置
				fseek('x.xxx',2);				以字节为单位定位指针
			[文件锁定]
				flock($f,LOCK_EX);				写操作被锁定
				flock($f,LOCK_UN);				解锁
			汉字在utf-8中占3个字节
		fclose($f);								[关闭文件]将句柄$f关闭
		[目录句柄操作]
			opendir('D:\x')						打开目录流
			readdir($d)							返回目录中的元素并后移指针
			scandir('D:\x');					将目录读入数组
			mkdir('D:\x');						创建目录
			rmdir('D:\x');						删除目录
			rename('Demo.c','Demo1.c');			重命名文件(将Demo替换成Demo1)
			closedir($d)						关闭目录流					

第七章 自定义函数
	函数调用不区分大小写
	function fun($a=7){return $a;}				包含默认参数的函数
	function fun(&$a,$b){return $a+=1;}			//按引用传递
	global $a 					//函数内部声明全局变量
	$GLOBALS['a']=7;			//使用超级全局变量$GLOBALS['a']
	unset($a)					//销毁变量
	include'xx/xx.php';			//包含并运行指定文件	
	include_once'xx/xx.php';	//判断xx.php是否存在,存在就不执行复制
	require('xx/xx.php');		//同include
	require_once('xx.xx.php');	//同include_once
		require/include执行效果完全相同,但require调用失败后返回致命错误,include返回警告
		推荐使用require_once();
	魔法常量：
		__FILE__		当前文件名
		__LINE__		当前行号
		__FUNCTION__	当前函数名
		__CLASS__		当前类名
		__METHOD__		当前方法名




			
