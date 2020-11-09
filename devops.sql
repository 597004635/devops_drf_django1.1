-- MySQL dump 10.13  Distrib 5.6.46, for Linux (x86_64)
--
-- Host: localhost    Database: devops
-- ------------------------------------------------------
-- Server version	5.6.46

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
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
INSERT INTO `auth_group` VALUES (1,'研发一组'),(2,'运维部');
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
INSERT INTO `auth_group_permissions` VALUES (2,2,6),(7,2,472),(6,2,473),(8,2,474),(9,2,475),(10,2,476),(11,2,477),(3,2,478),(4,2,479),(5,2,480);
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=481 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add permission',1,'add_permission'),(2,'Can change permission',1,'change_permission'),(3,'Can delete permission',1,'delete_permission'),(4,'Can add group',2,'add_group'),(5,'Can change group',2,'change_group'),(6,'Can delete group',2,'delete_group'),(7,'Can add content type',3,'add_contenttype'),(8,'Can change content type',3,'change_contenttype'),(9,'Can delete content type',3,'delete_contenttype'),(10,'Can add 用户',4,'add_user'),(11,'Can change 用户',4,'change_user'),(12,'Can delete 用户',4,'delete_user'),(13,'can view user',4,'view_user'),(14,'Can add session',5,'add_session'),(15,'Can change session',5,'change_session'),(16,'Can delete session',5,'delete_session'),(17,'Can add menu',6,'add_menu'),(18,'Can change menu',6,'change_menu'),(19,'Can delete menu',6,'delete_menu'),(20,'Can add product',7,'add_product'),(21,'Can change product',7,'change_product'),(22,'Can delete product',7,'delete_product'),(23,'can view products',7,'view_product'),(24,'Can add idc',8,'add_idc'),(25,'Can change idc',8,'change_idc'),(26,'Can delete idc',8,'delete_idc'),(27,'cat view idc',8,'view_idc'),(28,'Can add ip',9,'add_ip'),(29,'Can change ip',9,'change_ip'),(30,'Can delete ip',9,'delete_ip'),(31,'cat view ip',9,'view_ip'),(32,'Can add server',10,'add_server'),(33,'Can change server',10,'change_server'),(34,'Can delete server',10,'delete_server'),(35,'cat view server',10,'view_server'),(36,'Can add manufacturer',11,'add_manufacturer'),(37,'Can change manufacturer',11,'change_manufacturer'),(38,'Can delete manufacturer',11,'delete_manufacturer'),(39,'cat view manufacturer',11,'view_manufacturer'),(40,'Can add product model',12,'add_productmodel'),(41,'Can change product model',12,'change_productmodel'),(42,'Can delete product model',12,'delete_productmodel'),(43,'cat view productmodel',12,'view_productmodel'),(44,'Can add cabinet',13,'add_cabinet'),(45,'Can change cabinet',13,'change_cabinet'),(46,'Can delete cabinet',13,'delete_cabinet'),(47,'cat view cabinet',13,'view_cabinet'),(48,'Can add network device',14,'add_networkdevice'),(49,'Can change network device',14,'change_networkdevice'),(50,'Can delete network device',14,'delete_networkdevice'),(51,'cat view networkdevice',14,'view_networkdevice'),(52,'Can add acknowledges',15,'add_acknowledges'),(53,'Can change acknowledges',15,'change_acknowledges'),(54,'Can delete acknowledges',15,'delete_acknowledges'),(55,'Can add actions',16,'add_actions'),(56,'Can change actions',16,'change_actions'),(57,'Can delete actions',16,'delete_actions'),(58,'Can add alerts',17,'add_alerts'),(59,'Can change alerts',17,'change_alerts'),(60,'Can delete alerts',17,'delete_alerts'),(61,'Can add application discovery',18,'add_applicationdiscovery'),(62,'Can change application discovery',18,'change_applicationdiscovery'),(63,'Can delete application discovery',18,'delete_applicationdiscovery'),(64,'Can add application prototype',19,'add_applicationprototype'),(65,'Can change application prototype',19,'change_applicationprototype'),(66,'Can delete application prototype',19,'delete_applicationprototype'),(67,'Can add applications',20,'add_applications'),(68,'Can change applications',20,'change_applications'),(69,'Can delete applications',20,'delete_applications'),(70,'Can add application template',21,'add_applicationtemplate'),(71,'Can change application template',21,'change_applicationtemplate'),(72,'Can delete application template',21,'delete_applicationtemplate'),(73,'Can add auditlog',22,'add_auditlog'),(74,'Can change auditlog',22,'change_auditlog'),(75,'Can delete auditlog',22,'delete_auditlog'),(76,'Can add auditlog details',23,'add_auditlogdetails'),(77,'Can change auditlog details',23,'change_auditlogdetails'),(78,'Can delete auditlog details',23,'delete_auditlogdetails'),(79,'Can add autoreg host',24,'add_autoreghost'),(80,'Can change autoreg host',24,'change_autoreghost'),(81,'Can delete autoreg host',24,'delete_autoreghost'),(82,'Can add conditions',25,'add_conditions'),(83,'Can change conditions',25,'change_conditions'),(84,'Can delete conditions',25,'delete_conditions'),(85,'Can add config',26,'add_config'),(86,'Can change config',26,'change_config'),(87,'Can delete config',26,'delete_config'),(88,'Can add correlation',27,'add_correlation'),(89,'Can change correlation',27,'change_correlation'),(90,'Can delete correlation',27,'delete_correlation'),(91,'Can add corr operation',28,'add_corroperation'),(92,'Can change corr operation',28,'change_corroperation'),(93,'Can delete corr operation',28,'delete_corroperation'),(94,'Can add dashboard',29,'add_dashboard'),(95,'Can change dashboard',29,'change_dashboard'),(96,'Can delete dashboard',29,'delete_dashboard'),(97,'Can add dashboard user',30,'add_dashboarduser'),(98,'Can change dashboard user',30,'change_dashboarduser'),(99,'Can delete dashboard user',30,'delete_dashboarduser'),(100,'Can add dashboard usrgrp',31,'add_dashboardusrgrp'),(101,'Can change dashboard usrgrp',31,'change_dashboardusrgrp'),(102,'Can delete dashboard usrgrp',31,'delete_dashboardusrgrp'),(103,'Can add dbversion',32,'add_dbversion'),(104,'Can change dbversion',32,'change_dbversion'),(105,'Can delete dbversion',32,'delete_dbversion'),(106,'Can add dchecks',33,'add_dchecks'),(107,'Can change dchecks',33,'change_dchecks'),(108,'Can delete dchecks',33,'delete_dchecks'),(109,'Can add dhosts',34,'add_dhosts'),(110,'Can change dhosts',34,'change_dhosts'),(111,'Can delete dhosts',34,'delete_dhosts'),(112,'Can add drules',35,'add_drules'),(113,'Can change drules',35,'change_drules'),(114,'Can delete drules',35,'delete_drules'),(115,'Can add dservices',36,'add_dservices'),(116,'Can change dservices',36,'change_dservices'),(117,'Can delete dservices',36,'delete_dservices'),(118,'Can add escalations',37,'add_escalations'),(119,'Can change escalations',37,'change_escalations'),(120,'Can delete escalations',37,'delete_escalations'),(121,'Can add event tag',38,'add_eventtag'),(122,'Can change event tag',38,'change_eventtag'),(123,'Can delete event tag',38,'delete_eventtag'),(124,'Can add expressions',39,'add_expressions'),(125,'Can change expressions',39,'change_expressions'),(126,'Can delete expressions',39,'delete_expressions'),(127,'Can add functions',40,'add_functions'),(128,'Can change functions',40,'change_functions'),(129,'Can delete functions',40,'delete_functions'),(130,'Can add globalmacro',41,'add_globalmacro'),(131,'Can change globalmacro',41,'change_globalmacro'),(132,'Can delete globalmacro',41,'delete_globalmacro'),(133,'Can add globalvars',42,'add_globalvars'),(134,'Can change globalvars',42,'change_globalvars'),(135,'Can delete globalvars',42,'delete_globalvars'),(136,'Can add graphs items',43,'add_graphsitems'),(137,'Can change graphs items',43,'change_graphsitems'),(138,'Can delete graphs items',43,'delete_graphsitems'),(139,'Can add graph theme',44,'add_graphtheme'),(140,'Can change graph theme',44,'change_graphtheme'),(141,'Can delete graph theme',44,'delete_graphtheme'),(142,'Can add group prototype',45,'add_groupprototype'),(143,'Can change group prototype',45,'change_groupprototype'),(144,'Can delete group prototype',45,'delete_groupprototype'),(145,'Can add history',46,'add_history'),(146,'Can change history',46,'change_history'),(147,'Can delete history',46,'delete_history'),(148,'Can add history log',47,'add_historylog'),(149,'Can change history log',47,'change_historylog'),(150,'Can delete history log',47,'delete_historylog'),(151,'Can add history str',48,'add_historystr'),(152,'Can change history str',48,'change_historystr'),(153,'Can delete history str',48,'delete_historystr'),(154,'Can add history text',49,'add_historytext'),(155,'Can change history text',49,'change_historytext'),(156,'Can delete history text',49,'delete_historytext'),(157,'Can add history uint',50,'add_historyuint'),(158,'Can change history uint',50,'change_historyuint'),(159,'Can delete history uint',50,'delete_historyuint'),(160,'Can add hostmacro',51,'add_hostmacro'),(161,'Can change hostmacro',51,'change_hostmacro'),(162,'Can delete hostmacro',51,'delete_hostmacro'),(163,'Can add hosts groups',52,'add_hostsgroups'),(164,'Can change hosts groups',52,'change_hostsgroups'),(165,'Can delete hosts groups',52,'delete_hostsgroups'),(166,'Can add hosts templates',53,'add_hoststemplates'),(167,'Can change hosts templates',53,'change_hoststemplates'),(168,'Can delete hosts templates',53,'delete_hoststemplates'),(169,'Can add housekeeper',54,'add_housekeeper'),(170,'Can change housekeeper',54,'change_housekeeper'),(171,'Can delete housekeeper',54,'delete_housekeeper'),(172,'Can add httpstep',55,'add_httpstep'),(173,'Can change httpstep',55,'change_httpstep'),(174,'Can delete httpstep',55,'delete_httpstep'),(175,'Can add httpstep field',56,'add_httpstepfield'),(176,'Can change httpstep field',56,'change_httpstepfield'),(177,'Can delete httpstep field',56,'delete_httpstepfield'),(178,'Can add httpstepitem',57,'add_httpstepitem'),(179,'Can change httpstepitem',57,'change_httpstepitem'),(180,'Can delete httpstepitem',57,'delete_httpstepitem'),(181,'Can add httptest',58,'add_httptest'),(182,'Can change httptest',58,'change_httptest'),(183,'Can delete httptest',58,'delete_httptest'),(184,'Can add httptest field',59,'add_httptestfield'),(185,'Can change httptest field',59,'change_httptestfield'),(186,'Can delete httptest field',59,'delete_httptestfield'),(187,'Can add httptestitem',60,'add_httptestitem'),(188,'Can change httptestitem',60,'change_httptestitem'),(189,'Can delete httptestitem',60,'delete_httptestitem'),(190,'Can add icon map',61,'add_iconmap'),(191,'Can change icon map',61,'change_iconmap'),(192,'Can delete icon map',61,'delete_iconmap'),(193,'Can add icon mapping',62,'add_iconmapping'),(194,'Can change icon mapping',62,'change_iconmapping'),(195,'Can delete icon mapping',62,'delete_iconmapping'),(196,'Can add ids',63,'add_ids'),(197,'Can change ids',63,'change_ids'),(198,'Can delete ids',63,'delete_ids'),(199,'Can add images',64,'add_images'),(200,'Can change images',64,'change_images'),(201,'Can delete images',64,'delete_images'),(202,'Can add item application prototype',65,'add_itemapplicationprototype'),(203,'Can change item application prototype',65,'change_itemapplicationprototype'),(204,'Can delete item application prototype',65,'delete_itemapplicationprototype'),(205,'Can add item condition',66,'add_itemcondition'),(206,'Can change item condition',66,'change_itemcondition'),(207,'Can delete item condition',66,'delete_itemcondition'),(208,'Can add item discovery',67,'add_itemdiscovery'),(209,'Can change item discovery',67,'change_itemdiscovery'),(210,'Can delete item discovery',67,'delete_itemdiscovery'),(211,'Can add item preproc',68,'add_itempreproc'),(212,'Can change item preproc',68,'change_itempreproc'),(213,'Can delete item preproc',68,'delete_itempreproc'),(214,'Can add items',69,'add_items'),(215,'Can change items',69,'change_items'),(216,'Can delete items',69,'delete_items'),(217,'Can add items applications',70,'add_itemsapplications'),(218,'Can change items applications',70,'change_itemsapplications'),(219,'Can delete items applications',70,'delete_itemsapplications'),(220,'Can add maintenances',71,'add_maintenances'),(221,'Can change maintenances',71,'change_maintenances'),(222,'Can delete maintenances',71,'delete_maintenances'),(223,'Can add maintenances groups',72,'add_maintenancesgroups'),(224,'Can change maintenances groups',72,'change_maintenancesgroups'),(225,'Can delete maintenances groups',72,'delete_maintenancesgroups'),(226,'Can add maintenances hosts',73,'add_maintenanceshosts'),(227,'Can change maintenances hosts',73,'change_maintenanceshosts'),(228,'Can delete maintenances hosts',73,'delete_maintenanceshosts'),(229,'Can add maintenances windows',74,'add_maintenanceswindows'),(230,'Can change maintenances windows',74,'change_maintenanceswindows'),(231,'Can delete maintenances windows',74,'delete_maintenanceswindows'),(232,'Can add mappings',75,'add_mappings'),(233,'Can change mappings',75,'change_mappings'),(234,'Can delete mappings',75,'delete_mappings'),(235,'Can add media',76,'add_media'),(236,'Can change media',76,'change_media'),(237,'Can delete media',76,'delete_media'),(238,'Can add media type',77,'add_mediatype'),(239,'Can change media type',77,'change_mediatype'),(240,'Can delete media type',77,'delete_mediatype'),(241,'Can add opcommand grp',78,'add_opcommandgrp'),(242,'Can change opcommand grp',78,'change_opcommandgrp'),(243,'Can delete opcommand grp',78,'delete_opcommandgrp'),(244,'Can add opcommand hst',79,'add_opcommandhst'),(245,'Can change opcommand hst',79,'change_opcommandhst'),(246,'Can delete opcommand hst',79,'delete_opcommandhst'),(247,'Can add opconditions',80,'add_opconditions'),(248,'Can change opconditions',80,'change_opconditions'),(249,'Can delete opconditions',80,'delete_opconditions'),(250,'Can add opgroup',81,'add_opgroup'),(251,'Can change opgroup',81,'change_opgroup'),(252,'Can delete opgroup',81,'delete_opgroup'),(253,'Can add opmessage grp',82,'add_opmessagegrp'),(254,'Can change opmessage grp',82,'change_opmessagegrp'),(255,'Can delete opmessage grp',82,'delete_opmessagegrp'),(256,'Can add opmessage usr',83,'add_opmessageusr'),(257,'Can change opmessage usr',83,'change_opmessageusr'),(258,'Can delete opmessage usr',83,'delete_opmessageusr'),(259,'Can add optemplate',84,'add_optemplate'),(260,'Can change optemplate',84,'change_optemplate'),(261,'Can delete optemplate',84,'delete_optemplate'),(262,'Can add problem tag',85,'add_problemtag'),(263,'Can change problem tag',85,'change_problemtag'),(264,'Can delete problem tag',85,'delete_problemtag'),(265,'Can add profiles',86,'add_profiles'),(266,'Can change profiles',86,'change_profiles'),(267,'Can delete profiles',86,'delete_profiles'),(268,'Can add proxy autoreg host',87,'add_proxyautoreghost'),(269,'Can change proxy autoreg host',87,'change_proxyautoreghost'),(270,'Can delete proxy autoreg host',87,'delete_proxyautoreghost'),(271,'Can add proxy dhistory',88,'add_proxydhistory'),(272,'Can change proxy dhistory',88,'change_proxydhistory'),(273,'Can delete proxy dhistory',88,'delete_proxydhistory'),(274,'Can add proxy history',89,'add_proxyhistory'),(275,'Can change proxy history',89,'change_proxyhistory'),(276,'Can delete proxy history',89,'delete_proxyhistory'),(277,'Can add regexps',90,'add_regexps'),(278,'Can change regexps',90,'change_regexps'),(279,'Can delete regexps',90,'delete_regexps'),(280,'Can add rights',91,'add_rights'),(281,'Can change rights',91,'change_rights'),(282,'Can delete rights',91,'delete_rights'),(283,'Can add screens',92,'add_screens'),(284,'Can change screens',92,'change_screens'),(285,'Can delete screens',92,'delete_screens'),(286,'Can add screens items',93,'add_screensitems'),(287,'Can change screens items',93,'change_screensitems'),(288,'Can delete screens items',93,'delete_screensitems'),(289,'Can add screen user',94,'add_screenuser'),(290,'Can change screen user',94,'change_screenuser'),(291,'Can delete screen user',94,'delete_screenuser'),(292,'Can add screen usrgrp',95,'add_screenusrgrp'),(293,'Can change screen usrgrp',95,'change_screenusrgrp'),(294,'Can delete screen usrgrp',95,'delete_screenusrgrp'),(295,'Can add scripts',96,'add_scripts'),(296,'Can change scripts',96,'change_scripts'),(297,'Can delete scripts',96,'delete_scripts'),(298,'Can add service alarms',97,'add_servicealarms'),(299,'Can change service alarms',97,'change_servicealarms'),(300,'Can delete service alarms',97,'delete_servicealarms'),(301,'Can add services',98,'add_services'),(302,'Can change services',98,'change_services'),(303,'Can delete services',98,'delete_services'),(304,'Can add services links',99,'add_serviceslinks'),(305,'Can change services links',99,'change_serviceslinks'),(306,'Can delete services links',99,'delete_serviceslinks'),(307,'Can add services times',100,'add_servicestimes'),(308,'Can change services times',100,'change_servicestimes'),(309,'Can delete services times',100,'delete_servicestimes'),(310,'Can add sessions',101,'add_sessions'),(311,'Can change sessions',101,'change_sessions'),(312,'Can delete sessions',101,'delete_sessions'),(313,'Can add slides',102,'add_slides'),(314,'Can change slides',102,'change_slides'),(315,'Can delete slides',102,'delete_slides'),(316,'Can add slideshows',103,'add_slideshows'),(317,'Can change slideshows',103,'change_slideshows'),(318,'Can delete slideshows',103,'delete_slideshows'),(319,'Can add slideshow user',104,'add_slideshowuser'),(320,'Can change slideshow user',104,'change_slideshowuser'),(321,'Can delete slideshow user',104,'delete_slideshowuser'),(322,'Can add slideshow usrgrp',105,'add_slideshowusrgrp'),(323,'Can change slideshow usrgrp',105,'change_slideshowusrgrp'),(324,'Can delete slideshow usrgrp',105,'delete_slideshowusrgrp'),(325,'Can add sysmap element trigger',106,'add_sysmapelementtrigger'),(326,'Can change sysmap element trigger',106,'change_sysmapelementtrigger'),(327,'Can delete sysmap element trigger',106,'delete_sysmapelementtrigger'),(328,'Can add sysmap element url',107,'add_sysmapelementurl'),(329,'Can change sysmap element url',107,'change_sysmapelementurl'),(330,'Can delete sysmap element url',107,'delete_sysmapelementurl'),(331,'Can add sysmaps',108,'add_sysmaps'),(332,'Can change sysmaps',108,'change_sysmaps'),(333,'Can delete sysmaps',108,'delete_sysmaps'),(334,'Can add sysmaps elements',109,'add_sysmapselements'),(335,'Can change sysmaps elements',109,'change_sysmapselements'),(336,'Can delete sysmaps elements',109,'delete_sysmapselements'),(337,'Can add sysmap shape',110,'add_sysmapshape'),(338,'Can change sysmap shape',110,'change_sysmapshape'),(339,'Can delete sysmap shape',110,'delete_sysmapshape'),(340,'Can add sysmaps links',111,'add_sysmapslinks'),(341,'Can change sysmaps links',111,'change_sysmapslinks'),(342,'Can delete sysmaps links',111,'delete_sysmapslinks'),(343,'Can add sysmaps link triggers',112,'add_sysmapslinktriggers'),(344,'Can change sysmaps link triggers',112,'change_sysmapslinktriggers'),(345,'Can delete sysmaps link triggers',112,'delete_sysmapslinktriggers'),(346,'Can add sysmap url',113,'add_sysmapurl'),(347,'Can change sysmap url',113,'change_sysmapurl'),(348,'Can delete sysmap url',113,'delete_sysmapurl'),(349,'Can add sysmap user',114,'add_sysmapuser'),(350,'Can change sysmap user',114,'change_sysmapuser'),(351,'Can delete sysmap user',114,'delete_sysmapuser'),(352,'Can add sysmap usrgrp',115,'add_sysmapusrgrp'),(353,'Can change sysmap usrgrp',115,'change_sysmapusrgrp'),(354,'Can delete sysmap usrgrp',115,'delete_sysmapusrgrp'),(355,'Can add timeperiods',116,'add_timeperiods'),(356,'Can change timeperiods',116,'change_timeperiods'),(357,'Can delete timeperiods',116,'delete_timeperiods'),(358,'Can add trends',117,'add_trends'),(359,'Can change trends',117,'change_trends'),(360,'Can delete trends',117,'delete_trends'),(361,'Can add trends uint',118,'add_trendsuint'),(362,'Can change trends uint',118,'change_trendsuint'),(363,'Can delete trends uint',118,'delete_trendsuint'),(364,'Can add trigger depends',119,'add_triggerdepends'),(365,'Can change trigger depends',119,'change_triggerdepends'),(366,'Can delete trigger depends',119,'delete_triggerdepends'),(367,'Can add trigger tag',120,'add_triggertag'),(368,'Can change trigger tag',120,'change_triggertag'),(369,'Can delete trigger tag',120,'delete_triggertag'),(370,'Can add users',121,'add_users'),(371,'Can change users',121,'change_users'),(372,'Can delete users',121,'delete_users'),(373,'Can add users groups',122,'add_usersgroups'),(374,'Can change users groups',122,'change_usersgroups'),(375,'Can delete users groups',122,'delete_usersgroups'),(376,'Can add usrgrp',123,'add_usrgrp'),(377,'Can change usrgrp',123,'change_usrgrp'),(378,'Can delete usrgrp',123,'delete_usrgrp'),(379,'Can add valuemaps',124,'add_valuemaps'),(380,'Can change valuemaps',124,'change_valuemaps'),(381,'Can delete valuemaps',124,'delete_valuemaps'),(382,'Can add widget',125,'add_widget'),(383,'Can change widget',125,'change_widget'),(384,'Can delete widget',125,'delete_widget'),(385,'Can add widget field',126,'add_widgetfield'),(386,'Can change widget field',126,'change_widgetfield'),(387,'Can delete widget field',126,'delete_widgetfield'),(388,'Can add corr condition',127,'add_corrcondition'),(389,'Can change corr condition',127,'change_corrcondition'),(390,'Can delete corr condition',127,'delete_corrcondition'),(391,'Can add corr condition tagpair',128,'add_corrconditiontagpair'),(392,'Can change corr condition tagpair',128,'change_corrconditiontagpair'),(393,'Can delete corr condition tagpair',128,'delete_corrconditiontagpair'),(394,'Can add corr condition group',129,'add_corrconditiongroup'),(395,'Can change corr condition group',129,'change_corrconditiongroup'),(396,'Can delete corr condition group',129,'delete_corrconditiongroup'),(397,'Can add corr condition tagvalue',130,'add_corrconditiontagvalue'),(398,'Can change corr condition tagvalue',130,'change_corrconditiontagvalue'),(399,'Can delete corr condition tagvalue',130,'delete_corrconditiontagvalue'),(400,'Can add corr condition tag',131,'add_corrconditiontag'),(401,'Can change corr condition tag',131,'change_corrconditiontag'),(402,'Can delete corr condition tag',131,'delete_corrconditiontag'),(403,'Can add graphs',132,'add_graphs'),(404,'Can change graphs',132,'change_graphs'),(405,'Can delete graphs',132,'delete_graphs'),(406,'Can add graph discovery',133,'add_graphdiscovery'),(407,'Can change graph discovery',133,'change_graphdiscovery'),(408,'Can delete graph discovery',133,'delete_graphdiscovery'),(409,'Can add group discovery',134,'add_groupdiscovery'),(410,'Can change group discovery',134,'change_groupdiscovery'),(411,'Can delete group discovery',134,'delete_groupdiscovery'),(412,'Can add groups',135,'add_groups'),(413,'Can change groups',135,'change_groups'),(414,'Can delete groups',135,'delete_groups'),(415,'Can add host discovery',136,'add_hostdiscovery'),(416,'Can change host discovery',136,'change_hostdiscovery'),(417,'Can delete host discovery',136,'delete_hostdiscovery'),(418,'Can add hosts',137,'add_hosts'),(419,'Can change hosts',137,'change_hosts'),(420,'Can delete hosts',137,'delete_hosts'),(421,'Can add host inventory',138,'add_hostinventory'),(422,'Can change host inventory',138,'change_hostinventory'),(423,'Can delete host inventory',138,'delete_hostinventory'),(424,'Can add interface discovery',139,'add_interfacediscovery'),(425,'Can change interface discovery',139,'change_interfacediscovery'),(426,'Can delete interface discovery',139,'delete_interfacediscovery'),(427,'Can add interface',140,'add_interface'),(428,'Can change interface',140,'change_interface'),(429,'Can delete interface',140,'delete_interface'),(430,'Can add opinventory',141,'add_opinventory'),(431,'Can change opinventory',141,'change_opinventory'),(432,'Can delete opinventory',141,'delete_opinventory'),(433,'Can add opcommand',142,'add_opcommand'),(434,'Can change opcommand',142,'change_opcommand'),(435,'Can delete opcommand',142,'delete_opcommand'),(436,'Can add opmessage',143,'add_opmessage'),(437,'Can change opmessage',143,'change_opmessage'),(438,'Can delete opmessage',143,'delete_opmessage'),(439,'Can add operations',144,'add_operations'),(440,'Can change operations',144,'change_operations'),(441,'Can delete operations',144,'delete_operations'),(442,'Can add event recovery',145,'add_eventrecovery'),(443,'Can change event recovery',145,'change_eventrecovery'),(444,'Can delete event recovery',145,'delete_eventrecovery'),(445,'Can add events',146,'add_events'),(446,'Can change events',146,'change_events'),(447,'Can delete events',146,'delete_events'),(448,'Can add problem',147,'add_problem'),(449,'Can change problem',147,'change_problem'),(450,'Can delete problem',147,'delete_problem'),(451,'Can add task',148,'add_task'),(452,'Can change task',148,'change_task'),(453,'Can delete task',148,'delete_task'),(454,'Can add task remote command',149,'add_taskremotecommand'),(455,'Can change task remote command',149,'change_taskremotecommand'),(456,'Can delete task remote command',149,'delete_taskremotecommand'),(457,'Can add task remote command result',150,'add_taskremotecommandresult'),(458,'Can change task remote command result',150,'change_taskremotecommandresult'),(459,'Can delete task remote command result',150,'delete_taskremotecommandresult'),(460,'Can add task acknowledge',151,'add_taskacknowledge'),(461,'Can change task acknowledge',151,'change_taskacknowledge'),(462,'Can delete task acknowledge',151,'delete_taskacknowledge'),(463,'Can add task close problem',152,'add_taskcloseproblem'),(464,'Can change task close problem',152,'change_taskcloseproblem'),(465,'Can delete task close problem',152,'delete_taskcloseproblem'),(466,'Can add triggers',153,'add_triggers'),(467,'Can change triggers',153,'change_triggers'),(468,'Can delete triggers',153,'delete_triggers'),(469,'Can add trigger discovery',154,'add_triggerdiscovery'),(470,'Can change trigger discovery',154,'change_triggerdiscovery'),(471,'Can delete trigger discovery',154,'delete_triggerdiscovery'),(472,'Can add 图书信息',155,'add_book'),(473,'Can change 图书信息',155,'change_book'),(474,'Can delete 图书信息',155,'delete_book'),(475,'Can add 出版商信息',156,'add_publish'),(476,'Can change 出版商信息',156,'change_publish'),(477,'Can delete 出版商信息',156,'delete_publish'),(478,'Can add 作者信息',157,'add_author'),(479,'Can change 作者信息',157,'change_author'),(480,'Can delete 作者信息',157,'delete_author');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `name` varchar(32) DEFAULT NULL,
  `phone` varchar(11) DEFAULT NULL,
  `id_rsa_key` longtext,
  `id_rsa_pub` longtext,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$36000$5cSrD3yvttTx$iHlhrmLftKKykqqBjU3jsEBHubz719PzylcA6XPq6Xc=','2020-11-09 16:27:04.848592',1,'admin','','','admin@11.com',1,1,'2020-11-03 13:59:09.398108',NULL,NULL,NULL,NULL),(2,'',NULL,0,'zhangsan','','','',0,0,'2020-11-03 14:39:01.921378','张三','13200000000',NULL,NULL),(3,'pbkdf2_sha256$36000$aAigIFKa0VJ5$swnsDzGdpwhfY2T0RbmC+9AkpTiUBsF4cwFzvLWCRn0=',NULL,0,'lisi','','','lisi@16801.com',0,0,'2020-11-03 16:38:18.202313','李四','13200000000','-----BEGIN RSA PRIVATE KEY-----\nMIIEpAIBAAKCAQEAvJWHFczzD4NCfmOfx/BCakbh5pgLNRKndxzYW37HghynA1mn\nTjr93Qw3PcvlcT+CuMMJNET0lj6bHMq/y6lRh5iuYDmGkpcMCP8w2G1P88AVqHBl\nobYcdH7CrbB61JLvMnVS9IQz2L5W7Xvfx/Fg61gLk0JbBDCasLqyUnrvrmEZzQZq\nLERKUT0nCpb9XiWwymT+qXF6mPrlPFohjJ4/Tj3Vef/2ir3++mFEkXwG27gMeG4U\n1kCw8eCWKRaMNme3cnwge0Kkmuf+ndTlL9CT3IhoponsZCf3kyT6wk8IwxJI24+J\nZLyhXxK3gUIF4aOvhQqkGIo5xvLwVXT2FkoQFwIDAQABAoIBAEgKp0xAuynV7vTx\ngfyTYAvRgELjGoTv12G9dzmcuQKPh43UFgHgr1JedEv7NG+K35lNiJqbLQSobgEV\nwyc+S5MNVLAVyb7+TO6y7in/uGdZnex245xfQYePVTedD49dgls4TrRyPIw0Smj2\nxYpQP8IoJGPhGXwERVP2PmEb7awja88iTwdD24OvSEu1bBvaRbTefshRw9F0pvbZ\n3swEFYpZSBCcmZIYyIohBsiS9HCMly0DCG3OojkSSoxetjmRVePcS5ZpNp6zC6VH\nqof8nh7VSHClczUX7QpblqJkpnVMQ3YpnhrHg9i8RNZSSA/Jog7j/l26FjOFpX+/\n/JskIaECgYEA6fFEzRnes75fv7IVsTqpCzCWQvxgT7OlXcDqCCEiZMEqhBGVpj7c\nXmlXKhhrBEIgSoS9nhpOhyQVVWU5go7BGS5td6VyUq6JBhDlIpks605fa0yHO9Wu\nsSEXj03NcQ7GEXl66TGVZH1z0aSGwAxN1oiXMUyub4j+95cD+F1uT2MCgYEAzl1u\nmmWu0EoyJqaG3KER4Qn00MsKvqN6f+Ew+NfiFy66ibWWwDcUW8gy9Eu68aGO2BAi\nRt8Mdl+u1KLiXoWVsNKdvLnzsF1nk7naXup+yPRgyUPIKWSugbAXzGlOf5f3YTM8\n3qbYjuKu1U/Lm948BSdqw7jVvMTjJp7kNLO8/L0CgYEAuoUesdhaczzp4lD+cpuu\ng7ltVGMb9u/ofON+tJSWc3Z/i2Tpx+5+jNe4I1vslyyRylgjRpb63UyrpbZbL/jZ\nhFY7+RT0HXAC189IoVk3MzT9ZvNRLyejbJ5RxnPlxKpeyTfuA1cBIWnUmeVveldV\nCCNHSIs22L6FaqoBBFiZxrkCgYBCcYjEA4tGmy0Mjr+LV/z2tQrzEvzRprcxZ2Mq\nK/AqwKvk3Oe92b4fUxU83QlC9V6VqJQwt24+ys3yvsMd5ertdNK+yixxE5He2Y86\n0kuiDjT/eGiBE16weO8grKNOp7JJxIKLubKuRsQ+ACQxelte2XMhs2h2D/qHG8+k\nPF7UDQKBgQC2RZPSZ5hnbw+oG3WgDQ2YoVsZYqxKnaFuvdUa0P0WItit8xClaJR3\nGSFm4wMu9WOv3qAaEhJ6w6uFglulXUv/NRym4bBLC4tdgzux4TnWqlP367XU9Lk2\niYTjKUp6oMMvTy3zFjw6gZGFYNXa+7kru6IyML8iIATnPKUgJsS4nw==\n-----END RSA PRIVATE KEY-----\n','ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC8lYcVzPMPg0J+Y5/H8EJqRuHmmAs1Eqd3HNhbfseCHKcDWadOOv3dDDc9y+VxP4K4wwk0RPSWPpscyr/LqVGHmK5gOYaSlwwI/zDYbU/zwBWocGWhthx0fsKtsHrUku8ydVL0hDPYvlbte9/H8WDrWAuTQlsEMJqwurJSeu+uYRnNBmosREpRPScKlv1eJbDKZP6pcXqY+uU8WiGMnj9OPdV5//aKvf76YUSRfAbbuAx4bhTWQLDx4JYpFow2Z7dyfCB7QqSa5/6d1OUv0JPciGimiexkJ/eTJPrCTwjDEkjbj4lkvKFfEreBQgXho6+FCqQYijnG8vBVdPYWShAX lisi@16801.com'),(5,'pbkdf2_sha256$36000$LdajYb4r8y8D$/x9qF36wImV97WOmYRsEIKzyxQ5sS2zwZNLo5VZkI7U=',NULL,0,'yunwei','','','yunwei@16801.com',0,0,'2020-11-05 09:33:05.405898','运维通用','13200000000','-----BEGIN RSA PRIVATE KEY-----\nMIIEowIBAAKCAQEA0r9edzs+hJjMzNz5znCI7Fpmje8vMmyoLbw19kCnkmY0vTqG\nY5MiKGayPIoK9+57TqfgEPV0vi1/XTbDqUuTnSTpOYlZYFBH76Bo2SHrb+1676uu\nFgFMOrHt2vF9tQ9v0HB+Sjc4LxmSXm5UpAIg5s8+Kh3PSws+HMbRopl5ojTGxW39\nOUS+yPIbi2gnX/lmnUx5w25cMgLZMTUR1bdWTPQzGimadSgiIQwwo9knnm1uDXTb\nuW2zR5s+McuVgsodQeVECwfjbBpzJL5VEZwEoh2zstj5yl3prDmc8cQL6qkvxL/k\nu7LMphy+R9fTeu2y3T0bhixlEANdOyQ6nF7gswIDAQABAoIBABG+hyem11a2vteo\n62eUVhMAcY4Vy3WFbIudQzXer71F2b7tBI+xvbiFHRC31sCVVdCDlfwXjqLMleK1\nT7gbYuxiRTjQ9bOETupAKVPO5VHhPu6bF+dGaLKwdIRwvNLX3+Q+9IMvLw3YK1jE\nFWBRxY9pd6R4KhH5eltV6iS0o2civ0LP3gVW9ON4Agu6lQwddBsHSY0jQALn3a5O\nEM6ZEG+fZqi9Bb2VlFKCdSIHupDpuul4oxIDNafvUwO4fRINrsg0ebrh3OImfkYX\ng9P+NxIaxa09WZaKg/s38rOYXe1C+MkPuYmrv1qCByo0SIQqoTiKhkk7IL7xRCWF\nIGd7QeECgYEA9n9zLZv3RG1ii7RICLCJNHjTyeNJXh3AtbUF5VqD/WEomEJt14Jp\nVpncKZtBfav5jdbv9x1xqktaROxjihEhZL3V6qYfapZvUNrAN+wTbeD+VZS0EMhT\nu/tGUJBOq0/Kh28mqV5cMY4x8sGTTkEVnl4GYxzAJYjqyC5SlhmI/mkCgYEA2t8e\nftVkwci60sCMjVkfdfKUfwy87Lh/Wdm5vw3nNr5WTwdw3CiAKwCEYz3P9UKzKjOS\nIu6lG9xh3n/6bR+xZ2zOB62sFBEsjW5gAhNYYglRe5+gpmRL8L4JYqu7RLF32NxN\nTdt4JbSp2+/imLC+f8wlbG4uo3TQ/iQ8Kne3ersCgYEAysrt2h8PXbdUNLVb8fIy\n3v1s2BJqgMifi55jPF6sah+twx4bugprWTj5vS0iwx5iEAQ9paMOqViW6k9EUQlo\n3LWlMQf8nrcm23EsZJWPIn3RIF1XitsUsHm4Tn16i0v4xlV2jC66UHa4twv0gZPg\nEksunAnCNt8esRQTE7PsVckCgYBdKcvZQQv6UG71dnBdWipCEleTHODuAjpzDHI8\nGLbqXmpuiURI8hRcOYQgmhcC1rlcpUb3B43QJiaihucZu/vPgkjQi+RLRmQob2r+\ndy2PzVeZv4CqUtbgSoPENEUqIEBbVqqxEVI6+oOy0pEpXVI5I7RqSxwfB4JOKy5R\nBVRcMQKBgH7+zoV91Qa1rWPeSo5srxSLErWE3WEih6u49IUXl2rzl1ACepWIa30U\nJUv/P23baQ+NDe2lozQbjK9ux3zHzZx2l7E8vfDkclB9Ulino/jhpPSiYT9unIMX\nEe8LokyW2xp8jJkb7aXNa5SvGOZkkYqZXJKSs6fsMp0Jta20IIsj\n-----END RSA PRIVATE KEY-----\n','ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDSv153Oz6EmMzM3PnOcIjsWmaN7y8ybKgtvDX2QKeSZjS9OoZjkyIoZrI8igr37ntOp+AQ9XS+LX9dNsOpS5OdJOk5iVlgUEfvoGjZIetv7Xrvq64WAUw6se3a8X21D2/QcH5KNzgvGZJeblSkAiDmzz4qHc9LCz4cxtGimXmiNMbFbf05RL7I8huLaCdf+WadTHnDblwyAtkxNRHVt1ZM9DMaKZp1KCIhDDCj2SeebW4NdNu5bbNHmz4xy5WCyh1B5UQLB+NsGnMkvlURnASiHbOy2PnKXemsOZzxxAvqqS/Ev+S7ssymHL5H19N67bLdPRuGLGUQA107JDqcXuCz yunwei@16801.com'),(6,'pbkdf2_sha256$36000$1n03CXBwdZfs$jMR9O8h0EplhS0q9y53IDw22bSR4crj1Cj9lQVpZoAo=',NULL,0,'wangwu','','','wangwu@16801.com',0,1,'2020-11-06 13:41:06.744190','王五','13200000000','-----BEGIN RSA PRIVATE KEY-----\nMIIEpQIBAAKCAQEAnc2j1N9uV3fESzaUoW1WgZ4NlG1Z3+d1t7oVZe/uK70ltR+h\npzw3PHdBfPFJLbcZFcpdwKva2Jr1bf769cTaMWCOx2zUvL4jnX0OxTPR72ucX+rC\n8Fa4RZ12Vb5w/92+75Br6hELRAtqQCLf6nfO0TNFqZBuHyXuu1r5RSIqZYTuzqed\nrMHJHOaeMNa9KAIhnWuce2fTGYFEOUEbghknD7cF+2eE6nIv+/ocYi+uUAtScjQD\nX3kAVdAgQK+Avm/CPpCU+ehiodF/OC+FBsClIksZdiHVYBiyzd9VsgRKTknm8BxH\nskdx7jSWDS2+J5pEULRaA03+BycL9oWvHHswvQIDAQABAoIBAQCE0mPFd1KuuJY2\nIHi17wvTCa+wcOIm/fEtdakxJeQ4WHp2m2s7EgoEEPTEL2tC2Ux59N04oO4RR0yx\nCt89IjXtPbKv1MCzJO9hTbOy9M0NUmxKp5TxKmzr23+Q6DzAgGqHxe2vFC2BVoJV\n/YSvG6yulRNbh7/I4+qvNAF/2SQKUakysd9JIZ5W1wTRJJ+YbglWAemedmyuF4Mc\nLglY7fdEF33GHpLlD9WfHG0nwrZwaH6OTo1Y7F7huJmDggOvw5LqeMplKiHtXAsh\nGn/7QwapSH/s3kwIn1xoaKH/XA+vgs6GZLHUzny7QdUhvsrV4a0W1cCTwDVN98cX\n/QtuVXyBAoGBAMw5rDkbf3LpxRKw6ZOppKiFKNH5/BO/44XeP+VeRINqycqjrcHd\nnSvc6BZ4ZITqmvJ1g33YeoQufXA5yRIQgmmQ4kdiSwi7wd9rN79LQVHSwp/HC5do\nurRHFppbY8GuBls68sgk71VOzGUHI1eWTHMSAtMyMX+02vnkrCau6dKNAoGBAMXP\nJ7HaFr4nObwZJJR6vzhh10Ef5bayc3Do9FvDgf5dI1q1IFRw8RJYjVR2vzS0m6Ra\nTNZRcI8BIYj1pcUmNBkZJXetCNQrZ7cOLuRFPkBdfMsUG8Kw6YWkXDeJnImmJW0g\nxOINaY3qvC4l8T6RxAQWhKSO0UAriBJ6rV0fSmLxAoGBAJeZZEAMKoKaB+HFE866\nSnGST2f3gukCM5onDhVs8b0AI4VaFVzo7ogl9t7fRfbo1FaRZyee7+t5O0J4ksrn\nGHfWxjIpQ/varKL1yy8kZPuhUTocHn2pj5bNgnjYyGd4kF1el+R8jnEsCkwgjVqy\nRlPRFenCw73B+h8wYZ5hj07tAoGBALAmZonp1WDmW3KWzU1v9YMHFgIHnq/QQB8n\nRBvHgaZ7WHV5YF3x6avVsZ2q1WDhCM0WIOCly199uVhWsJVdDP3gt83YCEmwkX6h\nIb7jrqjw16WctY/trTb2g6xtXjnx+9gvW0SWfw4DICrUXP3EHtMpHlvQVqUXXuhd\n2K5ZpAtxAoGAM3GDz8mI8uFPM83Y1FVaI3dnu/6LuDCTDp8BJeOSPN6TP3fQS/rS\n60CC0UAEf5iNBW+jv6fk7BEdFw4BZl8FGLq3PkciQQXM7LH+4bWqVyDt23vRATkF\nn6Gt1u9LbQTfYJbood3KsSE5I16A381OO/uT0Q3tpJ8ah7Coj+mdq6Q=\n-----END RSA PRIVATE KEY-----\n','ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCdzaPU325Xd8RLNpShbVaBng2UbVnf53W3uhVl7+4rvSW1H6GnPDc8d0F88UkttxkVyl3Aq9rYmvVt/vr1xNoxYI7HbNS8viOdfQ7FM9Hva5xf6sLwVrhFnXZVvnD/3b7vkGvqEQtEC2pAIt/qd87RM0WpkG4fJe67WvlFIiplhO7Op52swckc5p4w1r0oAiGda5x7Z9MZgUQ5QRuCGScPtwX7Z4Tqci/7+hxiL65QC1JyNANfeQBV0CBAr4C+b8I+kJT56GKh0X84L4UGwKUiSxl2IdVgGLLN31WyBEpOSebwHEeyR3HuNJYNLb4nmkRQtFoDTf4HJwv2ha8cezC9 wangwu@16801.com');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
