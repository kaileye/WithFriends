-- MySQL dump 10.13  Distrib 5.7.9, for osx10.9 (x86_64)
--
-- Host: localhost    Database: WithFriends
-- ------------------------------------------------------
-- Server version	5.7.15

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `WithFriends_Advertisements`
--

DROP TABLE IF EXISTS `WithFriends_Advertisements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `WithFriends_Advertisements` (
  `ADId` int(11) NOT NULL,
  `EmployeeId` int(11) DEFAULT NULL,
  `Type` varchar(20) DEFAULT NULL,
  `PostDate` date DEFAULT NULL,
  `Company` varchar(50) DEFAULT NULL,
  `ItemName` varchar(50) DEFAULT NULL,
  `Content` varchar(2000) DEFAULT NULL,
  `UnitPrice` int(11) DEFAULT NULL,
  PRIMARY KEY (`ADId`),
  KEY `EmployeeId` (`EmployeeId`),
  CONSTRAINT `withfriends_advertisements_ibfk_1` FOREIGN KEY (`EmployeeId`) REFERENCES `WithFriends_Employees` (`EmployeeId`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `WithFriends_Advertisements`
--

LOCK TABLES `WithFriends_Advertisements` WRITE;
/*!40000 ALTER TABLE `WithFriends_Advertisements` DISABLE KEYS */;
INSERT INTO `WithFriends_Advertisements` VALUES (800001,100021,'Commercial','2016-11-17','H&M','Coat#1','Worm and water-proof',100),(800002,100021,'Commercial','2016-11-17','A&F','Coat#2','Worm',150),(800003,100022,'Educational','2016-11-17','Blackboard Inc.','Blackboard','Easy to use',300),(800004,100023,'Commercial','2016-11-17','Canada Goose','Coat#3','Great',900),(800005,100024,'Educational','2016-11-17','Nike','Sneaker#1','Confortable for running',150),(800006,100024,'Commercial','2016-11-17','Apple','MacBook Pro','Powerful',1999),(800007,100025,'Commercial','2016-11-17','Microsoft','Surface Pro','Ppwerful too',1899),(800008,100024,'Educational','2016-11-17','Staple','Large Notebook','Cheap',3),(800009,100026,'Commercial','2016-11-17','Dior','Handbag#1','Luxury',3000),(800010,100027,'Commercial','2016-11-17','Michael Kors','Handbag#2','Great deal',500),(800011,100025,'Commercial','2016-11-17','Microsoft','Office','easy',800),(800012,100025,'Commercial','2016-11-17','Yida Corp','Software','Designed by Yida',80),(800013,100027,'Commercial','2016-11-19','Yida Corp','Yida\'s Notes','Comprehensive',50);
/*!40000 ALTER TABLE `WithFriends_Advertisements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `WithFriends_Comments`
--

DROP TABLE IF EXISTS `WithFriends_Comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `WithFriends_Comments` (
  `CommentId` int(11) NOT NULL,
  `PosterId` int(11) DEFAULT NULL,
  `PostId` int(11) DEFAULT NULL,
  `PostDate` date DEFAULT NULL,
  `Content` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`CommentId`),
  KEY `PosterId` (`PosterId`),
  KEY `PostId` (`PostId`),
  CONSTRAINT `withfriends_comments_ibfk_1` FOREIGN KEY (`PosterId`) REFERENCES `WithFriends_Users` (`UserId`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `withfriends_comments_ibfk_2` FOREIGN KEY (`PostId`) REFERENCES `WithFriends_Posts` (`PostId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `WithFriends_Comments`
--

