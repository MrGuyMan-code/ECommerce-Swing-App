-- MySQL dump 10.13  Distrib 8.0.45, for Linux (x86_64)
--
-- Host: localhost    Database: ecommerce_db
-- ------------------------------------------------------
-- Server version	8.0.45-0ubuntu0.24.04.1

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

--
-- Table structure for table `audit_comenzi_anulate`
--

DROP TABLE IF EXISTS `audit_comenzi_anulate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audit_comenzi_anulate` (
  `id_audit` int NOT NULL AUTO_INCREMENT,
  `id_comanda` int DEFAULT NULL,
  `id_client` int DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  `status_vechi` varchar(50) DEFAULT NULL,
  `data_anulare` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_audit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audit_comenzi_anulate`
--

LOCK TABLES `audit_comenzi_anulate` WRITE;
/*!40000 ALTER TABLE `audit_comenzi_anulate` DISABLE KEYS */;
/*!40000 ALTER TABLE `audit_comenzi_anulate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categorii`
--

DROP TABLE IF EXISTS `categorii`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categorii` (
  `id_categorie` int NOT NULL AUTO_INCREMENT,
  `nume` varchar(100) NOT NULL,
  `id_categorie_parinte` int DEFAULT NULL,
  `descriere` text,
  PRIMARY KEY (`id_categorie`),
  KEY `id_categorie_parinte` (`id_categorie_parinte`),
  CONSTRAINT `categorii_ibfk_1` FOREIGN KEY (`id_categorie_parinte`) REFERENCES `categorii` (`id_categorie`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorii`
--

LOCK TABLES `categorii` WRITE;
/*!40000 ALTER TABLE `categorii` DISABLE KEYS */;
INSERT INTO `categorii` VALUES (1,'Laptopuri',NULL,'Calculatoare portabile'),(2,'Telefoane',NULL,'Smartphone-uri și accesorii'),(3,'Tablete',NULL,'Dispozitive tabletă'),(4,'Televizoare',NULL,'Televizoare smart'),(5,'Audio',NULL,'Căști, boxe, sisteme audio'),(6,'Fotografie',NULL,'Camere foto, camere video'),(7,'Gaming',NULL,'Console, jocuri, periferice'),(8,'Îmbrăcăminte bărbați',NULL,'Haine pentru bărbați'),(9,'Îmbrăcăminte femei',NULL,'Haine pentru femei'),(10,'Încălțăminte bărbați',NULL,'Pantofi pentru bărbați'),(11,'Încălțăminte femei',NULL,'Pantofi pentru femei'),(12,'Accesorii',NULL,'Ceasuri, bijuterii, genți'),(13,'Sport',NULL,'Echipamente sportive'),(14,'Casă și grădină',NULL,'Mobilier, decorațiuni'),(15,'Electrocasnice',NULL,'Aparate electrocasnice'),(16,'Telefoane flagship',NULL,'Calculatoare portabile'),(17,'Telefoane mid-range',NULL,'Smartphone-uri și accesorii'),(18,'Telefoane buget',NULL,'Dispozitive tabletă'),(19,'Laptopuri gaming',NULL,'Televizoare smart'),(20,'Laptopuri office',NULL,'Căști, boxe, sisteme audio'),(21,'Tablete Android',NULL,'Camere foto, camere video'),(22,'Tablete iPad',NULL,'Console, jocuri, periferice'),(23,'Blugi bărbați',NULL,'Haine pentru bărbați'),(24,'Cămăși bărbați',NULL,'Haine pentru femei'),(25,'Rochii femei',NULL,'Pantofi pentru bărbați'),(26,'Bluze femei',NULL,'Pantofi pentru femei'),(27,'Echipamente fitness',NULL,'Ceasuri, bijuterii, genți'),(28,'Îmbrăcăminte sport',NULL,'Echipamente sportive'),(29,'Încălțăminte sport',NULL,'Mobilier, decorațiuni'),(30,'Mobilier living',NULL,'Aparate electrocasnice'),(31,'Decorațiuni',14,'Tablouri, vaze, obiecte decorative'),(32,'Electrocasnice mici',15,'Aparate electrocasnice mici'),(33,'Căști audio',5,'Căști wireless și wired'),(34,'Boxe portabile',5,'Boxe Bluetooth și portabile'),(35,'Smartwatch-uri',12,'Ceasuri inteligente'),(36,'Accesorii telefoane',12,'Huse, încărcătoare, folii'),(37,'Tricouri bărbați',8,'Tricouri casual și polo'),(38,'Geci bărbați',8,'Geci de iarnă și demi-sezon'),(39,'Costume bărbați',8,'Costume formale și casual'),(40,'Fuste femei',9,'Fuste diverse lungimi'),(41,'Paltoane femei',9,'Paltoane de iarnă și toamnă'),(42,'Pantaloni femei',9,'Pantaloni elefanți, skinny, cargo'),(43,'Pantofi bărbați',10,'Pantofi eleganți și casual'),(44,'Tenși bărbați',10,'Adidași și sneakers'),(45,'Ghete bărbați',10,'Ghete de iarnă și trekking'),(46,'Pantofi femei',11,'Pantofi eleganți și balerini'),(47,'Tenși femei',11,'Sneakers și adidași'),(48,'Cizme femei',11,'Cizme de iarnă și toamnă'),(49,'Accesorii sport',13,'Bidoane, genți, accesorii'),(50,'Yoga și Pilates',13,'Covoare, accesorii yoga'),(51,'Mobilier dormitor',14,'Paturi, dulapuri, noptiere'),(52,'Iluminat',14,'Lămpi, corpuri de iluminat'),(53,'Grădină',14,'Mobilier grădină, unelte'),(54,'Electrocasnice mari',15,'Frigidere, mașini spălat'),(55,'Îngrijire personală',15,'Uscătoare păr, aparate ras'),(56,'Console gaming',7,'PlayStation, Xbox, Nintendo'),(57,'Periferice gaming',7,'Mouse, tastaturi, căști gaming'),(58,'Jocuri video',7,'Jocuri pentru diverse console');
/*!40000 ALTER TABLE `categorii` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clienti`
--

DROP TABLE IF EXISTS `clienti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clienti` (
  `id_client` int NOT NULL AUTO_INCREMENT,
  `nume` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `telefon` varchar(20) DEFAULT NULL,
  `adresa` text,
  `data_inregistrare` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_client`),
  UNIQUE KEY `email` (`email`),
  KEY `idx_clienti_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clienti`
--

LOCK TABLES `clienti` WRITE;
/*!40000 ALTER TABLE `clienti` DISABLE KEYS */;
INSERT INTO `clienti` VALUES (1,'Ion Popescu','andrei.popescu@email.com','0721123401','București, Str. Victoriei nr. 1','2026-04-01 21:58:11'),(2,'Maria Ionescu','elena.ionescu@email.com','0721123402','Cluj-Napoca, Str. Memorandumului nr. 5','2026-04-01 21:58:11'),(3,'Andrei Popescu','mihai.georgescu@email.com','0721123403','Timișoara, Str. Alba Iulia nr. 10','2026-04-01 21:58:11'),(4,'Elena Ionescu','ana.dumitrescu@email.com','0721123404','Iași, Str. Ștefan cel Mare nr. 15','2026-04-01 21:58:11'),(5,'Mihai Georgescu','cristian.vasile@email.com','0721123405','Constanța, Str. Ferdinand nr. 20','2026-04-01 21:58:11'),(6,'Ana Dumitrescu','diana.stan@email.com','0721123406','Brașov, Str. Republicii nr. 8','2026-04-01 21:58:11'),(7,'Cristian Vasile','florin.marin@email.com','0721123407','Craiova, Str. Unirii nr. 12','2026-04-01 21:58:11'),(8,'Diana Stan','gabriela.dobre@email.com','0721123408','Galați, Str. Domnească nr. 3','2026-04-01 21:58:11'),(9,'Florin Marin','horia.neagu@email.com','0721123409','Ploiești, Str. Independenței nr. 7','2026-04-01 21:58:11'),(10,'Gabriela Dobre','ioana.radu@email.com','0721123410','Oradea, Str. Republicii nr. 25','2026-04-01 21:58:11'),(11,'Iulian Popa','iulian.popa@email.com','0721123411','Bacău, Str. Mărășești nr. 14','2026-04-01 21:58:11'),(12,'Laura Stoica','laura.stoica@email.com','0721123412','Arad, Str. Revoluției nr. 9','2026-04-01 21:58:11'),(13,'Marius Toma','marius.toma@email.com','0721123413','Sibiu, Str. Avram Iancu nr. 18','2026-04-01 21:58:11'),(14,'Nicoleta Bălan','nicoleta.balan@email.com','0721123414','Târgu Mureș, Str. Gheorghe Doja nr. 22','2026-04-01 21:58:11'),(15,'Ovidiu Cernat','ovidiu.cernat@email.com','0721123415','Baia Mare, Str. Victoriei nr. 30','2026-04-01 21:58:11'),(16,'Paula Rădulescu','paula.radulescu@email.com','0721123416','Buzău, Str. Nicolae Bălcescu nr. 5','2026-04-01 21:58:11'),(17,'Radu Constantinescu','radu.constantinescu@email.com','0721123417','Satu Mare, Str. Libertății nr. 11','2026-04-01 21:58:11'),(18,'Simona Tudor','simona.tudor@email.com','0721123418','Botoșani, Str. Păcii nr. 8','2026-04-01 21:58:11'),(19,'Tudor Andrei','tudor.andrei@email.com','0721123419','Râmnicu Vâlcea, Str. Tudor Vladimirescu nr. 16','2026-04-01 21:58:11'),(20,'Valentina Matei','valentina.matei@email.com','0721123420','Focșani, Str. Unirii nr. 23','2026-04-01 21:58:11'),(21,'Alexandru Munteanu','alexandru.munteanu@email.com','0721123421','Pitești, Str. Eroilor nr. 4','2026-04-01 21:58:11'),(22,'Bianca Cojocaru','bianca.cojocaru@email.com','0721123422','Suceava, Str. Ștefan cel Mare nr. 19','2026-04-01 21:58:11'),(23,'Cătălin Barbu','catalin.barbu@email.com','0721123423','Drobeta-Turnu Severin, Str. Traian nr. 27','2026-04-01 21:58:11'),(24,'Daniela Gheorghe','daniela.gheorghe@email.com','0721123424','Alba Iulia, Str. Mihai Viteazul nr. 13','2026-04-01 21:58:11'),(25,'Emil Drăghici','emil.draghici@email.com','0721123425','Tulcea, Str. Isaccei nr. 6','2026-04-01 21:58:11'),(26,'Florentina Nistor','florentina.nistor@email.com','0721123426','Slatina, Str. Griviței nr. 31','2026-04-01 21:58:11'),(27,'George Istrate','george.istrate@email.com','0721123427','Călărași, Str. București nr. 2','2026-04-01 21:58:11'),(28,'Horațiu Pintea','horatiu.pintea@email.com','0721123428','Giurgiu, Str. 1 Mai nr. 17','2026-04-01 21:58:11'),(29,'Ileana Mocanu','ileana.mocanu@email.com','0721123429','Deva, Str. 22 Decembrie nr. 24','2026-04-01 21:58:11'),(30,'Jean Lupu','jean.lupu@email.com','0721123430','Hunedoara, Str. Principală nr. 8','2026-04-01 21:58:11'),(31,'Karla Voicu','karla.voicu@email.com','0721123431','Zalău, Str. Simion Bărnuțiu nr. 12','2026-04-01 21:58:11'),(32,'Lucian Niță','lucian.nita@email.com','0721123432','Reșița, Str. Calea Severinului nr. 5','2026-04-01 21:58:11'),(33,'Mădălina Paraschiv','madalina.paraschiv@email.com','0721123433','Slobozia, Str. Ștefan cel Mare nr. 19','2026-04-01 21:58:11'),(34,'Nicolae Enache','nicolae.enache@email.com','0721123434','Alexandria, Str. Dunării nr. 33','2026-04-01 21:58:11'),(35,'Oana Bucur','oana.bucur@email.com','0721123435','Vaslui, Str. Decebal nr. 14','2026-04-01 21:58:11'),(36,'Paul Grigore','paul.grigore@email.com','0721123436','Bârlad, Str. Republicii nr. 7','2026-04-01 21:58:11'),(37,'Raluca Dumitru','raluca.dumitru@email.com','0721123437','Medgidia, Str. Ovidiu nr. 21','2026-04-01 21:58:11'),(38,'Sorin Anghel','sorin.anghel@email.com','0721123438','Roman, Str. Mihai Eminescu nr. 9','2026-04-01 21:58:11'),(39,'Teodora Pavel','teodora.pavel@email.com','0721123439','Odorheiu Secuiesc, Str. Bethlen nr. 16','2026-04-01 21:58:11'),(40,'Vlad Ciobanu','vlad.ciobanu@email.com','0721123440','Petroșani, Str. 1 Decembrie nr. 28','2026-04-01 21:58:11'),(41,'Andreea Olteanu','andreea.olteanu@email.com','0721123441','Câmpina, Str. Culturii nr. 11','2026-04-01 21:58:11'),(42,'Bogdan Stancu','bogdan.stancu@email.com','0721123442','Curtea de Argeș, Str. Negru Vodă nr. 4','2026-04-01 21:58:11'),(43,'Carmen Florea','carmen.florea@email.com','0721123443','Miercurea Ciuc, Str. Petőfi Sándor nr. 22','2026-04-01 21:58:11'),(44,'Dragoș Ilie','dragos.ilie@email.com','0721123444','Făgăraș, Str. 13 Decembrie nr. 18','2026-04-01 21:58:11'),(45,'Ecaterina Lazăr','ecaterina.lazar@email.com','0721123445','Sfântu Gheorghe, Str. Kós Károly nr. 7','2026-04-01 21:58:11'),(46,'Felix Mihăilescu','felix.mihailescu@email.com','0721123446','Lugoj, Str. Eroilor nr. 29','2026-04-01 21:58:11'),(47,'Georgiana Voinea','georgiana.voinea@email.com','0721123447','Caracal, Str. Victoriei nr. 13','2026-04-01 21:58:11'),(48,'Haralambie Popovici','haralambie.popovici@email.com','0721123448','Mangalia, Str. Olimpului nr. 25','2026-04-01 21:58:11'),(49,'Irina Coman','irina.coman@email.com','0721123449','Motru, Str. Principală nr. 31','2026-04-01 21:58:11'),(50,'Jozsef Szabo','jozsef.szabo@email.com','0721123450','Târgu Secuiesc, Str. Gábor Áron nr. 6','2026-04-01 21:58:11'),(101,'Alexandru Marin','alexandru.marin@email.com','0721123451','București, Calea Victoriei nr. 45','2026-04-01 22:26:51'),(102,'Ioana Popa','ioana.popa@email.com','0721123452','Cluj-Napoca, Str. Eroilor nr. 12','2026-04-01 22:26:51'),(103,'Marius Iancu','marius.iancu@email.com','0721123453','Timișoara, Str. Bega nr. 8','2026-04-01 22:26:51'),(104,'Andreea Stoica','andreea.stoica@email.com','0721123454','Iași, B-dul Ștefan cel Mare nr. 22','2026-04-01 22:26:51'),(105,'Radu Neagu','radu.neagu@email.com','0721123455','Constanța, Str. Mamaia nr. 10','2026-04-01 22:26:51'),(106,'Camelia Dinu','camelia.dinu@email.com','0721123456','Brașov, Str. Lungă nr. 15','2026-04-01 22:26:51'),(107,'Vlad Petrescu','vlad.petrescu@email.com','0721123457','Craiova, Str. România nr. 30','2026-04-01 22:26:51'),(108,'Roxana Enache','roxana.enache@email.com','0721123458','Galați, Str. Portului nr. 5','2026-04-01 22:26:51'),(109,'Ștefan Voicu','stefan.voicu@email.com','0721123459','Ploiești, B-dul Republicii nr. 18','2026-04-01 22:26:51'),(110,'Monica Lazăr','monica.lazar@email.com','0721123460','Oradea, Str. Libertății nr. 7','2026-04-01 22:26:51'),(111,'Ciprian Tudor','ciprian.tudor@email.com','0721123461','Arad, Str. Revoluției nr. 23','2026-04-01 22:26:51'),(112,'Daniela Matei','daniela.matei@email.com','0721123462','Sibiu, Str. Avram Iancu nr. 14','2026-04-01 22:26:51'),(113,'Florin Chelaru','florin.chelaru@email.com','0721123463','Bacău, Str. Mărășești nr. 9','2026-04-01 22:26:51'),(114,'Larisa Coman','larisa.coman@email.com','0721123464','Târgu Mureș, Str. Gheorghe Doja nr. 11','2026-04-01 22:26:51'),(115,'Emil Cernat','emil.cernat@email.com','0721123465','Baia Mare, Str. Victoriei nr. 33','2026-04-01 22:26:51'),(116,'Gabriela Nistor','gabriela.nistor@email.com','0721123466','Buzău, Str. Unirii nr. 19','2026-04-01 22:26:51'),(117,'Sorin Oltean','sorin.oltean@email.com','0721123467','Satu Mare, Str. Libertății nr. 27','2026-04-01 22:26:51'),(118,'Alina Radu','alina.radu@email.com','0721123468','Botoșani, Str. Păcii nr. 42','2026-04-01 22:26:51'),(119,'Mihai Voinea','mihai.voinea@email.com','0721123469','Pitești, Str. Eroilor nr. 16','2026-04-01 22:26:51'),(120,'Oana Simion','oana.simion@email.com','0721123470','Suceava, Str. Ștefan cel Mare nr. 38','2026-04-01 22:26:51');
/*!40000 ALTER TABLE `clienti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comenzi`
--

DROP TABLE IF EXISTS `comenzi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comenzi` (
  `id_comanda` int NOT NULL AUTO_INCREMENT,
  `id_client` int DEFAULT NULL,
  `data_comanda` datetime DEFAULT CURRENT_TIMESTAMP,
  `status` varchar(50) DEFAULT 'pending',
  `total` decimal(10,2) DEFAULT '0.00',
  `id_metoda_plata` int DEFAULT NULL,
  PRIMARY KEY (`id_comanda`),
  KEY `id_client` (`id_client`),
  KEY `id_metoda_plata` (`id_metoda_plata`),
  KEY `idx_comenzi_data` (`data_comanda`),
  CONSTRAINT `comenzi_ibfk_1` FOREIGN KEY (`id_client`) REFERENCES `clienti` (`id_client`),
  CONSTRAINT `comenzi_ibfk_2` FOREIGN KEY (`id_metoda_plata`) REFERENCES `metode_plata` (`id_metoda`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comenzi`
--

LOCK TABLES `comenzi` WRITE;
/*!40000 ALTER TABLE `comenzi` DISABLE KEYS */;
INSERT INTO `comenzi` VALUES (1,1,'2026-04-01 22:06:55','delivered',2800.00,1),(2,2,'2026-04-01 22:06:55','pending',4200.00,2),(3,3,'2026-04-01 22:06:55','processing',350.00,1),(4,4,'2026-04-01 22:06:55','delivered',1800.00,3),(5,5,'2026-04-01 22:06:55','cancelled',1200.00,1),(6,6,'2026-04-01 22:06:55','delivered',4000.00,2),(7,7,'2026-04-01 22:06:55','pending',2500.00,1),(8,8,'2026-04-01 22:06:55','processing',3200.00,4),(9,9,'2026-04-01 22:06:55','delivered',90.00,1),(10,10,'2026-04-01 22:06:55','delivered',1500.00,2),(11,1,'2026-04-01 22:01:08','delivered',2800.00,1),(12,2,'2026-04-01 22:01:08','processing',4200.00,2),(13,3,'2026-04-01 22:01:08','delivered',350.00,1),(14,4,'2026-04-01 22:01:08','pending',1800.00,3),(15,5,'2026-04-01 22:01:08','delivered',1200.00,1),(16,6,'2026-04-01 22:01:08','shipped',4000.00,2),(17,7,'2026-04-01 22:01:08','delivered',2500.00,1),(18,8,'2026-04-01 22:01:08','processing',3200.00,4),(19,9,'2026-04-01 22:01:08','delivered',90.00,1),(20,10,'2026-04-01 22:01:08','pending',1500.00,2),(21,1,'2026-04-01 22:26:51','delivered',1750.00,1),(22,2,'2026-04-01 22:26:51','shipped',2900.00,3),(23,3,'2026-04-01 22:26:51','delivered',480.00,1),(24,4,'2026-04-01 22:26:51','processing',5600.00,2),(25,5,'2026-04-01 22:26:51','delivered',920.00,1),(26,6,'2026-04-01 22:26:51','pending',3100.00,4),(27,7,'2026-04-01 22:26:51','delivered',4300.00,1),(28,8,'2026-04-01 22:26:51','delivered',1280.00,2),(29,9,'2026-04-01 22:26:51','shipped',3500.00,1),(30,10,'2026-04-01 22:26:51','processing',2100.00,3),(31,11,'2026-04-01 22:26:51','delivered',890.00,1),(32,12,'2026-04-01 22:26:51','delivered',4700.00,2),(33,13,'2026-04-01 22:26:51','pending',550.00,1),(34,14,'2026-04-01 22:26:51','delivered',1950.00,4),(35,15,'2026-04-01 22:26:51','shipped',2800.00,1),(36,16,'2026-04-01 22:26:51','delivered',3400.00,2),(37,17,'2026-04-01 22:26:51','processing',4200.00,3),(38,18,'2026-04-01 22:26:51','delivered',1200.00,1),(39,19,'2026-04-01 22:26:51','delivered',2900.00,2),(40,20,'2026-04-01 22:26:51','pending',800.00,1),(41,101,'2026-04-04 21:58:56','pending',11150.00,1);
/*!40000 ALTER TABLE `comenzi` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `log_comanda_anulata` BEFORE UPDATE ON `comenzi` FOR EACH ROW BEGIN
    IF NEW.status = 'cancelled' AND OLD.status != 'cancelled' THEN
        INSERT INTO audit_comenzi_anulate (id_comanda, id_client, total, status_vechi)
        VALUES (OLD.id_comanda, OLD.id_client, OLD.total, OLD.status);
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `detalii_comanda`
--

DROP TABLE IF EXISTS `detalii_comanda`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalii_comanda` (
  `id_detalii` int NOT NULL AUTO_INCREMENT,
  `id_comanda` int DEFAULT NULL,
  `id_produs` int DEFAULT NULL,
  `cantitate` int NOT NULL,
  `pret_unitar` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_detalii`),
  KEY `idx_detalii_comanda_produs` (`id_produs`),
  KEY `idx_detalii_comanda_comanda` (`id_comanda`),
  CONSTRAINT `detalii_comanda_ibfk_1` FOREIGN KEY (`id_comanda`) REFERENCES `comenzi` (`id_comanda`),
  CONSTRAINT `detalii_comanda_ibfk_2` FOREIGN KEY (`id_produs`) REFERENCES `produse` (`id_produs`)
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalii_comanda`
--

LOCK TABLES `detalii_comanda` WRITE;
/*!40000 ALTER TABLE `detalii_comanda` DISABLE KEYS */;
INSERT INTO `detalii_comanda` VALUES (12,1,2,1,2800.00),(13,2,11,1,4200.00),(14,3,41,2,175.00),(15,4,16,1,1800.00),(16,5,18,1,1200.00),(17,6,3,1,3200.00),(18,6,63,2,400.00),(19,7,4,1,2500.00),(20,8,5,1,3200.00),(21,9,50,1,90.00),(22,10,62,1,1500.00),(23,40,63,3,160.00),(24,39,63,2,160.00),(25,38,63,2,160.00),(26,37,63,1,160.00),(27,36,63,1,160.00),(28,35,63,2,160.00),(29,34,63,3,160.00),(30,33,63,1,160.00),(31,32,63,1,160.00),(32,31,63,1,160.00),(33,30,63,3,160.00),(34,29,63,2,160.00),(35,28,63,3,160.00),(36,27,63,3,160.00),(37,26,63,1,160.00),(38,25,63,2,160.00),(39,24,63,2,160.00),(40,23,63,3,160.00),(41,22,63,3,160.00),(42,21,63,1,160.00),(43,20,63,3,160.00),(44,19,63,3,160.00),(45,18,63,2,160.00),(46,17,63,1,160.00),(47,16,63,1,160.00),(48,15,63,3,160.00),(49,14,63,3,160.00),(50,13,63,2,160.00),(51,12,63,3,160.00),(52,11,63,2,160.00),(53,40,275,1,80.00),(54,39,275,2,80.00),(55,38,275,1,80.00),(56,37,275,2,80.00),(57,36,275,1,80.00),(58,35,275,1,80.00),(59,34,275,3,80.00),(60,33,275,2,80.00),(61,32,275,2,80.00),(62,31,275,2,80.00),(63,30,275,3,80.00),(64,29,275,1,80.00),(65,28,275,1,80.00),(66,27,275,1,80.00),(67,26,275,2,80.00),(68,25,275,2,80.00),(69,24,275,1,80.00),(70,23,275,3,80.00),(71,22,275,3,80.00),(72,21,275,3,80.00),(73,20,275,1,80.00),(74,19,275,1,80.00),(75,18,275,3,80.00),(76,17,275,3,80.00),(77,16,275,3,80.00),(78,15,275,3,80.00),(79,14,275,1,80.00),(80,13,275,1,80.00),(81,12,275,3,80.00),(82,11,275,3,80.00),(83,40,101,2,4800.00),(84,39,101,2,4800.00),(85,38,101,2,4800.00),(86,37,101,2,4800.00),(87,36,101,2,4800.00),(88,35,101,3,4800.00),(89,34,101,3,4800.00),(90,33,101,2,4800.00),(91,32,101,3,4800.00),(92,31,101,1,4800.00),(93,30,101,2,4800.00),(94,29,101,2,4800.00),(95,28,101,3,4800.00),(96,27,101,3,4800.00),(97,26,101,1,4800.00),(98,25,101,1,4800.00),(99,24,101,3,4800.00),(100,23,101,2,4800.00),(101,22,101,2,4800.00),(102,21,101,3,4800.00),(103,41,220,1,11000.00),(104,41,59,1,150.00);
/*!40000 ALTER TABLE `detalii_comanda` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `verifica_stoc_inainte_comanda` BEFORE INSERT ON `detalii_comanda` FOR EACH ROW BEGIN
    DECLARE stock_disponibil INT;
    
    SELECT cantitate INTO stock_disponibil 
    FROM stocuri 
    WHERE id_produs = NEW.id_produs;
    
    IF stock_disponibil < NEW.cantitate THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Stoc insuficient!';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `actualizare_stoc_dupa_comanda` AFTER INSERT ON `detalii_comanda` FOR EACH ROW UPDATE stocuri 
SET cantitate = cantitate - NEW.cantitate,
    ultima_actualizare = NOW()
WHERE id_produs = NEW.id_produs */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `calculeaza_total_comanda` AFTER INSERT ON `detalii_comanda` FOR EACH ROW UPDATE comenzi 
SET total = (
    SELECT SUM(cantitate * pret_unitar) 
    FROM detalii_comanda 
    WHERE id_comanda = NEW.id_comanda
)
WHERE id_comanda = NEW.id_comanda */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `metode_plata`
--

DROP TABLE IF EXISTS `metode_plata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `metode_plata` (
  `id_metoda` int NOT NULL AUTO_INCREMENT,
  `nume` varchar(50) NOT NULL,
  `activ` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id_metoda`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metode_plata`
--

LOCK TABLES `metode_plata` WRITE;
/*!40000 ALTER TABLE `metode_plata` DISABLE KEYS */;
INSERT INTO `metode_plata` VALUES (1,'Card bancar',1),(2,'Ramburs',1),(3,'PayPal',1),(4,'Transfer bancar',1);
/*!40000 ALTER TABLE `metode_plata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produse`
--

DROP TABLE IF EXISTS `produse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produse` (
  `id_produs` int NOT NULL AUTO_INCREMENT,
  `nume` varchar(200) NOT NULL,
  `descriere` text,
  `pret` decimal(10,2) NOT NULL,
  `id_categorie` int DEFAULT NULL,
  `data_adaugare` datetime DEFAULT CURRENT_TIMESTAMP,
  `activ` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id_produs`),
  KEY `id_categorie` (`id_categorie`),
  KEY `idx_produse_nume` (`nume`),
  CONSTRAINT `produse_ibfk_1` FOREIGN KEY (`id_categorie`) REFERENCES `categorii` (`id_categorie`)
) ENGINE=InnoDB AUTO_INCREMENT=332 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produse`
--

LOCK TABLES `produse` WRITE;
/*!40000 ALTER TABLE `produse` DISABLE KEYS */;
INSERT INTO `produse` VALUES (1,'Laptop Dell XPS 13','Procesor Intel i7, 16GB RAM, 512GB SSD',4500.00,1,'2026-04-01 21:58:11',1),(2,'Laptop Dell Inspiron 15','Procesor Intel i5, 8GB RAM, 256GB SSD',2800.00,1,'2026-04-01 21:58:11',1),(3,'Laptop HP Pavilion','AMD Ryzen 5, 8GB RAM, 512GB SSD',3200.00,1,'2026-04-01 21:58:11',1),(4,'Laptop Lenovo ThinkPad','Intel i7, 16GB RAM, 512GB SSD',5200.00,1,'2026-04-01 21:58:11',1),(5,'Laptop ASUS ZenBook','Intel i5, 8GB RAM, 256GB SSD',3500.00,1,'2026-04-01 21:58:11',1),(6,'Laptop Acer Aspire','Intel i3, 4GB RAM, 128GB SSD',1800.00,1,'2026-04-01 21:58:11',1),(7,'Laptop MSI Gaming','Intel i7, 16GB RAM, 1TB SSD, RTX 3060',6500.00,1,'2026-04-01 21:58:11',1),(8,'MacBook Air M1','Apple M1, 8GB RAM, 256GB SSD',4800.00,1,'2026-04-01 21:58:11',1),(9,'MacBook Pro 14','Apple M2 Pro, 16GB RAM, 512GB SSD',9500.00,1,'2026-04-01 21:58:11',1),(10,'Laptop Huawei MateBook','Intel i5, 8GB RAM, 256GB SSD',3300.00,1,'2026-04-01 21:58:11',1),(11,'iPhone 14 Pro','128GB, ecran 6.1 inch',5200.00,2,'2026-04-01 21:58:11',1),(12,'iPhone 14','128GB, ecran 6.1 inch',4200.00,2,'2026-04-01 21:58:11',1),(13,'iPhone 13','128GB, ecran 6.1 inch',3500.00,2,'2026-04-01 21:58:11',1),(14,'Samsung Galaxy S23 Ultra','256GB, ecran 6.8 inch',5500.00,2,'2026-04-01 21:58:11',1),(15,'Samsung Galaxy S23','128GB, ecran 6.1 inch',3800.00,2,'2026-04-01 21:58:11',1),(16,'Samsung Galaxy A54','128GB, ecran 6.4 inch',1800.00,2,'2026-04-01 21:58:11',1),(17,'Xiaomi 13 Pro','256GB, ecran 6.7 inch',3200.00,2,'2026-04-01 21:58:11',1),(18,'Xiaomi Redmi Note 12','128GB, ecran 6.7 inch',1200.00,2,'2026-04-01 21:58:11',1),(19,'Google Pixel 7','128GB, ecran 6.3 inch',2900.00,2,'2026-04-01 21:58:11',1),(20,'OnePlus 11','256GB, ecran 6.7 inch',3400.00,2,'2026-04-01 21:58:11',1),(21,'Samsung QLED 55\"','256GB, ecran 6.5 inch',2600.00,2,'2026-04-01 21:58:11',1),(22,'Samsung QLED 65\"','256GB, ecran 6.7 inch',3100.00,2,'2026-04-01 21:58:11',1),(23,'LG OLED 55\"','128GB, ecran 6.1 inch',3600.00,2,'2026-04-01 21:58:11',1),(24,'LG OLED 65\"','256GB, ecran 6.8 inch',4200.00,2,'2026-04-01 21:58:11',1),(25,'Sony Bravia 55\"','512GB, ecran 6.8 inch',4800.00,2,'2026-04-01 21:58:11',1),(26,'Sony Bravia 65\"','4K Smart TV, 120Hz',3200.00,4,'2026-04-01 21:58:11',1),(27,'TCL 50\"','4K Smart TV, 120Hz',4500.00,4,'2026-04-01 21:58:11',1),(28,'Xiaomi Mi TV 55\"','4K Smart TV, 120Hz',3800.00,4,'2026-04-01 21:58:11',1),(29,'Sony WH-1000XM5','4K Smart TV, 120Hz',5200.00,4,'2026-04-01 21:58:11',1),(30,'AirPods Pro 2','4K Android TV',2900.00,4,'2026-04-01 21:58:11',1),(31,'Samsung Buds2 Pro','4K Android TV',4100.00,4,'2026-04-01 21:58:11',1),(32,'JBL Charge 5','4K Google TV',1600.00,4,'2026-04-01 21:58:11',1),(33,'Bose QuietComfort 45','4K Android TV',1800.00,4,'2026-04-01 21:58:11',1),(34,'Sony SRS-XB43','Căști wireless cu noise canceling',1300.00,5,'2026-04-01 21:58:11',1),(35,'Logitech G733','Căști wireless Apple',1100.00,5,'2026-04-01 21:58:11',1),(36,'Razer BlackShark V2','Căști wireless Samsung',800.00,5,'2026-04-01 21:58:11',1),(37,'JBL Tune 510BT','Boxă portabilă Bluetooth',500.00,5,'2026-04-01 21:58:11',1),(38,'Anker Soundcore','Căști cu noise canceling',1400.00,5,'2026-04-01 21:58:11',1),(39,'Tricou bumbac alb','Boxă portabilă extra bass',800.00,5,'2026-04-01 21:58:11',1),(40,'Tricou bumbac negru','Căști gaming wireless',600.00,5,'2026-04-01 21:58:11',1),(41,'Cămașă albă','Căști gaming',400.00,5,'2026-04-01 21:58:11',1),(42,'Cămașă bleu','Căști wireless',200.00,5,'2026-04-01 21:58:11',1),(43,'Blugi slim fit','Căști wireless budget',150.00,5,'2026-04-01 21:58:11',1),(44,'Blugi regular fit','Tricou din bumbac 100%, alb',49.99,8,'2026-04-01 21:58:11',1),(45,'Hanorac gri','Tricou din bumbac 100%, negru',49.99,8,'2026-04-01 21:58:11',1),(46,'Geacă de piele','Cămașă formală din bumbac',120.00,8,'2026-04-01 21:58:11',1),(47,'Sacou gri','Cămașă formală din bumbac',120.00,8,'2026-04-01 21:58:11',1),(48,'Pantaloni chino','Blugi albastri slim fit',180.00,8,'2026-04-01 21:58:11',1),(49,'Rochie florală','Blugi albastri regular fit',180.00,8,'2026-04-01 21:58:11',1),(50,'Rochie neagră','Hanorac din bumbac',150.00,8,'2026-04-01 21:58:11',1),(51,'Bluză albă','Geacă din piele ecologică',350.00,8,'2026-04-01 21:58:11',1),(52,'Bluză florală','Sacou formal',280.00,8,'2026-04-01 21:58:11',1),(53,'Blugi skinny','Pantaloni chino bej',140.00,8,'2026-04-01 21:58:11',1),(54,'Fustă creion','Pantaloni de trening',90.00,8,'2026-04-01 21:58:11',1),(55,'Palton bej','Tricou polo cu guler',80.00,8,'2026-04-01 21:58:11',1),(56,'Geacă denim','Pulover din lână merinos',200.00,8,'2026-04-01 21:58:11',1),(57,'Tricou crop top','Costum formal gri',600.00,8,'2026-04-01 21:58:11',1),(58,'Pantaloni elefanți','Set pijama bumbac',100.00,8,'2026-04-01 21:58:11',1),(59,'Adidas Superstar','Rochie lungă cu imprimeu floral',150.00,9,'2026-04-01 21:58:11',1),(60,'Nike Air Force 1','Rochie elegantă neagră',180.00,9,'2026-04-01 21:58:11',1),(61,'Nike Air Max','Bluză din mătase',90.00,9,'2026-04-01 21:58:11',1),(62,'Nintendo Switch','Bluză cu imprimeu floral',70.00,9,'2026-04-01 21:58:11',1),(63,'Mouse Logitech G502','Blugi skinny albastri',160.00,9,'2026-04-01 21:58:11',1),(64,'PlayStation 5','Fustă creion neagră',110.00,9,'2026-04-01 21:58:11',1),(65,'Xbox Series X','Palton lung de iarnă',400.00,9,'2026-04-01 21:58:11',1),(66,'Tastatură Razer','Geacă din denim',180.00,9,'2026-04-01 21:58:11',1),(67,'Monitor Gaming 27\"','Tricou scurt',40.00,9,'2026-04-01 21:58:11',1),(68,'Scaun gaming','Pantaloni largi',120.00,9,'2026-04-01 21:58:11',1),(69,'Jachetă puf','Jachetă de iarnă',250.00,9,'2026-04-01 21:58:11',1),(70,'Costum baie','Costum de baie două piese',90.00,9,'2026-04-01 21:58:11',1),(71,'Pijama mătase','Set pijama din mătase',150.00,9,'2026-04-01 21:58:11',1),(72,'Pulover oversized','Pulover larg',110.00,9,'2026-04-01 21:58:11',1),(73,'Cardigan','Cardigan din lână',140.00,9,'2026-04-01 21:58:11',1),(74,'Adidas Superstar','Tenși casual albi',350.00,10,'2026-04-01 21:58:11',1),(75,'Nike Air Force 1','Tenși casual albi',400.00,10,'2026-04-01 21:58:11',1),(76,'Nike Air Max','Tenși sport',450.00,10,'2026-04-01 21:58:11',1),(77,'Puma RS-X','Tenși casual',320.00,10,'2026-04-01 21:58:11',1),(78,'Pantofi piele negri','Pantofi formali',250.00,10,'2026-04-01 21:58:11',1),(79,'Pantofi piele maro','Pantofi formali',250.00,10,'2026-04-01 21:58:11',1),(80,'Ghete iarnă','Ghete impermeabile',300.00,10,'2026-04-01 21:58:11',1),(81,'Sandale piele','Sandale de vară',120.00,11,'2026-04-01 21:58:11',1),(82,'Espadrile','Pantofi casual vară',80.00,11,'2026-04-01 21:58:11',1),(83,'Bocanci trekking','Bocanci de munte',400.00,10,'2026-04-01 21:58:11',1),(84,'Papuci casă','Papuci comozi',50.00,11,'2026-04-01 21:58:11',1),(85,'Cauciucuri ploaie','Cizme de ploaie',100.00,11,'2026-04-01 21:58:11',1),(86,'PlayStation 5','Console Sony cu 1 controller',2800.00,7,'2026-04-01 21:58:11',1),(87,'Xbox Series X','Console Microsoft cu 1 controller',2700.00,7,'2026-04-01 21:58:11',1),(88,'Nintendo Switch','Console hibridă',1500.00,7,'2026-04-01 21:58:11',1),(89,'Mouse Logitech G502','Mouse gaming',250.00,7,'2026-04-01 21:58:11',1),(90,'Tastatură Razer','Tastatură mecanică',350.00,7,'2026-04-01 21:58:11',1),(91,'Monitor Gaming 27\"','Monitor 144Hz 1ms',1200.00,7,'2026-04-01 21:58:11',1),(92,'Scaun gaming','Scaun ergonomic',800.00,7,'2026-04-01 21:58:11',1),(93,'Controller Xbox','Controller wireless',200.00,7,'2026-04-01 21:58:11',1),(94,'Laptop Dell XPS 13','Procesor Intel i7, 16GB RAM, 512GB SSD',4500.00,1,'2026-04-01 22:01:08',1),(95,'Laptop Dell Inspiron 15','Procesor Intel i5, 8GB RAM, 256GB SSD',2800.00,1,'2026-04-01 22:01:08',1),(96,'Laptop HP Pavilion','AMD Ryzen 5, 8GB RAM, 512GB SSD',3200.00,1,'2026-04-01 22:01:08',1),(97,'Laptop Lenovo ThinkPad','Intel i7, 16GB RAM, 512GB SSD',5200.00,1,'2026-04-01 22:01:08',1),(98,'Laptop ASUS ZenBook','Intel i5, 8GB RAM, 256GB SSD',3500.00,1,'2026-04-01 22:01:08',1),(99,'Laptop Acer Aspire','Intel i3, 4GB RAM, 128GB SSD',1800.00,1,'2026-04-01 22:01:08',1),(100,'Laptop MSI Gaming','Intel i7, 16GB RAM, 1TB SSD, RTX 3060',6500.00,1,'2026-04-01 22:01:08',1),(101,'MacBook Air M1','Apple M1, 8GB RAM, 256GB SSD',4800.00,1,'2026-04-01 22:01:08',1),(102,'MacBook Pro 14','Apple M2 Pro, 16GB RAM, 512GB SSD',9500.00,1,'2026-04-01 22:01:08',1),(103,'Laptop Huawei MateBook','Intel i5, 8GB RAM, 256GB SSD',3300.00,1,'2026-04-01 22:01:08',1),(104,'iPhone 14 Pro','128GB, ecran 6.1 inch',5200.00,2,'2026-04-01 22:01:08',1),(105,'iPhone 14','128GB, ecran 6.1 inch',4200.00,2,'2026-04-01 22:01:08',1),(106,'iPhone 13','128GB, ecran 6.1 inch',3500.00,2,'2026-04-01 22:01:08',1),(107,'Samsung Galaxy S23 Ultra','256GB, ecran 6.8 inch',5500.00,2,'2026-04-01 22:01:08',1),(108,'Samsung Galaxy S23','128GB, ecran 6.1 inch',3800.00,2,'2026-04-01 22:01:08',1),(109,'Samsung Galaxy A54','128GB, ecran 6.4 inch',1800.00,2,'2026-04-01 22:01:08',1),(110,'Xiaomi 13 Pro','256GB, ecran 6.7 inch',3200.00,2,'2026-04-01 22:01:08',1),(111,'Xiaomi Redmi Note 12','128GB, ecran 6.7 inch',1200.00,2,'2026-04-01 22:01:08',1),(112,'Google Pixel 7','128GB, ecran 6.3 inch',2900.00,2,'2026-04-01 22:01:08',1),(113,'OnePlus 11','256GB, ecran 6.7 inch',3400.00,2,'2026-04-01 22:01:08',1),(114,'Motorola Edge 40','256GB, ecran 6.5 inch',2600.00,2,'2026-04-01 22:01:08',1),(115,'Nothing Phone 2','256GB, ecran 6.7 inch',3100.00,2,'2026-04-01 22:01:08',1),(116,'Sony Xperia 5 IV','128GB, ecran 6.1 inch',3600.00,2,'2026-04-01 22:01:08',1),(117,'HONOR Magic5 Pro','256GB, ecran 6.8 inch',4200.00,2,'2026-04-01 22:01:08',1),(118,'ASUS ROG Phone 7','512GB, ecran 6.8 inch',4800.00,2,'2026-04-01 22:01:08',1),(119,'Samsung QLED 55\"','4K Smart TV, 120Hz',3200.00,4,'2026-04-01 22:01:08',1),(120,'Samsung QLED 65\"','4K Smart TV, 120Hz',4500.00,4,'2026-04-01 22:01:08',1),(121,'LG OLED 55\"','4K Smart TV, 120Hz',3800.00,4,'2026-04-01 22:01:08',1),(122,'LG OLED 65\"','4K Smart TV, 120Hz',5200.00,4,'2026-04-01 22:01:08',1),(123,'Sony Bravia 55\"','4K Android TV',2900.00,4,'2026-04-01 22:01:08',1),(124,'Sony Bravia 65\"','4K Android TV',4100.00,4,'2026-04-01 22:01:08',1),(125,'TCL 50\"','4K Google TV',1600.00,4,'2026-04-01 22:01:08',1),(126,'Xiaomi Mi TV 55\"','4K Android TV',1800.00,4,'2026-04-01 22:01:08',1),(127,'Sony WH-1000XM5','Căști wireless cu noise canceling',1300.00,5,'2026-04-01 22:01:08',1),(128,'AirPods Pro 2','Căști wireless Apple',1100.00,5,'2026-04-01 22:01:08',1),(129,'Samsung Buds2 Pro','Căști wireless Samsung',800.00,5,'2026-04-01 22:01:08',1),(130,'JBL Charge 5','Boxă portabilă Bluetooth',500.00,5,'2026-04-01 22:01:08',1),(131,'Bose QuietComfort 45','Căști cu noise canceling',1400.00,5,'2026-04-01 22:01:08',1),(132,'Sony SRS-XB43','Boxă portabilă extra bass',800.00,5,'2026-04-01 22:01:08',1),(133,'Logitech G733','Căști gaming wireless',600.00,5,'2026-04-01 22:01:08',1),(134,'Razer BlackShark V2','Căști gaming',400.00,5,'2026-04-01 22:01:08',1),(135,'JBL Tune 510BT','Căști wireless',200.00,5,'2026-04-01 22:01:08',1),(136,'Anker Soundcore','Căști wireless budget',150.00,5,'2026-04-01 22:01:08',1),(137,'Tricou bumbac alb','Tricou din bumbac 100%, alb',49.99,8,'2026-04-01 22:01:08',1),(138,'Tricou bumbac negru','Tricou din bumbac 100%, negru',49.99,8,'2026-04-01 22:01:08',1),(139,'Cămașă albă','Cămașă formală din bumbac',120.00,8,'2026-04-01 22:01:08',1),(140,'Cămașă bleu','Cămașă formală din bumbac',120.00,8,'2026-04-01 22:01:08',1),(141,'Blugi slim fit','Blugi albastri slim fit',180.00,8,'2026-04-01 22:01:08',1),(142,'Blugi regular fit','Blugi albastri regular fit',180.00,8,'2026-04-01 22:01:08',1),(143,'Hanorac gri','Hanorac din bumbac',150.00,8,'2026-04-01 22:01:08',1),(144,'Geacă de piele','Geacă din piele ecologică',350.00,8,'2026-04-01 22:01:08',1),(145,'Sacou gri','Sacou formal',280.00,8,'2026-04-01 22:01:08',1),(146,'Pantaloni chino','Pantaloni chino bej',140.00,8,'2026-04-01 22:01:08',1),(147,'Pantaloni sport','Pantaloni de trening',90.00,8,'2026-04-01 22:01:08',1),(148,'Tricou polo','Tricou polo cu guler',80.00,8,'2026-04-01 22:01:08',1),(149,'Pulover lână','Pulover din lână merinos',200.00,8,'2026-04-01 22:01:08',1),(150,'Costum trei piese','Costum formal gri',600.00,8,'2026-04-01 22:01:08',1),(151,'Pijama bumbac','Set pijama bumbac',100.00,8,'2026-04-01 22:01:08',1),(152,'Rochie florală','Rochie lungă cu imprimeu floral',150.00,9,'2026-04-01 22:01:08',1),(153,'Rochie neagră','Rochie elegantă neagră',180.00,9,'2026-04-01 22:01:08',1),(154,'Bluză albă','Bluză din mătase',90.00,9,'2026-04-01 22:01:08',1),(155,'Bluză florală','Bluză cu imprimeu floral',70.00,9,'2026-04-01 22:01:08',1),(156,'Blugi skinny','Blugi skinny albastri',160.00,9,'2026-04-01 22:01:08',1),(157,'Fustă creion','Fustă creion neagră',110.00,9,'2026-04-01 22:01:08',1),(158,'Palton bej','Palton lung de iarnă',400.00,9,'2026-04-01 22:01:08',1),(159,'Geacă denim','Geacă din denim',180.00,9,'2026-04-01 22:01:08',1),(160,'Tricou crop top','Tricou scurt',40.00,9,'2026-04-01 22:01:08',1),(161,'Pantaloni elefanți','Pantaloni largi',120.00,9,'2026-04-01 22:01:08',1),(162,'Jachetă puf','Jachetă de iarnă',250.00,9,'2026-04-01 22:01:08',1),(163,'Costum baie','Costum de baie două piese',90.00,9,'2026-04-01 22:01:08',1),(164,'Pijama mătase','Set pijama din mătase',150.00,9,'2026-04-01 22:01:08',1),(165,'Pulover oversized','Pulover larg',110.00,9,'2026-04-01 22:01:08',1),(166,'Cardigan','Cardigan din lână',140.00,9,'2026-04-01 22:01:08',1),(167,'Adidas Superstar','Tenși casual albi',350.00,10,'2026-04-01 22:01:08',1),(168,'Nike Air Force 1','Tenși casual albi',400.00,10,'2026-04-01 22:01:08',1),(169,'Nike Air Max','Tenși sport',450.00,10,'2026-04-01 22:01:08',1),(170,'Puma RS-X','Tenși casual',320.00,10,'2026-04-01 22:01:08',1),(171,'Pantofi piele negri','Pantofi formali',250.00,10,'2026-04-01 22:01:08',1),(172,'Pantofi piele maro','Pantofi formali',250.00,10,'2026-04-01 22:01:08',1),(173,'Ghete iarnă','Ghete impermeabile',300.00,10,'2026-04-01 22:01:08',1),(174,'Sandale piele','Sandale de vară',120.00,11,'2026-04-01 22:01:08',1),(175,'Espadrile','Pantofi casual vară',80.00,11,'2026-04-01 22:01:08',1),(176,'Bocanci trekking','Bocanci de munte',400.00,10,'2026-04-01 22:01:08',1),(177,'Papuci casă','Papuci comozi',50.00,11,'2026-04-01 22:01:08',1),(178,'Cauciucuri ploaie','Cizme de ploaie',100.00,11,'2026-04-01 22:01:08',1),(179,'PlayStation 5','Console Sony cu 1 controller',2800.00,7,'2026-04-01 22:01:08',1),(180,'Xbox Series X','Console Microsoft cu 1 controller',2700.00,7,'2026-04-01 22:01:08',1),(181,'Nintendo Switch','Console hibridă',1500.00,7,'2026-04-01 22:01:08',1),(182,'Mouse Logitech G502','Mouse gaming',250.00,7,'2026-04-01 22:01:08',1),(183,'Tastatură Razer','Tastatură mecanică',350.00,7,'2026-04-01 22:01:08',1),(184,'Monitor Gaming 27\"','Monitor 144Hz 1ms',1200.00,7,'2026-04-01 22:01:08',1),(185,'Scaun gaming','Scaun ergonomic',800.00,7,'2026-04-01 22:01:08',1),(186,'Controller Xbox','Controller wireless',200.00,7,'2026-04-01 22:01:08',1),(187,'iPhone 15 Pro Max 256GB','A17 Pro, Titanium, 5G',6500.00,16,'2026-04-01 22:26:51',1),(188,'iPhone 15 Pro 128GB','A17 Pro, Titanium, 5G',5500.00,16,'2026-04-01 22:26:51',1),(189,'Samsung Galaxy S24 Ultra','S-Pen, 200MP camera, 5G',5900.00,16,'2026-04-01 22:26:51',1),(190,'Samsung Galaxy S24+','AI features, 5G, 256GB',4800.00,16,'2026-04-01 22:26:51',1),(191,'Google Pixel 8 Pro','AI camera, 5G, 128GB',4300.00,16,'2026-04-01 22:26:51',1),(192,'Xiaomi 14 Ultra','Leica camera, 512GB, 5G',4500.00,16,'2026-04-01 22:26:51',1),(193,'OnePlus 12','Snapdragon 8 Gen 3, 256GB',4100.00,16,'2026-04-01 22:26:51',1),(194,'Sony Xperia 1 VI','4K OLED, camera profesionistă',5200.00,16,'2026-04-01 22:26:51',1),(195,'Nothing Phone 3','Glyph interface, 256GB',3800.00,16,'2026-04-01 22:26:51',1),(196,'Honor Magic6 Pro','AI camera, 512GB, 5G',4600.00,16,'2026-04-01 22:26:51',1),(197,'Samsung Galaxy A55','5G, 128GB, 6.6\"',1800.00,17,'2026-04-01 22:26:51',1),(198,'Samsung Galaxy A35','5G, 128GB, 6.6\"',1500.00,17,'2026-04-01 22:26:51',1),(199,'Xiaomi Redmi Note 13 Pro','200MP camera, 5G',1600.00,17,'2026-04-01 22:26:51',1),(200,'Xiaomi Redmi Note 13','108MP camera, 5G',1200.00,17,'2026-04-01 22:26:51',1),(201,'Google Pixel 7a','Tensor G2, 5G, 128GB',2100.00,17,'2026-04-01 22:26:51',1),(202,'Motorola Edge 40 Neo','144Hz display, 5G',1700.00,17,'2026-04-01 22:26:51',1),(203,'Nothing Phone 2a','Glyph lights, 5G',1900.00,17,'2026-04-01 22:26:51',1),(204,'OnePlus Nord 4','5G, 128GB, fast charging',2000.00,17,'2026-04-01 22:26:51',1),(205,'Honor 200 Pro','Portrait camera, 5G',2300.00,17,'2026-04-01 22:26:51',1),(206,'Realme 12 Pro+','Periscope camera, 5G',1900.00,17,'2026-04-01 22:26:51',1),(207,'Samsung Galaxy A15','5G, 128GB',800.00,18,'2026-04-01 22:26:51',1),(208,'Xiaomi Redmi 13C','128GB, 6.7\"',550.00,18,'2026-04-01 22:26:51',1),(209,'Motorola Moto G54','5G, 8GB RAM',700.00,18,'2026-04-01 22:26:51',1),(210,'Nokia G42','5G, 128GB',650.00,18,'2026-04-01 22:26:51',1),(211,'TCL 40 SE','6.7\", 128GB',500.00,18,'2026-04-01 22:26:51',1),(212,'Infinix Hot 40','128GB, 6.7\"',450.00,18,'2026-04-01 22:26:51',1),(213,'Tecno Spark 20','128GB, 6.6\"',400.00,18,'2026-04-01 22:26:51',1),(214,'Honor X7b','128GB, 6.7\"',750.00,18,'2026-04-01 22:26:51',1),(215,'ASUS ROG Strix G16','Intel i9, RTX 4080, 32GB RAM, 1TB',12500.00,19,'2026-04-01 22:26:51',1),(216,'ASUS TUF Gaming F15','Intel i7, RTX 4060, 16GB RAM',5500.00,19,'2026-04-01 22:26:51',1),(217,'MSI Katana 15','Intel i7, RTX 4070, 16GB RAM',6800.00,19,'2026-04-01 22:26:51',1),(218,'Lenovo Legion Pro 5','AMD Ryzen 9, RTX 4070',7000.00,19,'2026-04-01 22:26:51',1),(219,'HP Omen 16','Intel i7, RTX 4060, 16GB',5800.00,19,'2026-04-01 22:26:51',1),(220,'Acer Predator Helios','Intel i9, RTX 4080, 32GB',11000.00,19,'2026-04-01 22:26:51',1),(221,'Dell G15','Intel i5, RTX 3050, 8GB',3800.00,19,'2026-04-01 22:26:51',1),(222,'Razer Blade 15','Intel i7, RTX 4070, 16GB',9800.00,19,'2026-04-01 22:26:51',1),(223,'Dell XPS 13','Intel i5, 8GB, 256GB',5500.00,20,'2026-04-01 22:26:51',1),(224,'Dell Latitude 5440','Intel i5, 8GB, 256GB',4200.00,20,'2026-04-01 22:26:51',1),(225,'HP EliteBook 845','AMD Ryzen 5, 16GB, 512GB',4800.00,20,'2026-04-01 22:26:51',1),(226,'Lenovo ThinkPad X1','Intel i7, 16GB, 512GB',7500.00,20,'2026-04-01 22:26:51',1),(227,'Lenovo IdeaPad 5','AMD Ryzen 5, 8GB, 512GB',2800.00,20,'2026-04-01 22:26:51',1),(228,'ASUS Zenbook 14','Intel i5, 8GB, 512GB',3500.00,20,'2026-04-01 22:26:51',1),(229,'Microsoft Surface Laptop','Intel i5, 8GB, 256GB',4800.00,20,'2026-04-01 22:26:51',1),(230,'Acer Swift 3','Intel i5, 8GB, 512GB',2900.00,20,'2026-04-01 22:26:51',1),(231,'Huawei MateBook D14','AMD Ryzen 5, 8GB, 512GB',2700.00,20,'2026-04-01 22:26:51',1),(232,'MacBook Air 13\"','M2, 8GB, 256GB',5200.00,20,'2026-04-01 22:26:51',1),(233,'iPad Pro 12.9\" 512GB','M2 chip, WiFi + Cellular',8500.00,22,'2026-04-01 22:26:51',1),(234,'iPad Pro 11\" 256GB','M2 chip, WiFi',5500.00,22,'2026-04-01 22:26:51',1),(235,'iPad Air 10.9\" 64GB','M1 chip, WiFi',3200.00,22,'2026-04-01 22:26:51',1),(236,'iPad 10.9\" 64GB','A14 Bionic, WiFi',2200.00,22,'2026-04-01 22:26:51',1),(237,'iPad mini 64GB','A15 Bionic, WiFi',2400.00,22,'2026-04-01 22:26:51',1),(238,'Samsung Galaxy Tab S9 Ultra','14.6\", 512GB, S-Pen',6500.00,21,'2026-04-01 22:26:51',1),(239,'Samsung Galaxy Tab S9+','12.4\", 256GB, S-Pen',4800.00,21,'2026-04-01 22:26:51',1),(240,'Samsung Galaxy Tab S9','11\", 128GB, S-Pen',3500.00,21,'2026-04-01 22:26:51',1),(241,'Xiaomi Pad 6 Pro','11\", 256GB',2200.00,21,'2026-04-01 22:26:51',1),(242,'Lenovo Tab P12 Pro','12.6\", 256GB',2800.00,21,'2026-04-01 22:26:51',1),(243,'Sony WH-1000XM5','Noise canceling premium',1300.00,33,'2026-04-01 22:26:51',1),(244,'Bose QuietComfort Ultra','Noise canceling, spatial audio',1500.00,33,'2026-04-01 22:26:51',1),(245,'Apple AirPods Max','Premium, spatial audio',2400.00,33,'2026-04-01 22:26:51',1),(246,'Sennheiser Momentum 4','60h battery, premium sound',1200.00,33,'2026-04-01 22:26:51',1),(247,'Bose QuietComfort 45','Noise canceling, 24h battery',1100.00,33,'2026-04-01 22:26:51',1),(248,'Sony WH-CH720N','Budget noise canceling',450.00,33,'2026-04-01 22:26:51',1),(249,'JBL Tune 770NC','Noise canceling, 70h battery',400.00,33,'2026-04-01 22:26:51',1),(250,'Anker Soundcore Q45','Premium noise canceling',550.00,33,'2026-04-01 22:26:51',1),(251,'Beats Studio Pro','Apple integration, premium',1400.00,33,'2026-04-01 22:26:51',1),(252,'Skullcandy Crusher','Bass haptic feedback',550.00,33,'2026-04-01 22:26:51',1),(253,'Audio-Technica M50x','Studio monitor, wired',700.00,33,'2026-04-01 22:26:51',1),(254,'AKG K371','Studio quality, wired',550.00,33,'2026-04-01 22:26:51',1),(255,'JBL Charge 5','IP67, 20h battery',550.00,34,'2026-04-01 22:26:51',1),(256,'JBL Flip 6','IP67, 12h battery',400.00,34,'2026-04-01 22:26:51',1),(257,'Sony SRS-XE300','IP67, 24h battery',450.00,34,'2026-04-01 22:26:51',1),(258,'Bose SoundLink Flex','IP67, 12h battery',600.00,34,'2026-04-01 22:26:51',1),(259,'Marshall Emberton II','IP67, 30h battery',500.00,34,'2026-04-01 22:26:51',1),(260,'Ultimate Ears Boom 3','IP67, 15h battery',480.00,34,'2026-04-01 22:26:51',1),(261,'Sony SRS-XB13','Compact, IP67',150.00,34,'2026-04-01 22:26:51',1),(262,'JBL Go 4','Ultra compact',120.00,34,'2026-04-01 22:26:51',1),(263,'Anker Soundcore 3','24h battery, IPX7',200.00,34,'2026-04-01 22:26:51',1),(264,'Tribit StormBox','24h battery, 360 sound',180.00,34,'2026-04-01 22:26:51',1),(265,'Apple Watch Ultra 2','49mm, GPS + Cellular',3800.00,35,'2026-04-01 22:26:51',1),(266,'Apple Watch Series 9','45mm, GPS',2200.00,35,'2026-04-01 22:26:51',1),(267,'Samsung Galaxy Watch 6 Classic','47mm, Bluetooth',1800.00,35,'2026-04-01 22:26:51',1),(268,'Samsung Galaxy Watch 6','44mm, Bluetooth',1400.00,35,'2026-04-01 22:26:51',1),(269,'Garmin Fenix 7','Multisport GPS',3200.00,35,'2026-04-01 22:26:51',1),(270,'Garmin Venu 3','AMOLED display, fitness',2300.00,35,'2026-04-01 22:26:51',1),(271,'Google Pixel Watch 2','Fitbit integration',1400.00,35,'2026-04-01 22:26:51',1),(272,'Xiaomi Watch 2 Pro','Wear OS, GPS',800.00,35,'2026-04-01 22:26:51',1),(273,'Tricou bumbac alb','Bumbac 100%, alb',50.00,37,'2026-04-01 22:26:51',1),(274,'Tricou bumbac negru','Bumbac 100%, negru',50.00,37,'2026-04-01 22:26:51',1),(275,'Tricou polo albastru','Polo din bumbac',80.00,37,'2026-04-01 22:26:51',1),(276,'Tricou polo negru','Polo din bumbac',80.00,37,'2026-04-01 22:26:51',1),(277,'Tricou Nike Dri-FIT','Material respirabil',120.00,37,'2026-04-01 22:26:51',1),(278,'Tricou Adidas','Climalite, uscare rapidă',110.00,37,'2026-04-01 22:26:51',1),(279,'Tricou Under Armour','HeatGear, compresie',100.00,37,'2026-04-01 22:26:51',1),(280,'Tricou Tommy Hilfiger','Branded, bumbac premium',150.00,37,'2026-04-01 22:26:51',1),(281,'Tricou Carhartt','Heavy duty, bumbac',120.00,37,'2026-04-01 22:26:51',1),(282,'Tricou The North Face','Outdoor, respirabil',130.00,37,'2026-04-01 22:26:51',1),(283,'Cămașă albă formală','Bumbac 100%, slim fit',150.00,24,'2026-04-01 22:26:51',1),(284,'Cămașă bleu formală','Bumbac 100%, regular fit',150.00,24,'2026-04-01 22:26:51',1),(285,'Cămașă ecru formală','Bumbac 100%, slim fit',150.00,24,'2026-04-01 22:26:51',1),(286,'Cămașă casual carouri','Roșu-negru, bumbac',120.00,24,'2026-04-01 22:26:51',1),(287,'Cămașă casual albastră','Oxford, bumbac',110.00,24,'2026-04-01 22:26:51',1),(288,'Cămașă in','In 100%, alb, vară',180.00,24,'2026-04-01 22:26:51',1),(289,'Cămașă denim','Blugi, casual',130.00,24,'2026-04-01 22:26:51',1),(290,'Cămașă florală','Imprimeu floral, vară',100.00,24,'2026-04-01 22:26:51',1),(291,'Cămașă polo','Polo cu guler, bumbac',90.00,24,'2026-04-01 22:26:51',1),(292,'Cămașă de noapte','Pijama bumbac',80.00,24,'2026-04-01 22:26:51',1),(293,'Levi\'s 501 Original','Regular fit, denim albastru',350.00,23,'2026-04-01 22:26:51',1),(294,'Levi\'s 511 Slim Fit','Slim fit, albastru închis',350.00,23,'2026-04-01 22:26:51',1),(295,'Levi\'s 502 Taper','Tapered fit, albastru',340.00,23,'2026-04-01 22:26:51',1),(296,'Wrangler Texas','Regular fit, albastru',250.00,23,'2026-04-01 22:26:51',1),(297,'Wrangler Slim','Slim fit, negru',260.00,23,'2026-04-01 22:26:51',1),(298,'Tommy Hilfiger','Slim fit, albastru',380.00,23,'2026-04-01 22:26:51',1),(299,'H&M Slim','Slim fit, albastru',180.00,23,'2026-04-01 22:26:51',1),(300,'Zara Skinny','Skinny fit, negru',190.00,23,'2026-04-01 22:26:51',1),(301,'Rochie midi florală','Midi, imprimeu floral',180.00,25,'2026-04-01 22:26:51',1),(302,'Rochie lungă neagră','Maxi, evenimente',250.00,25,'2026-04-01 22:26:51',1),(303,'Rochie scurtă roșie','Mini, cocktail',150.00,25,'2026-04-01 22:26:51',1),(304,'Rochie vaporoasă','Maxi, plajă',120.00,25,'2026-04-01 22:26:51',1),(305,'Rochie creion','Corporate, negru',200.00,25,'2026-04-01 22:26:51',1),(306,'Rochie cu paiete','Party, scurtă',280.00,25,'2026-04-01 22:26:51',1),(307,'Rochie din denim','Casual, scurtă',140.00,25,'2026-04-01 22:26:51',1),(308,'Rochie tricot','Tricot, iarnă',160.00,25,'2026-04-01 22:26:51',1),(309,'Rochie mătase','Mătase, eleganță',350.00,25,'2026-04-01 22:26:51',1),(310,'Rochie boho','Boho, lungă',130.00,25,'2026-04-01 22:26:51',1),(311,'Rochie cămașă','Stil cămașă, casual',110.00,25,'2026-04-01 22:26:51',1),(312,'Rochie guler','Cu guler, office',140.00,25,'2026-04-01 22:26:51',1),(313,'Nike Air Force 1','Alb, clasic',450.00,44,'2026-04-01 22:26:51',1),(314,'Nike Air Max 90','Negru, icon',500.00,44,'2026-04-01 22:26:51',1),(315,'Adidas Superstar','Alb, shell toe',400.00,44,'2026-04-01 22:26:51',1),(316,'Adidas Stan Smith','Alb, minimalist',380.00,44,'2026-04-01 22:26:51',1),(317,'New Balance 574','Gri, confort',420.00,44,'2026-04-01 22:26:51',1),(318,'Puma Suede Classic','Negru, clasici',350.00,44,'2026-04-01 22:26:51',1),(319,'Converse Chuck Taylor','Alb, canvas',280.00,44,'2026-04-01 22:26:51',1),(320,'Vans Old Skool','Negru, skate',350.00,44,'2026-04-01 22:26:51',1),(321,'ASICS Japan S','Alb, retro',320.00,44,'2026-04-01 22:26:51',1),(322,'Reebok Club C','Alb, vintage',340.00,44,'2026-04-01 22:26:51',1),(323,'Pantofi piele negri','Oxford, piele naturală',350.00,43,'2026-04-01 22:26:51',1),(324,'Pantofi piele maro','Derby, piele naturală',350.00,43,'2026-04-01 22:26:51',1),(325,'Pantofi casual negri','Loafers, piele',280.00,43,'2026-04-01 22:26:51',1),(326,'Pantofi casual maro','Brogues, piele',290.00,43,'2026-04-01 22:26:51',1),(327,'Pantofi sport-elegant','Ecco, piele',450.00,43,'2026-04-01 22:26:51',1),(328,'Mocasini piele','Mocasini, casual',220.00,43,'2026-04-01 22:26:51',1),(329,'Pantofi din pânză','Espadrile, vară',120.00,43,'2026-04-01 22:26:51',1),(330,'Pantofi de trening','Skechers, confort',300.00,43,'2026-04-01 22:26:51',1),(331,'Gaming Laptop ASUS ROG','Intel i9, RTX 4090, 32GB RAM, 2TB SSD',12500.00,1,'2026-04-04 22:15:25',1);
/*!40000 ALTER TABLE `produse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recenzii`
--

DROP TABLE IF EXISTS `recenzii`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recenzii` (
  `id_recenzie` int NOT NULL AUTO_INCREMENT,
  `id_produs` int DEFAULT NULL,
  `id_client` int DEFAULT NULL,
  `rating` int DEFAULT '5',
  `comentariu` text,
  `data_recenzie` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_recenzie`),
  KEY `id_produs` (`id_produs`),
  KEY `id_client` (`id_client`),
  CONSTRAINT `recenzii_ibfk_1` FOREIGN KEY (`id_produs`) REFERENCES `produse` (`id_produs`),
  CONSTRAINT `recenzii_ibfk_2` FOREIGN KEY (`id_client`) REFERENCES `clienti` (`id_client`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recenzii`
--

LOCK TABLES `recenzii` WRITE;
/*!40000 ALTER TABLE `recenzii` DISABLE KEYS */;
INSERT INTO `recenzii` VALUES (1,1,1,5,'Laptop excelent, rulează tot ce am nevoie!','2026-04-01 22:06:55'),(2,11,2,4,'Telefon bun, dar bateria ține puțin','2026-04-01 22:06:55'),(3,2,3,5,'Super calitate, recomand!','2026-04-01 22:06:55'),(4,16,4,3,'OK pentru preț, dar nu excepțional','2026-04-01 22:06:55'),(5,63,6,5,'Mouse-ul perfect pentru gaming','2026-04-01 22:06:55'),(6,62,10,4,'Consolă foarte distractivă pentru întreaga familie','2026-04-01 22:06:55'),(7,41,8,4,'Cămașă de calitate, dar cam mare','2026-04-01 22:06:55'),(8,50,9,5,'Rochie superbă!','2026-04-01 22:06:55'),(9,3,7,4,'Laptop puternic, dar se încinge','2026-04-01 22:06:55'),(10,18,5,2,'Nu sunt mulțumit, se blochează des','2026-04-01 22:06:55');
/*!40000 ALTER TABLE `recenzii` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `retururi`
--

DROP TABLE IF EXISTS `retururi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `retururi` (
  `id_retur` int NOT NULL AUTO_INCREMENT,
  `id_comanda` int DEFAULT NULL,
  `id_produs` int DEFAULT NULL,
  `motiv` text,
  `data_retur` datetime DEFAULT CURRENT_TIMESTAMP,
  `status` varchar(50) DEFAULT 'pending',
  PRIMARY KEY (`id_retur`),
  KEY `id_comanda` (`id_comanda`),
  KEY `id_produs` (`id_produs`),
  CONSTRAINT `retururi_ibfk_1` FOREIGN KEY (`id_comanda`) REFERENCES `comenzi` (`id_comanda`),
  CONSTRAINT `retururi_ibfk_2` FOREIGN KEY (`id_produs`) REFERENCES `produse` (`id_produs`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `retururi`
--

LOCK TABLES `retururi` WRITE;
/*!40000 ALTER TABLE `retururi` DISABLE KEYS */;
/*!40000 ALTER TABLE `retururi` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `actualizare_stoc_la_return` AFTER UPDATE ON `retururi` FOR EACH ROW BEGIN
    IF NEW.status = 'approved' AND OLD.status != 'approved' THEN
        UPDATE stocuri s
        JOIN detalii_comanda dc ON s.id_produs = dc.id_produs
        SET s.cantitate = s.cantitate + dc.cantitate,
            s.ultima_actualizare = NOW()
        WHERE dc.id_comanda = NEW.id_comanda 
        AND dc.id_produs = NEW.id_produs;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `stocuri`
--

DROP TABLE IF EXISTS `stocuri`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stocuri` (
  `id_stoc` int NOT NULL AUTO_INCREMENT,
  `id_produs` int DEFAULT NULL,
  `cantitate` int NOT NULL DEFAULT '0',
  `ultima_actualizare` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_stoc`),
  KEY `id_produs` (`id_produs`),
  CONSTRAINT `stocuri_ibfk_1` FOREIGN KEY (`id_produs`) REFERENCES `produse` (`id_produs`)
) ENGINE=InnoDB AUTO_INCREMENT=400 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stocuri`
--

LOCK TABLES `stocuri` WRITE;
/*!40000 ALTER TABLE `stocuri` DISABLE KEYS */;
INSERT INTO `stocuri` VALUES (1,1,138,'2026-04-01 21:58:11'),(2,2,111,'2026-04-01 21:58:11'),(3,3,131,'2026-04-01 21:58:11'),(4,4,121,'2026-04-01 21:58:11'),(5,5,12,'2026-04-01 21:58:11'),(6,6,69,'2026-04-01 21:58:11'),(7,7,110,'2026-04-01 21:58:11'),(8,8,145,'2026-04-01 21:58:11'),(9,9,193,'2026-04-01 21:58:11'),(10,10,143,'2026-04-01 21:58:11'),(11,11,123,'2026-04-01 21:58:11'),(12,12,180,'2026-04-01 21:58:11'),(13,13,141,'2026-04-01 21:58:11'),(14,14,154,'2026-04-01 21:58:11'),(15,15,149,'2026-04-01 21:58:11'),(16,16,81,'2026-04-01 21:58:11'),(17,17,141,'2026-04-01 21:58:11'),(18,18,74,'2026-04-01 21:58:11'),(19,19,124,'2026-04-01 21:58:11'),(20,20,11,'2026-04-01 21:58:11'),(21,21,51,'2026-04-01 21:58:11'),(22,22,22,'2026-04-01 21:58:11'),(23,23,137,'2026-04-01 21:58:11'),(24,24,42,'2026-04-01 21:58:11'),(25,25,168,'2026-04-01 21:58:11'),(26,26,136,'2026-04-01 21:58:11'),(27,27,168,'2026-04-01 21:58:11'),(28,28,40,'2026-04-01 21:58:11'),(29,29,68,'2026-04-01 21:58:11'),(30,30,21,'2026-04-01 21:58:11'),(31,31,80,'2026-04-01 21:58:11'),(32,32,140,'2026-04-01 21:58:11'),(33,33,68,'2026-04-01 21:58:11'),(34,34,101,'2026-04-01 21:58:11'),(35,35,102,'2026-04-01 21:58:11'),(36,36,199,'2026-04-01 21:58:11'),(37,37,107,'2026-04-01 21:58:11'),(38,38,121,'2026-04-01 21:58:11'),(39,39,85,'2026-04-01 21:58:11'),(40,40,50,'2026-04-01 21:58:11'),(41,41,178,'2026-04-01 21:58:11'),(42,42,158,'2026-04-01 21:58:11'),(43,43,57,'2026-04-01 21:58:11'),(44,86,181,'2026-04-01 21:58:11'),(45,87,157,'2026-04-01 21:58:11'),(46,88,39,'2026-04-01 21:58:11'),(47,89,98,'2026-04-01 21:58:11'),(48,90,173,'2026-04-01 21:58:11'),(49,91,179,'2026-04-01 21:58:11'),(50,92,178,'2026-04-01 21:58:11'),(51,93,155,'2026-04-01 21:58:11'),(52,44,39,'2026-04-01 21:58:11'),(53,45,101,'2026-04-01 21:58:11'),(54,46,190,'2026-04-01 21:58:11'),(55,47,65,'2026-04-01 21:58:11'),(56,48,127,'2026-04-01 21:58:11'),(57,49,51,'2026-04-01 21:58:11'),(58,50,52,'2026-04-01 21:58:11'),(59,51,100,'2026-04-01 21:58:11'),(60,52,145,'2026-04-01 21:58:11'),(61,53,34,'2026-04-01 21:58:11'),(62,54,108,'2026-04-01 21:58:11'),(63,55,47,'2026-04-01 21:58:11'),(64,56,90,'2026-04-01 21:58:11'),(65,57,109,'2026-04-01 21:58:11'),(66,58,78,'2026-04-01 21:58:11'),(67,59,54,'2026-04-04 21:58:56'),(68,60,28,'2026-04-01 21:58:11'),(69,61,158,'2026-04-01 21:58:11'),(70,62,125,'2026-04-01 21:58:11'),(71,63,141,'2026-04-01 21:58:11'),(72,64,133,'2026-04-01 21:58:11'),(73,65,40,'2026-04-01 21:58:11'),(74,66,173,'2026-04-01 21:58:11'),(75,67,165,'2026-04-01 21:58:11'),(76,68,108,'2026-04-01 21:58:11'),(77,69,33,'2026-04-01 21:58:11'),(78,70,24,'2026-04-01 21:58:11'),(79,71,199,'2026-04-01 21:58:11'),(80,72,156,'2026-04-01 21:58:11'),(81,73,174,'2026-04-01 21:58:11'),(82,74,13,'2026-04-01 21:58:11'),(83,75,103,'2026-04-01 21:58:11'),(84,76,85,'2026-04-01 21:58:11'),(85,77,109,'2026-04-01 21:58:11'),(86,78,90,'2026-04-01 21:58:11'),(87,79,114,'2026-04-01 21:58:11'),(88,80,101,'2026-04-01 21:58:11'),(89,83,153,'2026-04-01 21:58:11'),(90,81,73,'2026-04-01 21:58:11'),(91,82,86,'2026-04-01 21:58:11'),(92,84,11,'2026-04-01 21:58:11'),(93,85,169,'2026-04-01 21:58:11'),(128,94,40,'2026-04-01 22:01:08'),(129,95,63,'2026-04-01 22:01:08'),(130,96,187,'2026-04-01 22:01:08'),(131,97,166,'2026-04-01 22:01:08'),(132,98,70,'2026-04-01 22:01:08'),(133,99,33,'2026-04-01 22:01:08'),(134,100,134,'2026-04-01 22:01:08'),(135,101,181,'2026-04-01 22:01:08'),(136,102,116,'2026-04-01 22:01:08'),(137,103,27,'2026-04-01 22:01:08'),(138,104,157,'2026-04-01 22:01:08'),(139,105,123,'2026-04-01 22:01:08'),(140,106,134,'2026-04-01 22:01:08'),(141,107,101,'2026-04-01 22:01:08'),(142,108,97,'2026-04-01 22:01:08'),(143,109,170,'2026-04-01 22:01:08'),(144,110,169,'2026-04-01 22:01:08'),(145,111,135,'2026-04-01 22:01:08'),(146,112,161,'2026-04-01 22:01:08'),(147,113,198,'2026-04-01 22:01:08'),(148,114,118,'2026-04-01 22:01:08'),(149,115,177,'2026-04-01 22:01:08'),(150,116,142,'2026-04-01 22:01:08'),(151,117,169,'2026-04-01 22:01:08'),(152,118,30,'2026-04-01 22:01:08'),(153,119,12,'2026-04-01 22:01:08'),(154,120,150,'2026-04-01 22:01:08'),(155,121,137,'2026-04-01 22:01:08'),(156,122,34,'2026-04-01 22:01:08'),(157,123,128,'2026-04-01 22:01:08'),(158,124,148,'2026-04-01 22:01:08'),(159,125,160,'2026-04-01 22:01:08'),(160,126,153,'2026-04-01 22:01:08'),(161,127,87,'2026-04-01 22:01:08'),(162,128,157,'2026-04-01 22:01:08'),(163,129,135,'2026-04-01 22:01:08'),(164,130,194,'2026-04-01 22:01:08'),(165,131,173,'2026-04-01 22:01:08'),(166,132,87,'2026-04-01 22:01:08'),(167,133,94,'2026-04-01 22:01:08'),(168,134,198,'2026-04-01 22:01:08'),(169,135,131,'2026-04-01 22:01:08'),(170,136,53,'2026-04-01 22:01:08'),(171,179,51,'2026-04-01 22:01:08'),(172,180,84,'2026-04-01 22:01:08'),(173,181,71,'2026-04-01 22:01:08'),(174,182,93,'2026-04-01 22:01:08'),(175,183,53,'2026-04-01 22:01:08'),(176,184,164,'2026-04-01 22:01:08'),(177,185,82,'2026-04-01 22:01:08'),(178,186,97,'2026-04-01 22:01:08'),(179,137,41,'2026-04-01 22:01:08'),(180,138,95,'2026-04-01 22:01:08'),(181,139,151,'2026-04-01 22:01:08'),(182,140,83,'2026-04-01 22:01:08'),(183,141,140,'2026-04-01 22:01:08'),(184,142,64,'2026-04-01 22:01:08'),(185,143,80,'2026-04-01 22:01:08'),(186,144,199,'2026-04-01 22:01:08'),(187,145,177,'2026-04-01 22:01:08'),(188,146,86,'2026-04-01 22:01:08'),(189,147,81,'2026-04-01 22:01:08'),(190,148,136,'2026-04-01 22:01:08'),(191,149,48,'2026-04-01 22:01:08'),(192,150,13,'2026-04-01 22:01:08'),(193,151,103,'2026-04-01 22:01:08'),(194,152,84,'2026-04-01 22:01:08'),(195,153,104,'2026-04-01 22:01:08'),(196,154,67,'2026-04-01 22:01:08'),(197,155,15,'2026-04-01 22:01:08'),(198,156,54,'2026-04-01 22:01:08'),(199,157,24,'2026-04-01 22:01:08'),(200,158,141,'2026-04-01 22:01:08'),(201,159,52,'2026-04-01 22:01:08'),(202,160,16,'2026-04-01 22:01:08'),(203,161,106,'2026-04-01 22:01:08'),(204,162,93,'2026-04-01 22:01:08'),(205,163,138,'2026-04-01 22:01:08'),(206,164,21,'2026-04-01 22:01:08'),(207,165,61,'2026-04-01 22:01:08'),(208,166,41,'2026-04-01 22:01:08'),(209,167,13,'2026-04-01 22:01:08'),(210,168,122,'2026-04-01 22:01:08'),(211,169,183,'2026-04-01 22:01:08'),(212,170,161,'2026-04-01 22:01:08'),(213,171,54,'2026-04-01 22:01:08'),(214,172,159,'2026-04-01 22:01:08'),(215,173,51,'2026-04-01 22:01:08'),(216,176,150,'2026-04-01 22:01:08'),(217,174,16,'2026-04-01 22:01:08'),(218,175,191,'2026-04-01 22:01:08'),(219,177,138,'2026-04-01 22:01:08'),(220,178,108,'2026-04-01 22:01:08'),(255,187,105,'2026-04-01 22:26:51'),(256,188,96,'2026-04-01 22:26:51'),(257,189,143,'2026-04-01 22:26:51'),(258,190,209,'2026-04-01 22:26:51'),(259,191,198,'2026-04-01 22:26:51'),(260,192,142,'2026-04-01 22:26:51'),(261,193,96,'2026-04-01 22:26:51'),(262,194,37,'2026-04-01 22:26:51'),(263,195,75,'2026-04-01 22:26:51'),(264,196,43,'2026-04-01 22:26:51'),(265,197,174,'2026-04-01 22:26:51'),(266,198,120,'2026-04-01 22:26:51'),(267,199,60,'2026-04-01 22:26:51'),(268,200,120,'2026-04-01 22:26:51'),(269,201,200,'2026-04-01 22:26:51'),(270,202,219,'2026-04-01 22:26:51'),(271,203,78,'2026-04-01 22:26:51'),(272,204,113,'2026-04-01 22:26:51'),(273,205,111,'2026-04-01 22:26:51'),(274,206,197,'2026-04-01 22:26:51'),(275,207,30,'2026-04-01 22:26:51'),(276,208,142,'2026-04-01 22:26:51'),(277,209,201,'2026-04-01 22:26:51'),(278,210,160,'2026-04-01 22:26:51'),(279,211,176,'2026-04-01 22:26:51'),(280,212,182,'2026-04-01 22:26:51'),(281,213,161,'2026-04-01 22:26:51'),(282,214,38,'2026-04-01 22:26:51'),(283,215,90,'2026-04-01 22:26:51'),(284,216,116,'2026-04-01 22:26:51'),(285,217,91,'2026-04-01 22:26:51'),(286,218,85,'2026-04-01 22:26:51'),(287,219,136,'2026-04-01 22:26:51'),(288,220,203,'2026-04-04 21:58:56'),(289,221,192,'2026-04-01 22:26:51'),(290,222,128,'2026-04-01 22:26:51'),(291,223,47,'2026-04-01 22:26:51'),(292,224,31,'2026-04-01 22:26:51'),(293,225,195,'2026-04-01 22:26:51'),(294,226,62,'2026-04-01 22:26:51'),(295,227,106,'2026-04-01 22:26:51'),(296,228,125,'2026-04-01 22:26:51'),(297,229,86,'2026-04-01 22:26:51'),(298,230,35,'2026-04-01 22:26:51'),(299,231,97,'2026-04-01 22:26:51'),(300,232,163,'2026-04-01 22:26:51'),(301,238,105,'2026-04-01 22:26:51'),(302,239,213,'2026-04-01 22:26:51'),(303,240,134,'2026-04-01 22:26:51'),(304,241,211,'2026-04-01 22:26:51'),(305,242,33,'2026-04-01 22:26:51'),(306,233,113,'2026-04-01 22:26:51'),(307,234,44,'2026-04-01 22:26:51'),(308,235,64,'2026-04-01 22:26:51'),(309,236,169,'2026-04-01 22:26:51'),(310,237,31,'2026-04-01 22:26:51'),(311,293,30,'2026-04-01 22:26:51'),(312,294,39,'2026-04-01 22:26:51'),(313,295,85,'2026-04-01 22:26:51'),(314,296,88,'2026-04-01 22:26:51'),(315,297,166,'2026-04-01 22:26:51'),(316,298,148,'2026-04-01 22:26:51'),(317,299,22,'2026-04-01 22:26:51'),(318,300,45,'2026-04-01 22:26:51'),(319,283,142,'2026-04-01 22:26:51'),(320,284,154,'2026-04-01 22:26:51'),(321,285,125,'2026-04-01 22:26:51'),(322,286,145,'2026-04-01 22:26:51'),(323,287,129,'2026-04-01 22:26:51'),(324,288,189,'2026-04-01 22:26:51'),(325,289,141,'2026-04-01 22:26:51'),(326,290,118,'2026-04-01 22:26:51'),(327,291,147,'2026-04-01 22:26:51'),(328,292,162,'2026-04-01 22:26:51'),(329,301,151,'2026-04-01 22:26:51'),(330,302,47,'2026-04-01 22:26:51'),(331,303,164,'2026-04-01 22:26:51'),(332,304,59,'2026-04-01 22:26:51'),(333,305,185,'2026-04-01 22:26:51'),(334,306,127,'2026-04-01 22:26:51'),(335,307,60,'2026-04-01 22:26:51'),(336,308,102,'2026-04-01 22:26:51'),(337,309,109,'2026-04-01 22:26:51'),(338,310,219,'2026-04-01 22:26:51'),(339,311,150,'2026-04-01 22:26:51'),(340,312,72,'2026-04-01 22:26:51'),(341,243,89,'2026-04-01 22:26:51'),(342,244,211,'2026-04-01 22:26:51'),(343,245,167,'2026-04-01 22:26:51'),(344,246,183,'2026-04-01 22:26:51'),(345,247,197,'2026-04-01 22:26:51'),(346,248,213,'2026-04-01 22:26:51'),(347,249,57,'2026-04-01 22:26:51'),(348,250,26,'2026-04-01 22:26:51'),(349,251,138,'2026-04-01 22:26:51'),(350,252,195,'2026-04-01 22:26:51'),(351,253,140,'2026-04-01 22:26:51'),(352,254,97,'2026-04-01 22:26:51'),(353,255,44,'2026-04-01 22:26:51'),(354,256,111,'2026-04-01 22:26:51'),(355,257,204,'2026-04-01 22:26:51'),(356,258,67,'2026-04-01 22:26:51'),(357,259,104,'2026-04-01 22:26:51'),(358,260,97,'2026-04-01 22:26:51'),(359,261,155,'2026-04-01 22:26:51'),(360,262,65,'2026-04-01 22:26:51'),(361,263,42,'2026-04-01 22:26:51'),(362,264,194,'2026-04-01 22:26:51'),(363,265,26,'2026-04-01 22:26:51'),(364,266,129,'2026-04-01 22:26:51'),(365,267,147,'2026-04-01 22:26:51'),(366,268,130,'2026-04-01 22:26:51'),(367,269,188,'2026-04-01 22:26:51'),(368,270,130,'2026-04-01 22:26:51'),(369,271,67,'2026-04-01 22:26:51'),(370,272,124,'2026-04-01 22:26:51'),(371,273,200,'2026-04-01 22:26:51'),(372,274,210,'2026-04-01 22:26:51'),(373,275,32,'2026-04-01 22:26:51'),(374,276,108,'2026-04-01 22:26:51'),(375,277,24,'2026-04-01 22:26:51'),(376,278,177,'2026-04-01 22:26:51'),(377,279,194,'2026-04-01 22:26:51'),(378,280,21,'2026-04-01 22:26:51'),(379,281,104,'2026-04-01 22:26:51'),(380,282,36,'2026-04-01 22:26:51'),(381,323,49,'2026-04-01 22:26:51'),(382,324,118,'2026-04-01 22:26:51'),(383,325,21,'2026-04-01 22:26:51'),(384,326,133,'2026-04-01 22:26:51'),(385,327,183,'2026-04-01 22:26:51'),(386,328,98,'2026-04-01 22:26:51'),(387,329,119,'2026-04-01 22:26:51'),(388,330,82,'2026-04-01 22:26:51'),(389,313,35,'2026-04-01 22:26:51'),(390,314,109,'2026-04-01 22:26:51'),(391,315,22,'2026-04-01 22:26:51'),(392,316,163,'2026-04-01 22:26:51'),(393,317,129,'2026-04-01 22:26:51'),(394,318,137,'2026-04-01 22:26:51'),(395,319,78,'2026-04-01 22:26:51'),(396,320,159,'2026-04-01 22:26:51'),(397,321,143,'2026-04-01 22:26:51'),(398,322,216,'2026-04-01 22:26:51'),(399,331,15,'2026-04-04 22:15:25');
/*!40000 ALTER TABLE `stocuri` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'ecommerce_db'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-05 14:58:30
