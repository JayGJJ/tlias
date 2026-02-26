-- MySQL dump 10.13  Distrib 8.0.17, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: tlias
-- ------------------------------------------------------
-- Server version	8.0.17

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE DATABASE IF NOT EXISTS tlias;
USE tlias;

--
-- Table structure for table `clazz`
--

DROP TABLE IF EXISTS `clazz`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clazz` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID,主键',
  `name` varchar(30) NOT NULL COMMENT '班级名称',
  `room` varchar(20) DEFAULT NULL COMMENT '班级教室',
  `begin_date` date NOT NULL COMMENT '开课时间',
  `end_date` date NOT NULL COMMENT '结课时间',
  `master_id` int(10) unsigned DEFAULT NULL COMMENT '班主任ID, 关联员工表ID',
  `subject` tinyint(3) unsigned NOT NULL COMMENT '学科, 1:java, 2:前端, 3:大数据, 4:Python, 5:Go, 6: 嵌入式',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='班级表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clazz`
--

LOCK TABLES `clazz` WRITE;
/*!40000 ALTER TABLE `clazz` DISABLE KEYS */;
INSERT INTO `clazz` VALUES (1,'JavaEE就业163期','212','2024-04-30','2024-06-29',10,1,'2024-06-01 17:08:23','2024-06-01 17:39:58'),(2,'前端就业91期','211','2024-07-15','2025-01-25',5,2,'2024-06-01 17:45:12','2026-01-30 19:32:16'),(3,'JavaEE就业165期','108','2024-06-15','2024-12-25',6,1,'2024-06-01 17:45:40','2024-06-01 17:45:40'),(4,'JavaEE就业166期','105','2024-07-20','2024-02-20',20,1,'2024-06-01 17:46:10','2024-06-01 17:46:10'),(7,'Python就业45期','208','2024-09-01','2025-03-01',4,4,'2026-01-30 18:58:02','2026-01-30 18:58:02'),(8,'JavaEE就业164期','213','2024-04-30','2024-06-29',10,1,'2026-01-30 19:05:05','2026-01-30 19:05:05'),(9,'大数据就业59期','666','2026-01-06','2026-03-21',1,3,'2026-01-30 19:06:23','2026-02-21 20:34:09');
/*!40000 ALTER TABLE `clazz` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dept`
--

DROP TABLE IF EXISTS `dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dept` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID, 主键',
  `name` varchar(10) NOT NULL COMMENT '部门名称',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='部门表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dept`
--

LOCK TABLES `dept` WRITE;
/*!40000 ALTER TABLE `dept` DISABLE KEYS */;
INSERT INTO `dept` VALUES (1,'学工部','2024-09-25 09:47:40','2026-01-19 20:48:37'),(2,'教研部','2026-01-19 19:57:56','2026-01-19 19:57:56'),(3,'咨询部','2024-09-25 09:47:40','2024-09-30 21:26:24'),(4,'就业部','2024-09-25 09:47:40','2024-09-25 09:47:40'),(6,'行政部','2024-11-30 20:56:37','2024-09-30 20:56:37'),(13,'研发二部','2026-02-15 15:05:31','2026-02-21 20:39:23');
/*!40000 ALTER TABLE `dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emp`
--

DROP TABLE IF EXISTS `emp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `emp` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID,主键',
  `username` varchar(20) NOT NULL COMMENT '用户名',
  `password` varchar(32) DEFAULT '123456' COMMENT '密码',
  `name` varchar(10) NOT NULL COMMENT '姓名',
  `gender` tinyint(3) unsigned NOT NULL COMMENT '性别, 1:男, 2:女',
  `phone` char(11) NOT NULL COMMENT '手机号',
  `job` tinyint(3) unsigned DEFAULT NULL COMMENT '职位, 1 班主任, 2 讲师 , 3 学工主管, 4 教研主管, 5 咨询师',
  `salary` int(10) unsigned DEFAULT NULL COMMENT '薪资',
  `image` varchar(255) DEFAULT NULL COMMENT '头像',
  `entry_date` date DEFAULT NULL COMMENT '入职日期',
  `dept_id` int(10) unsigned DEFAULT NULL COMMENT '部门ID',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `phone` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='员工表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emp`
--

LOCK TABLES `emp` WRITE;
/*!40000 ALTER TABLE `emp` DISABLE KEYS */;
INSERT INTO `emp` VALUES (1,'shinaian','123456','施耐庵',1,'13309090001',4,15005,'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg','2000-01-01',2,'2023-10-20 16:35:33','2026-02-21 20:57:42'),(2,'songjiang','123456','宋江',1,'13309090002',2,8600,'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg','2015-01-01',2,'2023-10-20 16:35:33','2023-10-20 16:35:37'),(3,'lujunyi','123456','卢俊义',1,'13309090003',2,8900,'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg','2008-05-01',2,'2023-10-20 16:35:33','2023-10-20 16:35:39'),(4,'wuyong','123456','吴用',1,'13309090004',2,9200,'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg','2007-01-01',2,'2023-10-20 16:35:33','2023-10-20 16:35:41'),(5,'gongsunsheng','123456','公孙胜',1,'13309090005',2,9500,'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg','2012-12-05',2,'2023-10-20 16:35:33','2023-10-20 16:35:43'),(6,'huosanniang','123456','扈三娘',2,'13309090006',3,6500,'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg','2013-09-05',1,'2023-10-20 16:35:33','2023-10-20 16:35:45'),(7,'chaijin','123456','柴进',1,'13309090007',1,4700,'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg','2005-08-01',1,'2023-10-20 16:35:33','2023-10-20 16:35:47'),(8,'likui','123456','李逵',1,'13309090008',1,4800,'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg','2014-11-09',1,'2023-10-20 16:35:33','2023-10-20 16:35:49'),(9,'wusong','123456','武松',1,'13309090009',1,4900,'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg','2011-03-11',1,'2023-10-20 16:35:33','2023-10-20 16:35:51'),(10,'linchong','123456','林冲',1,'13309090010',1,5000,'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg','2013-09-05',1,'2023-10-20 16:35:33','2023-10-20 16:35:53'),(11,'huyanzhuo','123456','呼延灼',1,'13309090011',2,9700,'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg','2007-02-01',2,'2023-10-20 16:35:33','2023-10-20 16:35:55'),(12,'xiaoliguang','123456','小李广',1,'13309090012',2,10000,'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg','2008-08-18',2,'2023-10-20 16:35:33','2023-10-20 16:35:57'),(13,'yangzhi','123456','杨志',1,'13309090013',1,5300,'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg','2012-11-01',1,'2023-10-20 16:35:33','2023-10-20 16:35:59'),(14,'shijin','123456','史进',1,'13309090014',2,10600,'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg','2002-08-01',2,'2023-10-20 16:35:33','2023-10-20 16:36:01'),(15,'sunerniang','123456','孙二娘',2,'13309090015',2,10900,'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg','2011-05-01',2,'2023-10-20 16:35:33','2023-10-20 16:36:03'),(16,'luzhishen','123456','鲁智深',1,'13309090016',2,9600,'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg','2010-01-01',2,'2023-10-20 16:35:33','2023-10-20 16:36:05'),(17,'liying','12345678','李应',1,'13309090017',1,5800,'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg','2015-03-21',1,'2023-10-20 16:35:33','2023-10-20 16:36:07'),(18,'shiqian','123456','时迁',1,'13309090018',2,10200,'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg','2015-01-01',2,'2023-10-20 16:35:33','2023-10-20 16:36:09'),(19,'gudasao','123456','顾大嫂',2,'13309090019',2,10500,'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg','2008-01-01',2,'2023-10-20 16:35:33','2023-10-20 16:36:11'),(20,'ruanxiaoer','123456','阮小二',1,'13309090020',2,10800,'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg','2018-01-01',2,'2023-10-20 16:35:33','2023-10-20 16:36:13'),(21,'ruanxiaowu','123456','阮小五',1,'13309090021',5,5200,'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg','2015-01-01',3,'2023-10-20 16:35:33','2023-10-20 16:36:15'),(22,'ruanxiaoqi','123456','阮小七',1,'13309090022',5,5500,'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg','2016-01-01',3,'2023-10-20 16:35:33','2023-10-20 16:36:17'),(23,'ruanji','123456','阮籍',1,'13309090023',5,5800,'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg','2012-01-01',3,'2023-10-20 16:35:33','2023-10-20 16:36:19'),(24,'tongwei','123456','童威',1,'13309090024',5,5000,'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg','2006-01-01',3,'2023-10-20 16:35:33','2023-10-20 16:36:21'),(25,'tongmeng','123456','童猛',1,'13309090025',5,4800,'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg','2002-01-01',3,'2023-10-20 16:35:33','2023-10-20 16:36:23'),(30,'liyun','123456','李云',1,'13309090030',NULL,NULL,'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg','2020-03-01',NULL,'2023-10-20 16:35:33','2023-10-20 16:36:31'),(36,'linghuchong','123456','令狐冲',1,'18809091212',2,6800,'https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg','2023-10-19',2,'2023-10-20 20:44:54','2023-11-09 09:41:04'),(38,'yuebuqun','123456789','岳不群',1,'18809091244',1,8000,'https://java-ai-jay.oss-cn-beijing.aliyuncs.com/2026/02/65ef3902-34ed-4a5f-be88-996e1f8bafd7.jpg','2022-09-18',1,'2026-01-22 19:50:03','2026-02-19 16:59:07'),(56,'wangyuyan','123456','王语嫣',2,'13388884444',5,7000,'https://java-ai-jay.oss-cn-beijing.aliyuncs.com/2026/01/8a48183c-98e3-43f1-8d29-76bf05696c1c.jpg','2026-01-30',3,'2026-01-28 18:06:18','2026-01-28 21:07:42');
/*!40000 ALTER TABLE `emp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emp_expr`
--

DROP TABLE IF EXISTS `emp_expr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `emp_expr` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID, 主键',
  `emp_id` int(10) unsigned DEFAULT NULL COMMENT '员工ID',
  `begin` date DEFAULT NULL COMMENT '开始时间',
  `end` date DEFAULT NULL COMMENT '结束时间',
  `company` varchar(50) DEFAULT NULL COMMENT '公司名称',
  `job` varchar(50) DEFAULT NULL COMMENT '职位',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='工作经历';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emp_expr`
--

LOCK TABLES `emp_expr` WRITE;
/*!40000 ALTER TABLE `emp_expr` DISABLE KEYS */;
INSERT INTO `emp_expr` VALUES (17,56,'2026-01-07','2026-02-28','滴滴','运营'),(31,38,'2012-07-01','2019-03-03','百度科技股份有限公司','java开发'),(32,38,'2019-03-15','2023-03-01','阿里巴巴科技股份有限公司','架构师'),(33,38,'2026-01-24','2026-02-28','滴滴','java');
/*!40000 ALTER TABLE `emp_expr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emp_log`
--

DROP TABLE IF EXISTS `emp_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `emp_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID, 主键',
  `operate_time` datetime DEFAULT NULL COMMENT '操作时间',
  `info` varchar(2000) DEFAULT NULL COMMENT '日志信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='员工日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emp_log`
--

LOCK TABLES `emp_log` WRITE;
/*!40000 ALTER TABLE `emp_log` DISABLE KEYS */;
INSERT INTO `emp_log` VALUES (1,'2026-01-27 17:50:06','新增员工：Emp(id=52, username=aaaa, password=null, name=aaaa, gender=1, phone=12345678911, job=2, salary=6000, image=, entryDate=2026-01-21, deptId=8, createTime=2026-01-27T17:50:05.849438400, updateTime=2026-01-27T17:50:05.849438400, deptName=null, exprList=[EmpExpr(id=null, empId=52, begin=2026-01-10, end=2026-02-28, company=aa, job=bb)])'),(2,'2026-01-27 17:54:26','新增员工：Emp(id=53, username=cccc, password=null, name=cccc, gender=2, phone=14657711236, job=3, salary=6000, image=, entryDate=2026-01-15, deptId=1, createTime=2026-01-27T17:54:26.281361900, updateTime=2026-01-27T17:54:26.281361900, deptName=null, exprList=[EmpExpr(id=null, empId=53, begin=2026-01-15, end=2026-02-27, company=ccc, job=ccc)])'),(4,'2026-01-27 18:01:48','新增员工：Emp(id=55, username=dddd, password=null, name=ddd, gender=1, phone=12544978297, job=2, salary=2000, image=, entryDate=2026-01-19, deptId=8, createTime=2026-01-27T18:01:47.546497300, updateTime=2026-01-27T18:01:47.546497300, deptName=null, exprList=[EmpExpr(id=null, empId=null, begin=2026-01-23, end=2026-02-27, company=ddd, job=ddd)])'),(5,'2026-01-28 18:06:18','新增员工：Emp(id=56, username=wangyuyan, password=null, name=王语嫣, gender=2, phone=13388884444, job=1, salary=6000, image=https://java-ai-jay.oss-cn-beijing.aliyuncs.com/2026/01/8a48183c-98e3-43f1-8d29-76bf05696c1c.jpg, entryDate=2026-01-30, deptId=1, createTime=2026-01-28T18:06:18.164591500, updateTime=2026-01-28T18:06:18.165582800, deptName=null, exprList=[EmpExpr(id=null, empId=56, begin=2026-01-07, end=2026-02-28, company=滴滴, job=运营)])'),(6,'2026-02-18 18:31:26','新增员工：Emp(id=57, username=gaoyuanyuan, password=null, name=高圆圆, gender=2, phone=13509098765, job=1, salary=6000, image=https://java-ai-jay.oss-cn-beijing.aliyuncs.com/2026/02/f23e4433-a369-430e-b775-bfbf3fcfb62b.jpg, entryDate=2026-02-20, deptId=1, createTime=2026-02-18T18:31:26.251809900, updateTime=2026-02-18T18:31:26.251809900, deptName=null, exprList=[EmpExpr(id=null, empId=57, begin=2026-02-13, end=2026-03-11, company=腾讯, job=客服)])');
/*!40000 ALTER TABLE `emp_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `operate_log`
--

DROP TABLE IF EXISTS `operate_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `operate_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `operate_emp_id` int(10) unsigned DEFAULT NULL COMMENT '操作人ID',
  `operate_time` datetime DEFAULT NULL COMMENT '操作时间',
  `class_name` varchar(100) DEFAULT NULL COMMENT '操作的类名',
  `method_name` varchar(100) DEFAULT NULL COMMENT '操作的方法名',
  `method_params` varchar(2000) DEFAULT NULL COMMENT '方法参数',
  `return_value` varchar(2000) DEFAULT NULL COMMENT '返回值',
  `cost_time` bigint(20) unsigned DEFAULT NULL COMMENT '方法执行耗时, 单位:ms',
  `operate_emp_name` varchar(10) DEFAULT NULL COMMENT '操作人姓名',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='操作日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operate_log`
--

LOCK TABLES `operate_log` WRITE;
/*!40000 ALTER TABLE `operate_log` DISABLE KEYS */;
INSERT INTO `operate_log` VALUES (1,1,'2026-02-09 16:47:15','com.gjj.controller.DeptController','Add','[Dept(id=null, name=666, createTime=2026-02-09T16:47:15.389307500, updateTime=2026-02-09T16:47:15.389307500)]','Result(code=1, msg=success, data=null)',18,'李四'),(2,1,'2026-02-09 16:47:20','com.gjj.controller.DeptController','update','[Dept(id=11, name=666678, createTime=2026-02-09T16:47:15, updateTime=2026-02-09T16:47:19.795653300)]','Result(code=1, msg=success, data=null)',12,'张三'),(3,1,'2026-02-09 16:47:21','com.gjj.controller.DeptController','deleteById','[11]','Result(code=1, msg=success, data=null)',20,'张三'),(4,10,'2026-02-09 19:04:01','com.gjj.controller.DeptController','Add','[Dept(id=null, name=666, createTime=2026-02-09T19:04:00.224138100, updateTime=2026-02-09T19:04:00.224138100)]','Result(code=1, msg=success, data=null)',545,'李四'),(5,10,'2026-02-09 19:04:04','com.gjj.controller.DeptController','update','[Dept(id=12, name=666888, createTime=2026-02-09T19:04, updateTime=2026-02-09T19:04:04.339646100)]','Result(code=1, msg=success, data=null)',9,'张三'),(6,10,'2026-02-09 19:04:09','com.gjj.controller.DeptController','deleteById','[12]','Result(code=1, msg=success, data=null)',14,'李四'),(7,2,'2026-02-15 15:05:31','com.gjj.controller.DeptController','Add','[Dept(id=null, name=研发一部, createTime=2026-02-15T15:05:31.364052300, updateTime=2026-02-15T15:05:31.364052300)]','Result(code=1, msg=success, data=null)',82,'李四'),(8,4,'2026-02-15 15:08:18','com.gjj.controller.DeptController','Add','[Dept(id=null, name=123, createTime=2026-02-15T15:08:18.236034600, updateTime=2026-02-15T15:08:18.236034600)]','Result(code=1, msg=success, data=null)',6,'李四'),(9,5,'2026-02-15 16:33:18','com.gjj.controller.DeptController','Add','[Dept(id=null, name=888, createTime=2026-02-15T16:33:18.305069, updateTime=2026-02-15T16:33:18.305069)]','Result(code=1, msg=success, data=null)',11,'王五'),(10,6,'2026-02-15 16:33:29','com.gjj.controller.DeptController','update','[Dept(id=16, name=888777, createTime=2026-02-15T16:33:18, updateTime=2026-02-15T16:33:29.105004200)]','Result(code=1, msg=success, data=null)',16,'李四'),(11,6,'2026-02-15 16:46:37','com.gjj.controller.DeptController','deleteById','[16]','Result(code=1, msg=success, data=null)',50,'张三'),(12,6,'2026-02-15 16:46:50','com.gjj.controller.DeptController','deleteById','[15]','Result(code=1, msg=success, data=null)',16,'李四'),(13,2,'2026-02-21 20:24:00','com.gjj.controller.ClazzController','update','[Clazz(id=9, name=大数据就业59期, room=6666, beginDate=2026-01-06, endDate=2026-03-21, masterId=1, subject=3, createTime=2026-01-30T19:06:23, updateTime=2026-02-21T20:23:59.558394900, masterName=null, status=null)]','Result(code=1, msg=success, data=null)',17,'admin'),(14,2,'2026-02-21 20:34:09','com.gjj.controller.ClazzController','update','[Clazz(id=9, name=大数据就业59期, room=666, beginDate=2026-01-06, endDate=2026-03-21, masterId=1, subject=3, createTime=2026-01-30T19:06:23, updateTime=2026-02-21T20:34:09.168081900, masterName=null, status=null)]','Result(code=1, msg=success, data=null)',25,'宋江'),(15,2,'2026-02-21 20:39:24','com.gjj.controller.DeptController','update','[Dept(id=13, name=研发二部, createTime=2026-02-15T15:05:31, updateTime=2026-02-21T20:39:23.495994)]','Result(code=1, msg=success, data=null)',12,'宋江'),(16,10,'2026-02-21 20:57:20','com.gjj.controller.StudentController','violation','[1, 5]','Result(code=1, msg=success, data=null)',19,'林冲'),(17,10,'2026-02-21 20:57:42','com.gjj.controller.EmpController','update','[Emp(id=1, username=shinaian, password=123456, name=施耐庵, gender=1, phone=13309090001, job=4, salary=15005, image=https://web-framework.oss-cn-hangzhou.aliyuncs.com/2023/1.jpg, entryDate=2000-01-01, deptId=2, createTime=2023-10-20T16:35:33, updateTime=2026-02-21T20:57:42.249214800, deptName=null, exprList=[])]','Result(code=1, msg=success, data=null)',31,'林冲');
/*!40000 ALTER TABLE `operate_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID,主键',
  `name` varchar(10) NOT NULL COMMENT '姓名',
  `no` char(10) NOT NULL COMMENT '学号',
  `gender` tinyint(3) unsigned NOT NULL COMMENT '性别, 1: 男, 2: 女',
  `phone` varchar(11) NOT NULL COMMENT '手机号',
  `id_card` char(18) NOT NULL COMMENT '身份证号',
  `is_college` tinyint(3) unsigned NOT NULL COMMENT '是否来自于院校, 1:是, 0:否',
  `address` varchar(100) DEFAULT NULL COMMENT '联系地址',
  `degree` tinyint(3) unsigned DEFAULT NULL COMMENT '最高学历, 1:初中, 2:高中, 3:大专, 4:本科, 5:硕士, 6:博士',
  `graduation_date` date DEFAULT NULL COMMENT '毕业时间',
  `clazz_id` int(10) unsigned NOT NULL COMMENT '班级ID, 关联班级表ID',
  `violation_count` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '违纪次数',
  `violation_score` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '违纪扣分',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `no` (`no`),
  UNIQUE KEY `phone` (`phone`),
  UNIQUE KEY `id_card` (`id_card`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='学员表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES (1,'段誉','2022222222',1,'18800000001','110120000300200001',0,'北京市昌平区建材城西路1号',1,'2021-07-01',3,2,15,'2024-11-14 21:22:19','2026-02-20 19:24:53'),(2,'萧峰','2022000002',1,'18800210003','110120000300200002',1,'北京市昌平区建材城西路2号',2,'2022-07-01',1,2,15,'2024-11-14 21:22:19','2024-11-14 21:22:19'),(3,'虚竹','2022000003',1,'18800013001','110120000300200003',1,'北京市昌平区建材城西路3号',2,'2024-07-01',1,2,10,'2024-11-14 21:22:19','2024-11-14 21:22:19'),(5,'阿朱','2022000005',2,'18800160002','110120000300200005',1,'北京市昌平区建材城西路5号',4,'2020-07-01',1,0,0,'2024-11-14 21:22:19','2024-11-14 21:22:19'),(6,'阿紫','2022000006',2,'18800000034','110120000300200006',1,'北京市昌平区建材城西路6号',6,'2021-07-01',2,0,0,'2024-11-14 21:22:19','2024-11-14 21:22:19'),(7,'游坦之','2022000007',1,'18800000067','110120000300200007',1,'北京市昌平区建材城西路7号',4,'2022-07-01',2,1,10,'2024-11-14 21:22:19','2024-11-14 21:22:19'),(8,'康敏','2022000008',2,'18800000077','110120000300200008',1,'北京市昌平区建材城西路8号',5,'2024-07-01',2,0,0,'2024-11-14 21:22:19','2024-11-14 21:22:19'),(9,'徐长老','2022000009',1,'18800000341','110120000300200009',1,'北京市昌平区建材城西路9号',3,'2024-07-01',2,0,0,'2024-11-14 21:22:19','2024-11-14 21:22:19'),(10,'云中鹤','2022000010',1,'18800006571','110120000300200010',1,'北京市昌平区建材城西路10号',2,'2020-07-01',2,0,0,'2024-11-14 21:22:19','2024-11-14 21:22:19'),(15,'刘竹庄','2022000015',1,'18800009401','110120000300200015',1,'北京市昌平区建材城西路15号',3,'2020-07-01',4,0,0,'2024-11-14 21:22:19','2024-11-14 21:22:19'),(16,'李春来','2022000016',1,'18800008501','110120000300200016',1,'北京市昌平区建材城西路16号',4,'2021-07-01',4,0,0,'2024-11-14 21:22:19','2024-11-14 21:22:19'),(17,'王语嫣','2022000017',2,'18800007601','110120000300200017',1,'北京市昌平区建材城西路17号',2,'2022-07-01',4,0,0,'2024-11-14 21:22:19','2024-11-14 21:22:19');
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-02-22 19:21:50
