/*
Navicat MySQL Data Transfer

Source Server         : PHPStudy
Source Server Version : 50553
Source Host           : 127.0.0.1:3307
Source Database       : think

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2017-05-01 21:11:54
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for data_excel
-- ----------------------------
DROP TABLE IF EXISTS `data_excel`;
CREATE TABLE `data_excel` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `table_name` varchar(100) NOT NULL,
  `field_name` varchar(50) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `create_time` int(10) NOT NULL,
  `file_name` varchar(30) NOT NULL,
  `row_sort` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=61 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for excel
-- ----------------------------
DROP TABLE IF EXISTS `excel`;
CREATE TABLE `excel` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `table_name` varchar(100) NOT NULL,
  `field_name` varchar(50) NOT NULL,
  `field_type` enum('手机号','日期','数值','字符') NOT NULL DEFAULT '字符',
  `english_field_name` varchar(50) NOT NULL,
  `order` int(10) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
