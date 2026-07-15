/*
SQLyog Community v13.3.0 (64 bit)
MySQL - 11.2.2-MariaDB : Database - abaya
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`abaya` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;

USE `abaya`;

/*Table structure for table `addresses` */

DROP TABLE IF EXISTS `addresses`;

CREATE TABLE `addresses` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `country_id` int(11) NOT NULL DEFAULT 1,
  `province_id` int(11) NOT NULL,
  `city_id` int(11) NOT NULL,
  `area_id` int(11) NOT NULL,
  `address` varchar(255) NOT NULL,
  `landmark` varchar(255) DEFAULT NULL,
  `map_latitude` decimal(10,7) DEFAULT NULL,
  `map_longitude` decimal(10,7) DEFAULT NULL,
  `map_url` varchar(2048) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `addresses` */

LOCK TABLES `addresses` WRITE;

UNLOCK TABLES;

/*Table structure for table `admin_roles` */

DROP TABLE IF EXISTS `admin_roles`;

CREATE TABLE `admin_roles` (
  `admin_id` int(10) unsigned NOT NULL,
  `role_id` int(10) unsigned NOT NULL,
  UNIQUE KEY `unique_admin_role` (`admin_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `admin_roles` */

LOCK TABLES `admin_roles` WRITE;

insert  into `admin_roles`(`admin_id`,`role_id`) values 
(1,1);

UNLOCK TABLES;

/*Table structure for table `admins` */

DROP TABLE IF EXISTS `admins`;

CREATE TABLE `admins` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admins_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `admins` */

LOCK TABLES `admins` WRITE;

insert  into `admins`(`id`,`name`,`email`,`password`,`is_active`,`email_verified_at`,`remember_token`,`created_at`,`updated_at`) values 
(1,'Super  Admin','admin@example.com','$2y$12$PZT5s6es.H4nIV8B/ba1JeFslM.UOUO5ZsJXbqmuiSaZW.vn9E/vO',1,NULL,NULL,'2026-07-13 11:03:54','2026-07-13 11:03:54');

UNLOCK TABLES;

/*Table structure for table `announcement_translations` */

DROP TABLE IF EXISTS `announcement_translations`;

CREATE TABLE `announcement_translations` (
  `id` char(36) NOT NULL,
  `announcement_id` char(36) NOT NULL,
  `locale` varchar(5) NOT NULL,
  `title` text NOT NULL,
  `description` text DEFAULT NULL,
  UNIQUE KEY `announcement_translations_announcement_id_locale_unique` (`announcement_id`,`locale`),
  KEY `announcement_translations_locale_index` (`locale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `announcement_translations` */

LOCK TABLES `announcement_translations` WRITE;

UNLOCK TABLES;

/*Table structure for table `announcements` */

DROP TABLE IF EXISTS `announcements`;

CREATE TABLE `announcements` (
  `id` char(36) NOT NULL,
  `link` text NOT NULL,
  `icon` varchar(255) NOT NULL,
  `position` int(11) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `announcements` */

LOCK TABLES `announcements` WRITE;

UNLOCK TABLES;

/*Table structure for table `api_sync_logs` */

DROP TABLE IF EXISTS `api_sync_logs`;

CREATE TABLE `api_sync_logs` (
  `id` char(36) NOT NULL,
  `source` varchar(255) NOT NULL,
  `endpoint` varchar(255) NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `total_records` int(10) unsigned NOT NULL DEFAULT 0,
  `success` tinyint(1) NOT NULL DEFAULT 0,
  `http_status` int(11) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `fetched_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `api_sync_logs` */

LOCK TABLES `api_sync_logs` WRITE;

UNLOCK TABLES;

/*Table structure for table `areas` */

DROP TABLE IF EXISTS `areas`;

CREATE TABLE `areas` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `city_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `areas` */

LOCK TABLES `areas` WRITE;

insert  into `areas`(`id`,`city_id`,`name`,`created_at`,`updated_at`) values 
(1,1,'Al Maryah Island','2026-07-13 11:03:54','2026-07-13 11:03:54'),
(2,1,'Al Raha','2026-07-13 11:03:54','2026-07-13 11:03:54'),
(3,1,'Al Khalidiyah','2026-07-13 11:03:54','2026-07-13 11:03:54'),
(4,1,'Al Khalifa Street','2026-07-13 11:03:54','2026-07-13 11:03:54'),
(5,2,'Al Jimi','2026-07-13 11:03:54','2026-07-13 11:03:54'),
(6,2,'Al Mutared','2026-07-13 11:03:54','2026-07-13 11:03:54'),
(7,2,'Al Hili','2026-07-13 11:03:54','2026-07-13 11:03:54'),
(8,3,'Deira','2026-07-13 11:03:54','2026-07-13 11:03:54'),
(9,3,'Bur Dubai','2026-07-13 11:03:54','2026-07-13 11:03:54'),
(10,3,'Marina','2026-07-13 11:03:54','2026-07-13 11:03:54'),
(11,3,'Jumeirah','2026-07-13 11:03:54','2026-07-13 11:03:54'),
(12,3,'Downtown','2026-07-13 11:03:54','2026-07-13 11:03:54'),
(13,4,'Hatta Village','2026-07-13 11:03:54','2026-07-13 11:03:54'),
(14,4,'Hatta Wadi Hub','2026-07-13 11:03:54','2026-07-13 11:03:54'),
(15,5,'JAFZA','2026-07-13 11:03:54','2026-07-13 11:03:54'),
(16,5,'Jebel Ali Village','2026-07-13 11:03:54','2026-07-13 11:03:54'),
(17,6,'Al Majaz','2026-07-13 11:03:54','2026-07-13 11:03:54'),
(18,6,'Al Nahda','2026-07-13 11:03:54','2026-07-13 11:03:54'),
(19,6,'Al Khan','2026-07-13 11:03:54','2026-07-13 11:03:54'),
(20,7,'Ajman Corniche','2026-07-13 11:03:54','2026-07-13 11:03:54'),
(21,7,'Al Nuaimiya','2026-07-13 11:03:54','2026-07-13 11:03:54'),
(22,8,'UAQ Free Zone','2026-07-13 11:03:54','2026-07-13 11:03:54'),
(23,8,'Sinaiya','2026-07-13 11:03:54','2026-07-13 11:03:54'),
(24,9,'Al Nakheel','2026-07-13 11:03:54','2026-07-13 11:03:54'),
(25,9,'Al Hamra','2026-07-13 11:03:54','2026-07-13 11:03:54'),
(26,10,'Dibba Corniche','2026-07-13 11:03:54','2026-07-13 11:03:54'),
(27,11,'Fujairah City Centre','2026-07-13 11:03:54','2026-07-13 11:03:54'),
(28,11,'Masafi','2026-07-13 11:03:54','2026-07-13 11:03:54'),
(29,11,'Khor Fakkan','2026-07-13 11:03:54','2026-07-13 11:03:54');

UNLOCK TABLES;

/*Table structure for table `attachments` */

DROP TABLE IF EXISTS `attachments`;

CREATE TABLE `attachments` (
  `id` char(36) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `file_type` varchar(255) DEFAULT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `attachable_type` varchar(255) NOT NULL,
  `attachable_id` char(36) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `attachments_attachable_type_attachable_id_index` (`attachable_type`,`attachable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `attachments` */

LOCK TABLES `attachments` WRITE;

insert  into `attachments`(`id`,`file_path`,`file_type`,`file_name`,`attachable_type`,`attachable_id`,`created_at`,`updated_at`) values 
('019f5fd9-c7b4-72b6-a51b-2eb5d206bbad','attachments/qSioVH9fgZIaRemYiJ750LPSivfFVhRFZJg9zpkw.png','image/png','Screenshot 2026-07-13 160221.png','App\\Models\\Catalog\\ProductVariant','019f5fd9-c791-710c-ac4e-d6c0f7b4cc20','2026-07-14 12:58:55','2026-07-14 12:58:55'),
('019f5fd9-c7bc-72a5-b8a0-6a1c71d334ed','attachments/Jzc3ilIfsmdquSknwTPHzkhzFDMRZC2dhIER5dnx.png','image/png','Screenshot 2026-07-13 160158.png','App\\Models\\Catalog\\ProductVariant','019f5fd9-c791-710c-ac4e-d6c0f7b4cc20','2026-07-14 12:58:55','2026-07-14 12:58:55'),
('019f5fd9-c813-7041-8968-14fd29e1380e','attachments/eb5rKWrORYBqk3EsKGFN8JaUU9psGs65Ydfahndz.webp','image/webp','pastel-brown-and-beige-designer-cut-abaya-941x1673.webp','App\\Models\\Catalog\\ProductVariant','019f5fd9-c791-710c-ac4e-d6c0f7b4cc20','2026-07-14 12:58:55','2026-07-14 12:58:55');

UNLOCK TABLES;

/*Table structure for table `attribute_values` */

DROP TABLE IF EXISTS `attribute_values`;

CREATE TABLE `attribute_values` (
  `id` char(36) NOT NULL,
  `reference_id` int(11) DEFAULT NULL,
  `reference_value` varchar(255) DEFAULT NULL,
  `attribute_id` char(36) NOT NULL,
  `value` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `attribute_values_attribute_id_index` (`attribute_id`),
  KEY `attribute_values_reference_id_index` (`reference_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `attribute_values` */

LOCK TABLES `attribute_values` WRITE;

insert  into `attribute_values`(`id`,`reference_id`,`reference_value`,`attribute_id`,`value`) values 
('019f5a83-dd82-70bd-afc8-019dd4e85833',NULL,NULL,'019f5a83-dd7a-71a0-a5c1-2edecdd30df6','48 inches | Ideal For Height (140 cm / 4.6 ft)'),
('019f5a83-dd85-7366-b451-7b446eb8a348',NULL,NULL,'019f5a83-dd7a-71a0-a5c1-2edecdd30df6','50 inches | Ideal For Height (147 cm / 4.8 ft)'),
('019f5a83-dd89-72ea-a825-6edfa6be979f',NULL,NULL,'019f5a83-dd7a-71a0-a5c1-2edecdd30df6','52 inches | Ideal For Height (153 cm / 5 ft)'),
('019f5a83-dd8e-70b7-990c-fa5959f106af',NULL,NULL,'019f5a83-dd7a-71a0-a5c1-2edecdd30df6','54 inches | Ideal For Height (161 cm / 5.3 ft)'),
('019f5a83-dd93-710f-ad78-a8c134082166',NULL,NULL,'019f5a83-dd7a-71a0-a5c1-2edecdd30df6','56 inches | Ideal For Height (168 cm / 5.51 ft)'),
('019f5a83-dd97-709c-868d-d611e8bba0e5',NULL,NULL,'019f5a83-dd7a-71a0-a5c1-2edecdd30df6','58 inches | Ideal For Height (175 cm / 5.74 ft)'),
('019f5a83-dd9b-70fd-b981-167d83f6c7b8',NULL,NULL,'019f5a83-dd7a-71a0-a5c1-2edecdd30df6','60 inches | Ideal For Height (182 cm / 6 ft )'),
('019f5a84-ebd5-7055-87e2-80b2b8f87d44',NULL,NULL,'019f5a84-ebd1-7189-bb6b-e642f7ef6ade','XS (Bust:37Inches) (Hip :39Inches)'),
('019f5a84-ebd9-721b-9158-07a227756c3b',NULL,NULL,'019f5a84-ebd1-7189-bb6b-e642f7ef6ade','S (Bust:40Inches) (Hip :42Inches)'),
('019f5a84-ebdd-7041-82e8-3b34ea96d45f',NULL,NULL,'019f5a84-ebd1-7189-bb6b-e642f7ef6ade','M (Bust :43inches) (Hip:45 inches)'),
('019f5a84-ebe0-72fa-9ab0-199cd7babb02',NULL,NULL,'019f5a84-ebd1-7189-bb6b-e642f7ef6ade','L (Bust :46inches) (Hip:48 inches)'),
('019f5a84-ebe7-7248-aa59-b8a3cbda96a7',NULL,NULL,'019f5a84-ebd1-7189-bb6b-e642f7ef6ade','XL (Bust:49Inches) (Hip:51Inches)'),
('019f5a84-ebeb-7259-b77a-1952dd441bb7',NULL,NULL,'019f5a84-ebd1-7189-bb6b-e642f7ef6ade','2XL (Bust:53Inches) (Hip:55Inches)'),
('019f5a85-1b82-72cb-917c-545fc3675be9',NULL,NULL,'019f5a83-dd7a-71a0-a5c1-2edecdd30df6','62 inches | Ideal For Height (189 cm / 6.2 ft)'),
('019f5b53-3e79-7103-b2b7-6a6bd201b1db',NULL,NULL,'019f5b53-3e74-7108-81c9-8d76e4b07b4c','Black'),
('019f5b53-790c-70d1-8bc4-75f3883d52e3',NULL,NULL,'019f5b53-3e74-7108-81c9-8d76e4b07b4c','Light Sky Blue');

UNLOCK TABLES;

/*Table structure for table `attributes` */

DROP TABLE IF EXISTS `attributes`;

CREATE TABLE `attributes` (
  `id` char(36) NOT NULL,
  `reference_id` int(11) DEFAULT NULL,
  `reference_name` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `attributes` */

LOCK TABLES `attributes` WRITE;

insert  into `attributes`(`id`,`reference_id`,`reference_name`,`name`,`created_at`,`updated_at`,`deleted_at`) values 
('019f5a83-dd7a-71a0-a5c1-2edecdd30df6',NULL,NULL,'Abaya Length','2026-07-13 12:06:59','2026-07-13 12:06:59',NULL),
('019f5a84-ebd1-7189-bb6b-e642f7ef6ade',NULL,NULL,'Body Size','2026-07-13 12:08:08','2026-07-13 12:08:08',NULL),
('019f5b53-3e74-7108-81c9-8d76e4b07b4c',NULL,NULL,'Color','2026-07-13 15:53:29','2026-07-13 15:53:29',NULL);

UNLOCK TABLES;

/*Table structure for table `banner_translations` */

DROP TABLE IF EXISTS `banner_translations`;

CREATE TABLE `banner_translations` (
  `id` char(36) NOT NULL,
  `banner_id` char(36) NOT NULL,
  `locale` varchar(5) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `subtitle` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `banner_translations_banner_id_locale_unique` (`banner_id`,`locale`),
  KEY `banner_translations_banner_id_index` (`banner_id`),
  KEY `banner_translations_locale_index` (`locale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `banner_translations` */

LOCK TABLES `banner_translations` WRITE;

insert  into `banner_translations`(`id`,`banner_id`,`locale`,`title`,`subtitle`,`description`,`created_at`,`updated_at`) values 
('019f5fc4-9118-73d0-999c-f644cdd1c5f9','019f5fc4-9117-702e-98bf-5ad57f334fbe','en-ae','Summer Collection',NULL,NULL,'2026-07-14 12:35:45','2026-07-14 12:35:45');

UNLOCK TABLES;

/*Table structure for table `banners` */

DROP TABLE IF EXISTS `banners`;

CREATE TABLE `banners` (
  `id` char(36) NOT NULL,
  `image` varchar(255) NOT NULL,
  `background` varchar(255) DEFAULT NULL,
  `text_color` varchar(255) NOT NULL,
  `btn_text` varchar(255) DEFAULT NULL,
  `btn_color` varchar(255) DEFAULT NULL,
  `btn_link` varchar(255) DEFAULT NULL,
  `position` int(11) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `banners` */

LOCK TABLES `banners` WRITE;

insert  into `banners`(`id`,`image`,`background`,`text_color`,`btn_text`,`btn_color`,`btn_link`,`position`,`is_active`,`created_at`,`updated_at`,`deleted_at`) values 
('019f5fc4-9117-702e-98bf-5ad57f334fbe','banners/MdC5Dnmh2bi6GmpNCvrR3P8TtGSex1QjZp1Sfr26.png',NULL,'#ffffff','View Collections','#000000',NULL,1,1,'2026-07-14 12:35:45','2026-07-14 12:35:45',NULL);

UNLOCK TABLES;

/*Table structure for table `billing_addresses` */

DROP TABLE IF EXISTS `billing_addresses`;

CREATE TABLE `billing_addresses` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `province` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `area` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `landmark` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `billing_addresses_user_id_foreign` (`user_id`),
  CONSTRAINT `billing_addresses_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `billing_addresses` */

LOCK TABLES `billing_addresses` WRITE;

UNLOCK TABLES;

/*Table structure for table `brands` */

DROP TABLE IF EXISTS `brands`;

CREATE TABLE `brands` (
  `id` char(36) NOT NULL,
  `reference_id` int(11) DEFAULT NULL,
  `reference_name` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `position` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `brands_slug_unique` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `brands` */

LOCK TABLES `brands` WRITE;

UNLOCK TABLES;

/*Table structure for table `cache` */

DROP TABLE IF EXISTS `cache`;

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` bigint(20) NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `cache` */

LOCK TABLES `cache` WRITE;

insert  into `cache`(`key`,`value`,`expiration`) values 
('laravel-cache-admin_permissions:1','a:106:{i:0;a:2:{s:6:\"module\";s:5:\"admin\";s:4:\"name\";s:9:\"view list\";}i:1;a:2:{s:6:\"module\";s:5:\"admin\";s:4:\"name\";s:6:\"create\";}i:2;a:2:{s:6:\"module\";s:5:\"admin\";s:4:\"name\";s:6:\"update\";}i:3;a:2:{s:6:\"module\";s:5:\"admin\";s:4:\"name\";s:6:\"delete\";}i:4;a:2:{s:6:\"module\";s:5:\"admin\";s:4:\"name\";s:7:\"restore\";}i:5;a:2:{s:6:\"module\";s:4:\"role\";s:4:\"name\";s:9:\"view list\";}i:6;a:2:{s:6:\"module\";s:4:\"role\";s:4:\"name\";s:6:\"create\";}i:7;a:2:{s:6:\"module\";s:4:\"role\";s:4:\"name\";s:6:\"update\";}i:8;a:2:{s:6:\"module\";s:4:\"role\";s:4:\"name\";s:6:\"delete\";}i:9;a:2:{s:6:\"module\";s:4:\"role\";s:4:\"name\";s:7:\"restore\";}i:10;a:2:{s:6:\"module\";s:10:\"permission\";s:4:\"name\";s:9:\"view list\";}i:11;a:2:{s:6:\"module\";s:10:\"permission\";s:4:\"name\";s:6:\"create\";}i:12;a:2:{s:6:\"module\";s:10:\"permission\";s:4:\"name\";s:6:\"update\";}i:13;a:2:{s:6:\"module\";s:10:\"permission\";s:4:\"name\";s:6:\"delete\";}i:14;a:2:{s:6:\"module\";s:10:\"permission\";s:4:\"name\";s:7:\"restore\";}i:15;a:2:{s:6:\"module\";s:6:\"module\";s:4:\"name\";s:9:\"view list\";}i:16;a:2:{s:6:\"module\";s:6:\"module\";s:4:\"name\";s:6:\"create\";}i:17;a:2:{s:6:\"module\";s:6:\"module\";s:4:\"name\";s:6:\"update\";}i:18;a:2:{s:6:\"module\";s:6:\"module\";s:4:\"name\";s:6:\"delete\";}i:19;a:2:{s:6:\"module\";s:6:\"module\";s:4:\"name\";s:7:\"restore\";}i:20;a:2:{s:6:\"module\";s:7:\"product\";s:4:\"name\";s:9:\"view list\";}i:21;a:2:{s:6:\"module\";s:7:\"product\";s:4:\"name\";s:6:\"create\";}i:22;a:2:{s:6:\"module\";s:7:\"product\";s:4:\"name\";s:6:\"update\";}i:23;a:2:{s:6:\"module\";s:7:\"product\";s:4:\"name\";s:6:\"delete\";}i:24;a:2:{s:6:\"module\";s:7:\"product\";s:4:\"name\";s:7:\"restore\";}i:25;a:2:{s:6:\"module\";s:7:\"product\";s:4:\"name\";s:4:\"bulk\";}i:26;a:2:{s:6:\"module\";s:8:\"category\";s:4:\"name\";s:9:\"view list\";}i:27;a:2:{s:6:\"module\";s:8:\"category\";s:4:\"name\";s:6:\"create\";}i:28;a:2:{s:6:\"module\";s:8:\"category\";s:4:\"name\";s:6:\"update\";}i:29;a:2:{s:6:\"module\";s:8:\"category\";s:4:\"name\";s:6:\"delete\";}i:30;a:2:{s:6:\"module\";s:8:\"category\";s:4:\"name\";s:7:\"restore\";}i:31;a:2:{s:6:\"module\";s:5:\"brand\";s:4:\"name\";s:9:\"view list\";}i:32;a:2:{s:6:\"module\";s:5:\"brand\";s:4:\"name\";s:6:\"create\";}i:33;a:2:{s:6:\"module\";s:5:\"brand\";s:4:\"name\";s:6:\"update\";}i:34;a:2:{s:6:\"module\";s:5:\"brand\";s:4:\"name\";s:6:\"delete\";}i:35;a:2:{s:6:\"module\";s:5:\"brand\";s:4:\"name\";s:7:\"restore\";}i:36;a:2:{s:6:\"module\";s:9:\"attribute\";s:4:\"name\";s:9:\"view list\";}i:37;a:2:{s:6:\"module\";s:9:\"attribute\";s:4:\"name\";s:6:\"create\";}i:38;a:2:{s:6:\"module\";s:9:\"attribute\";s:4:\"name\";s:6:\"update\";}i:39;a:2:{s:6:\"module\";s:9:\"attribute\";s:4:\"name\";s:6:\"delete\";}i:40;a:2:{s:6:\"module\";s:9:\"attribute\";s:4:\"name\";s:7:\"restore\";}i:41;a:2:{s:6:\"module\";s:6:\"coupon\";s:4:\"name\";s:9:\"view list\";}i:42;a:2:{s:6:\"module\";s:6:\"coupon\";s:4:\"name\";s:6:\"create\";}i:43;a:2:{s:6:\"module\";s:6:\"coupon\";s:4:\"name\";s:6:\"update\";}i:44;a:2:{s:6:\"module\";s:6:\"coupon\";s:4:\"name\";s:6:\"delete\";}i:45;a:2:{s:6:\"module\";s:6:\"coupon\";s:4:\"name\";s:7:\"restore\";}i:46;a:2:{s:6:\"module\";s:6:\"vendor\";s:4:\"name\";s:9:\"view list\";}i:47;a:2:{s:6:\"module\";s:6:\"vendor\";s:4:\"name\";s:6:\"create\";}i:48;a:2:{s:6:\"module\";s:6:\"vendor\";s:4:\"name\";s:6:\"update\";}i:49;a:2:{s:6:\"module\";s:6:\"vendor\";s:4:\"name\";s:6:\"delete\";}i:50;a:2:{s:6:\"module\";s:6:\"vendor\";s:4:\"name\";s:7:\"restore\";}i:51;a:2:{s:6:\"module\";s:5:\"offer\";s:4:\"name\";s:9:\"view list\";}i:52;a:2:{s:6:\"module\";s:5:\"offer\";s:4:\"name\";s:6:\"create\";}i:53;a:2:{s:6:\"module\";s:5:\"offer\";s:4:\"name\";s:6:\"update\";}i:54;a:2:{s:6:\"module\";s:5:\"offer\";s:4:\"name\";s:6:\"delete\";}i:55;a:2:{s:6:\"module\";s:5:\"offer\";s:4:\"name\";s:7:\"restore\";}i:56;a:2:{s:6:\"module\";s:15:\"inventorysource\";s:4:\"name\";s:9:\"view list\";}i:57;a:2:{s:6:\"module\";s:15:\"inventorysource\";s:4:\"name\";s:6:\"create\";}i:58;a:2:{s:6:\"module\";s:15:\"inventorysource\";s:4:\"name\";s:6:\"update\";}i:59;a:2:{s:6:\"module\";s:15:\"inventorysource\";s:4:\"name\";s:6:\"delete\";}i:60;a:2:{s:6:\"module\";s:15:\"inventorysource\";s:4:\"name\";s:7:\"restore\";}i:61;a:2:{s:6:\"module\";s:4:\"page\";s:4:\"name\";s:9:\"view list\";}i:62;a:2:{s:6:\"module\";s:4:\"page\";s:4:\"name\";s:6:\"create\";}i:63;a:2:{s:6:\"module\";s:4:\"page\";s:4:\"name\";s:6:\"update\";}i:64;a:2:{s:6:\"module\";s:4:\"page\";s:4:\"name\";s:6:\"delete\";}i:65;a:2:{s:6:\"module\";s:4:\"page\";s:4:\"name\";s:7:\"restore\";}i:66;a:2:{s:6:\"module\";s:6:\"banner\";s:4:\"name\";s:9:\"view list\";}i:67;a:2:{s:6:\"module\";s:6:\"banner\";s:4:\"name\";s:6:\"create\";}i:68;a:2:{s:6:\"module\";s:6:\"banner\";s:4:\"name\";s:6:\"update\";}i:69;a:2:{s:6:\"module\";s:6:\"banner\";s:4:\"name\";s:6:\"delete\";}i:70;a:2:{s:6:\"module\";s:6:\"banner\";s:4:\"name\";s:7:\"restore\";}i:71;a:2:{s:6:\"module\";s:4:\"news\";s:4:\"name\";s:9:\"view list\";}i:72;a:2:{s:6:\"module\";s:4:\"news\";s:4:\"name\";s:6:\"create\";}i:73;a:2:{s:6:\"module\";s:4:\"news\";s:4:\"name\";s:6:\"update\";}i:74;a:2:{s:6:\"module\";s:4:\"news\";s:4:\"name\";s:6:\"delete\";}i:75;a:2:{s:6:\"module\";s:4:\"news\";s:4:\"name\";s:7:\"restore\";}i:76;a:2:{s:6:\"module\";s:11:\"testimonial\";s:4:\"name\";s:9:\"view list\";}i:77;a:2:{s:6:\"module\";s:11:\"testimonial\";s:4:\"name\";s:6:\"create\";}i:78;a:2:{s:6:\"module\";s:11:\"testimonial\";s:4:\"name\";s:6:\"update\";}i:79;a:2:{s:6:\"module\";s:11:\"testimonial\";s:4:\"name\";s:6:\"delete\";}i:80;a:2:{s:6:\"module\";s:11:\"testimonial\";s:4:\"name\";s:7:\"restore\";}i:81;a:2:{s:6:\"module\";s:6:\"locale\";s:4:\"name\";s:9:\"view list\";}i:82;a:2:{s:6:\"module\";s:6:\"locale\";s:4:\"name\";s:6:\"create\";}i:83;a:2:{s:6:\"module\";s:6:\"locale\";s:4:\"name\";s:6:\"update\";}i:84;a:2:{s:6:\"module\";s:6:\"locale\";s:4:\"name\";s:6:\"delete\";}i:85;a:2:{s:6:\"module\";s:6:\"locale\";s:4:\"name\";s:7:\"restore\";}i:86;a:2:{s:6:\"module\";s:8:\"currency\";s:4:\"name\";s:9:\"view list\";}i:87;a:2:{s:6:\"module\";s:8:\"currency\";s:4:\"name\";s:6:\"create\";}i:88;a:2:{s:6:\"module\";s:8:\"currency\";s:4:\"name\";s:6:\"update\";}i:89;a:2:{s:6:\"module\";s:8:\"currency\";s:4:\"name\";s:6:\"delete\";}i:90;a:2:{s:6:\"module\";s:8:\"currency\";s:4:\"name\";s:7:\"restore\";}i:91;a:2:{s:6:\"module\";s:7:\"country\";s:4:\"name\";s:9:\"view list\";}i:92;a:2:{s:6:\"module\";s:7:\"country\";s:4:\"name\";s:6:\"create\";}i:93;a:2:{s:6:\"module\";s:7:\"country\";s:4:\"name\";s:6:\"update\";}i:94;a:2:{s:6:\"module\";s:7:\"country\";s:4:\"name\";s:6:\"delete\";}i:95;a:2:{s:6:\"module\";s:7:\"country\";s:4:\"name\";s:7:\"restore\";}i:96;a:2:{s:6:\"module\";s:3:\"tag\";s:4:\"name\";s:9:\"view list\";}i:97;a:2:{s:6:\"module\";s:3:\"tag\";s:4:\"name\";s:6:\"create\";}i:98;a:2:{s:6:\"module\";s:3:\"tag\";s:4:\"name\";s:6:\"update\";}i:99;a:2:{s:6:\"module\";s:3:\"tag\";s:4:\"name\";s:6:\"delete\";}i:100;a:2:{s:6:\"module\";s:3:\"tag\";s:4:\"name\";s:7:\"restore\";}i:101;a:2:{s:6:\"module\";s:5:\"email\";s:4:\"name\";s:9:\"view list\";}i:102;a:2:{s:6:\"module\";s:5:\"email\";s:4:\"name\";s:6:\"create\";}i:103;a:2:{s:6:\"module\";s:5:\"email\";s:4:\"name\";s:6:\"update\";}i:104;a:2:{s:6:\"module\";s:5:\"email\";s:4:\"name\";s:6:\"delete\";}i:105;a:2:{s:6:\"module\";s:5:\"email\";s:4:\"name\";s:7:\"restore\";}}',1784115637),
('laravel-cache-app_settings','a:9:{s:10:\"site_title\";N;s:10:\"site_intro\";N;s:13:\"contact_email\";N;s:13:\"contact_phone\";N;s:7:\"address\";N;s:9:\"copyright\";N;s:11:\"tiny_mc_key\";s:48:\"h3rea8194qv4ab63xugfqv8id2wa701co8ute8zcb5zrjywe\";s:18:\"return_policy_days\";s:1:\"7\";s:23:\"allow_negative_purchase\";s:1:\"0\";}',2099471320),
('laravel-cache-modules:all','a:21:{s:5:\"admin\";i:1;s:9:\"attribute\";i:8;s:6:\"banner\";i:14;s:5:\"brand\";i:7;s:8:\"category\";i:6;s:7:\"country\";i:19;s:6:\"coupon\";i:9;s:8:\"currency\";i:18;s:5:\"email\";i:21;s:15:\"inventorysource\";i:12;s:6:\"locale\";i:17;s:6:\"module\";i:4;s:4:\"news\";i:15;s:5:\"offer\";i:11;s:4:\"page\";i:13;s:10:\"permission\";i:3;s:7:\"product\";i:5;s:4:\"role\";i:2;s:3:\"tag\";i:20;s:11:\"testimonial\";i:16;s:6:\"vendor\";i:10;}',1784116837);

UNLOCK TABLES;

/*Table structure for table `cache_locks` */

DROP TABLE IF EXISTS `cache_locks`;

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` bigint(20) NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_locks_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `cache_locks` */

LOCK TABLES `cache_locks` WRITE;

UNLOCK TABLES;

/*Table structure for table `cart_items` */

DROP TABLE IF EXISTS `cart_items`;

CREATE TABLE `cart_items` (
  `id` char(36) NOT NULL,
  `cart_id` char(36) NOT NULL,
  `product_variant_id` char(36) NOT NULL,
  `quantity` int(10) unsigned NOT NULL DEFAULT 1,
  `price` decimal(10,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`id`),
  KEY `cart_items_cart_id_index` (`cart_id`),
  KEY `cart_items_product_variant_id_index` (`product_variant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `cart_items` */

LOCK TABLES `cart_items` WRITE;

UNLOCK TABLES;

/*Table structure for table `carts` */

DROP TABLE IF EXISTS `carts`;

CREATE TABLE `carts` (
  `id` char(36) NOT NULL,
  `user_id` char(36) DEFAULT NULL,
  `session_id` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `carts_user_id_index` (`user_id`),
  KEY `carts_session_id_index` (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `carts` */

LOCK TABLES `carts` WRITE;

UNLOCK TABLES;

/*Table structure for table `categories` */

DROP TABLE IF EXISTS `categories`;

CREATE TABLE `categories` (
  `id` char(36) NOT NULL,
  `reference_id` int(11) DEFAULT NULL,
  `slug` varchar(255) NOT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `banner_image` varchar(255) DEFAULT NULL,
  `background_color` varchar(255) DEFAULT NULL,
  `discount_type` enum('fixed','percent') DEFAULT NULL,
  `discount_value` decimal(15,2) DEFAULT NULL,
  `valid_forever` tinyint(1) NOT NULL DEFAULT 1,
  `valid_till` datetime DEFAULT NULL,
  `text_color` varchar(255) DEFAULT NULL,
  `parent_id` char(36) DEFAULT NULL,
  `position` int(11) NOT NULL DEFAULT 0,
  `menu_tag` varchar(100) DEFAULT NULL,
  `is_visible` tinyint(1) NOT NULL DEFAULT 1,
  `show_on_homepage` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `show_in_menu` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `categories_slug_unique` (`slug`),
  KEY `categories_parent_id_index` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `categories` */

LOCK TABLES `categories` WRITE;

insert  into `categories`(`id`,`reference_id`,`slug`,`icon`,`image`,`banner_image`,`background_color`,`discount_type`,`discount_value`,`valid_forever`,`valid_till`,`text_color`,`parent_id`,`position`,`menu_tag`,`is_visible`,`show_on_homepage`,`created_at`,`updated_at`,`deleted_at`,`show_in_menu`) values 
('019f5a87-8d24-71fb-9979-87aab98cca16',NULL,'abayas',NULL,NULL,NULL,'#000000',NULL,NULL,1,NULL,'#000000',NULL,1,NULL,1,0,'2026-07-13 12:11:00','2026-07-13 15:52:09',NULL,1),
('019f5b51-d079-7207-918d-670d62e11513',NULL,'open-abaya',NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'019f5a87-8d24-71fb-9979-87aab98cca16',2,NULL,1,0,'2026-07-13 15:51:56','2026-07-13 15:51:56',NULL,1),
('019f5b52-832c-7035-a25f-bcbc4cf40e0a',NULL,'black-abaya',NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'019f5a87-8d24-71fb-9979-87aab98cca16',3,NULL,1,0,'2026-07-13 15:52:42','2026-07-13 15:52:42',NULL,1);

UNLOCK TABLES;

/*Table structure for table `category_attributes` */

DROP TABLE IF EXISTS `category_attributes`;

CREATE TABLE `category_attributes` (
  `category_id` char(36) NOT NULL,
  `attribute_id` char(36) NOT NULL,
  PRIMARY KEY (`category_id`,`attribute_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `category_attributes` */

LOCK TABLES `category_attributes` WRITE;

insert  into `category_attributes`(`category_id`,`attribute_id`) values 
('019f5a87-8d24-71fb-9979-87aab98cca16','019f5a83-dd7a-71a0-a5c1-2edecdd30df6'),
('019f5a87-8d24-71fb-9979-87aab98cca16','019f5a84-ebd1-7189-bb6b-e642f7ef6ade'),
('019f5b51-d079-7207-918d-670d62e11513','019f5a83-dd7a-71a0-a5c1-2edecdd30df6'),
('019f5b51-d079-7207-918d-670d62e11513','019f5a84-ebd1-7189-bb6b-e642f7ef6ade'),
('019f5b52-832c-7035-a25f-bcbc4cf40e0a','019f5a83-dd7a-71a0-a5c1-2edecdd30df6'),
('019f5b52-832c-7035-a25f-bcbc4cf40e0a','019f5a84-ebd1-7189-bb6b-e642f7ef6ade');

UNLOCK TABLES;

/*Table structure for table `category_products` */

DROP TABLE IF EXISTS `category_products`;

CREATE TABLE `category_products` (
  `category_id` char(36) NOT NULL,
  `product_id` char(36) NOT NULL,
  UNIQUE KEY `category_product_unique` (`category_id`,`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `category_products` */

LOCK TABLES `category_products` WRITE;

UNLOCK TABLES;

/*Table structure for table `category_translations` */

DROP TABLE IF EXISTS `category_translations`;

CREATE TABLE `category_translations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` char(36) NOT NULL,
  `reference_name` varchar(255) DEFAULT NULL,
  `locale` varchar(5) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `category_translations_category_id_locale_unique` (`category_id`,`locale`),
  KEY `category_translations_category_id_index` (`category_id`),
  KEY `category_translations_locale_index` (`locale`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `category_translations` */

LOCK TABLES `category_translations` WRITE;

insert  into `category_translations`(`id`,`category_id`,`reference_name`,`locale`,`name`) values 
(1,'019f5a87-8d24-71fb-9979-87aab98cca16',NULL,'en-ae','Abayas'),
(2,'019f5b51-d079-7207-918d-670d62e11513',NULL,'en-ae','Open Abaya'),
(3,'019f5b52-832c-7035-a25f-bcbc4cf40e0a',NULL,'en-ae','Black Abaya');

UNLOCK TABLES;

/*Table structure for table `cities` */

DROP TABLE IF EXISTS `cities`;

CREATE TABLE `cities` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `province_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `cities` */

LOCK TABLES `cities` WRITE;

insert  into `cities`(`id`,`province_id`,`name`,`created_at`,`updated_at`) values 
(1,1,'Abu Dhabi','2026-07-13 11:03:54','2026-07-13 11:03:54'),
(2,1,'Al Ain','2026-07-13 11:03:54','2026-07-13 11:03:54'),
(3,2,'Dubai','2026-07-13 11:03:54','2026-07-13 11:03:54'),
(4,2,'Hatta','2026-07-13 11:03:54','2026-07-13 11:03:54'),
(5,2,'Jebel Ali','2026-07-13 11:03:54','2026-07-13 11:03:54'),
(6,3,'Sharjah','2026-07-13 11:03:54','2026-07-13 11:03:54'),
(7,4,'Ajman','2026-07-13 11:03:54','2026-07-13 11:03:54'),
(8,5,'Umm Al Quwain','2026-07-13 11:03:54','2026-07-13 11:03:54'),
(9,6,'Ras Al Khaimah','2026-07-13 11:03:54','2026-07-13 11:03:54'),
(10,6,'Dibba Al Hisn','2026-07-13 11:03:54','2026-07-13 11:03:54'),
(11,7,'Fujairah','2026-07-13 11:03:54','2026-07-13 11:03:54');

UNLOCK TABLES;

/*Table structure for table `colors` */

DROP TABLE IF EXISTS `colors`;

CREATE TABLE `colors` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `hex_code` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `colors` */

LOCK TABLES `colors` WRITE;

UNLOCK TABLES;

/*Table structure for table `comments` */

DROP TABLE IF EXISTS `comments`;

CREATE TABLE `comments` (
  `id` char(36) NOT NULL,
  `content` text NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `commentable_id` varchar(255) NOT NULL,
  `commentable_type` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL DEFAULT 'internal',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `comments_user_id_foreign` (`user_id`),
  KEY `comments_commentable_id_commentable_type_index` (`commentable_id`,`commentable_type`),
  CONSTRAINT `comments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `comments` */

LOCK TABLES `comments` WRITE;

UNLOCK TABLES;

/*Table structure for table `contact_submissions` */

DROP TABLE IF EXISTS `contact_submissions`;

CREATE TABLE `contact_submissions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `subject` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `notified_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `contact_submissions_user_id_foreign` (`user_id`),
  CONSTRAINT `contact_submissions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `contact_submissions` */

LOCK TABLES `contact_submissions` WRITE;

UNLOCK TABLES;

/*Table structure for table `countries` */

DROP TABLE IF EXISTS `countries`;

CREATE TABLE `countries` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(2) NOT NULL,
  `name` varchar(255) NOT NULL,
  `currency_id` int(11) NOT NULL,
  `icon` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `tax_label` varchar(255) NOT NULL,
  `tax_percentage` decimal(8,2) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `countries_code_unique` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `countries` */

LOCK TABLES `countries` WRITE;

insert  into `countries`(`id`,`code`,`name`,`currency_id`,`icon`,`created_at`,`updated_at`,`tax_label`,`tax_percentage`) values 
(1,'ae','United Arab Emirates',0,'','2026-07-13 11:03:54','2026-07-13 11:03:54','',0.00);

UNLOCK TABLES;

/*Table structure for table `coupon_product_variant` */

DROP TABLE IF EXISTS `coupon_product_variant`;

CREATE TABLE `coupon_product_variant` (
  `coupon_id` char(36) NOT NULL,
  `product_variant_id` char(36) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `coupon_product_variant` */

LOCK TABLES `coupon_product_variant` WRITE;

UNLOCK TABLES;

/*Table structure for table `coupon_usages` */

DROP TABLE IF EXISTS `coupon_usages`;

CREATE TABLE `coupon_usages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `coupon_id` char(36) NOT NULL,
  `user_id` char(36) DEFAULT NULL,
  `order_id` char(36) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `discount_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `coupon_usages` */

LOCK TABLES `coupon_usages` WRITE;

UNLOCK TABLES;

/*Table structure for table `coupons` */

DROP TABLE IF EXISTS `coupons`;

CREATE TABLE `coupons` (
  `id` char(36) NOT NULL,
  `code` varchar(255) NOT NULL,
  `type` enum('fixed','percentage') NOT NULL,
  `value` decimal(10,2) NOT NULL,
  `scope` enum('cart','variant') NOT NULL DEFAULT 'cart',
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `min_cart_amount` decimal(10,2) DEFAULT NULL,
  `first_time_only` tinyint(1) NOT NULL DEFAULT 0,
  `start_at` timestamp NULL DEFAULT NULL,
  `end_at` timestamp NULL DEFAULT NULL,
  `max_usage` int(11) DEFAULT NULL,
  `max_usage_per_user` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `coupons_code_unique` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `coupons` */

LOCK TABLES `coupons` WRITE;

UNLOCK TABLES;

/*Table structure for table `currencies` */

DROP TABLE IF EXISTS `currencies`;

CREATE TABLE `currencies` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(3) NOT NULL,
  `name` varchar(255) NOT NULL,
  `symbol` varchar(255) NOT NULL,
  `decimal` smallint(6) DEFAULT 2,
  `group_separator` varchar(10) DEFAULT ',',
  `decimal_separator` varchar(10) DEFAULT '.',
  `currency_position` enum('Left','Right') NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `symbol_html` varchar(255) NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `exchange_rate` decimal(10,4) NOT NULL DEFAULT 0.0000,
  PRIMARY KEY (`id`),
  UNIQUE KEY `currencies_code_unique` (`code`),
  UNIQUE KEY `currencies_name_unique` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `currencies` */

LOCK TABLES `currencies` WRITE;

insert  into `currencies`(`id`,`code`,`name`,`symbol`,`decimal`,`group_separator`,`decimal_separator`,`currency_position`,`created_at`,`updated_at`,`deleted_at`,`symbol_html`,`is_default`,`exchange_rate`) values 
(1,'AED','United Arab Emirates Dirham','د.إ',2,',','.','Right','2026-07-13 11:03:54','2026-07-13 11:03:54',NULL,'',1,0.0000),
(2,'USD','US Dollar','$',2,',','.','Left','2026-07-13 11:03:54','2026-07-13 11:03:54',NULL,'',0,0.0000),
(3,'EUR','Euro','€',2,'.',',','Left','2026-07-13 11:03:54','2026-07-13 11:03:54',NULL,'',0,0.0000),
(4,'GBP','British Pound','£',2,',','.','Left','2026-07-13 11:03:54','2026-07-13 11:03:54',NULL,'',0,0.0000),
(5,'INR','Indian Rupee','₹',2,',','.','Left','2026-07-13 11:03:54','2026-07-13 11:03:54',NULL,'',0,0.0000),
(6,'SAR','Saudi Riyal','ر.س',2,',','.','Right','2026-07-13 11:03:54','2026-07-13 11:03:54',NULL,'',0,0.0000),
(7,'PKR','Pakistani Rupee','₨',2,',','.','Left','2026-07-13 11:03:54','2026-07-13 11:03:54',NULL,'',0,0.0000);

UNLOCK TABLES;

/*Table structure for table `email_admin` */

DROP TABLE IF EXISTS `email_admin`;

CREATE TABLE `email_admin` (
  `email_id` char(36) NOT NULL,
  `admin_id` int(11) NOT NULL,
  `type` enum('to','cc','bcc','exclude') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `email_admin` */

LOCK TABLES `email_admin` WRITE;

UNLOCK TABLES;

/*Table structure for table `email_user` */

DROP TABLE IF EXISTS `email_user`;

CREATE TABLE `email_user` (
  `email_id` char(36) NOT NULL,
  `user_id` int(11) NOT NULL,
  `type` enum('to','cc','bcc','exclude') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `email_user` */

LOCK TABLES `email_user` WRITE;

UNLOCK TABLES;

/*Table structure for table `emails` */

DROP TABLE IF EXISTS `emails`;

CREATE TABLE `emails` (
  `id` char(36) NOT NULL,
  `reference` varchar(255) NOT NULL,
  `template` varchar(255) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `from_email` varchar(255) DEFAULT NULL,
  `from_name` varchar(255) DEFAULT NULL,
  `reply_to_email` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `emails` */

LOCK TABLES `emails` WRITE;

UNLOCK TABLES;

/*Table structure for table `failed_jobs` */

DROP TABLE IF EXISTS `failed_jobs`;

CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `connection` varchar(255) NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`),
  KEY `failed_jobs_connection_queue_failed_at_index` (`connection`,`queue`,`failed_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `failed_jobs` */

LOCK TABLES `failed_jobs` WRITE;

UNLOCK TABLES;

/*Table structure for table `inventories` */

DROP TABLE IF EXISTS `inventories`;

CREATE TABLE `inventories` (
  `id` char(36) NOT NULL,
  `product_variant_id` char(36) NOT NULL,
  `blocked_qty` int(11) NOT NULL DEFAULT 0,
  `net_available_qty` int(11) NOT NULL DEFAULT 0,
  `incoming_qty` int(11) NOT NULL DEFAULT 0,
  `total_qty` int(11) NOT NULL DEFAULT 0,
  `incoming_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `inventories_product_variant_id_index` (`product_variant_id`),
  CONSTRAINT `inventories_product_variant_id_foreign` FOREIGN KEY (`product_variant_id`) REFERENCES `product_variants` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `inventories` */

LOCK TABLES `inventories` WRITE;

UNLOCK TABLES;

/*Table structure for table `inventory_source_stocks` */

DROP TABLE IF EXISTS `inventory_source_stocks`;

CREATE TABLE `inventory_source_stocks` (
  `id` char(36) NOT NULL,
  `inventory_source_id` char(36) NOT NULL,
  `product_variant_id` char(36) NOT NULL,
  `qty` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `inventory_source_stock_unique` (`inventory_source_id`,`product_variant_id`),
  KEY `inventory_source_stocks_inventory_source_id_index` (`inventory_source_id`),
  KEY `inventory_source_stocks_product_variant_id_index` (`product_variant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `inventory_source_stocks` */

LOCK TABLES `inventory_source_stocks` WRITE;

UNLOCK TABLES;

/*Table structure for table `inventory_sources` */

DROP TABLE IF EXISTS `inventory_sources`;

CREATE TABLE `inventory_sources` (
  `id` char(36) NOT NULL,
  `code` varchar(40) NOT NULL,
  `name` varchar(120) NOT NULL,
  `description` text DEFAULT NULL,
  `contact_name` varchar(255) DEFAULT NULL,
  `contact_email` varchar(255) DEFAULT NULL,
  `contact_phone` varchar(255) DEFAULT NULL,
  `contact_fax` varchar(255) DEFAULT NULL,
  `country_id` int(11) NOT NULL,
  `province_id` int(11) NOT NULL,
  `city_id` int(11) NOT NULL,
  `street` varchar(160) DEFAULT NULL,
  `postcode` varchar(40) DEFAULT NULL,
  `lat` decimal(10,6) DEFAULT NULL,
  `lng` decimal(10,6) DEFAULT NULL,
  `priority` int(10) unsigned NOT NULL DEFAULT 10,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `inventory_sources_code_unique` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `inventory_sources` */

LOCK TABLES `inventory_sources` WRITE;

UNLOCK TABLES;

/*Table structure for table `job_batches` */

DROP TABLE IF EXISTS `job_batches`;

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `job_batches` */

LOCK TABLES `job_batches` WRITE;

UNLOCK TABLES;

/*Table structure for table `jobs` */

DROP TABLE IF EXISTS `jobs`;

CREATE TABLE `jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` smallint(5) unsigned NOT NULL,
  `reserved_at` int(10) unsigned DEFAULT NULL,
  `available_at` int(10) unsigned NOT NULL,
  `created_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `jobs` */

LOCK TABLES `jobs` WRITE;

UNLOCK TABLES;

/*Table structure for table `keywords` */

DROP TABLE IF EXISTS `keywords`;

CREATE TABLE `keywords` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `keyword` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `keywords_keyword_unique` (`keyword`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `keywords` */

LOCK TABLES `keywords` WRITE;

insert  into `keywords`(`id`,`keyword`,`created_at`,`updated_at`) values 
(1,'Abayas','2026-07-14 13:13:53','2026-07-14 13:13:53'),
(2,'Worlds Best Abayas','2026-07-14 13:13:53','2026-07-14 13:13:53'),
(3,'About us','2026-07-15 14:30:11','2026-07-15 14:30:11');

UNLOCK TABLES;

/*Table structure for table `locales` */

DROP TABLE IF EXISTS `locales`;

CREATE TABLE `locales` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `direction` enum('ltr','rtl') NOT NULL DEFAULT 'ltr',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `locales_code_unique` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `locales` */

LOCK TABLES `locales` WRITE;

insert  into `locales`(`id`,`code`,`name`,`logo`,`direction`,`created_at`,`updated_at`,`deleted_at`) values 
(1,'en-ae','English',NULL,'ltr','2026-07-13 11:03:54','2026-07-13 11:03:54',NULL);

UNLOCK TABLES;

/*Table structure for table `meta_keyword` */

DROP TABLE IF EXISTS `meta_keyword`;

CREATE TABLE `meta_keyword` (
  `meta_id` bigint(20) unsigned NOT NULL,
  `keyword_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`meta_id`,`keyword_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `meta_keyword` */

LOCK TABLES `meta_keyword` WRITE;

insert  into `meta_keyword`(`meta_id`,`keyword_id`) values 
(1,1),
(1,2),
(2,1),
(2,3);

UNLOCK TABLES;

/*Table structure for table `metas` */

DROP TABLE IF EXISTS `metas`;

CREATE TABLE `metas` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `metable_type` varchar(255) NOT NULL,
  `metable_id` char(36) NOT NULL,
  `locale` varchar(10) NOT NULL,
  `meta_title` varchar(255) DEFAULT NULL,
  `meta_description` text DEFAULT NULL,
  `meta_keywords` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `meta_unique` (`metable_id`,`metable_type`,`locale`),
  KEY `metas_metable_type_metable_id_index` (`metable_type`,`metable_id`),
  KEY `metas_locale_index` (`locale`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `metas` */

LOCK TABLES `metas` WRITE;

insert  into `metas`(`id`,`metable_type`,`metable_id`,`locale`,`meta_title`,`meta_description`,`meta_keywords`,`created_at`,`updated_at`) values 
(1,'App\\Models\\CMS\\Page','019f5fe7-7ae9-7046-a6c3-7066ffc90395','en-ae','Abayas | Buy Abayas from Our Store','Worlds\' Best Abayas now purchase from the store',NULL,'2026-07-14 13:13:53','2026-07-14 13:13:53'),
(2,'App\\Models\\CMS\\Page','019f6553-b0d1-7342-b59d-86d0125a6487','en-ae','About Us | Abayas Store','At Abaya Shop, we believe every woman deserves to feel both rooted in her heritage and radiant in her individuality. Born from a deep respect for Emirati culture and craftsmanship, our abayas are more than garments—they are timeless expressions of tradition, elegance, and confidence.',NULL,'2026-07-15 14:30:11','2026-07-15 14:30:11');

UNLOCK TABLES;

/*Table structure for table `migrations` */

DROP TABLE IF EXISTS `migrations`;

CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `migrations` */

LOCK TABLES `migrations` WRITE;

insert  into `migrations`(`id`,`migration`,`batch`) values 
(1,'0001_01_01_000000_create_users_table',1),
(2,'0001_01_01_000001_create_cache_table',1),
(3,'0001_01_01_000002_create_jobs_table',1),
(4,'2025_07_08_085822_create_categories_table',1),
(5,'2025_07_08_085823_create_attributes_table',1),
(6,'2025_07_08_085823_create_products_table',1),
(7,'2025_07_08_102548_create_settings_table',1),
(8,'2025_07_08_125949_create_attachments_table',1),
(9,'2025_07_09_055116_create_category_attributes_table',1),
(10,'2025_07_09_074817_create_countries_table',1),
(11,'2025_07_09_074904_create_product_countries_table',1),
(12,'2025_07_09_074930_create_brands_table',1),
(13,'2025_07_11_100753_create_metas_table',1),
(14,'2025_07_11_114848_create_product_variant_shippings_table',1),
(15,'2025_07_11_130000_create_pages_table',1),
(16,'2025_07_12_091838_create_locales_table',1),
(17,'2025_07_12_121956_create_admins_table',1),
(18,'2025_07_17_053035_create_carts_table',1),
(19,'2025_07_17_083051_create_billing_addresses_table',1),
(20,'2025_07_17_083056_create_user_cards_table',1),
(21,'2025_07_17_092833_create_customer_columns',1),
(22,'2025_07_17_092834_create_subscriptions_table',1),
(23,'2025_07_17_092835_create_subscription_items_table',1),
(24,'2025_07_17_120856_create_orders_table',1),
(25,'2025_07_17_120943_create_order_line_items_table',1),
(26,'2025_07_18_095538_add_customer_fields_to_users_table',1),
(27,'2025_07_19_124012_create_user_details_table',1),
(28,'2025_07_22_101943_create_currencies_table',1),
(29,'2025_07_23_092304_create_addresses_table',1),
(30,'2025_07_28_080009_create_offers_table',1),
(31,'2025_07_29_143629_create_authorization_tables',1),
(32,'2025_07_30_100705_create_payment_gateways_table',1),
(33,'2025_07_30_144934_create_coupons_table',1),
(34,'2025_08_01_154307_add_is_guest_to_users_table',1),
(35,'2025_08_01_162838_add_tax_to_countries_table',1),
(36,'2025_08_04_111957_create_tags_table',1),
(37,'2025_08_09_153022_create_emails_table',1),
(38,'2025_08_12_144904_add_symbol_html_to_currencies_table',1),
(39,'2025_08_13_091455_create_vendors_table',1),
(40,'2025_08_16_160031_add_promo_fields_to_offers_table',1),
(41,'2025_08_21_093142_create_wishlists_table',1),
(42,'2025_08_22_101601_create_inventory_sources_table',1),
(43,'2025_08_23_144015_add_prvoider_details_to_users_table',1),
(44,'2025_08_25_014438_create_testimonials_table',1),
(45,'2025_08_25_031115_create_news_table',1),
(46,'2025_08_28_093622_add_color_columns_to_categories_table',1),
(47,'2025_08_29_003605_create_banners_table',1),
(48,'2025_09_06_114358_create_announcements_table',1),
(49,'2025_09_13_100232_create_subscribers_table',1),
(50,'2025_10_15_095900_add_email_sent_column_in_orders_table',1),
(51,'2025_12_17_113508_create_colors_table',1),
(52,'2025_12_17_123719_create_category_products_table',1),
(53,'2025_12_17_132608_create_packagings_table',1),
(54,'2025_12_17_133441_add_api_related_columns',1),
(55,'2025_12_17_134818_create_product_variant_packagings_table',1),
(56,'2025_12_17_151841_create_product_pricings_table',1),
(57,'2025_12_22_111157_create_api_sync_logs_table',1),
(58,'2025_12_23_101804_add_primary_field_in_product_varaints_table',1),
(59,'2025_12_23_101930_create_product_varaint_translations_table',1),
(60,'2026_01_14_131901_create_return_reasons_table',1),
(61,'2026_01_14_131906_create_return_requests_table',1),
(62,'2026_01_14_131909_create_return_request_items_table',1),
(63,'2026_01_14_143936_add_delivered_at_to_orders_table',1),
(64,'2026_01_14_151248_add_shipping_label_to_return_requests_table',1),
(65,'2026_01_20_000000_add_status_to_orders_table',1),
(66,'2026_01_20_153630_add_discount_amount_to_coupon_usages_table',1),
(67,'2026_01_21_104634_add_tracking_fields_to_orders_table',1),
(68,'2026_01_21_110922_create_return_request_timelines_table',1),
(69,'2026_01_21_111308_add_refund_reference_to_return_requests_table',1),
(70,'2026_01_21_112410_expand_return_requests_architecture',1),
(71,'2026_01_21_113745_migrate_pending_returns_to_requested',1),
(72,'2026_01_23_000000_create_inventories_table',1),
(73,'2026_02_04_121256_add_options_to_order_line_items_table',1),
(74,'2026_02_04_122537_create_comments_table',1),
(75,'2026_02_05_163842_add_offer_fields_to_categories_table',1),
(76,'2026_02_26_120000_add_shipping_fields_to_orders_table',1),
(77,'2026_02_26_120100_add_map_fields_to_addresses_table',1),
(78,'2026_02_26_140500_create_contact_submissions_table',1),
(79,'2026_03_03_134504_add_tracking_provider_to_orders_table',1),
(80,'2026_07_14_133215_create_personal_access_tokens_table',2);

UNLOCK TABLES;

/*Table structure for table `modules` */

DROP TABLE IF EXISTS `modules`;

CREATE TABLE `modules` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `modules_name_unique` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `modules` */

LOCK TABLES `modules` WRITE;

insert  into `modules`(`id`,`name`,`is_active`,`created_at`,`updated_at`) values 
(1,'Admin',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(2,'Role',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(3,'Permission',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(4,'Module',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(5,'Product',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(6,'Category',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(7,'Brand',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(8,'Attribute',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(9,'Coupon',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(10,'Vendor',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(11,'Offer',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(12,'InventorySource',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(13,'Page',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(14,'Banner',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(15,'News',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(16,'Testimonial',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(17,'Locale',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(18,'Currency',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(19,'Country',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(20,'Tag',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(21,'Email',1,'2026-07-13 11:03:54','2026-07-13 11:03:54');

UNLOCK TABLES;

/*Table structure for table `news` */

DROP TABLE IF EXISTS `news`;

CREATE TABLE `news` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL,
  `author` varchar(255) NOT NULL,
  `is_guide` tinyint(1) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 0,
  `position` int(11) NOT NULL DEFAULT 99,
  `published_at` timestamp NOT NULL DEFAULT '2026-07-13 10:57:26',
  `thumbnail` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `news` */

LOCK TABLES `news` WRITE;

UNLOCK TABLES;

/*Table structure for table `news_translations` */

DROP TABLE IF EXISTS `news_translations`;

CREATE TABLE `news_translations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `news_id` int(11) NOT NULL,
  `locale` varchar(5) NOT NULL,
  `title` text NOT NULL,
  `intro` text NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `news_translations_news_id_locale_unique` (`news_id`,`locale`),
  KEY `news_translations_locale_index` (`locale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `news_translations` */

LOCK TABLES `news_translations` WRITE;

UNLOCK TABLES;

/*Table structure for table `offer_product_variants` */

DROP TABLE IF EXISTS `offer_product_variants`;

CREATE TABLE `offer_product_variants` (
  `offer_id` char(36) NOT NULL,
  `product_variant_id` char(36) NOT NULL,
  UNIQUE KEY `offer_product_variants_offer_id_product_variant_id_unique` (`offer_id`,`product_variant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `offer_product_variants` */

LOCK TABLES `offer_product_variants` WRITE;

UNLOCK TABLES;

/*Table structure for table `offer_translations` */

DROP TABLE IF EXISTS `offer_translations`;

CREATE TABLE `offer_translations` (
  `id` char(36) NOT NULL,
  `offer_id` char(36) NOT NULL,
  `locale` varchar(5) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `offer_translations_offer_id_locale_unique` (`offer_id`,`locale`),
  KEY `offer_translations_offer_id_index` (`offer_id`),
  KEY `offer_translations_locale_index` (`locale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `offer_translations` */

LOCK TABLES `offer_translations` WRITE;

UNLOCK TABLES;

/*Table structure for table `offers` */

DROP TABLE IF EXISTS `offers`;

CREATE TABLE `offers` (
  `id` char(36) NOT NULL,
  `discount_type` enum('fixed','percent') NOT NULL DEFAULT 'percent',
  `discount_value` decimal(10,2) NOT NULL,
  `starts_at` timestamp NULL DEFAULT NULL,
  `ends_at` timestamp NULL DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `banner_image` varchar(255) DEFAULT NULL,
  `link_url` varchar(255) DEFAULT NULL,
  `bg_color` varchar(32) DEFAULT NULL,
  `position` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `show_in_slider` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `offers_is_active_starts_at_ends_at_index` (`is_active`,`starts_at`,`ends_at`),
  KEY `offers_position_index` (`position`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `offers` */

LOCK TABLES `offers` WRITE;

UNLOCK TABLES;

/*Table structure for table `order_line_items` */

DROP TABLE IF EXISTS `order_line_items`;

CREATE TABLE `order_line_items` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) unsigned NOT NULL,
  `product_variant_id` char(36) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  `options` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`options`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_line_items_order_id_foreign` (`order_id`),
  CONSTRAINT `order_line_items_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `order_line_items` */

LOCK TABLES `order_line_items` WRITE;

UNLOCK TABLES;

/*Table structure for table `orders` */

DROP TABLE IF EXISTS `orders`;

CREATE TABLE `orders` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `reference_number` varchar(50) NOT NULL,
  `order_number` char(36) NOT NULL,
  `user_id` int(11) NOT NULL,
  `billing_address_id` int(11) NOT NULL,
  `shipping_address_id` bigint(20) unsigned DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `payment_method` enum('card','paypal') NOT NULL,
  `payment_status` varchar(255) NOT NULL DEFAULT 'pending',
  `status` varchar(255) NOT NULL DEFAULT 'placed',
  `tracking_number` varchar(255) DEFAULT NULL,
  `tracking_link` varchar(255) DEFAULT NULL,
  `tracking_provider` varchar(255) DEFAULT NULL,
  `tracking_status` varchar(255) DEFAULT NULL,
  `delivered_at` timestamp NULL DEFAULT NULL,
  `email_sent` tinyint(1) NOT NULL DEFAULT 0,
  `external_reference` varchar(255) DEFAULT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `sub_total` decimal(10,2) NOT NULL,
  `tax` decimal(10,2) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `orders_reference_number_unique` (`reference_number`),
  UNIQUE KEY `orders_order_number_unique` (`order_number`),
  KEY `orders_status_index` (`status`),
  KEY `orders_shipping_address_id_index` (`shipping_address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `orders` */

LOCK TABLES `orders` WRITE;

UNLOCK TABLES;

/*Table structure for table `packagings` */

DROP TABLE IF EXISTS `packagings`;

CREATE TABLE `packagings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `reference_id` int(11) DEFAULT NULL,
  `reference_name` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ec_packagings_reference_id_unique` (`reference_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `packagings` */

LOCK TABLES `packagings` WRITE;

insert  into `packagings`(`id`,`name`,`description`,`is_active`,`reference_id`,`reference_name`,`created_at`,`updated_at`) values 
(1,'HS / Commodity Code',NULL,1,NULL,'HS / Commodity Code','2025-12-20 05:10:30','2025-12-20 05:10:30'),
(2,'Qty per Carton',NULL,1,NULL,'Qty per Carton','2025-12-20 05:10:30','2025-12-20 05:10:30'),
(3,'Carton Dimensions (cm)',NULL,1,NULL,'Carton Dimensions (cm)','2025-12-20 05:10:30','2025-12-20 05:10:30'),
(4,'Carton Volume (cbm)',NULL,1,NULL,'Carton Volume (cbm)','2025-12-20 05:10:30','2025-12-20 05:10:30'),
(5,'Carton Gross Weight (kgs / carton)',NULL,1,NULL,'Carton Gross Weight (kgs / carton)','2025-12-20 05:10:30','2025-12-20 05:10:30');

UNLOCK TABLES;

/*Table structure for table `page_section_translations` */

DROP TABLE IF EXISTS `page_section_translations`;

CREATE TABLE `page_section_translations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `page_section_id` char(36) NOT NULL,
  `locale` varchar(5) NOT NULL,
  `heading` varchar(255) DEFAULT NULL,
  `content` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `page_section_translations_page_section_id_locale_unique` (`page_section_id`,`locale`),
  KEY `page_section_translations_page_section_id_index` (`page_section_id`),
  KEY `page_section_translations_locale_index` (`locale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `page_section_translations` */

LOCK TABLES `page_section_translations` WRITE;

UNLOCK TABLES;

/*Table structure for table `page_sections` */

DROP TABLE IF EXISTS `page_sections`;

CREATE TABLE `page_sections` (
  `id` char(36) NOT NULL,
  `page_id` char(36) NOT NULL,
  `type` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `settings` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`settings`)),
  `position` int(11) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `page_sections_page_id_index` (`page_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `page_sections` */

LOCK TABLES `page_sections` WRITE;

UNLOCK TABLES;

/*Table structure for table `page_translations` */

DROP TABLE IF EXISTS `page_translations`;

CREATE TABLE `page_translations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `page_id` char(36) NOT NULL,
  `locale` varchar(5) NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` longtext DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `page_translations_page_id_locale_unique` (`page_id`,`locale`),
  KEY `page_translations_page_id_index` (`page_id`),
  KEY `page_translations_locale_index` (`locale`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `page_translations` */

LOCK TABLES `page_translations` WRITE;

insert  into `page_translations`(`id`,`page_id`,`locale`,`title`,`content`,`created_at`,`updated_at`) values 
(1,'019f5fe7-7ae9-7046-a6c3-7066ffc90395','en-ae','Home','','2026-07-14 13:13:53','2026-07-14 13:13:53'),
(2,'019f6553-b0d1-7342-b59d-86d0125a6487','en-ae','About Us','<p>At Abaya Shop, we believe every woman deserves to feel both rooted in her heritage and radiant in her individuality. Born from a deep respect for Emirati culture and craftsmanship, our abayas are more than garments&mdash;they are timeless expressions of tradition, elegance, and confidence.<br><br>For generations, the abaya has been a symbol of grace and modesty. We honor this legacy by meticulously crafting each piece with premium fabrics, intricate details, and a modern sensibility. From the delicate drape of light crepe to the subtle shimmer of hand-embroidered accents, every stitch reflects our unwavering commitment to quality and beauty.<br><br>Our designs celebrate the rich heritage of the Emirates while embracing the evolving tastes of today&rsquo;s woman. Whether for work, social gatherings, or special occasions, Abaya Shop abayas blend cultural authenticity with contemporary sophistication, offering versatile styles that empower women to move seamlessly through life&rsquo;s moments.<br><br>Guided by our core values&mdash;authenticity,&nbsp;craftsmanship, and&nbsp;customer-centricity&mdash;we place your pride and comfort at the heart of every decision. We listen, innovate, and strive to exceed expectations, ensuring each abaya not only adorns but also uplifts.<br>At Abaya Shop, we are more than a brand; we are custodians of culture and companions in confidence. Together, let us walk forward with grace, honoring the past while embracing the promise of tomorrow.<br><br>Designed for Now. Crafted for Always. ?</p>','2026-07-15 14:30:11','2026-07-15 14:30:11');

UNLOCK TABLES;

/*Table structure for table `pages` */

DROP TABLE IF EXISTS `pages`;

CREATE TABLE `pages` (
  `id` char(36) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `banner` text DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `position` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pages_slug_unique` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `pages` */

LOCK TABLES `pages` WRITE;

insert  into `pages`(`id`,`slug`,`banner`,`is_active`,`position`,`created_at`,`updated_at`,`deleted_at`) values 
('019f5fe7-7ae9-7046-a6c3-7066ffc90395','home',NULL,1,1,'2026-07-14 13:13:53','2026-07-14 13:13:53',NULL),
('019f6553-b0d1-7342-b59d-86d0125a6487','about-us','pages/vZga4hI6EGc1cMKwKyhyRTznKu9lw1GTqNBfQLVb.png',1,2,'2026-07-15 14:30:11','2026-07-15 14:30:11',NULL);

UNLOCK TABLES;

/*Table structure for table `password_reset_tokens` */

DROP TABLE IF EXISTS `password_reset_tokens`;

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `password_reset_tokens` */

LOCK TABLES `password_reset_tokens` WRITE;

UNLOCK TABLES;

/*Table structure for table `payment_gateways` */

DROP TABLE IF EXISTS `payment_gateways`;

CREATE TABLE `payment_gateways` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `gateway` varchar(255) NOT NULL,
  `key` text DEFAULT NULL,
  `secret` text DEFAULT NULL,
  `additional` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`additional`)),
  `is_active` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `payment_gateways` */

LOCK TABLES `payment_gateways` WRITE;

UNLOCK TABLES;

/*Table structure for table `permissions` */

DROP TABLE IF EXISTS `permissions`;

CREATE TABLE `permissions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `module_id` int(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_module_permission` (`module_id`,`name`),
  KEY `permissions_module_id_index` (`module_id`)
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `permissions` */

LOCK TABLES `permissions` WRITE;

insert  into `permissions`(`id`,`module_id`,`name`,`is_active`,`created_at`,`updated_at`) values 
(1,1,'View List',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(2,1,'Create',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(3,1,'Update',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(4,1,'Delete',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(5,1,'Restore',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(6,2,'View List',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(7,2,'Create',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(8,2,'Update',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(9,2,'Delete',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(10,2,'Restore',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(11,3,'View List',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(12,3,'Create',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(13,3,'Update',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(14,3,'Delete',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(15,3,'Restore',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(16,4,'View List',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(17,4,'Create',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(18,4,'Update',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(19,4,'Delete',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(20,4,'Restore',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(21,5,'View List',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(22,5,'Create',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(23,5,'Update',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(24,5,'Delete',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(25,5,'Restore',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(26,5,'Bulk',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(27,6,'View List',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(28,6,'Create',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(29,6,'Update',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(30,6,'Delete',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(31,6,'Restore',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(32,7,'View List',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(33,7,'Create',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(34,7,'Update',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(35,7,'Delete',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(36,7,'Restore',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(37,8,'View List',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(38,8,'Create',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(39,8,'Update',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(40,8,'Delete',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(41,8,'Restore',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(42,9,'View List',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(43,9,'Create',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(44,9,'Update',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(45,9,'Delete',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(46,9,'Restore',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(47,10,'View List',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(48,10,'Create',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(49,10,'Update',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(50,10,'Delete',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(51,10,'Restore',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(52,11,'View List',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(53,11,'Create',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(54,11,'Update',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(55,11,'Delete',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(56,11,'Restore',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(57,12,'View List',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(58,12,'Create',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(59,12,'Update',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(60,12,'Delete',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(61,12,'Restore',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(62,13,'View List',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(63,13,'Create',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(64,13,'Update',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(65,13,'Delete',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(66,13,'Restore',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(67,14,'View List',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(68,14,'Create',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(69,14,'Update',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(70,14,'Delete',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(71,14,'Restore',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(72,15,'View List',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(73,15,'Create',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(74,15,'Update',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(75,15,'Delete',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(76,15,'Restore',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(77,16,'View List',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(78,16,'Create',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(79,16,'Update',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(80,16,'Delete',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(81,16,'Restore',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(82,17,'View List',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(83,17,'Create',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(84,17,'Update',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(85,17,'Delete',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(86,17,'Restore',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(87,18,'View List',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(88,18,'Create',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(89,18,'Update',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(90,18,'Delete',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(91,18,'Restore',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(92,19,'View List',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(93,19,'Create',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(94,19,'Update',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(95,19,'Delete',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(96,19,'Restore',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(97,20,'View List',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(98,20,'Create',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(99,20,'Update',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(100,20,'Delete',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(101,20,'Restore',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(102,21,'View List',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(103,21,'Create',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(104,21,'Update',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(105,21,'Delete',1,'2026-07-13 11:03:54','2026-07-13 11:03:54'),
(106,21,'Restore',1,'2026-07-13 11:03:54','2026-07-13 11:03:54');

UNLOCK TABLES;

/*Table structure for table `personal_access_tokens` */

DROP TABLE IF EXISTS `personal_access_tokens`;

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) unsigned NOT NULL,
  `name` text NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  KEY `personal_access_tokens_expires_at_index` (`expires_at`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `personal_access_tokens` */

LOCK TABLES `personal_access_tokens` WRITE;

insert  into `personal_access_tokens`(`id`,`tokenable_type`,`tokenable_id`,`name`,`token`,`abilities`,`last_used_at`,`expires_at`,`created_at`,`updated_at`) values 
(1,'App\\Models\\User',2,'auth-token','dfb442eb960aa15071149a03fbcbcabcd057f7037ca1f52477fd5cf534e12421','[\"*\"]','2026-07-14 14:41:23',NULL,'2026-07-14 14:41:15','2026-07-14 14:41:23'),
(6,'App\\Models\\User',3,'auth-token','9646c4f20de0c8aff06b399a7ed8f1e787c8f0569236ae4bb9550e50e76b6eac','[\"*\"]',NULL,NULL,'2026-07-14 15:32:22','2026-07-14 15:32:22'),
(7,'App\\Models\\User',3,'auth-token','59af0a6fc5cc5bee6718f8001fe19ad4ed66010696d87a8cd032b1b37d66cdaf','[\"*\"]','2026-07-15 14:10:27',NULL,'2026-07-15 14:06:20','2026-07-15 14:10:27');

UNLOCK TABLES;

/*Table structure for table `product_countries` */

DROP TABLE IF EXISTS `product_countries`;

CREATE TABLE `product_countries` (
  `product_id` char(36) NOT NULL,
  `country_code` varchar(2) NOT NULL,
  `currency_code` varchar(3) NOT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `is_available` tinyint(1) NOT NULL DEFAULT 1,
  `tax` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`product_id`,`country_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `product_countries` */

LOCK TABLES `product_countries` WRITE;

UNLOCK TABLES;

/*Table structure for table `product_pricings` */

DROP TABLE IF EXISTS `product_pricings`;

CREATE TABLE `product_pricings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `product_variant_id` char(36) NOT NULL,
  `country_id` int(11) NOT NULL,
  `currency_id` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `cost_price` decimal(10,2) DEFAULT NULL,
  `wholesale_price` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `product_pricings` */

LOCK TABLES `product_pricings` WRITE;

UNLOCK TABLES;

/*Table structure for table `product_translations` */

DROP TABLE IF EXISTS `product_translations`;

CREATE TABLE `product_translations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` char(36) NOT NULL,
  `locale` varchar(5) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_translations_product_id_locale_unique` (`product_id`,`locale`),
  KEY `product_translations_product_id_index` (`product_id`),
  KEY `product_translations_locale_index` (`locale`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `product_translations` */

LOCK TABLES `product_translations` WRITE;

insert  into `product_translations`(`id`,`product_id`,`locale`,`name`,`description`) values 
(1,'019f5b55-11de-7102-a916-2371853cbd6e','en-ae','Black Floral Embroidered Abaya with Stones','Make every special occasion memorable with our elegant black embroidered abaya. Designed to bring confidence and timeless style, it is perfect for your most important moments. Featuring beautiful black embroidery that flows across the front, back, sides, and sleeves, this abaya offers a graceful and refined look. Delicate Swarovski stone details add a subtle touch of sparkle, while the embroidery on one side of the scarf completes the design beautifully. Paired with a matching inner dress and scarf, this abaya creates an effortlessly elegant look for any special occasion.');

UNLOCK TABLES;

/*Table structure for table `product_varaint_translations` */

DROP TABLE IF EXISTS `product_varaint_translations`;

CREATE TABLE `product_varaint_translations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `product_variant_id` char(36) NOT NULL,
  `locale` varchar(5) NOT NULL,
  `title` text NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_varaint_translations_product_variant_id_locale_unique` (`product_variant_id`,`locale`),
  KEY `product_varaint_translations_locale_index` (`locale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `product_varaint_translations` */

LOCK TABLES `product_varaint_translations` WRITE;

UNLOCK TABLES;

/*Table structure for table `product_variant_attribute_value` */

DROP TABLE IF EXISTS `product_variant_attribute_value`;

CREATE TABLE `product_variant_attribute_value` (
  `product_variant_id` char(36) NOT NULL,
  `attribute_value_id` char(36) NOT NULL,
  PRIMARY KEY (`product_variant_id`,`attribute_value_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `product_variant_attribute_value` */

LOCK TABLES `product_variant_attribute_value` WRITE;

insert  into `product_variant_attribute_value`(`product_variant_id`,`attribute_value_id`) values 
('019f5fd9-c791-710c-ac4e-d6c0f7b4cc20','019f5a83-dd82-70bd-afc8-019dd4e85833'),
('019f5fd9-c791-710c-ac4e-d6c0f7b4cc20','019f5a84-ebd5-7055-87e2-80b2b8f87d44');

UNLOCK TABLES;

/*Table structure for table `product_variant_packagings` */

DROP TABLE IF EXISTS `product_variant_packagings`;

CREATE TABLE `product_variant_packagings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `product_variant_id` char(36) NOT NULL,
  `packaging_id` bigint(20) unsigned NOT NULL,
  `value` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `product_variant_packagings` */

LOCK TABLES `product_variant_packagings` WRITE;

insert  into `product_variant_packagings`(`id`,`product_variant_id`,`packaging_id`,`value`,`created_at`,`updated_at`) values 
(1,'019f5fd9-c791-710c-ac4e-d6c0f7b4cc20',1,'AB-00001','2026-07-14 12:58:55','2026-07-14 12:58:55'),
(2,'019f5fd9-c791-710c-ac4e-d6c0f7b4cc20',2,'1','2026-07-14 12:58:55','2026-07-14 12:58:55'),
(3,'019f5fd9-c791-710c-ac4e-d6c0f7b4cc20',3,'50','2026-07-14 12:58:55','2026-07-14 12:58:55'),
(4,'019f5fd9-c791-710c-ac4e-d6c0f7b4cc20',4,'50','2026-07-14 12:58:55','2026-07-14 12:58:55'),
(5,'019f5fd9-c791-710c-ac4e-d6c0f7b4cc20',5,'50','2026-07-14 12:58:55','2026-07-14 12:58:55');

UNLOCK TABLES;

/*Table structure for table `product_variant_shippings` */

DROP TABLE IF EXISTS `product_variant_shippings`;

CREATE TABLE `product_variant_shippings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `product_variant_id` char(36) NOT NULL,
  `length` decimal(8,2) DEFAULT NULL,
  `width` decimal(8,2) DEFAULT NULL,
  `height` decimal(8,2) DEFAULT NULL,
  `weight` decimal(8,2) DEFAULT NULL,
  `qty_per_carton` decimal(8,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_variant_shippings_product_variant_id_unique` (`product_variant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `product_variant_shippings` */

LOCK TABLES `product_variant_shippings` WRITE;

UNLOCK TABLES;

/*Table structure for table `product_variants` */

DROP TABLE IF EXISTS `product_variants`;

CREATE TABLE `product_variants` (
  `id` char(36) NOT NULL,
  `reference_id` int(11) DEFAULT NULL,
  `reference_sku` varchar(255) DEFAULT NULL,
  `product_id` char(36) NOT NULL,
  `thumbnail` varchar(255) DEFAULT NULL,
  `sku` varchar(255) NOT NULL,
  `is_primary` tinyint(1) NOT NULL DEFAULT 0,
  `price` decimal(10,2) NOT NULL,
  `stock` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_variants_sku_unique` (`sku`),
  KEY `product_variants_product_id_index` (`product_id`),
  KEY `product_variants_reference_id_index` (`reference_id`),
  KEY `product_variants_reference_sku_index` (`reference_sku`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `product_variants` */

LOCK TABLES `product_variants` WRITE;

insert  into `product_variants`(`id`,`reference_id`,`reference_sku`,`product_id`,`thumbnail`,`sku`,`is_primary`,`price`,`stock`,`created_at`,`updated_at`,`deleted_at`) values 
('019f5fd9-c791-710c-ac4e-d6c0f7b4cc20',NULL,NULL,'019f5b55-11de-7102-a916-2371853cbd6e',NULL,'SKU-00001',1,100.00,10,'2026-07-14 12:58:55','2026-07-14 12:58:55',NULL);

UNLOCK TABLES;

/*Table structure for table `products` */

DROP TABLE IF EXISTS `products`;

CREATE TABLE `products` (
  `id` char(36) NOT NULL,
  `reference_id` int(11) DEFAULT NULL,
  `category_id` char(36) NOT NULL,
  `brand_id` char(36) DEFAULT NULL,
  `slug` varchar(255) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `is_featured` tinyint(1) NOT NULL DEFAULT 0,
  `is_new` tinyint(1) NOT NULL DEFAULT 0,
  `show_in_slider` tinyint(1) NOT NULL DEFAULT 0,
  `position` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `products_slug_unique` (`slug`),
  KEY `products_category_id_index` (`category_id`),
  KEY `products_brand_id_index` (`brand_id`),
  KEY `products_reference_id_index` (`reference_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `products` */

LOCK TABLES `products` WRITE;

insert  into `products`(`id`,`reference_id`,`category_id`,`brand_id`,`slug`,`is_active`,`is_featured`,`is_new`,`show_in_slider`,`position`,`created_at`,`updated_at`,`deleted_at`) values 
('019f5b55-11de-7102-a916-2371853cbd6e',NULL,'019f5b52-832c-7035-a25f-bcbc4cf40e0a',NULL,'black-floral-embroidered-abaya-with-stones',1,0,0,0,1,'2026-07-13 15:55:29','2026-07-13 15:55:29',NULL);

UNLOCK TABLES;

/*Table structure for table `provinces` */

DROP TABLE IF EXISTS `provinces`;

CREATE TABLE `provinces` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `country_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `provinces` */

LOCK TABLES `provinces` WRITE;

insert  into `provinces`(`id`,`country_id`,`name`,`created_at`,`updated_at`) values 
(1,1,'Abu Dhabi','2026-07-13 11:03:54','2026-07-13 11:03:54'),
(2,1,'Dubai','2026-07-13 11:03:54','2026-07-13 11:03:54'),
(3,1,'Sharjah','2026-07-13 11:03:54','2026-07-13 11:03:54'),
(4,1,'Ajman','2026-07-13 11:03:54','2026-07-13 11:03:54'),
(5,1,'Umm Al Quwain','2026-07-13 11:03:54','2026-07-13 11:03:54'),
(6,1,'Ras Al Khaimah','2026-07-13 11:03:54','2026-07-13 11:03:54'),
(7,1,'Fujairah','2026-07-13 11:03:54','2026-07-13 11:03:54');

UNLOCK TABLES;

/*Table structure for table `return_reasons` */

DROP TABLE IF EXISTS `return_reasons`;

CREATE TABLE `return_reasons` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `reason` varchar(255) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `return_reasons` */

LOCK TABLES `return_reasons` WRITE;

UNLOCK TABLES;

/*Table structure for table `return_request_items` */

DROP TABLE IF EXISTS `return_request_items`;

CREATE TABLE `return_request_items` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `return_request_id` bigint(20) unsigned NOT NULL,
  `order_line_item_id` bigint(20) unsigned NOT NULL,
  `quantity` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `return_request_items_return_request_id_foreign` (`return_request_id`),
  KEY `return_request_items_order_line_item_id_foreign` (`order_line_item_id`),
  CONSTRAINT `return_request_items_order_line_item_id_foreign` FOREIGN KEY (`order_line_item_id`) REFERENCES `order_line_items` (`id`),
  CONSTRAINT `return_request_items_return_request_id_foreign` FOREIGN KEY (`return_request_id`) REFERENCES `return_requests` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `return_request_items` */

LOCK TABLES `return_request_items` WRITE;

UNLOCK TABLES;

/*Table structure for table `return_request_timelines` */

DROP TABLE IF EXISTS `return_request_timelines`;

CREATE TABLE `return_request_timelines` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `return_request_id` bigint(20) NOT NULL,
  `actor_type` varchar(255) NOT NULL,
  `actor_id` bigint(20) unsigned DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `old_status` varchar(255) DEFAULT NULL,
  `new_status` varchar(255) DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `return_request_timelines_actor_type_actor_id_index` (`actor_type`,`actor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `return_request_timelines` */

LOCK TABLES `return_request_timelines` WRITE;

UNLOCK TABLES;

/*Table structure for table `return_requests` */

DROP TABLE IF EXISTS `return_requests`;

CREATE TABLE `return_requests` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `reference_number` varchar(255) NOT NULL,
  `order_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `return_reason_id` bigint(20) unsigned NOT NULL,
  `reason_category` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'pending',
  `shipping_cost_borne_by` varchar(255) DEFAULT NULL,
  `refund_method` varchar(255) DEFAULT NULL,
  `refund_status` varchar(255) NOT NULL DEFAULT 'pending',
  `refund_reference` varchar(255) DEFAULT NULL,
  `resolution_type` varchar(255) DEFAULT NULL,
  `customer_tracking_number` varchar(255) DEFAULT NULL,
  `carrier_name` varchar(255) DEFAULT NULL,
  `inspection_status` varchar(255) NOT NULL DEFAULT 'pending',
  `inspection_notes` text DEFAULT NULL,
  `replacement_order_id` bigint(20) unsigned DEFAULT NULL,
  `admin_notes` text DEFAULT NULL,
  `shipping_label_path` varchar(255) DEFAULT NULL,
  `approved_at` timestamp NULL DEFAULT NULL,
  `shipped_at` timestamp NULL DEFAULT NULL,
  `received_at` timestamp NULL DEFAULT NULL,
  `refunded_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `return_requests_reference_number_unique` (`reference_number`),
  KEY `return_requests_order_id_foreign` (`order_id`),
  KEY `return_requests_user_id_foreign` (`user_id`),
  KEY `return_requests_return_reason_id_foreign` (`return_reason_id`),
  KEY `return_requests_replacement_order_id_foreign` (`replacement_order_id`),
  CONSTRAINT `return_requests_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  CONSTRAINT `return_requests_replacement_order_id_foreign` FOREIGN KEY (`replacement_order_id`) REFERENCES `orders` (`id`) ON DELETE SET NULL,
  CONSTRAINT `return_requests_return_reason_id_foreign` FOREIGN KEY (`return_reason_id`) REFERENCES `return_reasons` (`id`),
  CONSTRAINT `return_requests_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `return_requests` */

LOCK TABLES `return_requests` WRITE;

UNLOCK TABLES;

/*Table structure for table `role_permissions` */

DROP TABLE IF EXISTS `role_permissions`;

CREATE TABLE `role_permissions` (
  `role_id` int(10) unsigned NOT NULL,
  `permission_id` int(10) unsigned NOT NULL,
  UNIQUE KEY `unique_role_permission` (`role_id`,`permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `role_permissions` */

LOCK TABLES `role_permissions` WRITE;

insert  into `role_permissions`(`role_id`,`permission_id`) values 
(1,1),
(1,2),
(1,3),
(1,4),
(1,5),
(1,6),
(1,7),
(1,8),
(1,9),
(1,10),
(1,11),
(1,12),
(1,13),
(1,14),
(1,15),
(1,16),
(1,17),
(1,18),
(1,19),
(1,20),
(1,21),
(1,22),
(1,23),
(1,24),
(1,25),
(1,26),
(1,27),
(1,28),
(1,29),
(1,30),
(1,31),
(1,32),
(1,33),
(1,34),
(1,35),
(1,36),
(1,37),
(1,38),
(1,39),
(1,40),
(1,41),
(1,42),
(1,43),
(1,44),
(1,45),
(1,46),
(1,47),
(1,48),
(1,49),
(1,50),
(1,51),
(1,52),
(1,53),
(1,54),
(1,55),
(1,56),
(1,57),
(1,58),
(1,59),
(1,60),
(1,61),
(1,62),
(1,63),
(1,64),
(1,65),
(1,66),
(1,67),
(1,68),
(1,69),
(1,70),
(1,71),
(1,72),
(1,73),
(1,74),
(1,75),
(1,76),
(1,77),
(1,78),
(1,79),
(1,80),
(1,81),
(1,82),
(1,83),
(1,84),
(1,85),
(1,86),
(1,87),
(1,88),
(1,89),
(1,90),
(1,91),
(1,92),
(1,93),
(1,94),
(1,95),
(1,96),
(1,97),
(1,98),
(1,99),
(1,100),
(1,101),
(1,102),
(1,103),
(1,104),
(1,105),
(1,106);

UNLOCK TABLES;

/*Table structure for table `roles` */

DROP TABLE IF EXISTS `roles`;

CREATE TABLE `roles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_unique` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `roles` */

LOCK TABLES `roles` WRITE;

insert  into `roles`(`id`,`name`,`is_active`,`created_at`,`updated_at`) values 
(1,'SuperAdmin',1,'2026-07-13 11:03:54','2026-07-13 11:03:54');

UNLOCK TABLES;

/*Table structure for table `sessions` */

DROP TABLE IF EXISTS `sessions`;

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `sessions` */

LOCK TABLES `sessions` WRITE;

UNLOCK TABLES;

/*Table structure for table `settings` */

DROP TABLE IF EXISTS `settings`;

CREATE TABLE `settings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `value` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `settings_key_unique` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `settings` */

LOCK TABLES `settings` WRITE;

insert  into `settings`(`id`,`key`,`value`,`created_at`,`updated_at`) values 
(1,'site_title',NULL,'2026-07-15 14:28:38','2026-07-15 14:28:38'),
(2,'site_intro',NULL,'2026-07-15 14:28:38','2026-07-15 14:28:38'),
(3,'contact_email',NULL,'2026-07-15 14:28:38','2026-07-15 14:28:38'),
(4,'contact_phone',NULL,'2026-07-15 14:28:38','2026-07-15 14:28:38'),
(5,'address',NULL,'2026-07-15 14:28:38','2026-07-15 14:28:38'),
(6,'copyright',NULL,'2026-07-15 14:28:38','2026-07-15 14:28:38'),
(7,'tiny_mc_key','h3rea8194qv4ab63xugfqv8id2wa701co8ute8zcb5zrjywe','2026-07-15 14:28:38','2026-07-15 14:28:38'),
(8,'return_policy_days','7','2026-07-15 14:28:38','2026-07-15 14:28:38'),
(9,'allow_negative_purchase','0','2026-07-15 14:28:38','2026-07-15 14:28:38');

UNLOCK TABLES;

/*Table structure for table `subscribers` */

DROP TABLE IF EXISTS `subscribers`;

CREATE TABLE `subscribers` (
  `id` char(36) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `subscribed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `unsubscribed_at` timestamp NULL DEFAULT NULL,
  `source` varchar(255) DEFAULT NULL,
  `ip_address` varchar(255) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `subscribers_email_unique` (`email`),
  KEY `subscribers_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `subscribers` */

LOCK TABLES `subscribers` WRITE;

UNLOCK TABLES;

/*Table structure for table `subscription_items` */

DROP TABLE IF EXISTS `subscription_items`;

CREATE TABLE `subscription_items` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `subscription_id` bigint(20) unsigned NOT NULL,
  `stripe_id` varchar(255) NOT NULL,
  `stripe_product` varchar(255) NOT NULL,
  `stripe_price` varchar(255) NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `subscription_items_stripe_id_unique` (`stripe_id`),
  KEY `subscription_items_subscription_id_stripe_price_index` (`subscription_id`,`stripe_price`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `subscription_items` */

LOCK TABLES `subscription_items` WRITE;

UNLOCK TABLES;

/*Table structure for table `subscriptions` */

DROP TABLE IF EXISTS `subscriptions`;

CREATE TABLE `subscriptions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `type` varchar(255) NOT NULL,
  `stripe_id` varchar(255) NOT NULL,
  `stripe_status` varchar(255) NOT NULL,
  `stripe_price` varchar(255) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `trial_ends_at` timestamp NULL DEFAULT NULL,
  `ends_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `subscriptions_stripe_id_unique` (`stripe_id`),
  KEY `subscriptions_user_id_stripe_status_index` (`user_id`,`stripe_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `subscriptions` */

LOCK TABLES `subscriptions` WRITE;

UNLOCK TABLES;

/*Table structure for table `tag_product_variant` */

DROP TABLE IF EXISTS `tag_product_variant`;

CREATE TABLE `tag_product_variant` (
  `tag_id` char(36) NOT NULL,
  `product_variant_id` char(36) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `tag_product_variant` */

LOCK TABLES `tag_product_variant` WRITE;

insert  into `tag_product_variant`(`tag_id`,`product_variant_id`) values 
('019f5b58-fd08-7281-94a9-0d8b996a411d','019f5fd9-c791-710c-ac4e-d6c0f7b4cc20');

UNLOCK TABLES;

/*Table structure for table `tags` */

DROP TABLE IF EXISTS `tags`;

CREATE TABLE `tags` (
  `id` char(36) NOT NULL,
  `reference_id` int(11) DEFAULT NULL,
  `reference_name` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `position` int(11) NOT NULL DEFAULT 99,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `tags` */

LOCK TABLES `tags` WRITE;

insert  into `tags`(`id`,`reference_id`,`reference_name`,`is_active`,`position`,`name`,`created_at`,`updated_at`,`deleted_at`) values 
('019f5b58-fd08-7281-94a9-0d8b996a411d',NULL,NULL,1,1,'Butterfly Design','2026-07-13 15:59:46','2026-07-13 15:59:46',NULL),
('019f658c-42b9-7310-81f1-f260c5f170b2',NULL,NULL,1,2,'New Arrival','2026-07-15 15:31:58','2026-07-15 15:31:58',NULL);

UNLOCK TABLES;

/*Table structure for table `testimonial_translations` */

DROP TABLE IF EXISTS `testimonial_translations`;

CREATE TABLE `testimonial_translations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `testimonial_id` int(11) NOT NULL,
  `locale` varchar(5) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `testimonial_translations_testimonial_id_locale_unique` (`testimonial_id`,`locale`),
  KEY `testimonial_translations_locale_index` (`locale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `testimonial_translations` */

LOCK TABLES `testimonial_translations` WRITE;

UNLOCK TABLES;

/*Table structure for table `testimonials` */

DROP TABLE IF EXISTS `testimonials`;

CREATE TABLE `testimonials` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `image` varchar(255) NOT NULL,
  `designation` varchar(255) DEFAULT NULL,
  `company_name` varchar(255) DEFAULT NULL,
  `company_logo` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 0,
  `position` int(11) NOT NULL DEFAULT 99,
  `rating` int(11) NOT NULL DEFAULT 5,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `testimonials` */

LOCK TABLES `testimonials` WRITE;

UNLOCK TABLES;

/*Table structure for table `user_cards` */

DROP TABLE IF EXISTS `user_cards`;

CREATE TABLE `user_cards` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `card_last_four` varchar(255) NOT NULL,
  `card_brand` varchar(255) NOT NULL,
  `expiry_month` varchar(255) NOT NULL,
  `expiry_year` varchar(255) NOT NULL,
  `card_token` varchar(255) NOT NULL,
  `gateway` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_cards_user_id_foreign` (`user_id`),
  CONSTRAINT `user_cards_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `user_cards` */

LOCK TABLES `user_cards` WRITE;

UNLOCK TABLES;

/*Table structure for table `user_details` */

DROP TABLE IF EXISTS `user_details`;

CREATE TABLE `user_details` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `dob` date NOT NULL,
  `gender` varchar(255) NOT NULL,
  `mobile` varchar(255) NOT NULL,
  `country_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `user_details` */

LOCK TABLES `user_details` WRITE;

UNLOCK TABLES;

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `last_login_at` timestamp NULL DEFAULT NULL,
  `password_changed_at` timestamp NULL DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `is_guest` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `stripe_id` varchar(255) DEFAULT NULL,
  `pm_type` varchar(255) DEFAULT NULL,
  `pm_last_four` varchar(4) DEFAULT NULL,
  `trial_ends_at` timestamp NULL DEFAULT NULL,
  `provider_id` varchar(255) DEFAULT NULL,
  `provider_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  KEY `users_stripe_id_index` (`stripe_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `users` */

LOCK TABLES `users` WRITE;

insert  into `users`(`id`,`name`,`email`,`email_verified_at`,`password`,`remember_token`,`last_login_at`,`password_changed_at`,`is_active`,`is_guest`,`created_at`,`updated_at`,`stripe_id`,`pm_type`,`pm_last_four`,`trial_ends_at`,`provider_id`,`provider_name`) values 
(1,'User','user@example.com',NULL,'$2y$12$Y0XcUC1iQJB/8ty6dOF0IO0rzprywletI2qlLkZm7TMkcpgnmMb2u',NULL,NULL,NULL,1,0,'2026-07-13 11:03:54','2026-07-13 11:03:54',NULL,NULL,NULL,NULL,NULL,NULL),
(2,'Test User','testuser1@example.com',NULL,'$2y$12$yJ5OjzDmZjfNrfLipzTWeOChdkE/c7Rb7StDdjRFxcUOqGCUtGQdm',NULL,'2026-07-14 14:41:15',NULL,1,0,'2026-07-14 14:40:01','2026-07-14 14:41:15',NULL,NULL,NULL,NULL,NULL,NULL),
(3,'Arshdeep Singh','arshdeepjhagra@gmail.com',NULL,'$2y$12$ZQRiV8H75FqneFq35ZAJu.QmHbBTxAg0BqEgGONNUPMYRG8llEdA2','wOTEOKuNdF83ABxrvRs4cSx8NfYwDGagxsgRVTyapFNxl3ManwnjoU8m1yue','2026-07-15 14:06:20','2026-07-14 15:32:07',1,0,'2026-07-14 15:14:08','2026-07-15 14:06:20',NULL,NULL,NULL,NULL,NULL,NULL);

UNLOCK TABLES;

/*Table structure for table `vendors` */

DROP TABLE IF EXISTS `vendors`;

CREATE TABLE `vendors` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `vendors_email_unique` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `vendors` */

LOCK TABLES `vendors` WRITE;

UNLOCK TABLES;

/*Table structure for table `wishlists` */

DROP TABLE IF EXISTS `wishlists`;

CREATE TABLE `wishlists` (
  `id` char(36) NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `product_variant_id` char(36) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `wishlists_user_id_product_variant_id_unique` (`user_id`,`product_variant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `wishlists` */

LOCK TABLES `wishlists` WRITE;

UNLOCK TABLES;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
