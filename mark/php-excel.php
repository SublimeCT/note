<?php

class Test{
    public function test(){

        require_once(ROOT_PATH.'vendor'.DS.'phpoffice'.DS.'phpexcel'.DS.'Classes'.DS.'PHPExcel.php');
        define('MOVE_FILE_PATH', ROOT_PATH.'public'.DS.'uploads'.DS.'excel'.DS);
        if ($_POST) {
            $tableName = $_POST['tableName'];

            // 文件上传失败
            if ($_FILES['file']['error'] || empty($tableName)) {
                exit('文件上传失败');
            }
            // 文件扩展名错误
            $excelFile = $_FILES['file'];
            $excelSuffix = substr($excelFile['name'], strrpos($excelFile['name'], '.')+1);
            if ($excelSuffix !== 'xlsx' && $excelSuffix !== 'xls') {
                exit('文件扩展名错误');
            }
            // 文件移动失败
            $filePath = MOVE_FILE_PATH.time().mt_rand(100,999).'.'.$excelSuffix;
            move_uploaded_file($excelFile['tmp_name'], $filePath) ? null : exit('文件移动失败');

            // 获取该表对应的所有字段信息
            $table = Db::query('SELECT * FROM think.excel WHERE table_name="'.$tableName.'" ORDER BY `order`;');

            // 读取数据
            $phpExcel = \PHPExcel_IOFactory::load($filePath);
            $sheet = $phpExcel->getSheet(0);                            // 读取第一個工作表
            $rowCount = $sheet->getHighestRow();                        // 取得总行数
            $colCount = $sheet->getHighestColumn();                     // 取得总列数
            $data = [];                                                 // 获取数据

            // 取得表中字段名并绑定对应过滤规则
            $filter = $this->_setTableFilter($sheet, $colCount, $table);

            for ($row=2; $row<=$rowCount; $row++) {
                for ($col='A'; $col<=$colCount; $col++) { 
                    $cellData = $sheet->getCell($col.$row)->getValue().'';
                    // 数据类型检查
                    $res = $this->_filterExcelField($cellData, $filter[$col], $col.$row);
                    is_string($res) ? exit($res) : null;
                    $dataCell[] = $cellData;
                }
                $data[$row] = $dataCell;
                $dataCell = null;
            }
            $this->_saveExcelData($data, $tableName, $filePath);
            exit('sucess');

        }else{
            $this->assign('url', $this->request->url(true));
            return $this->fetch('test');
        }




    }


    private function _setTableFilter($sheet, $colCount, $table){
        $filter = [];
        for($col='A'; $col<=$colCount; $col++){
            $fieldName = $sheet->getCell($col.'1')->getValue().'';             // 字段名
            foreach ($table as $key => $value) {
                if ($value['field_name'] === $fieldName) {
                    $filter[$col] = $table[$key]['field_type'];
                }
            }
        }
        return $filter;
    }

    private function _filterExcelField($cellData, $filter, $fieldDetail){
        // 所有字段都可以为空
        if ($cellData === '') {
            return false;
        }
        switch ($filter) {
            case '数值':if(!is_numeric($cellData)){return '错误位置：'.$fieldDetail.'<br>错误原因：只能填入数值';} break;
            case '手机号':if(!is_numeric($cellData)){return '错误位置：'.$fieldDetail.'<br>错误原因：只能填入手机号';} break;
            case '日期':if(strtotime($cellData)){return '错误位置：'.$fieldDetail.'<br>错误原因：只能填入日期（2008-08-08 12:12:12）';} break;
        }
    }

    private function _saveExcelData($data, $tableName, $fileName){
        // 获取对应表的所有字段集合
        $fieldList = Db::query('SELECT * FROM think.excel WHERE table_name="'.$tableName.'" ORDER BY `order`;');
        if (count($fieldList)>count(reset($data))) {
            exit('您上传的excel表格字段不全，请到‘Excel设置’中进行更改，或下载最新版Excel模版');
        }
        $sql = 'INSERT INTO data_excel(table_name,field_name,value,create_time,file_name,row_sort) VALUES ';
        $time = time();
        $row_sort = Db::query('SELECT MAX(row_sort) FROM think.data_excel WHERE table_name="'.$tableName.'"');
        $row_sort = ($row_sort[0]['MAX(row_sort)']===null ? '1' : strval(intval($row_sort[0]['MAX(row_sort)'])+1));
        foreach ($data as $value) {
            for($cell=0; $cell<count($fieldList); $cell++){
                $fieldName = $fieldList[$cell]['english_field_name'];
                // 设置未填写项为 null
                $d = ($value[$cell]==='' ? 'NULL' : "'$value[$cell]'");
                $sql .= "('$tableName','$fieldName',$d,$time,'$fieldName',$row_sort),";
            }
        }
        $sql = substr($sql, 0, strlen($sql)-1);
        return Db::query($sql); 
    }

}