LOCK TABLES `WithFriends_Comments` WRITE;
/*!40000 ALTER TABLE `WithFriends_Comments` DISABLE KEYS */;
INSERT INTO `WithFriends_Comments` VALUES (500001,100002,400001,'2016-11-16','The rule is ridiculous Michael!!'),(500002,100001,400003,'2016-11-16','Switch to ISE and you will feel better.'),(500003,100002,400004,'2016-11-16','I\'m selling my 2014 Macbook Pro for $1000. Message me if you\'re interested.'),(500004,100002,400005,'2016-11-16','Hi, I\'m Aria, It\'s so nice to meet you on WithFriends!'),(500005,100001,400006,'2016-11-16','Don\'t worry too much, the average is like 38. You will be fine.'),(500006,100001,400007,'2016-11-16','You will have to pass both 114 and 215 with C or better.'),(500007,100002,400008,'2016-11-16','You are really good. What kind of questions you were asked?'),(500008,100001,400008,'2016-11-16','Well, it\'s basically just coding stuff with data structures and algorithms.'),(500009,100001,400009,'2016-11-16','CSE 381 is hard and heavliy use C++.'),(500010,100002,400010,'2016-11-16','You will have no time to sleep if you do this.');
/*!40000 ALTER TABLE `WithFriends_Comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `WithFriends_Employees`
--

DROP TABLE IF EXISTS `WithFriends_Employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `WithFriends_Employees` (
  `EmployeeId` int(11) NOT NULL,
  `SSN` int(11) DEFAULT NULL,
  `HourlyRate` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`EmployeeId`),
  UNIQUE KEY `SSN` (`SSN`),
  CONSTRAINT `withfriends_employees_ibfk_1` FOREIGN KEY (`EmployeeId`) REFERENCES `WithFriends_Users` (`UserId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `WithFriends_Employees`
--

LOCK TABLES `WithFriends_Employees` WRITE;
/*!40000 ALTER TABLE `WithFriends_Employees` DISABLE KEYS */;
INSERT INTO `WithFriends_Employees` VALUES (100021,222222001,10.28),(100022,222222002,10.28),(100023,222222003,10.28),(100024,222222004,10.28),(100025,222222005,10.28),(100026,222222006,10.28),(100027,222222007,10.28),(100028,222222008,10.28),(100029,222222009,10.28),(100030,222222010,10.28);
/*!40000 ALTER TABLE `WithFriends_Employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `WithFriends_Groups`
--

DROP TABLE IF EXISTS `WithFriends_Groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `WithFriends_Groups` (
  `GroupId` int(11) NOT NULL,
  `GroupName` varchar(50) DEFAULT NULL,
  `Type` varchar(20) DEFAULT NULL,
  `OwnerId` int(11) DEFAULT NULL,
  PRIMARY KEY (`GroupId`),
  KEY `OwnerId` (`OwnerId`),
  CONSTRAINT `withfriends_groups_ibfk_1` FOREIGN KEY (`OwnerId`) REFERENCES `WithFriends_Users` (`UserId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `WithFriends_Groups`
--

LOCK TABLES `WithFriends_Groups` WRITE;
/*!40000 ALTER TABLE `WithFriends_Groups` DISABLE KEYS */;
INSERT INTO `WithFriends_Groups` VALUES (200001,'My Friends','Friends',100001),(200002,'Best Friends','Friends',100002),(200003,'StonyBrookGang','Friends',100003),(200004,'CS Folks','Friends',100004),(200005,'My Family','Friends',100005),(200006,'Microsoft Groupies','Friends',100006),(200007,'WOWers','Game',100012),(200008,'Apartment Union','Neighbors',100013),(200009,'Agents','Work',100014),(200010,'Google Interns','Interns',100015),(200011,'Sys group','SYS',100021);
/*!40000 ALTER TABLE `WithFriends_Groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `WithFriends_GroupsMembers`
--

DROP TABLE IF EXISTS `WithFriends_GroupsMembers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `WithFriends_GroupsMembers` (
  `GroupId` int(11) NOT NULL,
  `UserId` int(11) NOT NULL,
  PRIMARY KEY (`GroupId`,`UserId`),
  KEY `UserId` (`UserId`),
  CONSTRAINT `withfriends_groupsmembers_ibfk_1` FOREIGN KEY (`GroupId`) REFERENCES `WithFriends_Groups` (`GroupId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `withfriends_groupsmembers_ibfk_2` FOREIGN KEY (`UserId`) REFERENCES `WithFriends_Users` (`UserId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `WithFriends_GroupsMembers`
--

LOCK TABLES `WithFriends_GroupsMembers` WRITE;
/*!40000 ALTER TABLE `WithFriends_GroupsMembers` DISABLE KEYS */;
INSERT INTO `WithFriends_GroupsMembers` VALUES (200001,100001),(200004,100001),(200001,100002),(200001,100003),(200003,100003),(200004,100004),(200003,100005),(200005,100005),(200001,100006),(200004,100010),(200004,100013),(200005,100017),(200005,100020),(200011,100021);
/*!40000 ALTER TABLE `WithFriends_GroupsMembers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `WithFriends_LikeComment`
--

DROP TABLE IF EXISTS `WithFriends_LikeComment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `WithFriends_LikeComment` (
  `UserId` int(11) NOT NULL,
  `CommentId` int(11) NOT NULL,
  PRIMARY KEY (`UserId`,`CommentId`),
  KEY `CommentId` (`CommentId`),
  CONSTRAINT `withfriends_likecomment_ibfk_1` FOREIGN KEY (`UserId`) REFERENCES `WithFriends_Users` (`UserId`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `withfriends_likecomment_ibfk_2` FOREIGN KEY (`CommentId`) REFERENCES `WithFriends_Comments` (`CommentId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `WithFriends_LikeComment`
--

LOCK TABLES `WithFriends_LikeComment` WRITE;
/*!40000 ALTER TABLE `WithFriends_LikeComment` DISABLE KEYS */;
INSERT INTO `WithFriends_LikeComment` VALUES (100002,500001),(100003,500001),(100004,500001),(100006,500001),(100008,500001),(100005,500002),(100007,500002),(100001,500004),(100009,500005),(100010,500007);
/*!40000 ALTER TABLE `WithFriends_LikeComment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `WithFriends_LikePost`
--

DROP TABLE IF EXISTS `WithFriends_LikePost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `WithFriends_LikePost` (
  `UserId` int(11) NOT NULL,
  `PostId` int(11) NOT NULL,
  PRIMARY KEY (`UserId`,`PostId`),
  KEY `PostId` (`PostId`),
  CONSTRAINT `withfriends_likepost_ibfk_1` FOREIGN KEY (`UserId`) REFERENCES `WithFriends_Users` (`UserId`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `withfriends_likepost_ibfk_2` FOREIGN KEY (`PostId`) REFERENCES `WithFriends_Posts` (`PostId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `WithFriends_LikePost`
--

LOCK TABLES `WithFriends_LikePost` WRITE;
/*!40000 ALTER TABLE `WithFriends_LikePost` DISABLE KEYS */;
INSERT INTO `WithFriends_LikePost` VALUES (100001,400001),(100002,400001),(100004,400001),(100009,400001),(100010,400001),(100003,400002),(100008,400002),(100005,400003),(100007,400003),(100006,400004);
/*!40000 ALTER TABLE `WithFriends_LikePost` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `WithFriends_Logins`
--

DROP TABLE IF EXISTS `WithFriends_Logins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `WithFriends_Logins` (
  `LoginInId` int(11) NOT NULL,
  PRIMARY KEY (`LoginInId`),
  CONSTRAINT `withfriends_logins_ibfk_1` FOREIGN KEY (`LoginInId`) REFERENCES `WithFriends_Users` (`UserId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `WithFriends_Logins`
--

LOCK TABLES `WithFriends_Logins` WRITE;
/*!40000 ALTER TABLE `WithFriends_Logins` DISABLE KEYS */;
INSERT INTO `WithFriends_Logins` VALUES (100031);
/*!40000 ALTER TABLE `WithFriends_Logins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `WithFriends_Messages`
--

DROP TABLE IF EXISTS `WithFriends_Messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `WithFriends_Messages` (
  `MessageId` int(11) NOT NULL,
  `SentDate` date DEFAULT NULL,
  `Subject` varchar(50) DEFAULT NULL,
  `Content` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`MessageId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `WithFriends_Messages`
--

LOCK TABLES `WithFriends_Messages` WRITE;
/*!40000 ALTER TABLE `WithFriends_Messages` DISABLE KEYS */;
INSERT INTO `WithFriends_Messages` VALUES (600001,'2016-11-17','System Msg','Content#1'),(600002,'2016-11-17','System Msg','Content#2'),(600003,'2016-11-17','System Msg','Content#3'),(600004,'2016-11-17','System Msg','Content#4'),(600005,'2016-11-17','System Msg','Content#5'),(600006,'2016-11-17','System Msg','Content#6'),(600007,'2016-11-17','System Msg','Content#7'),(600008,'2016-11-17','System Msg','Content#8'),(600009,'2016-11-17','System Msg','Content#9'),(600010,'2016-11-17','System Msg','Content#10'),(600011,'2016-11-17','System Msg','Content#11');
/*!40000 ALTER TABLE `WithFriends_Messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `WithFriends_MessagesSent`
--

DROP TABLE IF EXISTS `WithFriends_MessagesSent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `WithFriends_MessagesSent` (
  `MessageId` int(11) NOT NULL,
  `SenderId` int(11) NOT NULL,
  `ReceiverId` int(11) NOT NULL,
  PRIMARY KEY (`MessageId`,`SenderId`,`ReceiverId`),
  KEY `SenderId` (`SenderId`),
  KEY `ReceiverId` (`ReceiverId`),
  CONSTRAINT `withfriends_messagessent_ibfk_1` FOREIGN KEY (`MessageId`) REFERENCES `WithFriends_Messages` (`MessageId`),
  CONSTRAINT `withfriends_messagessent_ibfk_2` FOREIGN KEY (`SenderId`) REFERENCES `WithFriends_Users` (`UserId`),
  CONSTRAINT `withfriends_messagessent_ibfk_3` FOREIGN KEY (`ReceiverId`) REFERENCES `WithFriends_Users` (`UserId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `WithFriends_MessagesSent`
--

LOCK TABLES `WithFriends_MessagesSent` WRITE;
/*!40000 ALTER TABLE `WithFriends_MessagesSent` DISABLE KEYS */;
INSERT INTO `WithFriends_MessagesSent` VALUES (600001,100001,100002),(600002,100001,100003),(600006,100002,100005),(600003,100004,100002),(600005,100004,100007),(600008,100004,100009),(600004,100005,100001),(600010,100005,100004),(600007,100008,100002),(600009,100010,100001);
/*!40000 ALTER TABLE `WithFriends_MessagesSent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `WithFriends_Pages`
--

DROP TABLE IF EXISTS `WithFriends_Pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `WithFriends_Pages` (
  `PageId` int(11) NOT NULL,
  `OwnerId` int(11) DEFAULT NULL,
  `GroupId` int(11) DEFAULT NULL,
  `PostCount` int(11) DEFAULT NULL,
  `PageType` char(5) DEFAULT NULL,
  PRIMARY KEY (`PageId`),
  KEY `OwnerId` (`OwnerId`),
  KEY `GroupId` (`GroupId`),
  CONSTRAINT `withfriends_pages_ibfk_1` FOREIGN KEY (`OwnerId`) REFERENCES `WithFriends_Users` (`UserId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `withfriends_pages_ibfk_2` FOREIGN KEY (`GroupId`) REFERENCES `WithFriends_Groups` (`GroupId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `WithFriends_Pages`
--

LOCK TABLES `WithFriends_Pages` WRITE;
/*!40000 ALTER TABLE `WithFriends_Pages` DISABLE KEYS */;
INSERT INTO `WithFriends_Pages` VALUES (300001,100001,NULL,0,'User'),(300002,100002,NULL,0,'User'),(300003,100003,NULL,0,'User'),(300004,100004,NULL,0,'User'),(300005,100005,NULL,0,'User'),(300006,NULL,200001,0,'Group'),(300007,NULL,200002,0,'Group'),(300008,NULL,200003,0,'Group'),(300009,NULL,200004,0,'Group'),(300010,NULL,200005,0,'Group'),(300011,NULL,200011,0,'Group'),(300012,100031,NULL,0,'User');
/*!40000 ALTER TABLE `WithFriends_Pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `WithFriends_Posts`
--

DROP TABLE IF EXISTS `WithFriends_Posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `WithFriends_Posts` (
  `PostId` int(11) NOT NULL,
  `PosterId` int(11) DEFAULT NULL,
  `PageId` int(11) DEFAULT NULL,
  `PostDate` date DEFAULT NULL,
  `Content` varchar(2000) DEFAULT NULL,
  `CommentCount` int(11) DEFAULT NULL,
  PRIMARY KEY (`PostId`),
  KEY `PosterId` (`PosterId`),
  KEY `PageId` (`PageId`),
  CONSTRAINT `withfriends_posts_ibfk_1` FOREIGN KEY (`PosterId`) REFERENCES `WithFriends_Users` (`UserId`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `withfriends_posts_ibfk_2` FOREIGN KEY (`PageId`) REFERENCES `WithFriends_Pages` (`PageId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `WithFriends_Posts`
--

LOCK TABLES `WithFriends_Posts` WRITE;
/*!40000 ALTER TABLE `WithFriends_Posts` DISABLE KEYS */;
INSERT INTO `WithFriends_Posts` VALUES (400001,100001,300006,'2016-11-15','Hey guys, I\'m Michael Collins. The number one rule about this group: Michael is the king, Thinks!',0),(400002,100001,300006,'2016-11-15','This is the second post, just want to make sure it works.',0),(400003,100002,300006,'2016-11-15','This is Aria, I think CSE 320 is hard. Can somebody give me some advice.',0),(400004,100003,300006,'2016-11-15','Does anyboby selling a laptop?',0),(400005,100004,300004,'2016-11-15','Hey, I\'m Ellie, just registered for WithFriends and it\'s absolutely amazing',0),(400006,100004,300004,'2016-11-15','I only got 50 on the midterm, OMG, I\'m failing',0),(400007,100010,300009,'2016-11-15','I\'m Kylie, Does anyone know the requirements to get in CSE major?',0),(400008,100001,300009,'2016-11-15','Aced Google\'s interview today, really easy',0),(400009,100013,300009,'2016-11-15','What\'s the workload of CSE381 like? I\'m really interested in game programming.',0),(400010,100004,300009,'2016-11-15','My schedule for the next semester is : CSE 219, CSE 220, CSE 320, CSE 306, is it doable?',0),(400011,100031,300012,'2016-11-17','Post a msg for project phase 2',0);
/*!40000 ALTER TABLE `WithFriends_Posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `WithFriends_Sales`
--

DROP TABLE IF EXISTS `WithFriends_Sales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `WithFriends_Sales` (
  `TransactionId` int(11) NOT NULL,
  `SalesDate` datetime DEFAULT NULL,
  `ADId` int(11) DEFAULT NULL,
  `Units` int(11) DEFAULT NULL,
  `AccountNumber` int(11) DEFAULT NULL,
  PRIMARY KEY (`TransactionId`),
  KEY `ADId` (`ADId`),
  KEY `AccountNumber` (`AccountNumber`),
  CONSTRAINT `withfriends_sales_ibfk_1` FOREIGN KEY (`ADId`) REFERENCES `WithFriends_Advertisements` (`ADId`),
  CONSTRAINT `withfriends_sales_ibfk_2` FOREIGN KEY (`AccountNumber`) REFERENCES `WithFriends_Users` (`AccountNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `WithFriends_Sales`
--

LOCK TABLES `WithFriends_Sales` WRITE;
/*!40000 ALTER TABLE `WithFriends_Sales` DISABLE KEYS */;
INSERT INTO `WithFriends_Sales` VALUES (110001,'2016-11-17 23:23:23',800001,10,900001),(110002,'2016-11-17 23:23:23',800002,12,900002),(110003,'2016-11-17 23:23:23',800003,15,900003),(110004,'2016-11-17 23:23:23',800004,40,900004),(110005,'2016-11-17 23:23:23',800005,30,900005),(110006,'2016-11-17 23:23:23',800006,60,900006),(110007,'2016-11-17 23:23:23',800007,110,900007),(110008,'2016-11-17 23:23:23',800008,13,900008),(110009,'2016-11-17 23:23:23',800009,53,900009),(110010,'2016-11-17 23:23:23',800010,12,900010),(110011,'2016-11-17 23:23:23',800006,1,900002),(110012,'2016-11-17 23:23:23',800007,1,900002),(110013,'2016-11-17 23:23:23',800008,5,900002),(110014,'2016-11-17 23:23:23',800011,3,900010),(110015,'2016-11-17 23:23:23',800012,100,900010),(110016,'2016-11-18 23:23:23',800012,12,900012),(110017,'2016-11-17 23:23:23',800013,16,900004),(110018,'2016-11-17 23:23:23',800013,8,900007),(110019,'2016-11-17 23:23:23',800013,6,900013);
/*!40000 ALTER TABLE `WithFriends_Sales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `WithFriends_Users`
--

DROP TABLE IF EXISTS `WithFriends_Users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `WithFriends_Users` (
  `UserId` int(11) NOT NULL,
  `FirstName` varchar(20) DEFAULT NULL,
  `LastName` varchar(20) DEFAULT NULL,
  `sex` char(1) DEFAULT NULL,
  `EmailID` varchar(50) DEFAULT NULL,
  `PWD` varchar(20) DEFAULT NULL,
  `DOB` date DEFAULT NULL,
  `Address` varchar(50) DEFAULT NULL,
  `City` varchar(20) DEFAULT NULL,
  `State` varchar(20) DEFAULT NULL,
  `ZipCode` int(11) DEFAULT NULL,
  `Telephone` int(11) DEFAULT NULL,
  `AccountNumber` int(11) DEFAULT NULL,
  `AccountCreationDate` date DEFAULT NULL,
  `CreditCardNumber` int(11) DEFAULT NULL,
  `Preference` varchar(150) DEFAULT NULL,
  `Ratings` int(11) DEFAULT NULL,
  PRIMARY KEY (`UserId`),
  UNIQUE KEY `AccountNumber` (`AccountNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `WithFriends_Users`
--

LOCK TABLES `WithFriends_Users` WRITE;
/*!40000 ALTER TABLE `WithFriends_Users` DISABLE KEYS */;
INSERT INTO `WithFriends_Users` VALUES (100001,'Michael','Collins','M','Michael.Collins@cse305.stonybrook.edu','care2cash','1997-03-14',NULL,'Washington','DC',12345,228807080,900001,'2016-11-15',NULL,'Slacklining,Skateboarding,Surfing,Orienteering,Water sports',NULL),(100002,'Aria','Rose','F','Aria.Rose@cse305.stonybrook.edu','dawn4call','1991-05-11',NULL,'New York','NY',10001,263303749,900002,'2016-11-15',NULL,'Topiary,Jogging',NULL),(100003,'Jase','Black','M','Jase.Black@cse305.stonybrook.edu','data6bell','2012-04-26',NULL,'Washington','DC',12345,917443776,900003,'2016-11-15',NULL,'Rugby,Roller skating,Life insurance,Rock climbing,Scouting',NULL),(100004,'Ellie','Franklin','F','Ellie.Franklin@cse305.stonybrook.edu','ablelcash','2009-03-09',NULL,'Stony Brook','NY',11794,381870672,900004,'2016-11-15',NULL,'Cars,Skydiving,Bird watching,Sailing,Shopping,Skimboarding,Kayaking,Camping,Blacksmithing',NULL),(100005,'Mackenzie','Wells','F','Mackenzie.Wells@cse305.stonybrook.edu','burn2coat','2004-09-14',NULL,'New York','NY',10001,736594241,900005,'2016-11-15',NULL,'Hunting,Topiary,Nordic skating,Foraging,Metal detecting,Camping,Astronomy',NULL),(100006,'Cameron','Armstrong','M','Cameron.Armstrong@cse305.stonybrook.edu','aged6area','2010-08-14',NULL,'New York','NY',10001,182209299,900006,'2016-11-15',NULL,'Skydiving,Topiary,Scuba diving,Sailing,Beekeeping,Tai chi,Brazilian jiu-jitsu,Astronomy,Jogging',NULL),(100007,'Levi','Ross','M','Levi.Ross@cse305.stonybrook.edu','been7beer','1991-06-07',NULL,'Stony Brook','NY',11794,127536938,900007,'2016-11-15',NULL,'Urban exploration,Freestyle football',NULL),(100008,'Levi','West','M','Levi.West@cse305.stonybrook.edu','coal3cell','2011-02-09',NULL,'New York','NY',10001,699136094,900008,'2016-11-15',NULL,'BASE jumping,Letterboxing,Roller skating,Metal detecting,Swimming,Mountaineering,\n    Sculling or Rowing,Basketball,Surfing',NULL),(100009,'Christian','Davies','M','Christian.Davies@cse305.stonybrook.edu','bush1bone','2011-05-10',NULL,'Stony Brook','NY',11794,364390765,900009,'2016-11-15',NULL,'BASE jumping,Driving,Mountaineering',NULL),(100010,'Kylie','Davies','F','Kylie.Davies@cse305.stonybrook.edu','coat7calm','1996-11-22',NULL,'New York','NY',10001,562348521,900010,'2016-11-15',NULL,'Toys,Graffiti,Skiing,Road biking,Kayaking',NULL),(100011,'Tyler','Long','M','Tyler.Long@cse305.stonybrook.edu','area3boom','2007-01-08',NULL,'Stony Brook','NY',11794,306139234,900011,'2016-11-15',NULL,'Topiary,Basketball',NULL),(100012,'Henry','Stewart','M','Henry.Stewart@cse305.stonybrook.edu','boat3also','2006-02-11',NULL,'Washington','DC',12345,503422119,900012,'2016-11-15',NULL,'Roller skating,Netball,Flag football,Water sports',NULL),(100013,'Isaiah','Bennett','M','Isaiah.Bennett@cse305.stonybrook.edu','book6bank','1997-12-24',NULL,'Washington','DC',12345,929342276,900013,'2016-11-15',NULL,'Walking,Baseball,Scuba diving,Running,Shopping',NULL),(100014,'Arianna','Dunn','F','Arianna.Dunn@cse305.stonybrook.edu','chip2calm','2003-01-27',NULL,'New York','NY',10001,311083148,900014,'2016-11-15',NULL,'Shooting,Ghost hunting,Horseback riding,Netball,Astronomy',NULL),(100015,'Victoria','Powell','F','Victoria.Powell@cse305.stonybrook.edu','cash7bush','1997-04-28',NULL,'New York','NY',10001,854902993,900015,'2016-11-15',NULL,'LARPing,Walking,Slacklining,Foraging,Rock climbing,Taekwondo,Inline skating',NULL),(100016,'Blakely','Alexander','F','Blakely.Alexander@cse305.stonybrook.edu','bear3cope','2006-01-21',NULL,'Washington','DC',12345,140361398,900016,'2016-11-15',NULL,'Hooping,Bird watching,Shooting,Board sports,Graffiti,Sculling or Rowing',NULL),(100017,'Connor','Collins','M','Connor.Collins@cse305.stonybrook.edu','ball1days','2005-06-23',NULL,'New York','NY',10001,282433780,900017,'2016-11-15',NULL,'Rugby,Skiing,Snowboarding,Rock climbing,Swimming,Skimboarding,Scouting',NULL),(100018,'Jeremiah','Miller','M','Jeremiah.Miller@cse305.stonybrook.edu','code3case','1999-11-29',NULL,'New York','NY',10001,533130991,900018,'2016-11-15',NULL,'Urban exploration,Roller skating,Bird watching,Skiing,Kayaking,Mushroom hunting/Mycology',NULL),(100019,'Riley','Field','F','Riley.Field@cse305.stonybrook.edu','cash7born','2003-05-03',NULL,'New York','NY',10001,477174572,900019,'2016-11-15',NULL,'Photography,LARPing,Shooting,Archery,Kayaking,Fishing ,Astronomy',NULL),(100020,'Lucy','Phillips','F','Lucy.Phillips@cse305.stonybrook.edu','away2bath','1996-07-25',NULL,'New York','NY',10001,995652638,900020,'2016-11-15',NULL,'Parkour,Rock climbing,Handball,Surfing',NULL),(100021,'Empoyee#1','Sys#1','M','sys1@cse305.stonybrook.edu','admin1','1993-10-28',NULL,'New York','NY',10001,111111111,900021,'2016-11-15',NULL,'Managing Stuff',NULL),(100022,'Empoyee#2','Sys#2','M','sys2@cse305.stonybrook.edu','admin2','1993-10-28',NULL,'New York','NY',10001,111111111,900022,'2016-11-15',NULL,'Managing Stuff',NULL),(100023,'Empoyee#3','Sys#3','M','sys3@cse305.stonybrook.edu','admin3','1993-10-28',NULL,'New York','NY',10001,111111111,900023,'2016-11-15',NULL,'Managing Stuff',NULL),(100024,'Empoyee#4','Sys#4','M','sys4@cse305.stonybrook.edu','admin4','1993-10-28',NULL,'New York','NY',10001,111111111,900024,'2016-11-15',NULL,'Managing Stuff',NULL),(100025,'Empoyee#5','Sys#5','M','sys5@cse305.stonybrook.edu','admin5','1993-10-28',NULL,'New York','NY',10001,111111111,900025,'2016-11-15',NULL,'Managing Stuff',NULL),(100026,'Empoyee#6','Sys#6','M','sys6@cse305.stonybrook.edu','admin6','1993-10-28',NULL,'New York','NY',10001,111111111,900026,'2016-11-15',NULL,'Managing Stuff',NULL),(100027,'Empoyee#7','Sys#7','M','sys7@cse305.stonybrook.edu','admin7','1993-10-28',NULL,'New York','NY',10001,111111111,900027,'2016-11-15',NULL,'Managing Stuff',NULL),(100028,'Empoyee#8','Sys#8','M','sys8@cse305.stonybrook.edu','admin8','1993-10-28',NULL,'New York','NY',10001,111111111,900028,'2016-11-15',NULL,'Managing Stuff',NULL),(100029,'Empoyee#9','Sys#9','M','sys9@cse305.stonybrook.edu','admin9','1993-10-28',NULL,'New York','NY',10001,111111111,900029,'2016-11-15',NULL,'Managing Stuff',NULL),(100030,'Empoyee#10','Sys#10','M','sys10@cse305.stonybrook.edu','admin10','1993-10-28',NULL,'New York','NY',10001,111111111,900030,'2016-11-15',NULL,'Managing Stuff',NULL),(100031,'NewUser#1','Phase2','M','newuser#1@cse305.stonybrook.edu','admin11','1993-10-28',NULL,'New York','NY',10001,111111111,900031,'2016-11-18',NULL,'Register a new user for project phase 2',NULL);
/*!40000 ALTER TABLE `WithFriends_Users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `WithFriends_UsersFriends`
--

DROP TABLE IF EXISTS `WithFriends_UsersFriends`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `WithFriends_UsersFriends` (
  `UserId` int(11) NOT NULL,
  `FriendId` int(11) NOT NULL,
  PRIMARY KEY (`UserId`,`FriendId`),
  KEY `FriendId` (`FriendId`),
  CONSTRAINT `withfriends_usersfriends_ibfk_1` FOREIGN KEY (`UserId`) REFERENCES `WithFriends_Users` (`UserId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `withfriends_usersfriends_ibfk_2` FOREIGN KEY (`FriendId`) REFERENCES `WithFriends_Users` (`UserId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `WithFriends_UsersFriends`
--

LOCK TABLES `WithFriends_UsersFriends` WRITE;
/*!40000 ALTER TABLE `WithFriends_UsersFriends` DISABLE KEYS */;
INSERT INTO `WithFriends_UsersFriends` VALUES (100010,100011),(100009,100012),(100008,100013),(100007,100014),(100006,100015),(100005,100016),(100004,100017),(100003,100018),(100002,100019),(100001,100020);
/*!40000 ALTER TABLE `WithFriends_UsersFriends` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `all_employee_id`
--

DROP TABLE IF EXISTS `all_employee_id`;
/*!50001 DROP VIEW IF EXISTS `all_employee_id`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `all_employee_id` AS SELECT 
 1 AS `EmployeeId`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `all_items`
--

DROP TABLE IF EXISTS `all_items`;
/*!50001 DROP VIEW IF EXISTS `all_items`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `all_items` AS SELECT 
 1 AS `Company`,
 1 AS `ItemName`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `best_seller`
--

DROP TABLE IF EXISTS `best_seller`;
/*!50001 DROP VIEW IF EXISTS `best_seller`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `best_seller` AS SELECT 
 1 AS `SellerId`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `cus_groupid`
--

DROP TABLE IF EXISTS `cus_groupid`;
/*!50001 DROP VIEW IF EXISTS `cus_groupid`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `cus_groupid` AS SELECT 
 1 AS `GroupId`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `customer_revenue`
--

DROP TABLE IF EXISTS `customer_revenue`;
/*!50001 DROP VIEW IF EXISTS `customer_revenue`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `customer_revenue` AS SELECT 
 1 AS `Customer`,
 1 AS `Revenue`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!50001 DROP VIEW IF EXISTS `customers`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `customers` AS SELECT 
 1 AS `CustomerId`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `customers_acc`
--

DROP TABLE IF EXISTS `customers_acc`;
/*!50001 DROP VIEW IF EXISTS `customers_acc`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `customers_acc` AS SELECT 
 1 AS `CustomerId`,
 1 AS `Acc`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `revenue_by_customer`
--

DROP TABLE IF EXISTS `revenue_by_customer`;
/*!50001 DROP VIEW IF EXISTS `revenue_by_customer`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `revenue_by_customer` AS SELECT 
 1 AS `FirstName`,
 1 AS `LastName`,
 1 AS `Revenue`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `revenue_by_item`
--

DROP TABLE IF EXISTS `revenue_by_item`;
/*!50001 DROP VIEW IF EXISTS `revenue_by_item`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `revenue_by_item` AS SELECT 
 1 AS `ItemName`,
 1 AS `Revenue`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `revenue_by_itemtype`
--

DROP TABLE IF EXISTS `revenue_by_itemtype`;
/*!50001 DROP VIEW IF EXISTS `revenue_by_itemtype`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `revenue_by_itemtype` AS SELECT 
 1 AS `ItemName`,
 1 AS `Revenue`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `salesreport`
--

DROP TABLE IF EXISTS `salesreport`;
/*!50001 DROP VIEW IF EXISTS `salesreport`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `salesreport` AS SELECT 
 1 AS `TransactionId`,
 1 AS `ItemName`,
 1 AS `UnitPrice`,
 1 AS `units`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `seller_chart`
--

DROP TABLE IF EXISTS `seller_chart`;
/*!50001 DROP VIEW IF EXISTS `seller_chart`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `seller_chart` AS SELECT 
 1 AS `Seller`,
 1 AS `TotalSell`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `suggest_item`
--

DROP TABLE IF EXISTS `suggest_item`;
/*!50001 DROP VIEW IF EXISTS `suggest_item`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `suggest_item` AS SELECT 
 1 AS `ItemName`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `trans_by_item`
--

DROP TABLE IF EXISTS `trans_by_item`;
/*!50001 DROP VIEW IF EXISTS `trans_by_item`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `trans_by_item` AS SELECT 
 1 AS `TransId`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `trans_by_user`
--

DROP TABLE IF EXISTS `trans_by_user`;
/*!50001 DROP VIEW IF EXISTS `trans_by_user`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `trans_by_user` AS SELECT 
 1 AS `TransId`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `all_employee_id`
--

/*!50001 DROP VIEW IF EXISTS `all_employee_id`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `all_employee_id` AS select `withfriends_employees`.`EmployeeId` AS `EmployeeId` from `withfriends_employees` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `all_items`
--

/*!50001 DROP VIEW IF EXISTS `all_items`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `all_items` AS select distinct `A`.`Company` AS `Company`,`A`.`ItemName` AS `ItemName` from `withfriends_advertisements` `A` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `best_seller`
--

/*!50001 DROP VIEW IF EXISTS `best_seller`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `best_seller` AS select `seller_chart`.`Seller` AS `SellerId` from `seller_chart` order by `seller_chart`.`TotalSell` desc limit 1 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `cus_groupid`
--

/*!50001 DROP VIEW IF EXISTS `cus_groupid`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `cus_groupid` AS select `withfriends_groupsmembers`.`GroupId` AS `GroupId` from `withfriends_groupsmembers` where (`withfriends_groupsmembers`.`UserId` = 100005) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `customer_revenue`
--

/*!50001 DROP VIEW IF EXISTS `customer_revenue`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `customer_revenue` AS select `c`.`CustomerId` AS `Customer`,sum((`A`.`UnitPrice` * `S`.`Units`)) AS `Revenue` from ((`withfriends_advertisements` `A` join `withfriends_sales` `S`) join `customers_acc` `C`) where ((`A`.`ADId` = `S`.`ADId`) and (`S`.`AccountNumber` = `c`.`Acc`)) group by `c`.`CustomerId` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `customers`
--

/*!50001 DROP VIEW IF EXISTS `customers`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `customers` AS select distinct `U`.`UserId` AS `CustomerId` from (`withfriends_sales` `S` join `withfriends_users` `U`) where (`S`.`AccountNumber` = `U`.`AccountNumber`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `customers_acc`
--

/*!50001 DROP VIEW IF EXISTS `customers_acc`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `customers_acc` AS select distinct `U`.`UserId` AS `CustomerId`,`U`.`AccountNumber` AS `Acc` from (`withfriends_sales` `S` join `withfriends_users` `U`) where (`S`.`AccountNumber` = `U`.`AccountNumber`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `revenue_by_customer`
--

/*!50001 DROP VIEW IF EXISTS `revenue_by_customer`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `revenue_by_customer` AS select distinct `U`.`FirstName` AS `FirstName`,`U`.`LastName` AS `LastName`,(`S`.`Units` * `A`.`UnitPrice`) AS `Revenue` from ((`withfriends_sales` `S` join `withfriends_advertisements` `A`) join `withfriends_users` `U`) where ((`S`.`AccountNumber` = `U`.`AccountNumber`) and (`S`.`ADId` = `A`.`ADId`) and (`U`.`FirstName` = 'Michael') and (`U`.`LastName` = 'Collins')) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `revenue_by_item`
--

/*!50001 DROP VIEW IF EXISTS `revenue_by_item`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `revenue_by_item` AS select distinct `A`.`ItemName` AS `ItemName`,(`S`.`Units` * `A`.`UnitPrice`) AS `Revenue` from (`withfriends_sales` `S` join `withfriends_advertisements` `A`) where ((`S`.`ADId` = `A`.`ADId`) and (`A`.`ItemName` = 'Surface Pro')) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `revenue_by_itemtype`
--

/*!50001 DROP VIEW IF EXISTS `revenue_by_itemtype`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `revenue_by_itemtype` AS select `A`.`Type` AS `ItemName`,(`S`.`Units` * `A`.`UnitPrice`) AS `Revenue` from (`withfriends_sales` `S` join `withfriends_advertisements` `A`) where ((`S`.`ADId` = `A`.`ADId`) and (`A`.`Type` = 'Commercial')) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `salesreport`
--

/*!50001 DROP VIEW IF EXISTS `salesreport`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `salesreport` AS select distinct `S`.`TransactionId` AS `TransactionId`,`A`.`ItemName` AS `ItemName`,`A`.`UnitPrice` AS `UnitPrice`,`S`.`Units` AS `units` from ((`withfriends`.`withfriends_sales` `S` join `withfriends`.`withfriends_advertisements` `A`) join (select extract(month from `withfriends`.`withfriends_sales`.`SalesDate`) AS `SaleMonth` from `withfriends`.`withfriends_sales`) `M`) where ((`S`.`ADId` = `A`.`ADId`) and (`m`.`SaleMonth` = 11)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `seller_chart`
--

/*!50001 DROP VIEW IF EXISTS `seller_chart`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `seller_chart` AS select `A`.`EmployeeId` AS `Seller`,sum((`A`.`UnitPrice` * `S`.`Units`)) AS `TotalSell` from (`withfriends_advertisements` `A` join `withfriends_sales` `S`) where (`A`.`ADId` = `S`.`ADId`) group by `A`.`EmployeeId` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `suggest_item`
--

/*!50001 DROP VIEW IF EXISTS `suggest_item`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `suggest_item` AS select distinct `A`.`ItemName` AS `ItemName` from ((`withfriends_advertisements` `A` join `customers_acc` `C`) join `withfriends_sales` `S`) where ((`c`.`CustomerId` = 100002) and (`c`.`Acc` = `S`.`AccountNumber`) and (`S`.`ADId` = `A`.`ADId`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `trans_by_item`
--

/*!50001 DROP VIEW IF EXISTS `trans_by_item`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `trans_by_item` AS select distinct `S`.`TransactionId` AS `TransId` from (`withfriends_sales` `S` join `withfriends_advertisements` `A`) where ((`S`.`ADId` = `A`.`ADId`) and (`A`.`ItemName` = 'MacBook Pro')) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `trans_by_user`
--

/*!50001 DROP VIEW IF EXISTS `trans_by_user`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `trans_by_user` AS select distinct `S`.`TransactionId` AS `TransId` from (`withfriends_sales` `S` join `withfriends_users` `U`) where ((`S`.`AccountNumber` = `U`.`AccountNumber`) and (`U`.`FirstName` = 'Michael') and (`U`.`LastName` = 'Collins')) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-11-18 23:17:13