INSERT INTO `auth_user_groups` VALUES (3,2,1),(1,3,2),(2,5,2),(4,6,2);
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `books_author`
--

DROP TABLE IF EXISTS `books_author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `books_author` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  `email` varchar(254) NOT NULL,
  `phone` varchar(11) DEFAULT NULL,
  `address` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books_author`
--

LOCK TABLES `books_author` WRITE;
/*!40000 ALTER TABLE `books_author` DISABLE KEYS */;
INSERT INTO `books_author` VALUES (1,'金庸','jinyong@gmail.com','13200000000','浙江省海宁市'),(2,'曹雪芹','caoxueqin@gmail.com','13200000000','江苏南京'),(4,'高鹗','gaoe@gmail.com','13200000000','辽宁铁岭'),(5,'曹禺','caoyu@gmail.com','13200000000','湖北潜江'),(6,'天蚕土豆','lihu@gmail.com','13200000000','中国四川'),(7,'老舍','shuqingchun@gmail.com','13200000000','北京皇城根'),(8,'韩寒','hanhan@gmail.com','13200000000','上海市金山区亭林镇'),(9,'艾米莉·勃朗特','amilb@gmail.com','13200000000','英国 约克郡 布拉德福索顿'),(10,'尼古拉·奥斯特洛夫斯基','aostelfosh@gmail.com','13200000000','苏联乌克兰'),(11,'陈忠实','chenzhongshi@gmail.com','13200000000','陕西西安市灞桥区'),(12,'萧逸','xiaoyi@gmail.com','13200000000','山东菏泽');
/*!40000 ALTER TABLE `books_author` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `books_book`
--

DROP TABLE IF EXISTS `books_book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `books_book` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `publication_date` date DEFAULT NULL,
  `publisher_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `books_book_publisher_id_189e6c56_fk_books_publish_id` (`publisher_id`),
  CONSTRAINT `books_book_publisher_id_189e6c56_fk_books_publish_id` FOREIGN KEY (`publisher_id`) REFERENCES `books_publish` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books_book`
--

LOCK TABLES `books_book` WRITE;
/*!40000 ALTER TABLE `books_book` DISABLE KEYS */;
INSERT INTO `books_book` VALUES (4,'雷雨','1936-07-07',6),(5,'斗破苍穹','2016-06-12',7),(6,'天龙八部','1963-08-16',3),(7,'红楼梦','1996-12-24',2),(8,'茶馆','1956-11-20',4),(9,'三重门','2000-05-15',8),(10,'呼啸山庄','1999-10-17',2),(11,'钢铁是怎样炼成的','1980-09-09',2),(12,'白鹿原','1993-05-16',2),(13,'天龙地虎','1991-07-18',9);
/*!40000 ALTER TABLE `books_book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `books_book_authors`
--

DROP TABLE IF EXISTS `books_book_authors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `books_book_authors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `book_id` int(11) NOT NULL,
  `author_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `books_book_authors_book_id_author_id_8714badb_uniq` (`book_id`,`author_id`),
  KEY `books_book_authors_author_id_984f1ab8_fk_books_author_id` (`author_id`),
  CONSTRAINT `books_book_authors_author_id_984f1ab8_fk_books_author_id` FOREIGN KEY (`author_id`) REFERENCES `books_author` (`id`),
  CONSTRAINT `books_book_authors_book_id_ed3433e7_fk_books_book_id` FOREIGN KEY (`book_id`) REFERENCES `books_book` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books_book_authors`
--

LOCK TABLES `books_book_authors` WRITE;
/*!40000 ALTER TABLE `books_book_authors` DISABLE KEYS */;
INSERT INTO `books_book_authors` VALUES (5,4,5),(7,5,6),(8,6,1),(9,7,2),(10,7,4),(11,8,7),(12,9,8),(13,10,9),(14,11,10),(15,12,11),(16,13,12);
/*!40000 ALTER TABLE `books_book_authors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `books_publish`
--

DROP TABLE IF EXISTS `books_publish`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `books_publish` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `city` varchar(60) DEFAULT NULL,
  `address` varchar(60) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books_publish`
--

LOCK TABLES `books_publish` WRITE;
/*!40000 ALTER TABLE `books_publish` DISABLE KEYS */;
INSERT INTO `books_publish` VALUES (2,'人民文学出版社','北京','北京市东城区朝阳门内大街166号'),(3,'明报','香港','香港特别行政区东区柴湾嘉业街18号'),(4,'北京师范大学出版社','北京','北京西三环花园桥路23号'),(5,'广州大学出版社','广州','广州越秀区黄埔路94号'),(6,'文化生活出版社','上海','上海'),(7,'湖北少年儿童出版社','武汉','中国湖北省武汉市雄楚大街268号出版文化城'),(8,'作家出版社','北京','北京市房山区琉璃河地区 京深路4区'),(9,'内蒙古人民出版社','呼和浩特','内蒙古呼和浩特市新城区');
/*!40000 ALTER TABLE `books_publish` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=158 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (4,'accounts','user'),(2,'auth','group'),(1,'auth','permission'),(157,'books','author'),(155,'books','book'),(156,'books','publish'),(3,'contenttypes','contenttype'),(6,'menu','menu'),(13,'resources','cabinet'),(8,'resources','idc'),(9,'resources','ip'),(11,'resources','manufacturer'),(14,'resources','networkdevice'),(7,'resources','product'),(12,'resources','productmodel'),(10,'resources','server'),(5,'sessions','session'),(15,'zabbix','acknowledges'),(16,'zabbix','actions'),(17,'zabbix','alerts'),(18,'zabbix','applicationdiscovery'),(19,'zabbix','applicationprototype'),(20,'zabbix','applications'),(21,'zabbix','applicationtemplate'),(22,'zabbix','auditlog'),(23,'zabbix','auditlogdetails'),(24,'zabbix','autoreghost'),(25,'zabbix','conditions'),(26,'zabbix','config'),(127,'zabbix','corrcondition'),(129,'zabbix','corrconditiongroup'),(131,'zabbix','corrconditiontag'),(128,'zabbix','corrconditiontagpair'),(130,'zabbix','corrconditiontagvalue'),(27,'zabbix','correlation'),(28,'zabbix','corroperation'),(29,'zabbix','dashboard'),(30,'zabbix','dashboarduser'),(31,'zabbix','dashboardusrgrp'),(32,'zabbix','dbversion'),(33,'zabbix','dchecks'),(34,'zabbix','dhosts'),(35,'zabbix','drules'),(36,'zabbix','dservices'),(37,'zabbix','escalations'),(145,'zabbix','eventrecovery'),(146,'zabbix','events'),(38,'zabbix','eventtag'),(39,'zabbix','expressions'),(40,'zabbix','functions'),(41,'zabbix','globalmacro'),(42,'zabbix','globalvars'),(133,'zabbix','graphdiscovery'),(132,'zabbix','graphs'),(43,'zabbix','graphsitems'),(44,'zabbix','graphtheme'),(134,'zabbix','groupdiscovery'),(45,'zabbix','groupprototype'),(135,'zabbix','groups'),(46,'zabbix','history'),(47,'zabbix','historylog'),(48,'zabbix','historystr'),(49,'zabbix','historytext'),(50,'zabbix','historyuint'),(136,'zabbix','hostdiscovery'),(138,'zabbix','hostinventory'),(51,'zabbix','hostmacro'),(137,'zabbix','hosts'),(52,'zabbix','hostsgroups'),(53,'zabbix','hoststemplates'),(54,'zabbix','housekeeper'),(55,'zabbix','httpstep'),(56,'zabbix','httpstepfield'),(57,'zabbix','httpstepitem'),(58,'zabbix','httptest'),(59,'zabbix','httptestfield'),(60,'zabbix','httptestitem'),(61,'zabbix','iconmap'),(62,'zabbix','iconmapping'),(63,'zabbix','ids'),(64,'zabbix','images'),(140,'zabbix','interface'),(139,'zabbix','interfacediscovery'),(65,'zabbix','itemapplicationprototype'),(66,'zabbix','itemcondition'),(67,'zabbix','itemdiscovery'),(68,'zabbix','itempreproc'),(69,'zabbix','items'),(70,'zabbix','itemsapplications'),(71,'zabbix','maintenances'),(72,'zabbix','maintenancesgroups'),(73,'zabbix','maintenanceshosts'),(74,'zabbix','maintenanceswindows'),(75,'zabbix','mappings'),(76,'zabbix','media'),(77,'zabbix','mediatype'),(142,'zabbix','opcommand'),(78,'zabbix','opcommandgrp'),(79,'zabbix','opcommandhst'),(80,'zabbix','opconditions'),(144,'zabbix','operations'),(81,'zabbix','opgroup'),(141,'zabbix','opinventory'),(143,'zabbix','opmessage'),(82,'zabbix','opmessagegrp'),(83,'zabbix','opmessageusr'),(84,'zabbix','optemplate'),(147,'zabbix','problem'),(85,'zabbix','problemtag'),(86,'zabbix','profiles'),(87,'zabbix','proxyautoreghost'),(88,'zabbix','proxydhistory'),(89,'zabbix','proxyhistory'),(90,'zabbix','regexps'),(91,'zabbix','rights'),(92,'zabbix','screens'),(93,'zabbix','screensitems'),(94,'zabbix','screenuser'),(95,'zabbix','screenusrgrp'),(96,'zabbix','scripts'),(97,'zabbix','servicealarms'),(98,'zabbix','services'),(99,'zabbix','serviceslinks'),(100,'zabbix','servicestimes'),(101,'zabbix','sessions'),(102,'zabbix','slides'),(103,'zabbix','slideshows'),(104,'zabbix','slideshowuser'),(105,'zabbix','slideshowusrgrp'),(106,'zabbix','sysmapelementtrigger'),(107,'zabbix','sysmapelementurl'),(108,'zabbix','sysmaps'),(109,'zabbix','sysmapselements'),(110,'zabbix','sysmapshape'),(111,'zabbix','sysmapslinks'),(112,'zabbix','sysmapslinktriggers'),(113,'zabbix','sysmapurl'),(114,'zabbix','sysmapuser'),(115,'zabbix','sysmapusrgrp'),(148,'zabbix','task'),(151,'zabbix','taskacknowledge'),(152,'zabbix','taskcloseproblem'),(149,'zabbix','taskremotecommand'),(150,'zabbix','taskremotecommandresult'),(116,'zabbix','timeperiods'),(117,'zabbix','trends'),(118,'zabbix','trendsuint'),(119,'zabbix','triggerdepends'),(154,'zabbix','triggerdiscovery'),(153,'zabbix','triggers'),(120,'zabbix','triggertag'),(121,'zabbix','users'),(122,'zabbix','usersgroups'),(123,'zabbix','usrgrp'),(124,'zabbix','valuemaps'),(125,'zabbix','widget'),(126,'zabbix','widgetfield');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2020-11-03 13:57:59.147160'),(2,'contenttypes','0002_remove_content_type_name','2020-11-03 13:57:59.185647'),(3,'auth','0001_initial','2020-11-03 13:57:59.305792'),(4,'auth','0002_alter_permission_name_max_length','2020-11-03 13:57:59.331078'),(5,'auth','0003_alter_user_email_max_length','2020-11-03 13:57:59.341774'),(6,'auth','0004_alter_user_username_opts','2020-11-03 13:57:59.350781'),(7,'auth','0005_alter_user_last_login_null','2020-11-03 13:57:59.359685'),(8,'auth','0006_require_contenttypes_0002','2020-11-03 13:57:59.363311'),(9,'auth','0007_alter_validators_add_error_messages','2020-11-03 13:57:59.372216'),(10,'auth','0008_alter_user_username_max_length','2020-11-03 13:57:59.381134'),(11,'accounts','0001_initial','2020-11-03 13:57:59.518783'),(12,'sessions','0001_initial','2020-11-03 13:58:16.430698'),(14,'resources','0001_initial','2020-11-03 14:45:56.084678'),(15,'zabbix','0001_initial','2020-11-03 15:47:05.875312'),(16,'menu','0002_auto_20201103_1635','2020-11-03 16:36:06.343810'),(17,'books','0001_initial','2020-11-03 18:25:05.902790'),(18,'menu','0001_initial','2020-11-05 13:47:19.597747');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('7bkzjfv5yi5xxwzzvfnkaobzi8fh7icq','NDFjOTI2MzY5ZWI5MzNmOGExMjgwZDY4ZTMxNmZmNzZiZWUzOWU4Mjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIzN2JmZmRkMzY4MTQ4MmE4YWVjMDNjOWFlZTk4ZjJlYjY0YTk4MTQ4In0=','2020-11-20 10:17:18.041039'),('nldsvehhdmji4by9ipc913jql4d3f4p7','NDFjOTI2MzY5ZWI5MzNmOGExMjgwZDY4ZTMxNmZmNzZiZWUzOWU4Mjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIzN2JmZmRkMzY4MTQ4MmE4YWVjMDNjOWFlZTk4ZjJlYjY0YTk4MTQ4In0=','2020-11-19 16:13:38.829193'),('xetkvz6qywy4d9zyrhci0hcrhrhezbi8','NDFjOTI2MzY5ZWI5MzNmOGExMjgwZDY4ZTMxNmZmNzZiZWUzOWU4Mjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIzN2JmZmRkMzY4MTQ4MmE4YWVjMDNjOWFlZTk4ZjJlYjY0YTk4MTQ4In0=','2020-11-17 17:11:16.988812');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resources_cabinet`
--

DROP TABLE IF EXISTS `resources_cabinet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resources_cabinet` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `power_supply` int(11) NOT NULL,
  `idc_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `resources_cabinet_idc_id_4c48bdaf_fk_resources_idc_id` (`idc_id`),
  CONSTRAINT `resources_cabinet_idc_id_4c48bdaf_fk_resources_idc_id` FOREIGN KEY (`idc_id`) REFERENCES `resources_idc` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resources_cabinet`
--

LOCK TABLES `resources_cabinet` WRITE;
/*!40000 ALTER TABLE `resources_cabinet` DISABLE KEYS */;
INSERT INTO `resources_cabinet` VALUES (1,'zw-101',220,1),(2,'yz-402',110,2),(3,'hy-701',240,4);
/*!40000 ALTER TABLE `resources_cabinet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resources_idc`
--

DROP TABLE IF EXISTS `resources_idc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resources_idc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `letter` varchar(10) NOT NULL,
  `name` varchar(30) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `tel` varchar(15) DEFAULT NULL,
  `mail` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `letter` (`letter`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resources_idc`
--

LOCK TABLES `resources_idc` WRITE;
/*!40000 ALTER TABLE `resources_idc` DISABLE KEYS */;
INSERT INTO `resources_idc` VALUES (1,'zw','兆维机房','北京朝阳酒仙桥32号兆维大厦','13200000000','zw@11.com','北京地区'),(2,'yz','亦庄机房','北京大兴亦庄工业园','13200000000','yz@11.com',''),(4,'hy','华苑机房','天津塘沽','13200000000','hy@11.com','');
/*!40000 ALTER TABLE `resources_idc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resources_ip`
--

DROP TABLE IF EXISTS `resources_ip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resources_ip` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip_addr` varchar(20) NOT NULL,
  `netmask` varchar(20) NOT NULL,
  `device_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `resources_ip_ip_addr_52f00979` (`ip_addr`),
  KEY `resources_ip_device_id_fdac0136_fk_resources_networkdevice_id` (`device_id`),
  CONSTRAINT `resources_ip_device_id_fdac0136_fk_resources_networkdevice_id` FOREIGN KEY (`device_id`) REFERENCES `resources_networkdevice` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resources_ip`
--

LOCK TABLES `resources_ip` WRITE;
/*!40000 ALTER TABLE `resources_ip` DISABLE KEYS */;
/*!40000 ALTER TABLE `resources_ip` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resources_manufacturer`
--

DROP TABLE IF EXISTS `resources_manufacturer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resources_manufacturer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vendor_name` varchar(32) NOT NULL,
  `tel` varchar(20) DEFAULT NULL,
  `mail` varchar(254) DEFAULT NULL,
  `remark` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `resources_manufacturer_vendor_name_848ea581` (`vendor_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resources_manufacturer`
--

LOCK TABLES `resources_manufacturer` WRITE;
/*!40000 ALTER TABLE `resources_manufacturer` DISABLE KEYS */;
INSERT INTO `resources_manufacturer` VALUES (1,'Dell','13200000000','dell@11.com','戴尔'),(2,'Inspur','13200000000','ins@11.com','浪潮');
/*!40000 ALTER TABLE `resources_manufacturer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resources_networkdevice`
--

DROP TABLE IF EXISTS `resources_networkdevice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resources_networkdevice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `mac` varchar(32) NOT NULL,
  `remark` varchar(300) DEFAULT NULL,
  `host_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `resources_networkdevice_host_id_6d694dfd_fk_resources_server_id` (`host_id`),
  CONSTRAINT `resources_networkdevice_host_id_6d694dfd_fk_resources_server_id` FOREIGN KEY (`host_id`) REFERENCES `resources_server` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resources_networkdevice`
--

LOCK TABLES `resources_networkdevice` WRITE;
/*!40000 ALTER TABLE `resources_networkdevice` DISABLE KEYS */;
/*!40000 ALTER TABLE `resources_networkdevice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resources_product`
--

DROP TABLE IF EXISTS `resources_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resources_product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `service_name` varchar(32) NOT NULL,
  `pid` int(11) NOT NULL,
  `module_letter` varchar(32) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `resources_product_pid_724b87ff` (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resources_product`
--

LOCK TABLES `resources_product` WRITE;
/*!40000 ALTER TABLE `resources_product` DISABLE KEYS */;
INSERT INTO `resources_product` VALUES (1,'太古神王',0,'tgsw'),(2,'提审测试',1,'ts'),(3,'港澳台项目',0,'HTA'),(4,'吞星',3,'tx'),(5,'战斗服',3,'figter');
/*!40000 ALTER TABLE `resources_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resources_product_dev_interface`
--

DROP TABLE IF EXISTS `resources_product_dev_interface`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resources_product_dev_interface` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `resources_product_dev_interface_product_id_user_id_aad8d170_uniq` (`product_id`,`user_id`),
  KEY `resources_product_dev_interface_user_id_c636192b_fk_auth_user_id` (`user_id`),
  CONSTRAINT `resources_product_de_product_id_18f8f4a1_fk_resources` FOREIGN KEY (`product_id`) REFERENCES `resources_product` (`id`),
  CONSTRAINT `resources_product_dev_interface_user_id_c636192b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resources_product_dev_interface`
--

LOCK TABLES `resources_product_dev_interface` WRITE;
/*!40000 ALTER TABLE `resources_product_dev_interface` DISABLE KEYS */;
INSERT INTO `resources_product_dev_interface` VALUES (1,1,3),(2,2,3),(3,3,3),(4,4,3),(5,5,3);
/*!40000 ALTER TABLE `resources_product_dev_interface` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resources_product_op_interface`
--

DROP TABLE IF EXISTS `resources_product_op_interface`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resources_product_op_interface` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `resources_product_op_interface_product_id_user_id_d006813b_uniq` (`product_id`,`user_id`),
  KEY `resources_product_op_interface_user_id_a7ec9880_fk_auth_user_id` (`user_id`),
  CONSTRAINT `resources_product_op_interface_user_id_a7ec9880_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `resources_product_op_product_id_58008386_fk_resources` FOREIGN KEY (`product_id`) REFERENCES `resources_product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resources_product_op_interface`
--

LOCK TABLES `resources_product_op_interface` WRITE;
/*!40000 ALTER TABLE `resources_product_op_interface` DISABLE KEYS */;
INSERT INTO `resources_product_op_interface` VALUES (1,1,2),(2,2,2),(3,3,2),(4,4,2),(5,5,2);
/*!40000 ALTER TABLE `resources_product_op_interface` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resources_productmodel`
--

DROP TABLE IF EXISTS `resources_productmodel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resources_productmodel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `model_name` varchar(32) NOT NULL,
  `vendor_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `resources_productmod_vendor_id_7e006d79_fk_resources` (`vendor_id`),
  CONSTRAINT `resources_productmod_vendor_id_7e006d79_fk_resources` FOREIGN KEY (`vendor_id`) REFERENCES `resources_manufacturer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resources_productmodel`
--

LOCK TABLES `resources_productmodel` WRITE;
/*!40000 ALTER TABLE `resources_productmodel` DISABLE KEYS */;
INSERT INTO `resources_productmodel` VALUES (1,'R720',1),(2,'R910',1),(3,'NF5280M5',2);
/*!40000 ALTER TABLE `resources_productmodel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resources_server`
--

DROP TABLE IF EXISTS `resources_server`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resources_server` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `manufacture_data` date DEFAULT NULL,
  `cabinet_position` varchar(32) DEFAULT NULL,
  `warranty_time` date DEFAULT NULL,
  `purchasing_time` date DEFAULT NULL,
  `power_supply` int(11) DEFAULT NULL,
  `os` varchar(100) NOT NULL,
  `hostname` varchar(50) NOT NULL,
  `manage_ip` varchar(32) NOT NULL,
  `server_cpu` varchar(250) NOT NULL,
  `disk` varchar(300) DEFAULT NULL,
  `server_mem` varchar(100) NOT NULL,
  `status` varchar(32) DEFAULT NULL,
  `remark` longtext,
  `last_check` datetime(6) NOT NULL,
  `uuid` varchar(100) DEFAULT NULL,
  `sn` varchar(40) DEFAULT NULL,
  `rmt_card_ip` varchar(15) DEFAULT NULL,
  `server_type` int(11) NOT NULL,
  `cabinet_id` int(11) DEFAULT NULL,
  `idc_id` int(11) DEFAULT NULL,
  `manufacturer_id` int(11) DEFAULT NULL,
  `model_name_id` int(11) NOT NULL,
  `server_purpose_id` int(11) DEFAULT NULL,
  `service_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `resources_server_cabinet_id_b6bc883b_fk_resources_cabinet_id` (`cabinet_id`),
  KEY `resources_server_idc_id_fe131330_fk_resources_idc_id` (`idc_id`),
  KEY `resources_server_manufacturer_id_e95c0de3_fk_resources` (`manufacturer_id`),
  KEY `resources_server_model_name_id_95b32a09_fk_resources` (`model_name_id`),
  KEY `resources_server_server_purpose_id_c7534444_fk_resources` (`server_purpose_id`),
  KEY `resources_server_service_id_a9f14ac5_fk_resources_product_id` (`service_id`),
  KEY `resources_server_hostname_2a827d99` (`hostname`),
  KEY `resources_server_manage_ip_5341bf39` (`manage_ip`),
  KEY `resources_server_status_0ada9115` (`status`),
  KEY `resources_server_sn_3369a7d0` (`sn`),
  KEY `resources_server_server_type_400132b7` (`server_type`),
  CONSTRAINT `resources_server_cabinet_id_b6bc883b_fk_resources_cabinet_id` FOREIGN KEY (`cabinet_id`) REFERENCES `resources_cabinet` (`id`),
  CONSTRAINT `resources_server_idc_id_fe131330_fk_resources_idc_id` FOREIGN KEY (`idc_id`) REFERENCES `resources_idc` (`id`),
  CONSTRAINT `resources_server_manufacturer_id_e95c0de3_fk_resources` FOREIGN KEY (`manufacturer_id`) REFERENCES `resources_manufacturer` (`id`),
  CONSTRAINT `resources_server_model_name_id_95b32a09_fk_resources` FOREIGN KEY (`model_name_id`) REFERENCES `resources_productmodel` (`id`),
  CONSTRAINT `resources_server_server_purpose_id_c7534444_fk_resources` FOREIGN KEY (`server_purpose_id`) REFERENCES `resources_product` (`id`),
  CONSTRAINT `resources_server_service_id_a9f14ac5_fk_resources_product_id` FOREIGN KEY (`service_id`) REFERENCES `resources_product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resources_server`
--

LOCK TABLES `resources_server` WRITE;
/*!40000 ALTER TABLE `resources_server` DISABLE KEYS */;
INSERT INTO `resources_server` VALUES (1,'2020-10-27','第三层','2021-04-02','2020-11-03',220,'centos7','test-1','1.2.11.22','4','200G','8','在线','测试','2020-11-03 17:13:17.973242','1231231232132','1231212','2.2.2.2',1,1,1,1,1,2,1);
/*!40000 ALTER TABLE `resources_server` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `view_menu`
--

DROP TABLE IF EXISTS `view_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `view_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `path` varchar(100) NOT NULL,
  `icon` varchar(32) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `show` tinyint(1) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `view_menu_parent_id_11cc04dc_fk_view_menu_id` (`parent_id`),
  CONSTRAINT `view_menu_parent_id_11cc04dc_fk_view_menu_id` FOREIGN KEY (`parent_id`) REFERENCES `view_menu` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `view_menu`
--

LOCK TABLES `view_menu` WRITE;
/*!40000 ALTER TABLE `view_menu` DISABLE KEYS */;
INSERT INTO `view_menu` VALUES (1,'/','dashboard','Dashboard',1,NULL),(2,'/users','user','用户管理',1,NULL),(3,'/group/groupPermission','','权限列表',0,2),(4,'/list','','用户列表',1,2),(5,'/group','','角色',1,2),(6,'/resources','tree','资源管理',1,NULL),(7,'/idc','user','IDC机房',1,6),(8,'/ip','user','IP管理',0,6),(9,'/product','user','业务线管理',1,6),(10,'/manufacturer','user','制造商',0,6),(11,'/server','user','服务器',1,6),(12,'/product_model','user','机器型号',0,6),(13,'/cabinet','user','机柜管理',1,6),(14,'/network_device','user','网卡管理',0,6),(15,'/monitor','chart','监控管理',1,NULL),(16,'/zabbix','','Zabbix',1,15),(17,'/books','example','图书管理系统',1,NULL),(18,'/book','table','图书',1,17),(19,'/author','','作者',1,17),(20,'/publish','','出版社',1,17);
/*!40000 ALTER TABLE `view_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `view_menu_groups`
--

DROP TABLE IF EXISTS `view_menu_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `view_menu_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `menu_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `view_menu_groups_menu_id_group_id_9e499f9b_uniq` (`menu_id`,`group_id`),
  KEY `view_menu_groups_group_id_14f28df1_fk_auth_group_id` (`group_id`),
  CONSTRAINT `view_menu_groups_group_id_14f28df1_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `view_menu_groups_menu_id_2c9db833_fk_view_menu_id` FOREIGN KEY (`menu_id`) REFERENCES `view_menu` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `view_menu_groups`
--

LOCK TABLES `view_menu_groups` WRITE;
/*!40000 ALTER TABLE `view_menu_groups` DISABLE KEYS */;
INSERT INTO `view_menu_groups` VALUES (1,6,2),(2,7,2),(3,8,2),(4,9,2),(5,10,2),(6,11,2),(7,12,2),(8,13,2),(9,14,2),(10,17,2),(11,18,2),(12,19,2),(13,20,2);
/*!40000 ALTER TABLE `view_menu_groups` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-11-09 16:28:25
