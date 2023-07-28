-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: localhost    Database: bank_database
-- ------------------------------------------------------
-- Server version	8.0.33

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `_prisma_migrations`
--

DROP TABLE IF EXISTS `_prisma_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `_prisma_migrations` (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `checksum` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `finished_at` datetime(3) DEFAULT NULL,
  `migration_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `logs` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `rolled_back_at` datetime(3) DEFAULT NULL,
  `started_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `applied_steps_count` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `_prisma_migrations`
--

LOCK TABLES `_prisma_migrations` WRITE;
/*!40000 ALTER TABLE `_prisma_migrations` DISABLE KEYS */;
INSERT INTO `_prisma_migrations` VALUES ('7a19959f-afd7-4a94-8093-f84496832501','4f5ef54ce4912fcdf810e1b9b06a2fe69b00beb8e9b4f0e578635f01350db2bd','2023-07-27 05:58:04.257','20230727055803_role_added',NULL,NULL,'2023-07-27 05:58:04.034',1),('af2fde28-56eb-4edc-bd4a-16050e530ee7','3f115f9e98c540508606735449967f07f6240a206307763bbedc02682e398c13','2023-07-25 14:00:22.248','20230725130739_otp',NULL,NULL,'2023-07-25 14:00:22.159',1),('d0ffca34-8cbc-481e-932f-f424a85786df','8144738d5693ba9c34c5a3b5e101bf2c8f71f61d1b636e1d6060e0bc40d3e286','2023-07-25 14:00:22.156','20230725093432_init',NULL,NULL,'2023-07-25 14:00:21.360',1),('eabd9de1-85c7-45b7-ab4e-2a318565468f','6413f937da924d0d5ce4f6b3c041f2ee50f93ac1b40ddff5ea0c0f057dae654e','2023-07-25 14:00:36.424','20230725140036_ini',NULL,NULL,'2023-07-25 14:00:36.255',1);
/*!40000 ALTER TABLE `_prisma_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account` (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `account_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `account_number` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ifsc_code` enum('BANK0007') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'BANK0007',
  `account_balance` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `document_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Account_account_number_key` (`account_number`),
  KEY `Account_document_id_fkey` (`document_id`),
  CONSTRAINT `Account_document_id_fkey` FOREIGN KEY (`document_id`) REFERENCES `document` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES ('117431a0-81c0-4d4c-97a3-065463f7f1f2','SALARY','488736169321','BANK0007','900.00','57274dd2-37da-4352-bef2-a1ca7a0633f2','2023-07-27 15:55:17.927','2023-07-27 16:01:34.209'),('16e7fc79-9310-448b-8514-cd50567f383b','CURRENT','217353206621','BANK0007','758.00','79b281c4-0570-42c9-acf3-f0c4d28ec921','2023-07-26 05:47:22.480','2023-07-26 18:38:46.288'),('3db41a96-b098-4d16-9200-453a9a83fb0c','SAVINGS','372185570269','BANK0007','45500','110b3a78-2d0f-4c82-abc2-581120c27b8b','2023-07-27 12:58:37.658','2023-07-27 12:58:37.658'),('6b3a3117-6f37-437f-b3ec-287c1135cd30','CURRENT','970575108805','BANK0007','500.00','df4138d7-301b-4c9e-9ec6-721207664b8d','2023-07-25 17:07:27.156','2023-07-25 17:07:27.156'),('74370623-b0b2-483e-bd8f-5fcd96340395','SALARY','217256008117','BANK0007','71660.00','e049531e-27ca-47c6-8b8c-ead06f6cf2d1','2023-07-27 07:05:46.555','2023-07-27 15:47:45.914'),('be57eba8-6cf7-4365-bd91-526262ea523a','CURRENT','968728324673','BANK0007','599','504c1e2e-27b6-445b-a73d-34468c15d612','2023-07-25 14:01:42.615','2023-07-25 14:01:42.615'),('c0a9072c-1519-471c-a302-b92f93122f3e','CURRENT','749583675378','BANK0007','820.4','bed58386-b707-4556-9200-5885385270ec','2023-07-25 17:18:40.910','2023-07-25 17:18:40.910'),('d14ef326-d500-46e2-9bde-6e1a3b5ba748','CURRENT','417024359553','BANK0007','500.00','5a9fe043-2247-4e6b-99a0-f94881110883','2023-07-25 17:04:54.909','2023-07-25 17:04:54.909'),('f196a7f8-331a-49f4-b9cc-28cbd87c97f1','SAVINGS','659862486566','BANK0007','8965.00','96efe817-f483-4c9b-817d-9d3f26ac21b8','2023-07-26 17:45:01.186','2023-07-27 06:58:47.757');
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounttransaction`
--

