/*
SQLyog Community v8.4 RC2
MySQL - 5.0.15-nt : Database - nobroker
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`nobroker` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `nobroker`;

/*Table structure for table `items` */

DROP TABLE IF EXISTS `items`;

CREATE TABLE `items` (
  `farmer_email` varchar(30) NOT NULL,
  `item_name` enum('tomato','potato','carrot','onion','null') NOT NULL default 'null',
  `item_quantity` float NOT NULL,
  `item_price` float NOT NULL,
  `quantity_sold` float default '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `items` */

insert  into `items`(`farmer_email`,`item_name`,`item_quantity`,`item_price`,`quantity_sold`) values ('kalyan@gmail.com','tomato',0.5,15,0),('bhuvan@gmail.com','carrot',6,55,0);

/*Table structure for table `login` */

DROP TABLE IF EXISTS `login`;

CREATE TABLE `login` (
  `email` varchar(30) NOT NULL,
  `password` varchar(30) NOT NULL,
  `contact` bigint(30) NOT NULL,
  `category` enum('farmer','client') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `login` */

insert  into `login`(`email`,`password`,`contact`,`category`) values ('kalyan@gmail.com','123456',9490229230,'farmer'),('pavan@email.com','789',123456789,'client'),('bhuvan@gmail.com','123456',789456,'farmer'),('monu@gmail.com','123456',789,'client'),('pk@gmail.com','456',789,'client');

/*Table structure for table `orders` */

DROP TABLE IF EXISTS `orders`;

CREATE TABLE `orders` (
  `client_email` varchar(30) NOT NULL,
  `item_name` enum('tomato','potato','onion','carrot') NOT NULL,
  `vendor` varchar(30) NOT NULL,
  `quantity` float NOT NULL,
  `price` float NOT NULL,
  `status` enum('cart','ordered') NOT NULL default 'cart'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `orders` */

insert  into `orders`(`client_email`,`item_name`,`vendor`,`quantity`,`price`,`status`) values ('pavan@email.com','carrot','bhuvan@gmail.com',2,55,'cart'),('pavan@email.com','tomato','kalyan@gmail.com',5,15,'ordered');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
