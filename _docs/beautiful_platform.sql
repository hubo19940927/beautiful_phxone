/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80015
 Source Host           : localhost:3306
 Source Schema         : beautiful_platform

 Target Server Type    : MySQL
 Target Server Version : 80015
 File Encoding         : 65001

 Date: 27/10/2020 17:18:13
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for check_point
-- ----------------------------
DROP TABLE IF EXISTS `check_point`;
CREATE TABLE `check_point` (
  `id` int(20) NOT NULL AUTO_INCREMENT COMMENT '检查点id',
  `check_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '检查类型',
  `deleted` int(1) NOT NULL COMMENT '是否被删除',
  `desc` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of check_point
-- ----------------------------
BEGIN;
INSERT INTO `check_point` VALUES (1, 'CONTAINS', 0, '包含某个字段');
INSERT INTO `check_point` VALUES (2, 'GT', 0, '大于');
INSERT INTO `check_point` VALUES (3, 'LT', 0, '小于');
INSERT INTO `check_point` VALUES (5, 'EQUAL', 0, '等于');
COMMIT;

-- ----------------------------
-- Table structure for p_trunk_case
-- ----------------------------
DROP TABLE IF EXISTS `p_trunk_case`;
CREATE TABLE `p_trunk_case` (
  `id` int(20) NOT NULL AUTO_INCREMENT COMMENT '个人主干用例id',
  `case_suite_id` int(20) NOT NULL COMMENT '关联套件id',
  `reuqest_method` varchar(6) NOT NULL COMMENT '请求方法',
  `request_url` varchar(255) NOT NULL COMMENT '请求地址',
  `request_header` varchar(50) NOT NULL COMMENT '请求头',
  `request_format` varchar(30) NOT NULL COMMENT '请求格式 none form-dara raw json',
  `is_push` int(1) NOT NULL COMMENT '默认为0代表为推送到公共区域',
  `is_failed` int(1) NOT NULL COMMENT '预期结果 成功还是失败',
  `is_checked` int(1) NOT NULL COMMENT '是否开启检查点',
  `is_report` int(1) NOT NULL COMMENT '是否生成单个报告',
  `except_format` int(1) NOT NULL COMMENT '0 为预期返回json  1为其他',
  `request_spend_time` int(10) NOT NULL COMMENT '接口执行消耗时间',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `version` int(11) DEFAULT NULL COMMENT '乐观锁',
  `deleted` int(1) NOT NULL COMMENT '0为正常 1为删除',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `case_suite_id` (`case_suite_id`),
  CONSTRAINT `p_trunk_case_ibfk_1` FOREIGN KEY (`case_suite_id`) REFERENCES `p_trunk_case_suite` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='个人主干用例';

-- ----------------------------
-- Records of p_trunk_case
-- ----------------------------
BEGIN;
INSERT INTO `p_trunk_case` VALUES (1, 1, 'POST', 'http://www.baidu.com/s', '1', '1', 0, 0, 0, 0, 0, 342, '2020-10-27 17:12:13', '2020-10-27 17:12:30', 0, 0);
COMMIT;

-- ----------------------------
-- Table structure for p_trunk_case_suite
-- ----------------------------
DROP TABLE IF EXISTS `p_trunk_case_suite`;
CREATE TABLE `p_trunk_case_suite` (
  `id` int(20) NOT NULL AUTO_INCREMENT COMMENT '个人主干用例id',
  `case_suite_name` varchar(255) NOT NULL COMMENT '测试套件名称',
  `test_bill_id` int(20) NOT NULL COMMENT '提测单id',
  `create_userid` int(20) NOT NULL COMMENT '新增用户id',
  `update_userid` int(20) NOT NULL COMMENT '最近一次更新用户id',
  `is_report` int(1) NOT NULL COMMENT '是否生成套件报告',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `version` int(11) DEFAULT NULL COMMENT '乐观锁',
  `deleted` int(1) NOT NULL COMMENT '0为正常 1为删除',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `update_userid` (`update_userid`),
  KEY `test_bill_id` (`test_bill_id`),
  KEY `p_trunk_case_suite_ibfk_3` (`create_userid`),
  CONSTRAINT `p_trunk_case_suite_ibfk_1` FOREIGN KEY (`update_userid`) REFERENCES `sys_user` (`user_id`),
  CONSTRAINT `p_trunk_case_suite_ibfk_2` FOREIGN KEY (`test_bill_id`) REFERENCES `test_bill` (`id`),
  CONSTRAINT `p_trunk_case_suite_ibfk_3` FOREIGN KEY (`create_userid`) REFERENCES `sys_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='个人主干用例套件';

-- ----------------------------
-- Records of p_trunk_case_suite
-- ----------------------------
BEGIN;
INSERT INTO `p_trunk_case_suite` VALUES (1, '造车', 1, 1, 1, 0, '2020-10-27 17:10:10', '2020-10-27 17:10:10', 0, 0);
COMMIT;

-- ----------------------------
-- Table structure for schdule_application
-- ----------------------------
DROP TABLE IF EXISTS `schdule_application`;
CREATE TABLE `schdule_application` (
  `app_id` int(20) NOT NULL COMMENT '应用id',
  `appcliation_name` varchar(255) NOT NULL COMMENT '应用名称',
  `appcliation_owner` varchar(255) NOT NULL COMMENT '应用负责人',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `deleted` int(1) unsigned zerofill DEFAULT '0' COMMENT '0为正常 1为删除',
  PRIMARY KEY (`app_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='同步应用信息表';

-- ----------------------------
-- Records of schdule_application
-- ----------------------------
BEGIN;
INSERT INTO `schdule_application` VALUES (15543, '车辆中心', '蔡文姬1', '2020-10-27 17:07:36', '2020-10-27 17:07:38', 0);
COMMIT;

-- ----------------------------
-- Table structure for schdule_service
-- ----------------------------
DROP TABLE IF EXISTS `schdule_service`;
CREATE TABLE `schdule_service` (
  `service_id` int(20) NOT NULL COMMENT '服务id',
  `service_name` varchar(255) NOT NULL COMMENT '服务名称',
  `service_owner` varchar(255) NOT NULL COMMENT '服务负责人',
  `service_version` varchar(255) NOT NULL COMMENT '服务版本',
  `app_id` int(20) NOT NULL COMMENT '应用id',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `deleted` int(1) NOT NULL COMMENT '0为正常 1为删除',
  PRIMARY KEY (`service_id`) USING BTREE,
  KEY `app_id` (`app_id`),
  CONSTRAINT `schdule_service_ibfk_1` FOREIGN KEY (`app_id`) REFERENCES `schdule_application` (`app_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='同步服务信息表';

-- ----------------------------
-- Records of schdule_service
-- ----------------------------
BEGIN;
INSERT INTO `schdule_service` VALUES (20010, '造车服务', '扁鹊', '201001', 15543, '2020-10-27 17:08:53', '2020-10-27 17:08:56', 0);
COMMIT;

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `user_id` int(20) NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `account` varchar(45) DEFAULT NULL COMMENT '账号',
  `password` varchar(45) DEFAULT NULL COMMENT '密码',
  `salt` varchar(45) DEFAULT NULL COMMENT 'md5密码盐',
  `name` varchar(45) DEFAULT NULL COMMENT '名字',
  `email` varchar(45) DEFAULT NULL COMMENT '电子邮件',
  `phone` varchar(45) DEFAULT NULL COMMENT '电话',
  `status` int(1) unsigned zerofill DEFAULT NULL COMMENT '状态(字典)',
  `create_user` bigint(20) DEFAULT NULL COMMENT '创建人',
  `update_user` bigint(20) DEFAULT NULL COMMENT '更新人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `version` int(11) unsigned zerofill DEFAULT NULL COMMENT '乐观锁',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户信息表';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
BEGIN;
INSERT INTO `sys_user` VALUES (1, 'hubo', '123456', 'adnbcs', '胡博', 'hubo96194xxxxx@163.com', '19090909090', 0, 1, 1, '2020-10-27 17:04:47', '2020-10-27 17:05:47', 00000000000);
COMMIT;

-- ----------------------------
-- Table structure for test_bill
-- ----------------------------
DROP TABLE IF EXISTS `test_bill`;
CREATE TABLE `test_bill` (
  `id` int(20) NOT NULL AUTO_INCREMENT COMMENT '提测单id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='提测单';

-- ----------------------------
-- Records of test_bill
-- ----------------------------
BEGIN;
INSERT INTO `test_bill` VALUES (1);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
