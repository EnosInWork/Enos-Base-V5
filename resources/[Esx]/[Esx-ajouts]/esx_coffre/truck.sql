CREATE TABLE IF NOT EXISTS `truck_inventory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plate` varchar(8) NOT NULL,
  `data` text NOT NULL,
  `owned` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `plate` (`plate`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8;