DROP TABLE IF EXISTS `accounttransaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounttransaction` (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `transaction_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `transaction_amount` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `AccountTransaction_customer_id_fkey` (`customer_id`),
  CONSTRAINT `AccountTransaction_customer_id_fkey` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounttransaction`
--

LOCK TABLES `accounttransaction` WRITE;
/*!40000 ALTER TABLE `accounttransaction` DISABLE KEYS */;
INSERT INTO `accounttransaction` VALUES ('0818adb9-dbb3-4411-bd72-ed238961e72a','54375709-704d-4b0b-91f5-35fe24e39cd0','WITHDRAW','250','2023-07-27 06:58:38.017','2023-07-27 06:58:38.017'),('0b30e93c-a009-4ebe-b8f3-add9ea8db58a','95df5ea5-8b51-4613-abfa-7512c073595b','DEPOSITE','NaN','2023-07-26 16:30:14.308','2023-07-26 16:30:14.308'),('1334dcae-2672-486d-9adf-a4547bb1ee41','95df5ea5-8b51-4613-abfa-7512c073595b','DEPOSITE','200','2023-07-26 16:48:53.975','2023-07-26 16:48:53.975'),('139ecb1b-e06b-4a69-9272-790ebba26bb0','abc39a6d-e37a-427d-bbf6-7491a4e28c58','WITHDRAW','200','2023-07-27 16:01:34.240','2023-07-27 16:01:34.240'),('1c164c1c-8800-4c89-9501-8af4e51dc79d','54375709-704d-4b0b-91f5-35fe24e39cd0','WITHDRAW','100','2023-07-27 06:58:32.342','2023-07-27 06:58:32.342'),('267819c0-d402-4aad-a9a0-4adbc8240b35','abc39a6d-e37a-427d-bbf6-7491a4e28c58','DEPOSITE','600','2023-07-27 16:01:30.496','2023-07-27 16:01:30.496'),('44491311-dbc2-41ca-b042-3e079847670c','95df5ea5-8b51-4613-abfa-7512c073595b','DEPOSITE','NaN','2023-07-26 16:28:44.380','2023-07-26 16:28:44.380'),('48af6ba7-b9f3-4cdc-a9b8-a6be8bf451e0','95df5ea5-8b51-4613-abfa-7512c073595b','WITHDRAW','55','2023-07-26 17:19:35.713','2023-07-26 17:19:35.713'),('5ff0c5f1-4f71-4033-a92d-ab698b516d2f','95df5ea5-8b51-4613-abfa-7512c073595b','WITHDRAW','88','2023-07-26 17:19:41.275','2023-07-26 17:19:41.275'),('62605dc3-9717-426b-95f5-5461bbd76a23','95df5ea5-8b51-4613-abfa-7512c073595b','DEPOSITE','NaN','2023-07-26 16:34:04.517','2023-07-26 16:34:04.517'),('6662385b-af7a-4e9d-80d0-ace32697e3a7','95df5ea5-8b51-4613-abfa-7512c073595b','WITHDRAW','99','2023-07-26 17:19:28.668','2023-07-26 17:19:28.668'),('680a369e-455a-4161-b373-2653c22c632b','95df5ea5-8b51-4613-abfa-7512c073595b','WITHDRAW','12','2023-07-26 17:19:31.582','2023-07-26 17:19:31.582'),('68380293-96e1-49f8-9725-a9f906e6ae6a','95df5ea5-8b51-4613-abfa-7512c073595b','WITHDRAW','10','2023-07-26 18:38:33.338','2023-07-26 18:38:33.338'),('75e97898-d7cf-405d-9128-2b8ffd719be1','95df5ea5-8b51-4613-abfa-7512c073595b','DEPOSITE','1000','2023-07-26 16:49:18.081','2023-07-26 16:49:18.081'),('82a81886-dfdb-46ad-a4ed-8a1f5c99e60d','95df5ea5-8b51-4613-abfa-7512c073595b','WITHDRAW','100','2023-07-26 16:49:10.692','2023-07-26 16:49:10.692'),('8444b8ea-8a32-4fa6-9b03-384b2b91c9f8','95df5ea5-8b51-4613-abfa-7512c073595b','DEPOSITE','4','2023-07-26 16:47:15.947','2023-07-26 16:47:15.947'),('8dcda755-59d4-43eb-8d80-1488b11af555','54375709-704d-4b0b-91f5-35fe24e39cd0','WITHDRAW','500','2023-07-27 06:58:44.533','2023-07-27 06:58:44.533'),('91d8e6e3-2880-40ab-9f7f-9d2f4d789d2d','95df5ea5-8b51-4613-abfa-7512c073595b','WITHDRAW','500','2023-07-26 17:19:44.374','2023-07-26 17:19:44.374'),('9247b463-dee4-44be-8054-46b6947ce3b9','95df5ea5-8b51-4613-abfa-7512c073595b','DEPOSITE','20','2023-07-26 16:47:22.553','2023-07-26 16:47:22.553'),('94f1a3dd-c852-4648-95da-55acce6a04e6','54375709-704d-4b0b-91f5-35fe24e39cd0','WITHDRAW','100','2023-07-27 06:58:35.425','2023-07-27 06:58:35.425'),('95bc0142-291b-49c1-8264-f7a3a90f9a23','95df5ea5-8b51-4613-abfa-7512c073595b','WITHDRAW','10','2023-07-26 16:43:52.636','2023-07-26 16:43:52.636'),('98413750-e2bb-456d-bca8-4407f0d15c98','95df5ea5-8b51-4613-abfa-7512c073595b','WITHDRAW','44','2023-07-26 17:19:38.281','2023-07-26 17:19:38.281'),('99c9e242-37ef-45cc-b0e8-78424e0fe357','95df5ea5-8b51-4613-abfa-7512c073595b','DEPOSITE','NaN','2023-07-26 16:33:15.857','2023-07-26 16:33:15.857'),('9d3330c0-6bb2-443e-9a4e-711cbea21f98','54375709-704d-4b0b-91f5-35fe24e39cd0','WITHDRAW','44','2023-07-27 06:58:47.778','2023-07-27 06:58:47.778'),('ad48e845-a48d-4435-951e-d67af333acd4','95df5ea5-8b51-4613-abfa-7512c073595b','WITHDRAW','30','2023-07-26 16:44:05.575','2023-07-26 16:44:05.575'),('c0f9f8a0-e50e-43a3-ada8-0f8101382435','54375709-704d-4b0b-91f5-35fe24e39cd0','WITHDRAW','40','2023-07-27 06:58:41.297','2023-07-27 06:58:41.297'),('c4eaa6ed-f329-426a-921f-b42c944e47e8','95df5ea5-8b51-4613-abfa-7512c073595b','DEPOSITE','20','2023-07-26 18:38:46.314','2023-07-26 18:38:46.314'),('ca0e1211-bd5d-4218-95c4-263914856b49','dee2996b-d47e-422d-b4b6-59a037f7e148','WITHDRAW','1000','2023-07-27 15:47:39.241','2023-07-27 15:47:39.241'),('ce70c9f0-5b6b-42fa-bc10-0a40be586874','95df5ea5-8b51-4613-abfa-7512c073595b','WITHDRAW','20','2023-07-26 16:43:56.663','2023-07-26 16:43:56.663'),('e1f2a6ff-de88-4b10-bb34-a8ce9f2c6846','dee2996b-d47e-422d-b4b6-59a037f7e148','DEPOSITE','99','2023-07-27 15:47:45.940','2023-07-27 15:47:45.940'),('fdf06b76-0ca0-48c7-ade2-ec283fa9b6d6','95df5ea5-8b51-4613-abfa-7512c073595b','WITHDRAW','18','2023-07-26 16:44:00.632','2023-07-26 16:44:00.632');
/*!40000 ALTER TABLE `accounttransaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address` (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `country` enum('INDIA') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'INDIA',
  `state` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `district` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `landmark` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES ('037fed8c-a1bc-4440-aaac-2a4beb3e10e0','current','INDIA','maharashtra','pune','haveli','somewhere on earth','2023-07-27 07:05:46.566','2023-07-27 07:05:46.566'),('2154c673-020c-425c-be54-92dc7f559a6f','current','INDIA','maharashtra','pune','haveli','somewhere on earth','2023-07-25 17:18:40.937','2023-07-25 17:18:40.937'),('3d1c4a16-d068-43ec-8434-1f05f40cd1c5','current','INDIA','maharashtra','pune','bhosari','Near Dr. D. Y. Patil College of medica, science & engineering.','2023-07-26 05:47:22.504','2023-07-26 05:47:22.504'),('52ae3b7d-2634-42c5-94fe-79eded79eb85','current','INDIA','maharashtra','pune','bhosari','Near Dr. D. Y. Patil College of medica, science & engineering.','2023-07-25 14:01:42.627','2023-07-25 14:01:42.627'),('7647a4b8-79c4-44bc-9c96-190ba50bafe7','current','INDIA','maharashtra','pune','haveli','somewhere on earth','2023-07-26 17:45:01.196','2023-07-26 17:45:01.196'),('809aafe4-da9a-472c-944e-4cbe295825ef','current','INDIA','Assam','Haveli','Kathua','near by','2023-07-27 15:55:17.939','2023-07-27 15:55:17.939'),('b6930ec9-d6e6-46f3-ab26-01b3d4b740ce','current','INDIA','maharashtra','pune','haveli','somewhere on earth','2023-07-27 12:58:37.741','2023-07-27 12:58:37.741'),('b934169e-4365-4d11-98ed-158e842001e9','current','INDIA','maharashtra','pune','haveli','Near Dr. D. Y. Patil College.','2023-07-25 17:07:27.165','2023-07-25 17:07:27.165'),('d609db59-859a-4f7e-9dec-d7b07581be95','current','INDIA','maharashtra','pune','haveli','Near Dr. D. Y. Patil College.','2023-07-25 17:05:28.311','2023-07-25 17:05:28.311'),('ec49359c-2ae3-4cd6-a1f7-881baa839597','current','INDIA','maharashtra','pune','haveli','Near Dr. D. Y. Patil College.','2023-07-25 17:04:54.942','2023-07-25 17:04:54.942');
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `city`
--

DROP TABLE IF EXISTS `city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `city` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `districtid` int DEFAULT NULL,
  `state_id` int DEFAULT NULL,
  `description` text NOT NULL,
  `status` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6600 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `city`
--

LOCK TABLES `city` WRITE;
/*!40000 ALTER TABLE `city` DISABLE KEYS */;
INSERT INTO `city` VALUES (676,'Kupwara',47,15,'','Active'),(677,'Handwara',47,15,'','Active'),(678,'Karnah',47,15,'','Active'),(679,'Khag',39,15,'','Active'),(680,'Beerwah',39,15,'','Active'),(681,'Khansahib',39,15,'','Active'),(682,'Budgam',39,15,'','Active'),(683,'Chadoora',39,15,'','Active'),(684,'Charar- E- Shrief',39,15,'','Active'),(685,'Leh',48,15,'','Active'),(686,'Nubra',48,15,'','Active'),(687,'Khalsi',48,15,'','Active'),(688,'Kargil',43,15,'','Active'),(689,'Sanku',43,15,'','Active'),(690,'Zanskar',43,15,'','Active'),(691,'Haveli',49,15,'','Active'),(692,'Mandi',49,15,'','Active'),(693,'Mendhar',49,15,'','Active'),(694,'Surankote',49,15,'','Active'),(695,'Thanamandi',51,15,'','Active'),(696,'Darhal',51,15,'','Active'),(697,'Rajauri',51,15,'','Active'),(698,'Budhal',51,15,'','Active'),(699,'Kalakote',51,15,'','Active'),(700,'Nowshehra',51,15,'','Active'),(701,'Sunderbani',51,15,'','Active'),(702,'Billawar',44,15,'','Active'),(703,'Bashohli',44,15,'','Active'),(704,'Bani',44,15,'','Active'),(705,'Kathua',44,15,'','Active'),(706,'Hiranagar',44,15,'','Active'),(707,'Sopore',38,15,'','Active'),(708,'Rafiabad',38,15,'','Active'),(709,'Pattan',38,15,'','Active'),(710,'Baramulla',38,15,'','Active'),(711,'Kreeri',38,15,'','Active'),(712,'Uri',38,15,'','Active'),(713,'Boniyar',38,15,'','Active'),(714,'Tangmarg',38,15,'','Active'),(715,'Gurez',37,15,'','Active'),(716,'Bandipora',37,15,'','Active'),(717,'Sonawari',37,15,'','Active'),(718,'Srinagar (North)',56,15,'','Active'),(719,'Srinagar (South)',56,15,'','Active'),(720,'Lar',41,15,'','Active'),(721,'Kangan',41,15,'','Active'),(722,'Ganderbal',41,15,'','Active'),(723,'Pampore',50,15,'','Active'),(724,'Awantipora',50,15,'','Active'),(725,'Tral',50,15,'','Active'),(726,'Pulwama',50,15,'','Active'),(727,'Shopian',55,15,'','Active'),(728,'Pahalgam',36,15,'','Active'),(729,'Bijbehara',36,15,'','Active'),(730,'Anantnag',36,15,'','Active'),(731,'Shangus',36,15,'','Active'),(732,'Kokernag',36,15,'','Active'),(733,'Dooru',36,15,'','Active'),(734,'Kulgam',46,15,'','Active'),(735,'Devsar',46,15,'','Active'),(736,'Damhal Hanjipora',46,15,'','Active'),(737,'Doda',40,15,'','Active'),(738,'Thathri',40,15,'','Active'),(739,'Gandoh',40,15,'','Active'),(740,'Bhaderwah',40,15,'','Active'),(741,'Banihal',52,15,'','Active'),(742,'Ramban',52,15,'','Active'),(743,'Kishtwar',45,15,'','Active'),(744,'Marwah',45,15,'','Active'),(745,'Chhatroo',45,15,'','Active'),(746,'Atholi (Paddar)',45,15,'','Active'),(747,'Udhampur',57,15,'','Active'),(748,'Chenani',57,15,'','Active'),(749,'Ramnagar',57,15,'','Active'),(750,'Majalta',57,15,'','Active'),(751,'Gool-Gulabgarh',53,15,'','Active'),(752,'Reasi',53,15,'','Active'),(753,'Akhnoor',42,15,'','Active'),(754,'Jammu',42,15,'','Active'),(755,'Ranbir Singh Pora',42,15,'','Active'),(756,'Bishnah',42,15,'','Active'),(757,'Samba',54,15,'','Active'),(758,'Pangi',59,14,'','Active'),(759,'Chaurah',59,14,'','Active'),(760,'Saluni',59,14,'','Active'),(761,'Bhalai',59,14,'','Active'),(762,'Dalhousie',59,14,'','Active'),(763,'Bhattiyat',59,14,'','Active'),(764,'Sihunta',59,14,'','Active'),(765,'Chamba',59,14,'','Active'),(766,'Holi',59,14,'','Active'),(767,'Brahmaur',59,14,'','Active'),(768,'Nurpur',61,14,'','Active'),(769,'Indora',61,14,'','Active'),(770,'Fatehpur',61,14,'','Active'),(771,'Jawali',61,14,'','Active'),(772,'Harchakian',61,14,'','Active'),(773,'Shahpur',61,14,'','Active'),(774,'Dharmsala',61,14,'','Active'),(775,'Kangra',61,14,'','Active'),(776,'Nagrota Bagwan',61,14,'','Active'),(777,'Baroh',61,14,'','Active'),(778,'Dera Gopipur',61,14,'','Active'),(779,'Jawalamukhi',61,14,'','Active'),(780,'Jaswan',61,14,'','Active'),(781,'Rakkar',61,14,'','Active'),(782,'Khundian',61,14,'','Active'),(783,'Thural',61,14,'','Active'),(784,'Dhira',61,14,'','Active'),(785,'Jaisinghpur',61,14,'','Active'),(786,'Palampur',61,14,'','Active'),(787,'Baijnath',61,14,'','Active'),(788,'Multhan',61,14,'','Active'),(789,'Udaipur',64,14,'','Active'),(790,'Lahul',64,14,'','Active'),(791,'Spiti',64,14,'','Active'),(792,'Manali',63,14,'','Active'),(793,'Kullu',63,14,'','Active'),(794,'Sainj',63,14,'','Active'),(795,'Banjar',63,14,'','Active'),(796,'Ani',63,14,'','Active'),(797,'Nermand',63,14,'','Active'),(798,'Padhar',65,14,'','Active'),(799,'Jogindarnagar',65,14,'','Active'),(800,'Lad Bharol',65,14,'','Active'),(801,'Sandhol',65,14,'','Active'),(802,'Dharmpur',65,14,'','Active'),(803,'Kotli',65,14,'','Active'),(804,'Sarkaghat',65,14,'','Active'),(805,'Bhadrota',65,14,'','Active'),(806,'Baldwara',65,14,'','Active'),(807,'Sundarnagar',65,14,'','Active'),(808,'Mandi',65,14,'','Active'),(809,'Aut',65,14,'','Active'),(810,'Bali Chowki',65,14,'','Active'),(811,'Thunag',65,14,'','Active'),(812,'Chachyot',65,14,'','Active'),(813,'Nihri',65,14,'','Active'),(814,'Karsog',65,14,'','Active'),(815,'Tira Sujanpur',60,14,'','Active'),(816,'Nadaun',60,14,'','Active'),(817,'Galore',60,14,'','Active'),(818,'Hamirpur',60,14,'','Active'),(819,'Barsar',60,14,'','Active'),(820,'Dhatwal',60,14,'','Active'),(821,'Bhoranj',60,14,'','Active'),(822,'Bharwain',69,14,'','Active'),(823,'Amb',69,14,'','Active'),(824,'Bangana',69,14,'','Active'),(825,'Una',69,14,'','Active'),(826,'Haroli',69,14,'','Active'),(827,'Ghumarwin',58,14,'','Active'),(828,'Bharari',58,14,'','Active'),(829,'Jhanduta',58,14,'','Active'),(830,'Naina Devi',58,14,'','Active'),(831,'Bilaspur Sadar',58,14,'','Active'),(832,'Namhol',58,14,'','Active'),(833,'Arki',68,14,'','Active'),(834,'Darlaghat',68,14,'','Active'),(835,'Ramshahr',68,14,'','Active'),(836,'Nalagarh',68,14,'','Active'),(837,'Baddi',68,14,'','Active'),(838,'Krishangarh',68,14,'','Active'),(839,'Kasauli',68,14,'','Active'),(840,'Solan',68,14,'','Active'),(841,'Kandaghat',68,14,'','Active'),(842,'Rajgarh',67,14,'','Active'),(843,'Nohra',67,14,'','Active'),(844,'Pachhad',67,14,'','Active'),(845,'Renuka',67,14,'','Active'),(846,'Dadahu',67,14,'','Active'),(847,'Nahan',67,14,'','Active'),(848,'Paonta Sahib',67,14,'','Active'),(849,'Kamrau',67,14,'','Active'),(850,'Shalai',67,14,'','Active'),(851,'Ronhat',67,14,'','Active'),(852,'Rampur',66,14,'','Active'),(853,'Nankhari',66,14,'','Active'),(854,'Kumharsain',66,14,'','Active'),(855,'Seoni',66,14,'','Active'),(856,'Shimla (Rural)',66,14,'','Active'),(857,'Shimla (Urban)',66,14,'','Active'),(858,'Junga',66,14,'','Active'),(859,'Theog',66,14,'','Active'),(860,'Chaupal',66,14,'','Active'),(861,'Cheta',66,14,'','Active'),(862,'Nerua',66,14,'','Active'),(863,'Jubbal',66,14,'','Active'),(864,'Kotkhai',66,14,'','Active'),(865,'Tikar',66,14,'','Active'),(866,'Rohru',66,14,'','Active'),(867,'Chirgaon',66,14,'','Active'),(868,'Dodra Kwar',66,14,'','Active'),(869,'Hangrang',62,14,'','Active'),(870,'Poo',62,14,'','Active'),(871,'Morang',62,14,'','Active'),(872,'Kalpa',62,14,'','Active'),(873,'Nichar',62,14,'','Active'),(874,'Sangla',62,14,'','Active'),(875,'Dhar Kalan',76,28,'','Active'),(876,'Pathankot',76,28,'','Active'),(877,'Gurdaspur',76,28,'','Active'),(878,'Batala',76,28,'','Active'),(879,'Dera Baba Nanak',76,28,'','Active'),(880,'Bhulath',79,28,'','Active'),(881,'Kapurthala',79,28,'','Active'),(882,'Sultanpur Lodhi',79,28,'','Active'),(883,'Phagwara',79,28,'','Active'),(884,'Shahkot',78,28,'','Active'),(885,'Nakodar',78,28,'','Active'),(886,'Phillaur',78,28,'','Active'),(887,'Jalandhar - I',78,28,'','Active'),(888,'Jalandhar - Ii',78,28,'','Active'),(889,'Dasua',77,28,'','Active'),(890,'Mukerian',77,28,'','Active'),(891,'Hoshiarpur',77,28,'','Active'),(892,'Garhshankar',77,28,'','Active'),(893,'Nawanshahr',88,28,'','Active'),(894,'Balachaur',88,28,'','Active'),(895,'Bassi Pathana',74,28,'','Active'),(896,'Fatehgarh Sahib',74,28,'','Active'),(897,'Amloh',74,28,'','Active'),(898,'Khamanon',74,28,'','Active'),(899,'Samrala',80,28,'','Active'),(900,'Khanna',80,28,'','Active'),(901,'Payal',80,28,'','Active'),(902,'Ludhiana (East)',80,28,'','Active'),(903,'Ludhiana (West)',80,28,'','Active'),(904,'Raikot',80,28,'','Active'),(905,'Jagraon',80,28,'','Active'),(906,'Nihal Singhwala',82,28,'','Active'),(907,'Bagha Purana',82,28,'','Active'),(908,'Moga',82,28,'','Active'),(909,'Zira',75,28,'','Active'),(910,'Firozpur',75,28,'','Active'),(911,'Jalalabad',75,28,'','Active'),(912,'Fazilka',75,28,'','Active'),(913,'Abohar',75,28,'','Active'),(914,'Malout',83,28,'','Active'),(915,'Gidderbaha',83,28,'','Active'),(916,'Muktsar',83,28,'','Active'),(917,'Faridkot',73,28,'','Active'),(918,'Jaitu',73,28,'','Active'),(919,'Rampura Phul',72,28,'','Active'),(920,'Bathinda',72,28,'','Active'),(921,'Talwandi Sabo',72,28,'','Active'),(922,'Sardulgarh',81,28,'','Active'),(923,'Budhlada',81,28,'','Active'),(924,'Mansa',81,28,'','Active'),(925,'Samana',84,28,'','Active'),(926,'Patran',84,28,'','Active'),(927,'Nabha',84,28,'','Active'),(928,'Patiala',84,28,'','Active'),(929,'Rajpura',84,28,'','Active'),(930,'Ajnala',70,28,'','Active'),(931,'Amritsar -I',70,28,'','Active'),(932,'Amritsar- Ii',70,28,'','Active');
/*!40000 ALTER TABLE `city` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `middle_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_of_birth` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `gender` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `account_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `address_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `document_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL,
  `role` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Customer_phone_key` (`phone`),
  UNIQUE KEY `Customer_email_key` (`email`),
  KEY `Customer_account_id_fkey` (`account_id`),
  KEY `Customer_address_id_fkey` (`address_id`),
  KEY `Customer_document_id_fkey` (`document_id`),
  CONSTRAINT `Customer_account_id_fkey` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Customer_address_id_fkey` FOREIGN KEY (`address_id`) REFERENCES `address` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Customer_document_id_fkey` FOREIGN KEY (`document_id`) REFERENCES `document` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES ('54375709-704d-4b0b-91f5-35fe24e39cd0','john cena','wick','buthcher','1232267782','john1@gmail.com','$2b$10$EAi5DEyJZpU6mQ0U0Ul9FOD/78uXU6zTkWp0pTgBB/p/qIl89RsnC','21/7/2023','MALE','f196a7f8-331a-49f4-b9cc-28cbd87c97f1','7647a4b8-79c4-44bc-9c96-190ba50bafe7','96efe817-f483-4c9b-817d-9d3f26ac21b8','2023-07-26 17:45:01.203','2023-07-27 15:35:49.189','customer'),('95df5ea5-8b51-4613-abfa-7512c073595b','Sunil','G.','Gawai','7399253831','sunilgawai@gmail.com','$2b$10$avScRmnTHC6k3/K2EanUweIIHtcGIltIY40lxP4KfaGDzFREG/q6S','15-07-2023','MALE','16e7fc79-9310-448b-8514-cd50567f383b','3d1c4a16-d068-43ec-8434-1f05f40cd1c5','79b281c4-0570-42c9-acf3-f0c4d28ec921','2023-07-26 05:47:22.524','2023-07-27 07:06:39.158','admin'),('9a087340-7c41-4086-8bde-bd4fd6a170d9','Sunil','Gangaram','Gawai','7399253829','sunilgawai7397@gmail.com','$2b$10$ffx5NAS7Ddmt9fdCDwzz/e7FEcskO/GaVuZ2YdihqpkKIzcIpmUGu','30/09/2001','MALE','be57eba8-6cf7-4365-bd91-526262ea523a','52ae3b7d-2634-42c5-94fe-79eded79eb85','504c1e2e-27b6-445b-a73d-34468c15d612','2023-07-25 14:01:42.643','2023-07-27 12:38:53.570','customer'),('abc39a6d-e37a-427d-bbf6-7491a4e28c58','vishal','sdjcnjdcn','jdjj','0739797355','vishal123@gmail.com','$2b$10$Kyvz3ei1mIJoHvRFgADNt.uSgEi.bwr0u.iFtTiY9WQLvijVhgN0W','11/7/2023','male','117431a0-81c0-4d4c-97a3-065463f7f1f2','809aafe4-da9a-472c-944e-4cbe295825ef','57274dd2-37da-4352-bef2-a1ca7a0633f2','2023-07-27 15:55:17.950','2023-07-27 16:02:02.744','customer'),('dee2996b-d47e-422d-b4b6-59a037f7e148','Amar','Ghatak','Jadha','7397973125','amarjadhav@gmail.com','$2b$10$8Jz80mIaJkOm3GhVbckYPuxxOxnYZBosUWX9wbNsZMwhBWzFXQ0f2','15-07-1998','male','74370623-b0b2-483e-bd8f-5fcd96340395','037fed8c-a1bc-4440-aaac-2a4beb3e10e0','e049531e-27ca-47c6-8b8c-ead06f6cf2d1','2023-07-27 07:05:46.578','2023-07-27 15:48:37.629','customer');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `district`
--

DROP TABLE IF EXISTS `district`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `district` (
  `districtid` int NOT NULL AUTO_INCREMENT,
  `district_title` varchar(100) NOT NULL,
  `state_id` int DEFAULT NULL,
  `district_description` text NOT NULL,
  `district_status` varchar(10) NOT NULL,
  PRIMARY KEY (`districtid`)
) ENGINE=InnoDB AUTO_INCREMENT=6600 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `district`
--

LOCK TABLES `district` WRITE;
/*!40000 ALTER TABLE `district` DISABLE KEYS */;
INSERT INTO `district` VALUES (36,'Anantnag',15,'','Active'),(37,'Bandipore',15,'','Active'),(38,'Baramulla',15,'','Active'),(39,'Budgam',15,'','Active'),(40,'Doda',15,'','Active'),(41,'Ganderbal',15,'','Active'),(42,'Jammu',15,'','Active'),(43,'Kargil',15,'','Active'),(44,'Kathua',15,'','Active'),(45,'Kishtwar',15,'','Active'),(46,'Kulgam',15,'','Active'),(47,'Kupwara',15,'','Active'),(48,'Leh (Ladakh)',15,'','Active'),(49,'Poonch',15,'','Active'),(50,'Pulwama',15,'','Active'),(51,'Rajouri',15,'','Active'),(52,'Ramban',15,'','Active'),(53,'Reasi',15,'','Active'),(54,'Samba',15,'','Active'),(55,'Shopian',15,'','Active'),(56,'Srinagar',15,'','Active'),(57,'Udhampur',15,'','Active'),(58,'Bilaspur (Himachal Pradesh)',14,'','Active'),(59,'Chamba',14,'','Active'),(60,'Hamirpur (Himachal Pradesh)',14,'','Active'),(61,'Kangra',14,'','Active'),(62,'Kinnaur',14,'','Active'),(63,'Kullu',14,'','Active'),(64,'Lahul & Spiti',14,'','Active'),(65,'Mandi',14,'','Active'),(66,'Shimla',14,'','Active'),(67,'Sirmaur',14,'','Active'),(68,'Solan',14,'','Active'),(69,'Una',14,'','Active'),(70,'Amritsar',28,'','Active'),(71,'Barnala',28,'','Active'),(72,'Bathinda',28,'','Active'),(73,'Faridkot',28,'','Active'),(74,'Fatehgarh Sahib',28,'','Active'),(75,'Firozpur',28,'','Active'),(76,'Gurdaspur',28,'','Active'),(77,'Hoshiarpur',28,'','Active'),(78,'Jalandhar',28,'','Active'),(79,'Kapurthala',28,'','Active'),(80,'Ludhiana',28,'','Active'),(81,'Mansa',28,'','Active'),(82,'Moga',28,'','Active'),(83,'Muktsar',28,'','Active'),(84,'Patiala',28,'','Active'),(85,'Rupnagar (Ropar)',28,'','Active'),(86,'Sahibzada Ajit Singh Nagar (Mohali)',28,'','Active'),(87,'Sangrur',28,'','Active'),(88,'Shahid Bhagat Singh Nagar (Nawanshahr)',28,'','Active'),(89,'Tarn Taran',28,'','Active'),(90,'Chandigarh',6,'','Active'),(91,'Almora',34,'','Active'),(92,'Bageshwar',34,'','Active'),(93,'Chamoli',34,'','Active'),(94,'Champawat',34,'','Active'),(95,'Dehradun',34,'','Active'),(96,'Haridwar',34,'','Active'),(97,'Nainital',34,'','Active'),(98,'Pauri Garhwal',34,'','Active'),(99,'Pithoragarh',34,'','Active'),(100,'Rudraprayag',34,'','Active'),(101,'Tehri Garhwal',34,'','Active'),(102,'Udham Singh Nagar',34,'','Active'),(103,'Uttarkashi',34,'','Active'),(104,'Ambala',13,'','Active'),(105,'Bhiwani',13,'','Active'),(106,'Faridabad',13,'','Active'),(107,'Fatehabad',13,'','Active'),(108,'Gurgaon',13,'','Active'),(109,'Hisar',13,'','Active'),(110,'Jhajjar',13,'','Active'),(111,'Jind',13,'','Active'),(112,'Kaithal',13,'','Active'),(113,'Karnal',13,'','Active'),(114,'Kurukshetra',13,'','Active'),(115,'Mahendragarh',13,'','Active'),(116,'Mewat',13,'','Active'),(117,'Palwal',13,'','Active'),(118,'Panchkula',13,'','Active'),(119,'Panipat',13,'','Active'),(120,'Rewari',13,'','Active'),(121,'Rohtak',13,'','Active'),(122,'Sirsa',13,'','Active'),(123,'Sonipat',13,'','Active'),(124,'Yamuna Nagar',13,'','Active'),(125,'Central Delhi',10,'','Active'),(126,'East Delhi',10,'','Active'),(127,'New Delhi',10,'','Active'),(128,'North Delhi',10,'','Active'),(129,'North East Delhi',10,'','Active'),(130,'North West Delhi',10,'','Active'),(131,'South Delhi',10,'','Active'),(132,'South West Delhi',10,'','Active'),(133,'West Delhi',10,'','Active'),(134,'Ajmer',29,'','Active'),(135,'Alwar',29,'','Active'),(136,'Banswara',29,'','Active'),(137,'Baran',29,'','Active'),(138,'Barmer',29,'','Active'),(139,'Bharatpur',29,'','Active'),(140,'Bhilwara',29,'','Active'),(141,'Bikaner',29,'','Active'),(142,'Bundi',29,'','Active'),(143,'Chittorgarh',29,'','Active'),(144,'Churu',29,'','Active'),(145,'Dausa',29,'','Active'),(146,'Dholpur',29,'','Active'),(147,'Dungarpur',29,'','Active'),(148,'Ganganagar',29,'','Active'),(149,'Hanumangarh',29,'','Active'),(150,'Jaipur',29,'','Active'),(151,'Jaisalmer',29,'','Active'),(152,'Jalor',29,'','Active'),(153,'Jhalawar',29,'','Active'),(154,'Jhunjhunu',29,'','Active'),(155,'Jodhpur',29,'','Active'),(156,'Karauli',29,'','Active'),(157,'Kota',29,'','Active'),(158,'Nagaur',29,'','Active'),(159,'Pali',29,'','Active'),(160,'Pratapgarh (Rajasthan)',29,'','Active'),(161,'Rajsamand',29,'','Active'),(162,'Sawai Madhopur',29,'','Active'),(163,'Sikar',29,'','Active'),(164,'Sirohi',29,'','Active'),(165,'Tonk',29,'','Active'),(166,'Udaipur',29,'','Active'),(167,'Agra',33,'','Active'),(168,'Aligarh',33,'','Active'),(169,'Allahabad',33,'','Active'),(170,'Ambedkar Nagar',33,'','Active'),(171,'Auraiya',33,'','Active'),(172,'Azamgarh',33,'','Active'),(173,'Bagpat',33,'','Active'),(174,'Bahraich',33,'','Active'),(175,'Ballia',33,'','Active'),(176,'Balrampur',33,'','Active'),(177,'Banda',33,'','Active'),(178,'Barabanki',33,'','Active'),(179,'Bareilly',33,'','Active'),(180,'Basti',33,'','Active'),(181,'Bijnor',33,'','Active'),(182,'Budaun',33,'','Active'),(183,'Bulandshahr',33,'','Active'),(184,'Chandauli',33,'','Active'),(185,'Chitrakoot',33,'','Active'),(186,'Deoria',33,'','Active'),(187,'Etah',33,'','Active'),(188,'Etawah',33,'','Active'),(189,'Faizabad',33,'','Active'),(190,'Farrukhabad',33,'','Active'),(191,'Fatehpur',33,'','Active'),(192,'Firozabad',33,'','Active'),(193,'Gautam Buddha Nagar',33,'','Active'),(194,'Ghaziabad',33,'','Active'),(195,'Ghazipur',33,'','Active'),(196,'Gonda',33,'','Active'),(197,'Gorakhpur',33,'','Active'),(198,'Hamirpur',33,'','Active'),(199,'Hardoi',33,'','Active'),(200,'Hathras',33,'','Active'),(201,'Jalaun',33,'','Active'),(202,'Jaunpur',33,'','Active'),(203,'Jhansi',33,'','Active'),(204,'Jyotiba Phule Nagar',33,'','Active'),(205,'Kannauj',33,'','Active'),(206,'Kanpur Dehat',33,'','Active'),(207,'Kanpur Nagar',33,'','Active'),(208,'Kanshiram Nagar',33,'','Active'),(209,'Kaushambi',33,'','Active'),(210,'Kheri',33,'','Active'),(211,'Kushinagar',33,'','Active'),(212,'Lalitpur',33,'','Active'),(213,'Lucknow',33,'','Active'),(214,'Maharajganj',33,'','Active'),(215,'Mahoba',33,'','Active'),(216,'Mainpuri',33,'','Active'),(217,'Mathura',33,'','Active'),(218,'Mau',33,'','Active'),(219,'Meerut',33,'','Active'),(220,'Mirzapur',33,'','Active'),(221,'Moradabad',33,'','Active'),(222,'Muzaffarnagar',33,'','Active'),(223,'Pilibhit',33,'','Active'),(224,'Pratapgarh',33,'','Active'),(225,'Rae Bareli',33,'','Active'),(226,'Rampur',33,'','Active'),(227,'Saharanpur',33,'','Active'),(228,'Sant Kabir Nagar',33,'','Active'),(229,'Sant Ravidas Nagar (Bhadohi)',33,'','Active'),(230,'Shahjahanpur',33,'','Active'),(231,'Shrawasti',33,'','Active'),(232,'Siddharthnagar',33,'','Active'),(233,'Sitapur',33,'','Active'),(234,'Sonbhadra',33,'','Active'),(235,'Sultanpur',33,'','Active'),(236,'Unnao',33,'','Active'),(237,'Varanasi',33,'','Active'),(238,'Araria',5,'','Active'),(239,'Arwal',5,'','Active'),(240,'Aurangabad (Bihar)',5,'','Active'),(241,'Banka',5,'','Active'),(242,'Begusarai',5,'','Active'),(243,'Bhagalpur',5,'','Active'),(244,'Bhojpur',5,'','Active'),(245,'Buxar',5,'','Active'),(246,'Darbhanga',5,'','Active'),(247,'East Champaran',5,'','Active'),(248,'Gaya',5,'','Active'),(249,'Gopalganj',5,'','Active'),(250,'Jamui',5,'','Active'),(251,'Jehanabad',5,'','Active'),(252,'Kaimur (Bhabua)',5,'','Active'),(253,'Katihar',5,'','Active'),(254,'Khagaria',5,'','Active'),(255,'Kishanganj',5,'','Active'),(256,'Lakhisarai',5,'','Active'),(257,'Madhepura',5,'','Active'),(258,'Madhubani',5,'','Active'),(259,'Munger',5,'','Active'),(260,'Muzaffarpur',5,'','Active'),(261,'Nalanda',5,'','Active'),(262,'Nawada',5,'','Active'),(263,'Patna',5,'','Active'),(264,'Purnia',5,'','Active'),(265,'Rohtas',5,'','Active'),(266,'Saharsa',5,'','Active'),(267,'Samastipur',5,'','Active'),(268,'Saran',5,'','Active'),(269,'Sheikhpura',5,'','Active'),(270,'Sheohar',5,'','Active'),(271,'Sitamarhi',5,'','Active'),(272,'Siwan',5,'','Active'),(273,'Supaul',5,'','Active'),(274,'Vaishali',5,'','Active'),(275,'West Champaran',5,'','Active'),(276,'East Sikkim',30,'','Active'),(277,'North Sikkim',30,'','Active'),(278,'South Sikkim',30,'','Active'),(279,'West Sikkim',30,'','Active'),(280,'Anjaw',3,'','Active'),(281,'Changlang',3,'','Active'),(282,'Dibang Valley',3,'','Active'),(283,'East Kameng',3,'','Active'),(284,'East Siang',3,'','Active'),(285,'Kurung Kumey',3,'','Active'),(286,'Lohit',3,'','Active'),(287,'Lower Dibang Valley',3,'','Active'),(288,'Lower Subansiri',3,'','Active'),(289,'Papum Pare',3,'','Active'),(290,'Tawang',3,'','Active'),(291,'Tirap',3,'','Active'),(292,'Upper Siang',3,'','Active'),(293,'Upper Subansiri',3,'','Active'),(294,'West Kameng',3,'','Active'),(295,'West Siang',3,'','Active'),(296,'Dimapur',25,'','Active'),(297,'Kiphire',25,'','Active'),(298,'Kohima',25,'','Active'),(299,'Longleng',25,'','Active'),(300,'Mokokchung',25,'','Active'),(301,'Mon',25,'','Active'),(302,'Peren',25,'','Active'),(303,'Phek',25,'','Active'),(304,'Tuensang',25,'','Active'),(305,'Wokha',25,'','Active'),(306,'Zunheboto',25,'','Active'),(307,'Bishnupur',22,'','Active'),(308,'Chandel',22,'','Active'),(309,'Churachandpur',22,'','Active'),(310,'Imphal East',22,'','Active'),(311,'Imphal West',22,'','Active'),(312,'Senapati',22,'','Active'),(313,'Tamenglong',22,'','Active'),(314,'Thoubal',22,'','Active'),(315,'Ukhrul',22,'','Active'),(316,'Aizawl',24,'','Active'),(317,'Champhai',24,'','Active'),(318,'Kolasib',24,'','Active'),(319,'Lawngtlai',24,'','Active'),(320,'Lunglei',24,'','Active'),(321,'Mamit',24,'','Active'),(322,'Saiha',24,'','Active'),(323,'Serchhip',24,'','Active'),(324,'Dhalai',32,'','Active'),(325,'North Tripura',32,'','Active'),(326,'South Tripura',32,'','Active'),(327,'West Tripura',32,'','Active'),(328,'East Garo Hills',23,'','Active'),(329,'East Khasi Hills',23,'','Active'),(330,'Jaintia Hills',23,'','Active'),(331,'Ri Bhoi',23,'','Active'),(332,'South Garo Hills',23,'','Active'),(333,'West Garo Hills',23,'','Active'),(334,'West Khasi Hills',23,'','Active'),(335,'Baksa',4,'','Active'),(336,'Barpeta',4,'','Active'),(337,'Bongaigaon',4,'','Active'),(338,'Cachar',4,'','Active'),(339,'Chirang',4,'','Active'),(340,'Darrang',4,'','Active'),(341,'Dhemaji',4,'','Active'),(342,'Dhubri',4,'','Active'),(343,'Dibrugarh',4,'','Active'),(344,'Dima Hasao (North Cachar Hills)',4,'','Active'),(345,'Goalpara',4,'','Active'),(346,'Golaghat',4,'','Active'),(347,'Hailakandi',4,'','Active'),(348,'Jorhat',4,'','Active'),(349,'Kamrup',4,'','Active'),(350,'Kamrup Metropolitan',4,'','Active'),(351,'Karbi Anglong',4,'','Active'),(352,'Karimganj',4,'','Active'),(353,'Kokrajhar',4,'','Active'),(354,'Lakhimpur',4,'','Active'),(355,'Morigaon',4,'','Active'),(356,'Nagaon',4,'','Active'),(357,'Nalbari',4,'','Active'),(358,'Sivasagar',4,'','Active'),(359,'Sonitpur',4,'','Active'),(360,'Tinsukia',4,'','Active'),(361,'Udalguri',4,'','Active'),(362,'Bankura',35,'','Active'),(363,'Bardhaman',35,'','Active'),(364,'Birbhum',35,'','Active'),(365,'Cooch Behar',35,'','Active'),(366,'Dakshin Dinajpur (South Dinajpur)',35,'','Active'),(367,'Darjiling',35,'','Active'),(368,'Hooghly',35,'','Active'),(369,'Howrah',35,'','Active'),(370,'Jalpaiguri',35,'','Active'),(371,'Kolkata',35,'','Active'),(372,'Maldah',35,'','Active'),(373,'Murshidabad',35,'','Active'),(374,'Nadia',35,'','Active'),(375,'North 24 Parganas',35,'','Active'),(376,'Paschim Medinipur (West Midnapore)',35,'','Active'),(377,'Purba Medinipur (East Midnapore)',35,'','Active'),(378,'Puruliya',35,'','Active'),(379,'South 24 Parganas',35,'','Active'),(380,'Uttar Dinajpur (North Dinajpur)',35,'','Active'),(381,'Bokaro',16,'','Active'),(382,'Chatra',16,'','Active'),(383,'Deoghar',16,'','Active'),(384,'Dhanbad',16,'','Active'),(385,'Dumka',16,'','Active'),(386,'East Singhbhum',16,'','Active'),(387,'Garhwa',16,'','Active'),(388,'Giridih',16,'','Active'),(389,'Godda',16,'','Active'),(390,'Gumla',16,'','Active'),(391,'Hazaribagh',16,'','Active'),(392,'Jamtara',16,'','Active'),(393,'Khunti',16,'','Active'),(394,'Koderma',16,'','Active'),(395,'Latehar',16,'','Active'),(396,'Lohardaga',16,'','Active'),(397,'Pakur',16,'','Active'),(398,'Palamu',16,'','Active'),(399,'Ramgarh',16,'','Active'),(400,'Ranchi',16,'','Active'),(401,'Sahibganj',16,'','Active'),(402,'Seraikela-Kharsawan',16,'','Active'),(403,'Simdega',16,'','Active'),(404,'West Singhbhum',16,'','Active'),(405,'Angul',26,'','Active'),(406,'Balangir',26,'','Active'),(407,'Baleswar',26,'','Active'),(408,'Bargarh',26,'','Active'),(409,'Bhadrak',26,'','Active'),(410,'Boudh',26,'','Active'),(411,'Cuttack',26,'','Active'),(412,'Debagarh',26,'','Active'),(413,'Dhenkanal',26,'','Active'),(414,'Gajapati',26,'','Active'),(415,'Ganjam',26,'','Active'),(416,'Jagatsinghapur',26,'','Active'),(417,'Jajapur',26,'','Active'),(418,'Jharsuguda',26,'','Active'),(419,'Kalahandi',26,'','Active'),(420,'Kandhamal',26,'','Active'),(421,'Kendrapara',26,'','Active'),(422,'Kendujhar',26,'','Active'),(423,'Khordha',26,'','Active'),(424,'Koraput',26,'','Active'),(425,'Malkangiri',26,'','Active'),(426,'Mayurbhanj',26,'','Active'),(427,'Nabarangapur',26,'','Active'),(428,'Nayagarh',26,'','Active'),(429,'Nuapada',26,'','Active'),(430,'Puri',26,'','Active'),(431,'Rayagada',26,'','Active'),(432,'Sambalpur',26,'','Active'),(433,'Subarnapur (Sonapur)',26,'','Active'),(434,'Sundergarh',26,'','Active'),(435,'Bastar',7,'','Active'),(436,'Bijapur (Chhattisgarh)',7,'','Active'),(437,'Bilaspur (Chhattisgarh)',7,'','Active'),(438,'Dakshin Bastar Dantewada',7,'','Active'),(439,'Dhamtari',7,'','Active'),(440,'Durg',7,'','Active'),(441,'Janjgir-Champa',7,'','Active'),(442,'Jashpur',7,'','Active'),(443,'Kabirdham (Kawardha)',7,'','Active'),(444,'Korba',7,'','Active'),(445,'Koriya',7,'','Active'),(446,'Mahasamund',7,'','Active'),(447,'Narayanpur',7,'','Active'),(448,'Raigarh (Chhattisgarh)',7,'','Active'),(449,'Raipur',7,'','Active'),(450,'Rajnandgaon',7,'','Active'),(451,'Surguja',7,'','Active'),(452,'Uttar Bastar Kanker',7,'','Active'),(453,'Alirajpur',20,'','Active'),(454,'Anuppur',20,'','Active'),(455,'Ashok Nagar',20,'','Active'),(456,'Balaghat',20,'','Active'),(457,'Barwani',20,'','Active'),(458,'Betul',20,'','Active'),(459,'Bhind',20,'','Active'),(460,'Bhopal',20,'','Active'),(461,'Burhanpur',20,'','Active'),(462,'Chhatarpur',20,'','Active'),(463,'Chhindwara',20,'','Active'),(464,'Damoh',20,'','Active'),(465,'Datia',20,'','Active'),(466,'Dewas',20,'','Active'),(467,'Dhar',20,'','Active'),(468,'Dindori',20,'','Active'),(469,'Guna',20,'','Active'),(470,'Gwalior',20,'','Active'),(471,'Harda',20,'','Active'),(472,'Hoshangabad',20,'','Active'),(473,'Indore',20,'','Active'),(474,'Jabalpur',20,'','Active'),(475,'Jhabua',20,'','Active'),(476,'Katni',20,'','Active'),(477,'Khandwa (East Nimar)',20,'','Active'),(478,'Khargone (West Nimar)',20,'','Active'),(479,'Mandla',20,'','Active'),(480,'Mandsaur',20,'','Active'),(481,'Morena',20,'','Active'),(482,'Narsinghpur',20,'','Active'),(483,'Neemuch',20,'','Active'),(484,'Panna',20,'','Active'),(485,'Raisen',20,'','Active'),(486,'Rajgarh',20,'','Active'),(487,'Ratlam',20,'','Active'),(488,'Rewa',20,'','Active'),(489,'Sagar',20,'','Active'),(490,'Satna',20,'','Active'),(491,'Sehore',20,'','Active'),(492,'Seoni',20,'','Active'),(493,'Shahdol',20,'','Active'),(494,'Shajapur',20,'','Active'),(495,'Sheopur',20,'','Active'),(496,'Shivpuri',20,'','Active'),(497,'Sidhi',20,'','Active'),(498,'Singrauli',20,'','Active'),(499,'Tikamgarh',20,'','Active'),(500,'Ujjain',20,'','Active'),(501,'Umaria',20,'','Active'),(502,'Vidisha',20,'','Active'),(503,'Ahmedabad',12,'','Active'),(504,'Amreli',12,'','Active'),(505,'Anand',12,'','Active'),(506,'Banaskantha',12,'','Active'),(507,'Bharuch',12,'','Active'),(508,'Bhavnagar',12,'','Active'),(509,'Dahod',12,'','Active'),(510,'Gandhi Nagar',12,'','Active'),(511,'Jamnagar',12,'','Active'),(512,'Junagadh',12,'','Active'),(513,'Kachchh',12,'','Active'),(514,'Kheda',12,'','Active'),(515,'Mahesana',12,'','Active'),(516,'Narmada',12,'','Active'),(517,'Navsari',12,'','Active'),(518,'Panch Mahals',12,'','Active'),(519,'Patan',12,'','Active'),(520,'Porbandar',12,'','Active'),(521,'Rajkot',12,'','Active'),(522,'Sabarkantha',12,'','Active'),(523,'Surat',12,'','Active'),(524,'Surendra Nagar',12,'','Active'),(525,'Tapi',12,'','Active'),(526,'The Dangs',12,'','Active'),(527,'Vadodara',12,'','Active'),(528,'Valsad',12,'','Active'),(529,'Daman',9,'','Active'),(530,'Diu',9,'','Active'),(531,'Dadra & Nagar Haveli',8,'','Active'),(532,'Ahmed Nagar',21,'','Active'),(533,'Akola',21,'','Active'),(534,'Amravati',21,'','Active'),(535,'Aurangabad',21,'','Active'),(536,'Beed',21,'','Active'),(537,'Bhandara',21,'','Active'),(538,'Buldhana',21,'','Active'),(539,'Chandrapur',21,'','Active'),(540,'Dhule',21,'','Active'),(541,'Gadchiroli',21,'','Active'),(542,'Gondia',21,'','Active'),(543,'Hingoli',21,'','Active'),(544,'Jalgaon',21,'','Active'),(545,'Jalna',21,'','Active'),(546,'Kolhapur',21,'','Active'),(547,'Latur',21,'','Active'),(548,'Mumbai',21,'','Active'),(549,'Mumbai Suburban',21,'','Active'),(550,'Nagpur',21,'','Active'),(551,'Nanded',21,'','Active'),(552,'Nandurbar',21,'','Active'),(553,'Nashik',21,'','Active'),(554,'Osmanabad',21,'','Active'),(555,'Parbhani',21,'','Active'),(556,'Pune',21,'','Active'),(557,'Raigarh (Maharashtra)',21,'','Active'),(558,'Ratnagiri',21,'','Active'),(559,'Sangli',21,'','Active'),(560,'Satara',21,'','Active'),(561,'Sindhudurg',21,'','Active'),(562,'Solapur',21,'','Active'),(563,'Thane',21,'','Active'),(564,'Wardha',21,'','Active'),(565,'Washim',21,'','Active'),(566,'Yavatmal',21,'','Active'),(567,'Adilabad',2,'','Active'),(568,'Anantapur',2,'','Active'),(569,'Chittoor',2,'','Active'),(570,'East Godavari',2,'','Active'),(571,'Guntur',2,'','Active'),(572,'Hyderabad',2,'','Active'),(573,'Kadapa (Cuddapah)',2,'','Active'),(574,'Karim Nagar',2,'','Active'),(575,'Khammam',2,'','Active'),(576,'Krishna',2,'','Active'),(577,'Kurnool',2,'','Active'),(578,'Mahbubnagar',2,'','Active'),(579,'Medak',2,'','Active'),(580,'Nalgonda',2,'','Active'),(581,'Nellore',2,'','Active'),(582,'Nizamabad',2,'','Active'),(583,'Prakasam',2,'','Active'),(584,'Rangareddy',2,'','Active'),(585,'Srikakulam',2,'','Active'),(586,'Visakhapatnam',2,'','Active'),(587,'Vizianagaram',2,'','Active'),(588,'Warangal',2,'','Active'),(589,'West Godavari',2,'','Active'),(590,'Bagalkot',17,'','Active'),(591,'Bangalore',17,'','Active'),(592,'Bangalore Rural',17,'','Active'),(593,'Belgaum',17,'','Active'),(594,'Bellary',17,'','Active'),(595,'Bidar',17,'','Active'),(596,'Bijapur (Karnataka)',17,'','Active'),(597,'Chamrajnagar',17,'','Active'),(598,'Chickmagalur',17,'','Active'),(599,'Chikkaballapur',17,'','Active'),(600,'Chitradurga',17,'','Active'),(601,'Dakshina Kannada',17,'','Active'),(602,'Davanagere',17,'','Active'),(603,'Dharwad',17,'','Active'),(604,'Gadag',17,'','Active'),(605,'Gulbarga',17,'','Active'),(606,'Hassan',17,'','Active'),(607,'Haveri',17,'','Active'),(608,'Kodagu',17,'','Active'),(609,'Kolar',17,'','Active'),(610,'Koppal',17,'','Active'),(611,'Mandya',17,'','Active'),(612,'Mysore',17,'','Active'),(613,'Raichur',17,'','Active'),(614,'Ramanagara',17,'','Active'),(615,'Shimoga',17,'','Active'),(616,'Tumkur',17,'','Active'),(617,'Udupi',17,'','Active'),(618,'Uttara Kannada',17,'','Active'),(619,'Yadgir',17,'','Active'),(620,'North Goa',11,'','Active'),(621,'South Goa',11,'','Active'),(622,'Lakshadweep',19,'','Active'),(623,'Alappuzha',18,'','Active'),(624,'Ernakulam',18,'','Active'),(625,'Idukki',18,'','Active'),(626,'Kannur',18,'','Active'),(627,'Kasaragod',18,'','Active'),(628,'Kollam',18,'','Active'),(629,'Kottayam',18,'','Active'),(630,'Kozhikode',18,'','Active'),(631,'Malappuram',18,'','Active'),(632,'Palakkad',18,'','Active'),(633,'Pathanamthitta',18,'','Active'),(634,'Thiruvananthapuram',18,'','Active'),(635,'Thrissur',18,'','Active'),(636,'Wayanad',18,'','Active'),(637,'Ariyalur',31,'','Active'),(638,'Chennai',31,'','Active'),(639,'Coimbatore',31,'','Active'),(640,'Cuddalore',31,'','Active'),(641,'Dharmapuri',31,'','Active'),(642,'Dindigul',31,'','Active'),(643,'Erode',31,'','Active'),(644,'Kanchipuram',31,'','Active'),(645,'Kanyakumari',31,'','Active'),(646,'Karur',31,'','Active'),(647,'Krishnagiri',31,'','Active'),(648,'Madurai',31,'','Active'),(649,'Nagapattinam',31,'','Active'),(650,'Namakkal',31,'','Active'),(651,'Nilgiris',31,'','Active'),(652,'Perambalur',31,'','Active'),(653,'Pudukkottai',31,'','Active'),(654,'Ramanathapuram',31,'','Active'),(655,'Salem',31,'','Active'),(656,'Sivaganga',31,'','Active'),(657,'Thanjavur',31,'','Active'),(658,'Theni',31,'','Active'),(659,'Thoothukudi (Tuticorin)',31,'','Active'),(660,'Tiruchirappalli',31,'','Active'),(661,'Tirunelveli',31,'','Active'),(662,'Tiruppur',31,'','Active'),(663,'Tiruvallur',31,'','Active'),(664,'Tiruvannamalai',31,'','Active'),(665,'Tiruvarur',31,'','Active'),(666,'Vellore',31,'','Active'),(667,'Viluppuram',31,'','Active'),(668,'Virudhunagar',31,'','Active'),(669,'Karaikal',27,'','Active'),(670,'Mahe',27,'','Active'),(671,'Puducherry (Pondicherry)',27,'','Active'),(672,'Yanam',27,'','Active'),(673,'Nicobar',1,'','Active'),(674,'North And Middle Andaman',1,'','Active'),(675,'South Andaman',1,'','Active');
/*!40000 ALTER TABLE `district` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `document`
--

DROP TABLE IF EXISTS `document`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `document` (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `document_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `document_number` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `customerId` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Document_customerId_fkey` (`customerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `document`
--

LOCK TABLES `document` WRITE;
/*!40000 ALTER TABLE `document` DISABLE KEYS */;
INSERT INTO `document` VALUES ('110b3a78-2d0f-4c82-abc2-581120c27b8b','AADHAR','280541826744',NULL,'2023-07-27 12:58:37.610','2023-07-27 12:58:37.610'),('504c1e2e-27b6-445b-a73d-34468c15d612','UID','280541787397',NULL,'2023-07-25 14:01:42.568','2023-07-25 14:01:42.568'),('57274dd2-37da-4352-bef2-a1ca7a0633f2','PANCARD','755318524455',NULL,'2023-07-27 15:55:17.910','2023-07-27 15:55:17.910'),('5a9fe043-2247-4e6b-99a0-f94881110883','AADHAR','250541957365',NULL,'2023-07-25 17:04:54.805','2023-07-25 17:04:54.805'),('79b281c4-0570-42c9-acf3-f0c4d28ec921','UID','280541787397',NULL,'2023-07-26 05:47:22.391','2023-07-26 05:47:22.391'),('96efe817-f483-4c9b-817d-9d3f26ac21b8','PANCARD','754445132012',NULL,'2023-07-26 17:45:01.134','2023-07-26 17:45:01.134'),('bed58386-b707-4556-9200-5885385270ec','PANCARD','754445132012',NULL,'2023-07-25 17:18:40.855','2023-07-25 17:18:40.855'),('df4138d7-301b-4c9e-9ec6-721207664b8d','AADHAR','250541957365',NULL,'2023-07-25 17:07:27.122','2023-07-25 17:07:27.122'),('e049531e-27ca-47c6-8b8c-ead06f6cf2d1','PANCARD','755312154455',NULL,'2023-07-27 07:05:46.532','2023-07-27 07:05:46.532'),('ea3005f7-6066-48e7-8e3c-ce6850cff6d4','AADHAR','250541957365',NULL,'2023-07-25 17:05:28.283','2023-07-25 17:05:28.283');
/*!40000 ALTER TABLE `document` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `otp`
--

DROP TABLE IF EXISTS `otp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `otp` (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `otp` int NOT NULL,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Otp_email_key` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `otp`
--

LOCK TABLES `otp` WRITE;
/*!40000 ALTER TABLE `otp` DISABLE KEYS */;
/*!40000 ALTER TABLE `otp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `state`
--

DROP TABLE IF EXISTS `state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `state` (
  `state_id` int NOT NULL AUTO_INCREMENT,
  `state_title` varchar(100) NOT NULL,
  `state_description` text NOT NULL,
  `status` varchar(10) NOT NULL,
  PRIMARY KEY (`state_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6600 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `state`
--

LOCK TABLES `state` WRITE;
/*!40000 ALTER TABLE `state` DISABLE KEYS */;
INSERT INTO `state` VALUES (1,'Andaman & Nicobar Islands','','Active'),(2,'Andhra Pradesh','','Active'),(3,'Arunachal Pradesh','','Active'),(4,'Assam','','Active'),(5,'Bihar','','Active'),(6,'Chandigarh','','Active'),(7,'Chhattisgarh','','Active'),(8,'Dadra & Nagar Haveli','','Active'),(9,'Daman & Diu','','Active'),(10,'Delhi','','Active'),(11,'Goa','','Active'),(12,'Gujarat','','Active'),(13,'Haryana','','Active'),(14,'Himachal Pradesh','','Active'),(15,'Jammu & Kashmir','','Active'),(16,'Jharkhand','','Active'),(17,'Karnataka','','Active'),(18,'Kerala','','Active'),(19,'Lakshadweep','','Active'),(20,'Madhya Pradesh','','Active'),(21,'Maharashtra','','Active'),(22,'Manipur','','Active'),(23,'Meghalaya','','Active'),(24,'Mizoram','','Active'),(25,'Nagaland','','Active'),(26,'Odisha','','Active'),(27,'Puducherry','','Active'),(28,'Punjab','','Active'),(29,'Rajasthan','','Active'),(30,'Sikkim','','Active'),(31,'Tamil Nadu','','Active'),(32,'Tripura','','Active'),(33,'Uttar Pradesh','','Active'),(34,'Uttarakhand','','Active'),(35,'West Bengal','','Active');
/*!40000 ALTER TABLE `state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction`
--

DROP TABLE IF EXISTS `transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaction` (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `sender_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `receiver_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `time` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Transaction_sender_id_fkey` (`sender_id`),
  KEY `Transaction_receiver_id_fkey` (`receiver_id`),
  CONSTRAINT `Transaction_receiver_id_fkey` FOREIGN KEY (`receiver_id`) REFERENCES `account` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Transaction_sender_id_fkey` FOREIGN KEY (`sender_id`) REFERENCES `account` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction`
--

LOCK TABLES `transaction` WRITE;
/*!40000 ALTER TABLE `transaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `transaction` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-07-27 21:56:49
