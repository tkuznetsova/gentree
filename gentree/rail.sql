# SQL Manager 2007 Lite for MySQL 4.5.0.4
# ---------------------------------------
# Host     : localhost
# Port     : 3306
# Database : rail


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES latin1 */;

SET FOREIGN_KEY_CHECKS=0;

CREATE DATABASE `rail`;

USE `rail`;

#
# Structure for the `carriagetype` table : 
#

CREATE TABLE `carriagetype` (
  `id` int(11) NOT NULL,
  `title` varchar(45) DEFAULT NULL,
  `carriage_type_cost` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# Structure for the `carriage` table : 
#

CREATE TABLE `carriage` (
  `id` int(11) NOT NULL,
  `carriagetype_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_carriage_carriagetype1` (`carriagetype_id`),
  CONSTRAINT `fk_carriage_carriagetype1` FOREIGN KEY (`carriagetype_id`) REFERENCES `carriagetype` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# Structure for the `seattype` table : 
#

CREATE TABLE `seattype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

#
# Structure for the `carriage_seat` table : 
#

CREATE TABLE `carriage_seat` (
  `id` int(11) NOT NULL DEFAULT '0',
  `order_number` int(11) NOT NULL,
  `carriage_id` int(11) DEFAULT NULL,
  `seattype_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_carriageseat_seattype1` (`seattype_id`),
  KEY `fk_carriage_seat_carriage` (`carriage_id`),
  CONSTRAINT `fk_carriage_seat_carriage` FOREIGN KEY (`carriage_id`) REFERENCES `carriage` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_carriage_seat_seattype1` FOREIGN KEY (`seattype_id`) REFERENCES `seattype` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# Structure for the `station` table : 
#

CREATE TABLE `station` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(25) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

#
# Structure for the `train` table : 
#

CREATE TABLE `train` (
  `tnumb` int(11) NOT NULL,
  `tnam` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`tnumb`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# Structure for the `departure` table : 
#

CREATE TABLE `departure` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_dep` date NOT NULL,
  `tnumb` int(11) NOT NULL,
  `rout_id` int(11) NOT NULL,
  `dep_time` time DEFAULT NULL,
  `arr_time` time DEFAULT NULL,
  `str_st_id` int(11) DEFAULT NULL,
  `end_st_id` int(11) DEFAULT NULL,
  `stayin` int(11) NOT NULL,
  `travel_time` time NOT NULL,
  `distance` int(11) NOT NULL,
  `rout_cost` double DEFAULT NULL,
  `date_arr` date NOT NULL,
  PRIMARY KEY (`id`,`rout_id`),
  KEY `fk_departure_train1` (`tnumb`),
  KEY `fk_departure_station1` (`id`),
  KEY `fk_departure_station11` (`str_st_id`),
  KEY `fk_departure_station2` (`id`),
  KEY `fk_departure_station22` (`end_st_id`),
  CONSTRAINT `fk_departure_station11` FOREIGN KEY (`str_st_id`) REFERENCES `station` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_departure_station22` FOREIGN KEY (`end_st_id`) REFERENCES `station` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_departure_train1` FOREIGN KEY (`tnumb`) REFERENCES `train` (`tnumb`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

#
# Structure for the `passangerticket` table : 
#

CREATE TABLE `passangerticket` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `credit_card` int(11) DEFAULT NULL,
  `passport` int(11) DEFAULT NULL,
  `fullname` varchar(100) NOT NULL,
  `str_station_id` int(11) NOT NULL,
  `end_station_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_passangerticket_station1` (`str_station_id`),
  KEY `fk_passangerticket_station2` (`end_station_id`),
  CONSTRAINT `fk_passangerticket_station1` FOREIGN KEY (`str_station_id`) REFERENCES `station` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_passangerticket_station2` FOREIGN KEY (`end_station_id`) REFERENCES `station` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;

#
# Structure for the `passangertrip` table : 
#

CREATE TABLE `passangertrip` (
  `passangerticket_id` int(11) NOT NULL DEFAULT '0',
  `departure_id` int(11) DEFAULT NULL,
  `carriage_seat_id` int(11) DEFAULT NULL,
  `occuped` int(1) DEFAULT NULL,
  PRIMARY KEY (`passangerticket_id`),
  KEY `fk_passangertrip_departure1` (`departure_id`),
  KEY `fk_passangertrip_passangerticket1` (`passangerticket_id`),
  KEY `fk_passangertrip_carriage_seat1` (`carriage_seat_id`),
  CONSTRAINT `fk_passangertrip_carriage_seat1` FOREIGN KEY (`carriage_seat_id`) REFERENCES `carriage_seat` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_passangertrip_departure1` FOREIGN KEY (`departure_id`) REFERENCES `departure` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_passangertrip_passangerticket1` FOREIGN KEY (`passangerticket_id`) REFERENCES `passangerticket` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# Structure for the `rundays` table : 
#

CREATE TABLE `rundays` (
  `tnumb` int(11) NOT NULL,
  `daynum` int(1) NOT NULL DEFAULT '0',
  `presence` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`tnumb`,`daynum`),
  KEY `fk_rundays_train1` (`tnumb`),
  CONSTRAINT `fk_rundays_train1` FOREIGN KEY (`tnumb`) REFERENCES `train` (`tnumb`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# Structure for the `train_carriage` table : 
#

CREATE TABLE `train_carriage` (
  `carriage_id` int(11) NOT NULL,
  `tnumb` int(11) NOT NULL,
  `carri_ordinal_num` int(11) DEFAULT NULL,
  PRIMARY KEY (`carriage_id`,`tnumb`),
  KEY `fk_train_carriage_carriage1` (`carriage_id`),
  KEY `fk_train_carriage_train1` (`tnumb`),
  CONSTRAINT `fk_train_carriage_carriage1` FOREIGN KEY (`carriage_id`) REFERENCES `carriage` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_train_carriage_train1` FOREIGN KEY (`tnumb`) REFERENCES `train` (`tnumb`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# Data for the `carriagetype` table  (LIMIT 0,500)
#

INSERT INTO `carriagetype` (`id`, `title`, `carriage_type_cost`) VALUES 
  (0,'platscart',250),
  (1,'cupei',560),
  (2,'seat',16);
COMMIT;

#
# Data for the `carriage` table  (LIMIT 0,500)
#

INSERT INTO `carriage` (`id`, `carriagetype_id`) VALUES 
  (0,1),
  (1,1),
  (2,1),
  (3,2),
  (4,2),
  (5,0),
  (6,0),
  (7,0),
  (8,2),
  (9,2),
  (10,0),
  (11,0),
  (12,1),
  (13,1),
  (14,1),
  (15,0),
  (16,1),
  (17,2);
COMMIT;

#
# Data for the `seattype` table  (LIMIT 0,500)
#

INSERT INTO `seattype` (`id`, `title`) VALUES 
  (1,'ordinal'),
  (2,'upper'),
  (3,'lower'),
  (4,'latheral');
COMMIT;

#
# Data for the `carriage_seat` table  (LIMIT 0,500)
#

INSERT INTO `carriage_seat` (`id`, `order_number`, `carriage_id`, `seattype_id`) VALUES 
  (1,1,0,2),
  (2,2,0,3),
  (3,3,0,3),
  (4,1,1,3),
  (5,2,1,2),
  (6,3,1,2),
  (7,1,2,2),
  (8,2,2,3),
  (9,3,2,2),
  (10,1,3,1),
  (11,2,3,1),
  (12,3,3,1),
  (13,4,3,1),
  (14,5,3,1),
  (15,1,4,1),
  (16,2,4,1),
  (17,3,4,1),
  (18,4,4,1),
  (19,5,4,1),
  (20,1,5,2),
  (21,2,5,3),
  (22,3,5,4),
  (23,4,5,2),
  (24,1,6,2),
  (25,2,6,3),
  (26,3,6,4),
  (27,4,6,2),
  (28,1,7,3),
  (29,2,7,4),
  (30,3,7,2),
  (31,4,7,3),
  (32,1,8,1),
  (33,2,8,1),
  (34,3,8,1),
  (35,4,8,1),
  (36,5,8,1),
  (37,1,9,1),
  (38,2,9,1),
  (39,3,9,1),
  (40,4,9,1),
  (41,5,9,1),
  (42,1,10,2),
  (43,2,10,3),
  (44,3,10,4),
  (45,4,10,3),
  (46,1,11,4),
  (47,2,11,2),
  (48,3,11,3),
  (49,4,11,3),
  (50,1,12,2),
  (51,2,12,3),
  (52,3,12,2),
  (53,1,13,3),
  (54,2,13,2),
  (55,3,13,3),
  (56,1,14,2),
  (57,2,14,3),
  (58,3,14,2),
  (59,1,15,2),
  (60,2,15,3),
  (61,3,15,4),
  (62,4,15,2),
  (63,1,16,2),
  (64,2,16,3),
  (65,3,16,2),
  (66,4,16,3),
  (67,1,17,1),
  (68,2,17,1),
  (69,3,17,1),
  (70,4,17,1);
COMMIT;

#
# Data for the `station` table  (LIMIT 0,500)
#

INSERT INTO `station` (`id`, `title`) VALUES 
  (1,'Tomsk'),
  (2,'Yurga'),
  (3,'Bolotnoie'),
  (4,'Novosibirsk'),
  (5,'Kargat'),
  (6,'Barabinsk'),
  (7,'Omsk'),
  (8,'Berdsk'),
  (9,'Iskitim'),
  (10,'Barnaul'),
  (11,'Angero-Sujensk'),
  (12,'Kemerovo'),
  (13,'Novokuznetsk');
COMMIT;

#
# Data for the `train` table  (LIMIT 0,500)
#

INSERT INTO `train` (`tnumb`, `tnam`) VALUES 
  (101,'Lastochka'),
  (102,'Sibir Express'),
  (103,'Kuznetsk Nefteugansk'),
  (110,'Lastochka'),
  (120,'Sibir Express'),
  (130,'Kuznetsk Nefteugansk');
COMMIT;

#
# Data for the `departure` table  (LIMIT 0,500)
#

INSERT INTO `departure` (`id`, `date_dep`, `tnumb`, `rout_id`, `dep_time`, `arr_time`, `str_st_id`, `end_st_id`, `stayin`, `travel_time`, `distance`, `rout_cost`, `date_arr`) VALUES 
  (1,'2012-07-01',101,1,'06:30:00','07:10:00',1,2,10,'00:40:00',40,70,'2012-07-01'),
  (1,'2012-07-01',101,2,'07:20:00','08:00:00',2,3,5,'00:40:00',150,65,'2012-07-01'),
  (1,'2012-07-01',101,3,'08:05:00','08:25:00',3,4,60,'00:20:00',40,68,'2011-07-01'),
  (2,'2012-07-01',110,4,'06:20:00','06:40:00',4,3,3,'00:20:00',40,69,'2012-07-01'),
  (2,'2012-07-01',110,5,'06:45:00','07:15:00',3,2,5,'00:30:00',150,71,'2012-07-01'),
  (2,'2012-07-01',110,6,'07:20:00','08:00:00',2,1,20,'00:40:00',40,69,'2012-07-01'),
  (3,'2012-07-01',102,7,'12:00:00','13:00:00',4,5,10,'01:00:00',90,71,'2012-07-01'),
  (3,'2012-07-01',102,8,'13:10:00','15:10:00',5,6,3,'02:00:00',110,70,'2012-07-01'),
  (3,'2012-07-01',102,9,'15:15:00','18:15:00',6,7,5,'03:00:00',250,70,'2012-07-01'),
  (4,'2012-07-01',120,10,'13:30:00','15:50:00',7,6,10,'02:20:00',250,60,'2012-07-01'),
  (4,'2012-07-01',120,11,'16:00:00','17:50:00',6,5,5,'01:50:00',110,61,'2012-07-01'),
  (4,'2012-07-01',120,12,'17:55:00','18:30:00',5,4,30,'00:35:00',90,69,'2012-07-01'),
  (5,'2012-07-01',103,13,'15:00:00','15:30:00',13,12,5,'00:30:00',60,58,'2012-07-01'),
  (5,'2012-07-01',103,14,'15:35:00','18:45:00',12,11,5,'02:50:00',230,70,'2012-07-01'),
  (5,'2012-07-01',103,15,'18:50:00','19:50:00',11,10,10,'02:00:00',196,69,'2012-07-01'),
  (5,'2012-07-01',103,16,'20:00:00','20:30:00',10,9,30,'00:30:00',70,56,'2012-07-01'),
  (5,'2012-07-01',103,18,'21:00:00','21:30:00',9,8,30,'00:30:00',70,56,'2012-07-01'),
  (5,'2012-07-01',103,19,'22:00:00','22:30:00',8,4,30,'00:30:00',70,56,'2012-07-01'),
  (6,'2012-07-01',130,20,'15:00:00','15:30:00',4,8,5,'00:30:00',70,58,'2012-07-01'),
  (6,'2012-07-01',130,21,'15:35:00','16:05:00',8,9,3,'00:30:00',70,70,'2012-07-01'),
  (6,'2012-07-01',130,23,'16:10:00','17:00:00',9,10,30,'00:50:00',70,56,'2012-07-01'),
  (6,'2012-07-01',130,24,'17:30:00','20:30:00',10,11,30,'02:00:00',196,56,'2012-07-01'),
  (6,'2012-07-01',130,25,'21:00:00','23:40:00',11,12,10,'02:40:00',230,56,'2012-07-01'),
  (6,'2012-07-01',130,26,'23:50:00','00:30:00',12,13,30,'00:40:00',60,56,'2012-07-02');
COMMIT;

#
# Data for the `passangerticket` table  (LIMIT 0,500)
#

INSERT INTO `passangerticket` (`id`, `credit_card`,`passport`, `fullname`, `str_station_id`, `end_station_id`) VALUES 
  (1,1122323823, 2147483647,'IvanovaTB',1,6),
  (3,1122323822, 2147483647,'SidorovEA',2,4),
  (4,1122523823,2147483647,'IvanenkoTB',3,6),
  (5,1132323823,2147483647,'PetrenkoGR',13,2),
  (6,1122453823,2147483647,'SidorenkoEA',2,1),
  (7,1122334233,2147483647,'HomyakovAV',1,4),
  (8,1422323823,2147483647,'KuznetsovaFT',1,2),
  (9,1122323820,2147483647,'KovaliovaNM',9,3),
  (10,112232523,2147483647,'KovalchuckIO',6,5),
  (11,1122387823,2147483647,'KovalenkoGG',8,1),
  (12,1098323823,2147483647,'BondarevNV',1,5),
  (13,1122328423,2147483647,'BondarenkoEP',1,3),
  (14,1108323823,2147483647,'BondarchuckPS',8,4),
  (15,1174323823,2147483647,'BondarchuckVS',8,5),
  (16,1102323823,2147483647,'PetrenkoGP',8,3),
  (17,1122324823,2147483647,'PetrovLF',8,2),
  (18,1122053823,2147483647,'IvanovBB',13,1),
  (19,5122323823,2147483647,'IvanenkoBB',12,1),
  (20,1922323823,1358543223,'KuznetsovDI',12,5);
COMMIT;

#
# Data for the `passangertrip` table  (LIMIT 0,500)
#

INSERT INTO `passangertrip` (`passangerticket_id`, `departure_id`, `carriage_seat_id`, `occuped`) VALUES 
  (1,1,1,1),
  (3,2,4,1),
  (4,3,7,1),
  (5,4,20,1),
  (6,5,24,1),
  (7,6,59,1),
  (8,1,2,1),
  (9,2,5,1),
  (10,3,8,1),
  (11,4,21,1),
  (12,5,25,1),
  (13,6,1,1),
  (14,1,3,1),
  (15,2,6,1),
  (16,3,9,1),
  (17,4,22,1),
  (18,5,26,1),
  (19,6,60,1),
  (20,1,16,1);
COMMIT;

#
# Data for the `rundays` table  (LIMIT 0,500)
#

INSERT INTO `rundays` (`tnumb`, `daynum`, `presence`) VALUES 
  (101,1,1),
  (101,2,0),
  (101,3,1),
  (101,4,0),
  (101,5,1),
  (101,6,0),
  (101,7,0),
  (102,1,1),
  (102,2,0),
  (102,3,1),
  (102,4,0),
  (102,5,1),
  (102,6,0),
  (102,7,0),
  (103,1,1),
  (103,2,0),
  (103,3,1),
  (103,4,0),
  (103,5,1),
  (103,6,0),
  (103,7,0),
  (110,1,0),
  (110,2,1),
  (110,3,0),
  (110,4,1),
  (110,5,0),
  (110,6,0),
  (110,7,0),
  (120,1,1),
  (120,2,0),
  (120,3,0),
  (120,4,0),
  (120,5,1),
  (120,6,0),
  (120,7,1),
  (130,1,0),
  (130,2,0),
  (130,3,0),
  (130,4,0),
  (130,5,0),
  (130,6,0),
  (130,7,1);
COMMIT;

#
# Data for the `train_carriage` table  (LIMIT 0,500)
#

INSERT INTO `train_carriage` (`carriage_id`, `tnumb`, `carri_ordinal_num`) VALUES 
  (0,101,1),
  (1,110,1),
  (2,102,1),
  (3,103,1),
  (4,101,2),
  (5,120,2),
  (6,103,2),
  (7,101,3),
  (8,110,2),
  (9,120,3),
  (10,110,3),
  (11,102,2),
  (12,120,4),
  (13,103,3),
  (14,103,4),
  (15,130,1),
  (16,130,2),
  (17,130,3);
COMMIT;



/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;