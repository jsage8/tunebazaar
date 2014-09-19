-- MySQL dump 10.13  Distrib 5.5.34, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: tune_bazaar
-- ------------------------------------------------------
-- Server version	5.5.34-0ubuntu0.13.04.1

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
-- Table structure for table `albums`
--

DROP TABLE IF EXISTS `albums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `albums` (
  `album_id` int(10) NOT NULL,
  `artist_id` int(10) NOT NULL,
  `album_name` varchar(100) NOT NULL,
  `release_year` int(10) DEFAULT NULL,
  `image_filepath` varchar(255) DEFAULT NULL,
  `price` decimal(4,2) DEFAULT NULL,
  `album_filepath` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`album_id`),
  KEY `artist-album_idx` (`artist_id`),
  CONSTRAINT `artist_album` FOREIGN KEY (`artist_id`) REFERENCES `artists` (`artist_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `albums`
--

LOCK TABLES `albums` WRITE;
/*!40000 ALTER TABLE `albums` DISABLE KEYS */;
INSERT INTO `albums` VALUES (1,1,'Permanent Vacation',1988,'img/permanent_vacation.jpg',9.99,'music/aerosmith_-_permanent_vacation.zip\r'),(2,2,'Fruitcakes',1992,'img/fruitcakes.jpg',9.99,'music/jimmy_buffett_-_fruitcakes.zip\r'),(3,2,'Feeding Frenzy',1990,'img/feeding_frenzy.jpg',9.99,'music/jimmy_buffett_-_feeding_frenzy.zip\r'),(4,2,'Riddles In The Sand',1980,'img/riddles_in_the_sand.jpg',9.99,'music/jimmy_buffett_-_riddles_in_the_sand.zip\r'),(5,3,'Back In Black',1980,'img/back_in_black.jpg',9.99,'music/ac-dc_-_back_in_black.zip\r'),(6,3,'Fly On The Wall',1985,'img/fly_on_the_wall.jpg',9.99,'music/ac-dc_-_fly_on_the_wall.zip\r'),(7,4,'Pyromania',1986,'img/pyromania.jpg',9.99,'music/def_leppard_-_pyromania.zip\r'),(8,5,'Faith',1997,'img/faith.jpg',9.99,'music/faith_hill_-_faith.zip\r'),(9,6,'90 Millas',2007,'img/90_millas.jpg',9.99,'music/gloria_estefan_-_90_millas.zip\r'),(10,7,'Appetite for Destruction',1989,'img/appetite_for_destruction.jpg',9.99,'music/guns_n_roses_-_appetite_for_destruction.zip\r'),(11,8,'Bad to the Bone',1989,'img/bad_to_the_bone.jpg',9.99,'music/george_thorogood_-_bad_to_the_bone.zip\r'),(12,9,'Barenaked Ladies Greatest Hits',2001,'img/barenaked_ladies_greatest_hits.jpg',9.99,'music/barenaked_ladies_-_barenaked_ladies_greatest_hits.zip\r'),(13,1,'Big Ones',1994,'img/big_ones.jpg',9.99,'music/aerosmith_-_big_ones.zip\r'),(14,17,'Borrowed Heaven',2004,'img/borrowed_heaven.jpg',9.99,'music/the_coors_-_borrowed_heaven.zip\r'),(15,10,'Brooks And Dunn - Greatest Hits',1997,'img/brooks_and_dunn_-_greatest_hits.jpg',9.99,'music/brooks_and_dunn_-_brooks_and_dunn_-_greatest_hits.zip\r'),(17,11,'En Extasis',1996,'img/en_extasis.jpg',9.99,'music/thalia_-_en_extasis.zip\r'),(18,1,'Get a Grip',2001,'img/get_a_grip.jpg',9.99,'music/aerosmith_-_get_a_grip.zip\r'),(19,3,'High Voltage',1976,'img/high_voltage.jpg',9.99,'music/ac-dc_-_high_voltage.zip\r'),(20,3,'Highway to Hell',1979,'img/highway_to_hell.jpg',9.99,'music/ac-dc_-_highway_to_hell.zip\r'),(21,20,'Its Time',2005,'img/its_time.jpg',9.99,'music/michael_buble_-_its_time.zip\r'),(22,3,'Let There Be Rock',1978,'img/let_there_be_rock.jpg',9.99,'music/ac-dc_-_let_there_be_rock.zip\r'),(23,8,'Move It on Over',1990,'img/move_it_on_over.jpg',9.99,'music/george_thorogood_-_move_it_on_over.zip\r'),(24,14,'OU812',1990,'img/ou812.jpg',9.99,'music/van_halen_-_ou812.zip\r'),(25,13,'Music Is Better Than Words',2013,'img/music_is_better_than_words.jpg',9.99,'music/seth_macfarlane_-_music_is_better_than_words.zip\r'),(26,15,'Social Distortion',1990,'img/social_distortion.jpg',9.99,'music/social_distortion_-_social_distortion.zip\r'),(27,15,'Somewhere Between Heaven and Hell',1992,'img/somewhere_between_heaven_and_hell.jpg',9.99,'music/social_distortion_-_somewhere_between_heaven_and_hell.zip\r'),(28,16,'Cant Run From Yourself',1993,'img/cant_run_from_yourself.jpg',9.99,'music/tanya_tucker_-_cant_run_from_yourself.zip\r'),(29,18,'The Better Life',2000,'img/the_better_life.jpg',9.99,'music/3_doors_down_-_the_better_life.zip\r'),(32,7,'Use Your Illusion I',1991,'img/use_your_illusion_i.jpg',9.99,'music/guns_n_roses_-_use_your_illusion_i.zip\r'),(33,7,'Use Your Illusion II',1991,'img/use_your_illusion_ii.jpg',9.99,'music/guns_n_roses_-_use_your_illusion_ii.zip\r'),(34,17,'VH1 Presents the Corrs Live in Dublin',1992,'img/vh1_presents_the_corrs_live_in_dublin.jpg',9.99,'music/the_coors_-_vh1_presents_the_corrs_live_in_dublin.zip\r'),(35,3,'Who Made Who',1986,'img/who_made_who.jpg',9.99,'music/ac-dc_-_who_made_who.zip\r'),(36,2,'Changes in Latitudes Changes in Attitudes',0,'img/changes_in_latitudes_changes_in_attitudes.jpg',9.99,'music/jimmy_buffett_-_changes_in_latitudes_changes_in_attitudes.zip\r');
/*!40000 ALTER TABLE `albums` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `artists`
--

DROP TABLE IF EXISTS `artists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `artists` (
  `artist_id` int(10) NOT NULL,
  `artist_name` varchar(100) NOT NULL,
  `genre_id` int(10) NOT NULL,
  PRIMARY KEY (`artist_id`),
  KEY `genre_artists_idx` (`genre_id`),
  CONSTRAINT `genre_artists` FOREIGN KEY (`genre_id`) REFERENCES `genre` (`genre_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artists`
--

LOCK TABLES `artists` WRITE;
/*!40000 ALTER TABLE `artists` DISABLE KEYS */;
INSERT INTO `artists` VALUES (1,'Aerosmith',1),(2,'Jimmy Buffett',2),(3,'AC-DC',1),(4,'Def Leppard',1),(5,'Faith Hill',3),(6,'Gloria Estefan',10),(7,'Guns N Roses',1),(8,'George Thorogood',1),(9,'Barenaked Ladies',2),(10,'Brooks And Dunn',3),(11,'Thalia',10),(13,'Seth MacFarlane',4),(14,'Van Halen',1),(15,'Social Distortion',1),(16,'Tanya Tucker',3),(17,'The Coors',2),(18,'Three Doors Down',2),(20,'Michael Buble',2);
/*!40000 ALTER TABLE `artists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `credit_cards`
--

DROP TABLE IF EXISTS `credit_cards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `credit_cards` (
  `credit_card_id` int(10) NOT NULL,
  `number` varchar(16) NOT NULL,
  `user_id` int(10) NOT NULL,
  `type` varchar(30) NOT NULL,
  `expiration_month` varchar(2) NOT NULL,
  `expiration_year` varchar(4) NOT NULL,
  `name_on_card` varchar(255) NOT NULL,
  PRIMARY KEY (`credit_card_id`),
  KEY `customers_credit_cards_idx` (`user_id`),
  CONSTRAINT `customers_credit_cards` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `credit_cards`
--

LOCK TABLES `credit_cards` WRITE;
/*!40000 ALTER TABLE `credit_cards` DISABLE KEYS */;
INSERT INTO `credit_cards` VALUES (1,'1234123412341234',1,'visa','11','14','Jerry McGuire'),(2,'1234123412341234',2,'visa','12','15','Jonathan C Sage'),(3,'1234123412341234',1,'visa','11','15','Jerry McGuire'),(4,'1111222233334444',3,'visa','05','16','Peyton Manning'),(5,'1234567890123456',4,'visa','12','16','Happy Gilmore');
/*!40000 ALTER TABLE `credit_cards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genre`
--

DROP TABLE IF EXISTS `genre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `genre` (
  `genre_id` int(10) NOT NULL,
  `genre_name` varchar(45) NOT NULL,
  PRIMARY KEY (`genre_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genre`
--

LOCK TABLES `genre` WRITE;
/*!40000 ALTER TABLE `genre` DISABLE KEYS */;
INSERT INTO `genre` VALUES (1,'Rock\r'),(2,'Pop\r'),(3,'Country\r'),(4,'Jazz\r'),(5,'Vocal\r'),(6,'Rock/Pop\r'),(7,'Soundtrack\r'),(8,'Other\r'),(9,'Comedy\r'),(10,'Latin\r'),(11,'Classic Rock\r');
/*!40000 ALTER TABLE `genre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_lines`
--

DROP TABLE IF EXISTS `order_lines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_lines` (
  `order_line_id` int(10) NOT NULL AUTO_INCREMENT,
  `order_id` int(10) DEFAULT NULL,
  `product_id` int(10) NOT NULL,
  `line_item_cost` decimal(4,2) DEFAULT NULL,
  PRIMARY KEY (`order_line_id`,`product_id`),
  KEY `orders - order_items_idx` (`order_id`),
  KEY `order_lines_albums_idx` (`product_id`),
  CONSTRAINT `orders_order_lines` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_lines_albums` FOREIGN KEY (`product_id`) REFERENCES `albums` (`album_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_lines`
--

LOCK TABLES `order_lines` WRITE;
/*!40000 ALTER TABLE `order_lines` DISABLE KEYS */;
INSERT INTO `order_lines` VALUES (1,1,17,9.99),(2,1,1,9.99),(3,1,34,9.99),(4,2,17,9.99),(5,2,8,9.99),(6,3,21,9.99),(7,3,1,9.99),(8,4,5,9.99),(9,4,20,9.99),(10,5,27,9.99),(11,5,10,9.99),(12,6,13,9.99),(13,6,18,9.99);
/*!40000 ALTER TABLE `order_lines` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders` (
  `order_id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL,
  `order_date` date NOT NULL,
  `ship_date` date DEFAULT NULL,
  `merchandise_cost` decimal(10,2) NOT NULL,
  `shipping_cost` decimal(5,2) DEFAULT NULL,
  `tax_cost` decimal(4,2) DEFAULT NULL,
  `total_cost` decimal(10,2) NOT NULL,
  `bill_address_id` int(10) NOT NULL,
  `ship_address_id` int(10) NOT NULL,
  `home_phone_id` int(10) DEFAULT NULL,
  `cell_phone_id` int(10) DEFAULT NULL,
  `credit_card_id` int(10) NOT NULL,
  PRIMARY KEY (`order_id`),
  KEY `customers_orders_idx` (`user_id`),
  KEY `bill_address_id_idx` (`bill_address_id`),
  KEY `ship_address_id_idx` (`ship_address_id`),
  KEY `home_phone_id_idx` (`home_phone_id`),
  KEY `cell_phone_id_idx` (`cell_phone_id`),
  KEY `credit_card_id_idx` (`credit_card_id`),
  CONSTRAINT `bill_address_id` FOREIGN KEY (`bill_address_id`) REFERENCES `user_addresses` (`address_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `cell_phone_id` FOREIGN KEY (`cell_phone_id`) REFERENCES `phones` (`phone_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `credit_card_id` FOREIGN KEY (`credit_card_id`) REFERENCES `credit_cards` (`credit_card_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `home_phone_id` FOREIGN KEY (`home_phone_id`) REFERENCES `phones` (`phone_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ship_address_id` FOREIGN KEY (`ship_address_id`) REFERENCES `user_addresses` (`address_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `users_orders` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,2,'2013-12-08',NULL,29.97,NULL,1.50,31.47,2,2,3,NULL,2),(2,1,'2013-12-08',NULL,19.98,NULL,1.00,20.98,1,1,1,NULL,3),(3,3,'2013-12-08',NULL,19.98,NULL,1.00,20.98,3,3,4,NULL,4),(4,4,'2013-12-08',NULL,19.98,NULL,1.00,20.98,4,4,5,NULL,5),(5,2,'2013-12-08',NULL,19.98,NULL,1.00,20.98,2,2,3,NULL,2),(6,2,'2013-12-08',NULL,19.98,NULL,1.00,20.98,2,2,3,NULL,2);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phones`
--

DROP TABLE IF EXISTS `phones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phones` (
  `phone_id` int(10) NOT NULL AUTO_INCREMENT,
  `phone_number` varchar(30) NOT NULL,
  `type` varchar(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `is_primary` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`phone_id`),
  KEY `phoes-user_idx` (`user_id`),
  CONSTRAINT `phoes-user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phones`
--

LOCK TABLES `phones` WRITE;
/*!40000 ALTER TABLE `phones` DISABLE KEYS */;
INSERT INTO `phones` VALUES (1,'7036789123','home',1,'y'),(2,'7036789123','cell',1,'n'),(3,'1231231234','home',2,'n'),(4,'1112223333','home',3,'y'),(5,'7031234567','home',4,'y');
/*!40000 ALTER TABLE `phones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ratings`
--

DROP TABLE IF EXISTS `ratings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ratings` (
  `user_id` int(10) NOT NULL,
  `rating_value` int(10) DEFAULT NULL,
  `comments` varchar(255) DEFAULT NULL,
  `product_id` int(10) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  KEY `fk_ratings_albums1_idx` (`product_id`),
  CONSTRAINT `ratings_albums` FOREIGN KEY (`product_id`) REFERENCES `albums` (`album_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ratings_customers` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ratings`
--

LOCK TABLES `ratings` WRITE;
/*!40000 ALTER TABLE `ratings` DISABLE KEYS */;
/*!40000 ALTER TABLE `ratings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `songs`
--

DROP TABLE IF EXISTS `songs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `songs` (
  `song_id` int(10) NOT NULL,
  `album_id` int(10) NOT NULL,
  `song_name` varchar(100) NOT NULL,
  `filepath` varchar(255) NOT NULL,
  `track_number` int(10) NOT NULL,
  PRIMARY KEY (`song_id`),
  KEY `albums - songs_idx` (`album_id`),
  CONSTRAINT `albums_songs` FOREIGN KEY (`album_id`) REFERENCES `albums` (`album_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `songs`
--

LOCK TABLES `songs` WRITE;
/*!40000 ALTER TABLE `songs` DISABLE KEYS */;
INSERT INTO `songs` VALUES (1,1,'Angel','music/aerosmith_-_permanent_vacation/aerosmith_-_angel.mp3',1),(2,1,'Dude (Looks Like a Lady)','music/aerosmith_-_permanent_vacation/aerosmith_-_dude_(looks_like_a_lady).mp3',2),(3,1,'Girl Keeps Coming Apart','music/aerosmith_-_permanent_vacation/aerosmith_-_girl_keeps_coming_apart.mp3',3),(4,1,'Hangman Jury','music/aerosmith_-_permanent_vacation/aerosmith_-_hangman_jury.mp3',4),(5,1,'Heart\'s Done Time','music/aerosmith_-_permanent_vacation/aerosmith_-_heart\'s_done_time.mp3',5),(6,1,'I\'m Down','music/aerosmith_-_permanent_vacation/aerosmith_-_i\'m_down.mp3',6),(7,1,'Magic Touch','music/aerosmith_-_permanent_vacation/aerosmith_-_magic_touch.mp3',7),(8,1,'Permanent Vacation','music/aerosmith_-_permanent_vacation/aerosmith_-_permanent_vacation.mp3',8),(9,1,'Rag Doll','music/aerosmith_-_permanent_vacation/aerosmith_-_rag_doll.mp3',9),(10,1,'Simoriah','music/aerosmith_-_permanent_vacation/aerosmith_-_simoriah.mp3',10),(11,1,'St. John','music/aerosmith_-_permanent_vacation/aerosmith_-_st._john.mp3',11),(12,1,'The Movie [Instrumental]','music/aerosmith_-_permanent_vacation/aerosmith_-_the_movie_[instrumental].mp3',12),(13,2,'Apocalypso','music/jimmy_buffett_-_fruitcakes/jimmy_buffett_-_apocalypso.mp3',1),(14,2,'Delaney Talks to Statues','music/jimmy_buffett_-_fruitcakes/jimmy_buffett_-_delaney_talks_to_statues.mp3',2),(15,2,'Everybody\'s Got a Cousin in Miami','music/jimmy_buffett_-_fruitcakes/jimmy_buffett_-_everybody\'s_got_a_cousin_in_miami.mp3',3),(16,2,'Frenchman for the Night','music/jimmy_buffett_-_fruitcakes/jimmy_buffett_-_frenchman_for_the_night.mp3',4),(17,2,'Fruitcakes','music/jimmy_buffett_-_fruitcakes/jimmy_buffett_-_fruitcakes.mp3',5),(18,2,'Lone Palm','music/jimmy_buffett_-_fruitcakes/jimmy_buffett_-_lone_palm.mp3',6),(19,2,'Love in the Library','music/jimmy_buffett_-_fruitcakes/jimmy_buffett_-_love_in_the_library.mp3',7),(20,2,'Quietly Making Noise','music/jimmy_buffett_-_fruitcakes/jimmy_buffett_-_quietly_making_noise.mp3',8),(21,2,'She\'s Got You','music/jimmy_buffett_-_fruitcakes/jimmy_buffett_-_she\'s_got_you.mp3',9),(22,2,'Six String Music','music/jimmy_buffett_-_fruitcakes/jimmy_buffett_-_six_string_music.mp3',10),(23,2,'Sunny Afternoon','music/jimmy_buffett_-_fruitcakes/jimmy_buffett_-_sunny_afternoon.mp3',11),(24,2,'Uncle John\'s Band','music/jimmy_buffett_-_fruitcakes/jimmy_buffett_-_uncle_john\'s_band.mp3',12),(25,2,'\"Vampires, Mummies and the Holy Ghost\"','\"music/jimmy_buffett_-_fruitcakes/jimmy_buffett_-_vampires,_mummies_and_the_holy_ghost.mp3\"',13),(26,3,'A Love Song (From a Different Point of View)','music/jimmy_buffett_-_feeding_frenzy/jimmy_buffett_-_a_love_song_(from_a_different_point_of_view).mp3',1),(27,3,'A Pirate Looks at Forty','music/jimmy_buffett_-_feeding_frenzy/jimmy_buffett_-_a_pirate_looks_at_forty.mp3',2),(28,3,'Cheeseburger in Paradise','music/jimmy_buffett_-_feeding_frenzy/jimmy_buffett_-_cheeseburger_in_paradise.mp3',3),(29,3,'Come Monday','music/jimmy_buffett_-_feeding_frenzy/jimmy_buffett_-_come_monday.mp3',4),(30,3,'Fins','music/jimmy_buffett_-_feeding_frenzy/jimmy_buffett_-_fins.mp3',5),(31,3,'Gypsies in the Palace','music/jimmy_buffett_-_feeding_frenzy/jimmy_buffett_-_gypsies_in_the_palace.mp3',6),(32,3,'Honey Do','music/jimmy_buffett_-_feeding_frenzy/jimmy_buffett_-_honey_do.mp3',7),(33,3,'Jamaica Farewell','music/jimmy_buffett_-_feeding_frenzy/jimmy_buffett_-_jamaica_farewell.mp3',8),(34,3,'Jolly Mon Sing','music/jimmy_buffett_-_feeding_frenzy/jimmy_buffett_-_jolly_mon_sing.mp3',9),(35,3,'Last Mango in Paris','music/jimmy_buffett_-_feeding_frenzy/jimmy_buffett_-_last_mango_in_paris.mp3',10),(36,3,'Margaritaville','music/jimmy_buffett_-_feeding_frenzy/jimmy_buffett_-_margaritaville.mp3',11),(37,3,'One Particular Harbour','music/jimmy_buffett_-_feeding_frenzy/jimmy_buffett_-_one_particular_harbour.mp3',12),(38,3,'The City','music/jimmy_buffett_-_feeding_frenzy/jimmy_buffett_-_the_city.mp3',13),(39,3,'Today\'s Message','music/jimmy_buffett_-_feeding_frenzy/jimmy_buffett_-_today\'s_message.mp3',14),(40,3,'Volcano','music/jimmy_buffett_-_feeding_frenzy/jimmy_buffett_-_volcano.mp3',15),(41,3,'You\'ll Never Work In Dis Bidness Again','music/jimmy_buffett_-_feeding_frenzy/jimmy_buffett_-_you\'ll_never_work_in_dis_bidness_again.mp3',16),(42,4,'Bigger That the Both of Us','music/jimmy_buffett_-_riddles_in_the_sand/jimmy_buffett_-_bigger_that_the_both_of_us.mp3',1),(43,4,'Burn That Bridge','music/jimmy_buffett_-_riddles_in_the_sand/jimmy_buffett_-_burn_that_bridge.mp3',2),(44,4,'Come the the Moon','music/jimmy_buffett_-_riddles_in_the_sand/jimmy_buffett_-_come_the_the_moon.mp3',3),(45,4,'Knees of My Heart','music/jimmy_buffett_-_riddles_in_the_sand/jimmy_buffett_-_knees_of_my_heart.mp3',4),(46,4,'La Vie Dansante','music/jimmy_buffett_-_riddles_in_the_sand/jimmy_buffett_-_la_vie_dansante.mp3',5),(47,4,'Love in Decline','music/jimmy_buffett_-_riddles_in_the_sand/jimmy_buffett_-_love_in_decline.mp3',6),(48,4,'Ragtop Day','music/jimmy_buffett_-_riddles_in_the_sand/jimmy_buffett_-_ragtop_day.mp3',7),(49,4,'She\'s Going Out of My Mind','music/jimmy_buffett_-_riddles_in_the_sand/jimmy_buffett_-_she\'s_going_out_of_my_mind.mp3',8),(50,4,'When the Wild Life Betrays Me','music/jimmy_buffett_-_riddles_in_the_sand/jimmy_buffett_-_when_the_wild_life_betrays_me.mp3',9),(51,4,'Who\'s the Blonde Stranger-','music/jimmy_buffett_-_riddles_in_the_sand/jimmy_buffett_-_who\'s_the_blonde_stranger-.mp3',10),(52,5,'Back in Black','music/ac-dc_-_back_in_black/ac-dc_-_back_in_black.mp3',1),(53,5,'Given the Dog a Bone','music/ac-dc_-_back_in_black/ac-dc_-_given_the_dog_a_bone.mp3',2),(54,5,'Have a Drink on Me','music/ac-dc_-_back_in_black/ac-dc_-_have_a_drink_on_me.mp3',3),(55,5,'Hells Bells','music/ac-dc_-_back_in_black/ac-dc_-_hells_bells.mp3',4),(56,5,'Let Me Put My Love Into You','music/ac-dc_-_back_in_black/ac-dc_-_let_me_put_my_love_into_you.mp3',5),(57,5,'Rock & Roll Ain\'t Noise Pollution','music/ac-dc_-_back_in_black/ac-dc_-_rock_&_roll_ain\'t_noise_pollution.mp3',6),(58,5,'Shake a Leg','music/ac-dc_-_back_in_black/ac-dc_-_shake_a_leg.mp3',7),(59,5,'Shoot to Thrill','music/ac-dc_-_back_in_black/ac-dc_-_shoot_to_thrill.mp3',8),(60,5,'What Do You Do for Money Honey','music/ac-dc_-_back_in_black/ac-dc_-_what_do_you_do_for_money_honey.mp3',9),(61,5,'You Shook Me All Night Long','music/ac-dc_-_back_in_black/ac-dc_-_you_shook_me_all_night_long.mp3',10),(62,6,'Fly on the Wall','music/ac-dc_-_fly_on_the_wall/ac-dc_-__fly_on_the_wall.mp3',1),(63,6,'Shake Your Foundations','music/ac-dc_-_fly_on_the_wall/ac-dc_-__shake_your_foundations.mp3',2),(64,6,'Sink the Pink','music/ac-dc_-_fly_on_the_wall/ac-dc_-__sink_the_pink.mp3',3),(65,6,'Back in Business','music/ac-dc_-_fly_on_the_wall/ac-dc_-_back_in_business.mp3',4),(66,6,'Danger','music/ac-dc_-_fly_on_the_wall/ac-dc_-_danger.mp3',5),(67,6,'First Blood','music/ac-dc_-_fly_on_the_wall/ac-dc_-_first_blood.mp3',6),(68,6,'Hell or High Water','music/ac-dc_-_fly_on_the_wall/ac-dc_-_hell_or_high_water.mp3',7),(69,6,'Playing With Girls','music/ac-dc_-_fly_on_the_wall/ac-dc_-_playing_with_girls.mp3',8),(70,6,'Send for the Man','music/ac-dc_-_fly_on_the_wall/ac-dc_-_send_for_the_man.mp3',9),(71,6,'Stand Up','music/ac-dc_-_fly_on_the_wall/ac-dc_-_stand_up.mp3',10),(72,7,'Action! Not Words','music/def_leppard_-_pyromania/def_leppard_-_action!_not_words.mp3',1),(73,7,'Billy\'s Got a Gun','music/def_leppard_-_pyromania/def_leppard_-_billy\'s_got_a_gun.mp3',2),(74,7,'Comin\' Under Fire','music/def_leppard_-_pyromania/def_leppard_-_comin\'_under_fire.mp3',3),(75,7,'Die Hard the Hunter','music/def_leppard_-_pyromania/def_leppard_-_die_hard_the_hunter.mp3',4),(76,7,'Foolin\'','music/def_leppard_-_pyromania/def_leppard_-_foolin\'.mp3',5),(77,7,'Photograph','music/def_leppard_-_pyromania/def_leppard_-_photograph.mp3',6),(78,7,'Rock of Ages','music/def_leppard_-_pyromania/def_leppard_-_rock_of_ages.mp3',7),(79,7,'Rock Rock (Till You Drop)','music/def_leppard_-_pyromania/def_leppard_-_rock_rock_(till_you_drop).mp3',8),(80,7,'Stage Fright','music/def_leppard_-_pyromania/def_leppard_-_stage_fright.mp3',9),(81,7,'Too Late for Love','music/def_leppard_-_pyromania/def_leppard_-_too_late_for_love.mp3',10),(82,8,'Better Days','music/faith_hill_-_faith/faith_hill_-_better_days.mp3',1),(83,8,'I Love You','music/faith_hill_-_faith/faith_hill_-_i_love_you.mp3',2),(84,8,'Let Me Let Go','music/faith_hill_-_faith/faith_hill_-_let_me_let_go.mp3',3),(85,8,'Love Ain\'t Like That','music/faith_hill_-_faith/faith_hill_-_love_ain\'t_like_that.mp3',4),(86,8,'Me','music/faith_hill_-_faith/faith_hill_-_me.mp3',5),(87,8,'My Wild Frontier','music/faith_hill_-_faith/faith_hill_-_my_wild_frontier.mp3',6),(88,8,'Somebody Stand by Me','music/faith_hill_-_faith/faith_hill_-_somebody_stand_by_me.mp3',7),(89,8,'The Hard Way','music/faith_hill_-_faith/faith_hill_-_the_hard_way.mp3',8),(90,8,'The Secret of Life','music/faith_hill_-_faith/faith_hill_-_the_secret_of_life.mp3',9),(91,8,'This Kiss','music/faith_hill_-_faith/faith_hill_-_this_kiss.mp3',10),(92,8,'Tim McGraw - Just to Hear You Say That You Love','music/faith_hill_-_faith/faith_hill_-_tim_mcgraw_-_just_to_hear_you_say_that_you_love.mp3',11),(93,8,'You Give Me Love','music/faith_hill_-_faith/faith_hill_-_you_give_me_love.mp3',12),(94,9,'90 Millas','music/gloria_estefan_-_90_millas/gloria_estefan_-_90_millas.mp3',1),(95,9,'Besame','music/gloria_estefan_-_90_millas/gloria_estefan_-_besame.mp3',2),(96,9,'Esperando Cuando Cuba Sea Libre','music/gloria_estefan_-_90_millas/gloria_estefan_-_esperando_cuando_cuba_sea_libre.mp3',3),(97,9,'Lo Nuestro','music/gloria_estefan_-_90_millas/gloria_estefan_-_lo_nuestro.mp3',4),(98,9,'Volvere','music/gloria_estefan_-_90_millas/gloria_estefan_-_volvere.mp3',5),(99,9,'Yo No Cambiaria','music/gloria_estefan_-_90_millas/gloria_estefan_-_yo_no_cambiaria.mp3',6),(100,10,'Anything Goes','music/guns_n_roses_-_appetite_for_destruction/guns_n\'_roses_-_anything_goes.mp3',1),(101,10,'It\'s So Easy','music/guns_n_roses_-_appetite_for_destruction/guns_n\'_roses_-_it\'s_so_easy.mp3',2),(102,10,'Mr. Brownstone','music/guns_n_roses_-_appetite_for_destruction/guns_n\'_roses_-_mr._brownstone.mp3',3),(103,10,'My Michelle','music/guns_n_roses_-_appetite_for_destruction/guns_n\'_roses_-_my_michelle.mp3',4),(104,10,'Nightrain','music/guns_n_roses_-_appetite_for_destruction/guns_n\'_roses_-_nightrain.mp3',5),(105,10,'Out Ta Get Me','music/guns_n_roses_-_appetite_for_destruction/guns_n\'_roses_-_out_ta_get_me.mp3',6),(106,10,'Paradise City','music/guns_n_roses_-_appetite_for_destruction/guns_n\'_roses_-_paradise_city.mp3',7),(107,10,'Rocket Queen','music/guns_n_roses_-_appetite_for_destruction/guns_n\'_roses_-_rocket_queen.mp3',8),(108,10,'Sweet Child O\' Mine','music/guns_n_roses_-_appetite_for_destruction/guns_n\'_roses_-_sweet_child_o\'_mine.mp3',9),(109,10,'Think About You','music/guns_n_roses_-_appetite_for_destruction/guns_n\'_roses_-_think_about_you.mp3',10),(110,10,'Welcome to the Jungle','music/guns_n_roses_-_appetite_for_destruction/guns_n\'_roses_-_welcome_to_the_jungle.mp3',11),(111,10,'You\'re Crazy','music/guns_n_roses_-_appetite_for_destruction/guns_n\'_roses_-_you\'re_crazy.mp3',12),(112,11,'As the Years Go Passing ','music/george_thorogood_-_bad_to_the_bone/george_thorogood_&_the_destroyers_-_as_the_years_go_passing_.mp3',1),(113,11,'Back to Wentzville','music/george_thorogood_-_bad_to_the_bone/george_thorogood_&_the_destroyers_-_back_to_wentzville.mp3',2),(114,11,'Bad to the Bone','music/george_thorogood_-_bad_to_the_bone/george_thorogood_&_the_destroyers_-_bad_to_the_bone.mp3',3),(115,11,'Blue Highway','music/george_thorogood_-_bad_to_the_bone/george_thorogood_&_the_destroyers_-_blue_highway.mp3',4),(116,11,'It\'s a Sin','music/george_thorogood_-_bad_to_the_bone/george_thorogood_&_the_destroyers_-_it\'s_a_sin.mp3',5),(117,11,'Miss Luann','music/george_thorogood_-_bad_to_the_bone/george_thorogood_&_the_destroyers_-_miss_luann.mp3',6),(118,11,'New Boogie Chillun','music/george_thorogood_-_bad_to_the_bone/george_thorogood_&_the_destroyers_-_new_boogie_chillun.mp3',7),(119,11,'No Particular Place to G','music/george_thorogood_-_bad_to_the_bone/george_thorogood_&_the_destroyers_-_no_particular_place_to_g.mp3',8),(120,11,'Nobody But Me','music/george_thorogood_-_bad_to_the_bone/george_thorogood_&_the_destroyers_-_nobody_but_me.mp3',9),(121,11,'Wanted Man','music/george_thorogood_-_barenaked_ladies_greatest_hits/george_thorogood_&_the_destroyers_-_wanted_man.mp3',10),(122,12,'Alternative Girlfriend','music/barenaked_ladies_-_barenaked_ladies_greatest_hits/barenaked_ladies_-_alternative_girlfriend.mp3',1),(123,12,'Be My Yoko Ono','music/barenaked_ladies_-_barenaked_ladies_greatest_hits/barenaked_ladies_-_be_my_yoko_ono.mp3',2),(124,12,'Brian Wilson','music/barenaked_ladies_-_barenaked_ladies_greatest_hits/barenaked_ladies_-_brian_wilson.mp3',3),(125,12,'Call and Answer','music/barenaked_ladies_-_barenaked_ladies_greatest_hits/barenaked_ladies_-_call_and_answer.mp3',4),(126,12,'Enid','music/barenaked_ladies_-_barenaked_ladies_greatest_hits/barenaked_ladies_-_enid.mp3',5),(127,12,'Falling for the First Time','music/barenaked_ladies_-_barenaked_ladies_greatest_hits/barenaked_ladies_-_falling_for_the_first_time.mp3',6),(128,12,'Get in Line','music/barenaked_ladies_-_barenaked_ladies_greatest_hits/barenaked_ladies_-_get_in_line.mp3',7),(129,12,'If I Had $1000000','music/barenaked_ladies_-_barenaked_ladies_greatest_hits/barenaked_ladies_-_if_i_had_$1000000.mp3',8),(130,12,'It\'s All Been Done','music/barenaked_ladies_-_barenaked_ladies_greatest_hits/barenaked_ladies_-_it\'s_all_been_done.mp3',9),(131,12,'It\'s Only Me (The Wizard of Magicland)','music/barenaked_ladies_-_barenaked_ladies_greatest_hits/barenaked_ladies_-_it\'s_only_me_(the_wizard_of_magicland).mp3',10),(132,12,'Jane','music/barenaked_ladies_-_barenaked_ladies_greatest_hits/barenaked_ladies_-_jane.mp3',11),(133,12,'Lovers in a Dangerous Time','music/barenaked_ladies_-_barenaked_ladies_greatest_hits/barenaked_ladies_-_lovers_in_a_dangerous_time.mp3',12),(134,12,'One Week','music/barenaked_ladies_-_barenaked_ladies_greatest_hits/barenaked_ladies_-_one_week.mp3',13),(135,12,'Pinch Me','music/barenaked_ladies_-_barenaked_ladies_greatest_hits/barenaked_ladies_-_pinch_me.mp3',14),(136,12,'Shoebox','music/barenaked_ladies_-_barenaked_ladies_greatest_hits/barenaked_ladies_-_shoebox.mp3',15),(137,12,'Thanks That Was Fun','music/barenaked_ladies_-_barenaked_ladies_greatest_hits/barenaked_ladies_-_thanks_that_was_fun.mp3',16),(138,12,'The Old Apartment','music/barenaked_ladies_-_barenaked_ladies_greatest_hits/barenaked_ladies_-_the_old_apartment.mp3',17),(139,12,'Too Little Too Late','music/barenaked_ladies_-_barenaked_ladies_greatest_hits/barenaked_ladies_-_too_little_too_late.mp3',18),(140,12,'What a Good Boy','music/barenaked_ladies_-_barenaked_ladies_greatest_hits/barenaked_ladies_-_what_a_good_boy.mp3',19),(141,13,'Amazing','music/aerosmith_-_big_ones/aerosmith_-_amazing.mp3',1),(142,13,'Angel','music/aerosmith_-_big_ones/aerosmith_-_angel.mp3',2),(143,13,'Blind Man','music/aerosmith_-_big_ones/aerosmith_-_blind_man.mp3',3),(144,13,'Crazy','music/aerosmith_-_big_ones/aerosmith_-_crazy.mp3',4),(145,13,'Cryin\'','music/aerosmith_-_big_ones/aerosmith_-_cryin\'.mp3',5),(146,13,'Deuces Are Wild','music/aerosmith_-_big_ones/aerosmith_-_deuces_are_wild.mp3',6),(147,13,'Dude (Looks Like a Lady)','music/aerosmith_-_big_ones/aerosmith_-_dude_(looks_like_a_lady).mp3',7),(148,13,'Eat the Rich','music/aerosmith_-_big_ones/aerosmith_-_eat_the_rich.mp3',8),(149,13,'Janie\'s Got a Gun','music/aerosmith_-_big_ones/aerosmith_-_janie\'s_got_a_gun.mp3',9),(150,13,'Livin\' on the Edge','music/aerosmith_-_big_ones/aerosmith_-_livin\'_on_the_edge.mp3',10),(151,13,'Love in an Elevator','music/aerosmith_-_big_ones/aerosmith_-_love_in_an_elevator.mp3',11),(152,13,'Rag Doll','music/aerosmith_-_big_ones/aerosmith_-_rag_doll.mp3',12),(153,13,'The Other Side','music/aerosmith_-_big_ones/aerosmith_-_the_other_side.mp3',13),(154,13,'Walk on Water','music/aerosmith_-_big_ones/aerosmith_-_walk_on_water.mp3',14),(155,13,'What It Takes','music/aerosmith_-_big_ones/aerosmith_-_what_it_takes.mp3',15),(156,14,'Angel','music/the_coors_-_borrowed_heaven/the_corrs_-_angel.mp3',1),(157,14,'Baby Be Brave','music/the_coors_-_borrowed_heaven/the_corrs_-_baby_be_brave.mp3',2),(158,14,'Borrowed Heaven','music/the_coors_-_borrowed_heaven/the_corrs_-_borrowed_heaven.mp3',3),(159,14,'Confidence for Quiet','music/the_coors_-_borrowed_heaven/the_corrs_-_confidence_for_quiet.mp3',4),(160,14,'Even If','music/the_coors_-_borrowed_heaven/the_corrs_-_even_if.mp3',5),(161,14,'Goodbye','music/the_coors_-_borrowed_heaven/the_corrs_-_goodbye.mp3',6),(162,14,'Hideaway','music/the_coors_-_borrowed_heaven/the_corrs_-_hideaway.mp3',7),(163,14,'Humdrum','music/the_coors_-_borrowed_heaven/the_corrs_-_humdrum.mp3',8),(164,14,'Long Night','music/the_coors_-_borrowed_heaven/the_corrs_-_long_night.mp3',9),(165,14,'Silver Strand','music/the_coors_-_borrowed_heaven/the_corrs_-_silver_strand.mp3',10),(166,14,'Summer Sunshine','music/the_coors_-_borrowed_heaven/the_corrs_-_summer_sunshine.mp3',11),(167,14,'Time Enough for Tears','music/the_coors_-_borrowed_heaven/the_corrs_-_time_enough_for_tears.mp3',12),(168,15,'Lost and Found','music/brooks_and_dunn_-_greatest_hits/brooks_and_dunn_-_lost_and_found.mp3',1),(169,15,'Mama Don\'t Get Dressed Up for Nothing','music/brooks_and_dunn_-_greatest_hits/brooks_and_dunn_-_mama_don\'t_get_dressed_up_for_nothing.mp3',2),(170,15,'My Next Broken Heart','music/brooks_and_dunn_-_greatest_hits/brooks_and_dunn_-_my_next_broken_heart.mp3',3),(171,15,'Neon Moon','music/brooks_and_dunn_-_greatest_hits/brooks_and_dunn_-_neon_moon.mp3',4),(172,15,'She Used to Be Mine','music/brooks_and_dunn_-_greatest_hits/brooks_and_dunn_-_she_used_to_be_mine.mp3',5),(173,15,'That Ain\'t No Way to Go','music/brooks_and_dunn_-_greatest_hits/brooks_and_dunn_-_that_ain\'t_no_way_to_go.mp3',6),(174,15,'We\'ll Burn That Bridge','music/brooks_and_dunn_-_greatest_hits/brooks_and_dunn_-_we\'ll_burn_that_bridge.mp3',7),(175,15,'Whiskey Under the Bridge','music/brooks_and_dunn_-_greatest_hits/brooks_and_dunn_-_whiskey_under_the_bridge.mp3',8),(176,15,'You\'re Gonna Miss Me When I\'m Gone','music/brooks_and_dunn_-_greatest_hits/brooks_and_dunn_-_you\'re_gonna_miss_me_when_i\'m_gone.mp3',9),(177,36,'Banana Republics','music/jimmy_buffett_-_changes_in_latitudes_changes_in_attitudes/banana_republics.mp3',1),(178,36,'Biloxi','music/jimmy_buffett_-_changes_in_latitudes_changes_in_attitudes/biloxi.mp3',2),(179,36,'\"Changes In Latitudes, Changes In Attitudes\"','\"music/jimmy_buffett_-_changes_in_latitudes_changes_in_attitudes/changes_in_latitudes,_changes_in_attitudes.mp3\"',3),(180,36,'In The Shelter','music/jimmy_buffett_-_changes_in_latitudes_changes_in_attitudes/in_the_shelter.mp3',4),(181,36,'Landfall','music/jimmy_buffett_-_changes_in_latitudes_changes_in_attitudes/landfall.mp3',5),(182,36,'Lovely Cruise','music/jimmy_buffett_-_changes_in_latitudes_changes_in_attitudes/lovely_cruise.mp3',6),(183,36,'Margaritaville','music/jimmy_buffett_-_changes_in_latitudes_changes_in_attitudes/margaritaville.mp3',7),(184,36,'Miss You So Badly','music/jimmy_buffett_-_changes_in_latitudes_changes_in_attitudes/miss_you_so_badly.mp3',8),(185,36,'Tampico Trauma','music/jimmy_buffett_-_changes_in_latitudes_changes_in_attitudes/tampico_trauma.mp3',9),(186,36,'Wonder Why We Ever Go Home','music/jimmy_buffett_-_changes_in_latitudes_changes_in_attitudes/wonder_why_we_ever_go_home.mp3',10),(187,17,'Amandote','music/thalia_-_en_extasis/thalía_-_amandote.mp3',1),(188,17,'Fantasia','music/thalia_-_en_extasis/thalía_-_fantasia.mp3',2),(189,17,'Gracias a Dios','music/thalia_-_en_extasis/thalía_-_gracias_a_dios.mp3',3),(190,17,'Juana','music/thalia_-_en_extasis/thalía_-_juana.mp3',4),(191,17,'Lagrimas','music/thalia_-_en_extasis/thalía_-_lagrimas.mp3',5),(192,17,'Llevame Contigo','music/thalia_-_en_extasis/thalía_-_llevame_contigo.mp3',6),(193,17,'Maria la del Barrio','music/thalia_-_en_extasis/thalía_-_maria_la_del_barrio.mp3',7),(194,17,'Me Erotizas','music/thalia_-_en_extasis/thalía_-_me_erotizas.mp3',8),(195,17,'Me Faltas Tu','music/thalia_-_en_extasis/thalía_-_me_faltas_tu.mp3',9),(196,17,'Piel Morena [Remix]','music/thalia_-_en_extasis/thalía_-_piel_morena_[remix].mp3',10),(197,17,'Piel Morena','music/thalia_-_en_extasis/thalía_-_piel_morena.mp3',11),(198,17,'Quiero Hacerte el Amor','music/thalia_-_en_extasis/thalía_-_quiero_hacerte_el_amor.mp3',12),(199,17,'Te Deje la Puerta Abierta','music/thalia_-_en_extasis/thalía_-_te_deje_la_puerta_abierta.mp3',13),(200,17,'Te Quiero Tanto','music/thalia_-_en_extasis/thalía_-_te_quiero_tanto.mp3',14),(201,18,'Amazing','music/aerosmith_-_get_a_grip/aerosmith_-_amazing.mp3',1),(202,18,'Boogie Man','music/aerosmith_-_get_a_grip/aerosmith_-_boogie_man.mp3',2),(203,18,'Crazy','music/aerosmith_-_get_a_grip/aerosmith_-_crazy.mp3',3),(204,18,'Cryin\'','music/aerosmith_-_get_a_grip/aerosmith_-_cryin\'.mp3',4),(205,18,'Eat the Rich','music/aerosmith_-_get_a_grip/aerosmith_-_eat_the_rich.mp3',5),(206,18,'Fever','music/aerosmith_-_get_a_grip/aerosmith_-_fever.mp3',6),(207,18,'Flesh','music/aerosmith_-_get_a_grip/aerosmith_-_flesh.mp3',7),(208,18,'Get a Grip','music/aerosmith_-_get_a_grip/aerosmith_-_get_a_grip.mp3',8),(209,18,'Gotta Love It','music/aerosmith_-_get_a_grip/aerosmith_-_gotta_love_it.mp3',9),(210,18,'Intro','music/aerosmith_-_get_a_grip/aerosmith_-_intro.mp3',10),(211,18,'Line Up','music/aerosmith_-_get_a_grip/aerosmith_-_line_up.mp3',11),(212,18,'Livin\' on the Edge','music/aerosmith_-_get_a_grip/aerosmith_-_livin\'_on_the_edge.mp3',12),(213,18,'Shut Up and Dance','music/aerosmith_-_get_a_grip/aerosmith_-_shut_up_and_dance.mp3',13),(214,18,'Walk on Down','music/aerosmith_-_get_a_grip/aerosmith_-_walk_on_down.mp3',14),(215,19,'Can I Sit Next to You Girl','music/ac-dc_-_high_voltage/ac-dc_-_can_i_sit_next_to_you_girl.mp3',1),(216,19,'High Voltage','music/ac-dc_-_high_voltage/ac-dc_-_high_voltage.mp3',2),(217,19,'It\'s a Long Way to the Top (If You Wanna Rock & Roll','music/ac-dc_-_high_voltage/ac-dc_-_it\'s_a_long_way_to_the_top_(if_you_wanna_rock_&_roll.mp3',3),(218,19,'Little Lover','music/ac-dc_-_high_voltage/ac-dc_-_little_lover.mp3',4),(219,19,'Live Wire','music/ac-dc_-_high_voltage/ac-dc_-_live_wire.mp3',5),(220,19,'Rock & Roll Singer','music/ac-dc_-_high_voltage/ac-dc_-_rock_&_roll_singer.mp3',6),(221,19,'She\'s Got Balls','music/ac-dc_-_high_voltage/ac-dc_-_she\'s_got_balls.mp3',7),(222,19,'T.N.T.','music/ac-dc_-_high_voltage/ac-dc_-_t.n.t..mp3',8),(223,19,'The Jack','music/ac-dc_-_high_voltage/ac-dc_-_the_jack.mp3',9),(224,20,'Girls Got Rhythm','music/ac-dc_-_highway_to_hell/ac-dc_-___girls_got_rhythm.mp3',1),(225,20,'Shot Down in Flames','music/ac-dc_-_highway_to_hell/ac-dc_-___shot_down_in_flames.mp3',2),(226,20,'Beating Around the Bush','music/ac-dc_-_highway_to_hell/ac-dc_-__beating_around_the_bush.mp3',3),(227,20,'Get It Hot','music/ac-dc_-_highway_to_hell/ac-dc_-__get_it_hot.mp3',4),(228,20,'Highway to Hell','music/ac-dc_-_highway_to_hell/ac-dc_-_highway_to_hell.mp3',5),(229,20,'If You Want Blood (You\'ve Got It)','music/ac-dc_-_highway_to_hell/ac-dc_-_if_you_want_blood_(you\'ve_got_it).mp3',6),(230,20,'Love Hungry Man','music/ac-dc_-_highway_to_hell/ac-dc_-_love_hungry_man.mp3',7),(231,20,'Night Prowler','music/ac-dc_-_highway_to_hell/ac-dc_-_night_prowler.mp3',8),(232,20,'Touch Too Much','music/ac-dc_-_highway_to_hell/ac-dc_-_touch_too_much.mp3',9),(233,20,'Walk All over You','music/ac-dc_-_highway_to_hell/ac-dc_-_walk_all_over_you.mp3',10),(234,21,'A Foggy Day (In London Town)','music/michael_buble_-_its_time/a_foggy_day_(in_london_town).mp3',1),(235,21,'A Song For You','music/michael_buble_-_its_time/a_song_for_you.mp3',2),(236,21,'Can\'t Buy Me Love','music/michael_buble_-_its_time/can\'t_buy_me_love.mp3',3),(237,21,'Feeling Good','music/michael_buble_-_its_time/feeling_good.mp3',4),(238,21,'Home','music/michael_buble_-_its_time/home.mp3',5),(239,21,'How Sweet It Is','music/michael_buble_-_its_time/how_sweet_it_is.mp3',6),(240,21,'I\'ve Got You Under My Skin','music/michael_buble_-_its_time/i\'ve_got_you_under_my_skin.mp3',7),(241,21,'Quando Quando Quando','music/michael_buble_-_its_time/quando_quando_quando.mp3',8),(242,21,'Save The Last Dance For Me','music/michael_buble_-_its_time/save_the_last_dance_for_me.mp3',9),(243,21,'The More I See You','music/michael_buble_-_its_time/the_more_i_see_you.mp3',10),(244,21,'Try A Little Tenderness','music/michael_buble_-_its_time/try_a_little_tenderness.mp3',11),(245,21,'You And I','music/michael_buble_-_its_time/you_and_i.mp3',12),(246,21,'You Don\'t Know Me','music/michael_buble_-_its_time/you_don\'t_know_me.mp3',13),(247,22,'Go Down','music/ac-dc_-_let_there_be_rock/ac-dc_-__go_down.mp3',1),(248,22,'Let There Be Rock','music/ac-dc_-_let_there_be_rock/ac-dc_-__let_there_be_rock.mp3',2),(249,22,'Whole Lotta Rosie','music/ac-dc_-_let_there_be_rock/ac-dc_-__whole_lotta_rosie.mp3',3),(250,22,'Bad Boy Boogie','music/ac-dc_-_let_there_be_rock/ac-dc_-_bad_boy_boogie.mp3',4),(251,22,'Dog Eat Dog','music/ac-dc_-_let_there_be_rock/ac-dc_-_dog_eat_dog.mp3',5),(252,22,'Hell Ain\'t a Bad Place to Be','music/ac-dc_-_let_there_be_rock/ac-dc_-_hell_ain\'t_a_bad_place_to_be.mp3',6),(253,22,'Overdose','music/ac-dc_-_let_there_be_rock/ac-dc_-_overdose.mp3',7),(254,22,'Problem Child','music/ac-dc_-_let_there_be_rock/ac-dc_-_problem_child.mp3',8),(255,23,'Baby Please Set a Date','music/george_thorogood_-_move_it_on_over/george_thorogood_&_the_destroyers_-_baby_please_set_a_date.mp3',1),(256,23,'Cocaine Blues','music/george_thorogood_-_move_it_on_over/george_thorogood_&_the_destroyers_-_cocaine_blues.mp3',2),(257,23,'I\'m Just Your Good Thing','music/george_thorogood_-_move_it_on_over/george_thorogood_&_the_destroyers_-_i\'m_just_your_good_thing.mp3',3),(258,23,'It Wasn\'t Me','music/george_thorogood_-_move_it_on_over/george_thorogood_&_the_destroyers_-_it_wasn\'t_me.mp3',4),(259,23,'New Hawaiian Boogie','music/george_thorogood_-_move_it_on_over/george_thorogood_&_the_destroyers_-_new_hawaiian_boogie.mp3',5),(260,23,'So Much Trouble','music/george_thorogood_-_move_it_on_over/george_thorogood_&_the_destroyers_-_so_much_trouble.mp3',6),(261,23,'That Same Thing','music/george_thorogood_-_move_it_on_over/george_thorogood_&_the_destroyers_-_that_same_thing.mp3',7),(262,23,'The Sky Is Crying','music/george_thorogood_-_move_it_on_over/george_thorogood_&_the_destroyers_-_the_sky_is_crying.mp3',8),(263,23,'Move It on Over','music/george_thorogood_-_move_it_on_over/george_thorogood_-_move_it_on_over.mp3',9),(264,23,'Who Do You Love-','music/george_thorogood_-_move_it_on_over/george_thorogood_-_who_do_you_love-.mp3',10),(265,25,'It\'s Anybody\'s Spring','music/seth_macfarlane_-_music_is_better_than_words/01_-_it\'s_anybody\'s_spring.mp3',1),(266,25,'Music Is Better Than Words','music/seth_macfarlane_-_music_is_better_than_words/02_-_music_is_better_than_words.mp3',2),(267,25,'\"Anytime, Anywhere\"','\"music/seth_macfarlane_-_music_is_better_than_words/03_-_anytime,_anywhere.mp3\"',3),(268,25,'The Night They Invented Champagne','music/seth_macfarlane_-_music_is_better_than_words/04_-_the_night_they_invented_champagne.mp3',4),(269,25,'Two Sleepy People','music/seth_macfarlane_-_music_is_better_than_words/05_-_two_sleepy_people.mp3',5),(270,25,'You\'re The Cream In My Coffee','music/seth_macfarlane_-_music_is_better_than_words/06_-_you\'re_the_cream_in_my_coffee.mp3',6),(271,25,'Something Good','music/seth_macfarlane_-_music_is_better_than_words/07_-_something_good.mp3',7),(272,25,'Nine O\'Clock','music/seth_macfarlane_-_music_is_better_than_words/08_-_nine_o\'clock.mp3',8),(273,25,'Love Won\'t Let You Get Away','music/seth_macfarlane_-_music_is_better_than_words/09_-_love_won\'t_let_you_get_away.mp3',9),(274,25,'It\'s Easy To Remember','music/seth_macfarlane_-_music_is_better_than_words/10_-_it\'s_easy_to_remember.mp3',10),(275,25,'The Sadder But Wiser Girl','music/seth_macfarlane_-_music_is_better_than_words/11_-_the_sadder_but_wiser_girl.mp3',11),(276,25,'Laura','music/seth_macfarlane_-_music_is_better_than_words/12_-_laura.mp3',12),(277,25,'You And I','music/seth_macfarlane_-_music_is_better_than_words/13_-_you_and_i.mp3',13),(278,25,'She\'s Wonderful Too','music/seth_macfarlane_-_music_is_better_than_words/14_-_she\'s_wonderful_too.mp3',14),(279,25,'Let\'s Fall in Love (feat_ Seth MacFarlane)','music/seth_macfarlane_-_music_is_better_than_words/let\'s_fall_in_love_(feat__seth_macfarlane).mp3',15),(280,25,'We Saw Your Boobs','music/seth_macfarlane_-_music_is_better_than_words/we_saw_your_boobs.mp3',16),(281,24,'Feels so good','music/van_halen_-_ou812/van_halen_-__feels_so_good.mp3',1),(282,24,'When its love','music/van_halen_-_ou812/van_halen_-__when_its_love.mp3',2),(283,24,'A Apolitical blues','music/van_halen_-_ou812/van_halen_-_a_apolitical_blues.mp3',3),(284,24,'Black and Blue','music/van_halen_-_ou812/van_halen_-_black_and_blue.mp3',4),(285,24,'Cabo Wabo','music/van_halen_-_ou812/van_halen_-_cabo_wabo.mp3',5),(286,24,'Finish What You Started','music/van_halen_-_ou812/van_halen_-_finish_what_you_started.mp3',6),(287,24,'Source of infection','music/van_halen_-_ou812/van_halen_-_source_of_infection.mp3',7),(288,24,'Sucker in a piece','music/van_halen_-_ou812/van_halen_-_sucker_in_a_piece.mp3',8),(289,26,'Ring of Fire','music/social_distortion_-_social_distortion/social_distortion_-__ring_of_fire.mp3',1),(290,26,'A Place in My Heart','music/social_distortion_-_social_distortion/social_distortion_-_a_place_in_my_heart.mp3',2),(291,26,'Ball and Chain','music/social_distortion_-_social_distortion/social_distortion_-_ball_and_chain.mp3',3),(292,26,'Drug Train','music/social_distortion_-_social_distortion/social_distortion_-_drug_train.mp3',4),(293,26,'It Coulda Been Me','music/social_distortion_-_social_distortion/social_distortion_-_it_coulda_been_me.mp3',5),(294,26,'Let It Be Me','music/social_distortion_-_social_distortion/social_distortion_-_let_it_be_me.mp3',6),(295,26,'She\'s a Knockout','music/social_distortion_-_social_distortion/social_distortion_-_she\'s_a_knockout.mp3',7),(296,26,'Sick Boys','music/social_distortion_-_social_distortion/social_distortion_-_sick_boys.mp3',8),(297,26,'So Far Away','music/social_distortion_-_social_distortion/social_distortion_-_so_far_away.mp3',9),(298,26,'Story of My Life','music/social_distortion_-_social_distortion/social_distortion_-_story_of_my_life.mp3',10),(299,27,'When She Begins','music/social_distortion_-_somewhere_between_heaven_and_hell/social_distortion_-____when_she_begins.mp3',1),(300,27,'King of Fools','music/social_distortion_-_somewhere_between_heaven_and_hell/social_distortion_-___king_of_fools.mp3',2),(301,27,'Making Believe','music/social_distortion_-_somewhere_between_heaven_and_hell/social_distortion_-___making_believe.mp3',3),(302,27,'Sometimes I Do','music/social_distortion_-_somewhere_between_heaven_and_hell/social_distortion_-___sometimes_i_do.mp3',4),(303,27,'Bad Luck','music/social_distortion_-_somewhere_between_heaven_and_hell/social_distortion_-__bad_luck.mp3',5),(304,27,'Born to Lose','music/social_distortion_-_somewhere_between_heaven_and_hell/social_distortion_-__born_to_lose.mp3',6),(305,27,'This Time Darlin\'','music/social_distortion_-_somewhere_between_heaven_and_hell/social_distortion_-__this_time_darlin\'.mp3',7),(306,27,'Bye Bye Baby','music/social_distortion_-_somewhere_between_heaven_and_hell/social_distortion_-_bye_bye_baby.mp3',8),(307,27,'Cold Feelings','music/social_distortion_-_somewhere_between_heaven_and_hell/social_distortion_-_cold_feelings.mp3',9),(308,27,'Ghost Town Blues','music/social_distortion_-_somewhere_between_heaven_and_hell/social_distortion_-_ghost_town_blues.mp3',10),(309,27,'Ninety-Nine to Life','music/social_distortion_-_somewhere_between_heaven_and_hell/social_distortion_-_ninety-nine_to_life.mp3',11),(310,28,'Tell Me About It','music/tanya_tucker_-_cant_run_from_yourself/delbert_mcclinton_-_tanya_tucker_-_tell_me_about_it.mp3',1),(311,28,'Can\'t Run from Yourself','music/tanya_tucker_-_cant_run_from_yourself/tanya_tucker_-_can\'t_run_from_yourself.mp3',2),(312,28,'Danger Ahead','music/tanya_tucker_-_cant_run_from_yourself/tanya_tucker_-_danger_ahead.mp3',3),(313,28,'Don\'t Let My Heart Be the Last to Know','music/tanya_tucker_-_cant_run_from_yourself/tanya_tucker_-_don\'t_let_my_heart_be_the_last_to_know.mp3',4),(314,28,'I\'ve Learned to Live','music/tanya_tucker_-_cant_run_from_yourself/tanya_tucker_-_i\'ve_learned_to_live.mp3',5),(315,28,'It\'s a Little Too Late','music/tanya_tucker_-_cant_run_from_yourself/tanya_tucker_-_it\'s_a_little_too_late.mp3',6),(316,28,'Rainbow Rider','music/tanya_tucker_-_cant_run_from_yourself/tanya_tucker_-_rainbow_rider.mp3',7),(317,28,'Two Sparrows in a Hurricane','music/tanya_tucker_-_cant_run_from_yourself/tanya_tucker_-_two_sparrows_in_a_hurricane.mp3',8),(318,28,'Half The Moon','\"music/tanya_tucker_-_cant_run_from_yourself/tucker,_tanya_-_half_the_moon.mp3\"',9),(319,28,'What Do They Know','\"music/tanya_tucker_-_cant_run_from_yourself/tucker,_tanya_-_what_do_they_know.mp3\"',10),(320,29,' Kryptonite','music/3_doors_down_-_the_better_life/3_doors_down_-__kryptonite.mp3',1),(321,29,'Be Like That','music/3_doors_down_-_the_better_life/3_doors_down_-_be_like_that.mp3',2),(322,29,'Better Life','music/3_doors_down_-_the_better_life/3_doors_down_-_better_life.mp3',3),(323,29,'By My Side','music/3_doors_down_-_the_better_life/3_doors_down_-_by_my_side.mp3',4),(324,29,'Down Poison','music/3_doors_down_-_the_better_life/3_doors_down_-_down_poison.mp3',5),(325,29,'Duck and Run','music/3_doors_down_-_the_better_life/3_doors_down_-_duck_and_run.mp3',6),(326,29,'Life of My Own','music/3_doors_down_-_the_better_life/3_doors_down_-_life_of_my_own.mp3',7),(327,29,'Loser','music/3_doors_down_-_the_better_life/3_doors_down_-_loser.mp3',8),(328,29,'Not Enough','music/3_doors_down_-_the_better_life/3_doors_down_-_not_enough.mp3',9),(329,29,'Smack','music/3_doors_down_-_the_better_life/3_doors_down_-_smack.mp3',10),(330,29,'So I Need You','music/3_doors_down_-_the_better_life/3_doors_down_-_so_i_need_you.mp3',11),(331,32,'Back off Bitch','music/guns_n_roses_-_use_your_illusion_i/guns_n\'_roses_-_back_off_bitch.mp3',1),(332,32,'Bad Apples','music/guns_n_roses_-_use_your_illusion_i/guns_n\'_roses_-_bad_apples.mp3',2),(333,32,'Bad Obsession','music/guns_n_roses_-_use_your_illusion_i/guns_n\'_roses_-_bad_obsession.mp3',3),(334,32,'Coma','music/guns_n_roses_-_use_your_illusion_i/guns_n\'_roses_-_coma.mp3',4),(335,32,'Dead Horse','music/guns_n_roses_-_use_your_illusion_i/guns_n\'_roses_-_dead_horse.mp3',5),(336,32,'Don\'t Cry [Original Version]','music/guns_n_roses_-_use_your_illusion_i/guns_n\'_roses_-_don\'t_cry_[original_version].mp3',6),(337,32,'Don\'t Damn Me','music/guns_n_roses_-_use_your_illusion_i/guns_n\'_roses_-_don\'t_damn_me.mp3',7),(338,32,'Double Talkin\' Jive','music/guns_n_roses_-_use_your_illusion_i/guns_n\'_roses_-_double_talkin\'_jive.mp3',8),(339,32,'Dust N\' Bones','music/guns_n_roses_-_use_your_illusion_i/guns_n\'_roses_-_dust_n\'_bones.mp3',9),(340,32,'Garden of Eden','music/guns_n_roses_-_use_your_illusion_i/guns_n\'_roses_-_garden_of_eden.mp3',10),(341,32,'Live and Let Die','music/guns_n_roses_-_use_your_illusion_i/guns_n\'_roses_-_live_and_let_die.mp3',11),(342,32,'November Rain','music/guns_n_roses_-_use_your_illusion_i/guns_n\'_roses_-_november_rain.mp3',12),(343,32,'Perfect Crime','music/guns_n_roses_-_use_your_illusion_i/guns_n\'_roses_-_perfect_crime.mp3',13),(344,32,'Right Next Door to Hell','music/guns_n_roses_-_use_your_illusion_i/guns_n\'_roses_-_right_next_door_to_hell.mp3',14),(345,32,'The Garden','music/guns_n_roses_-_use_your_illusion_i/guns_n\'_roses_-_the_garden.mp3',15),(346,32,'You Ain\'t the First','music/guns_n_roses_-_use_your_illusion_i/guns_n\'_roses_-_you_ain\'t_the_first.mp3',16),(347,33,'14 Years','music/guns_n_roses_-_use_your_illusion_ii/guns_n\'_roses_-_14_years.mp3',1),(348,33,'Breakdown','music/guns_n_roses_-_use_your_illusion_ii/guns_n\'_roses_-_breakdown.mp3',2),(349,33,'Civil War','music/guns_n_roses_-_use_your_illusion_ii/guns_n\'_roses_-_civil_war.mp3',3),(350,33,'Don\'t Cry [Alternate Lyrics]','music/guns_n_roses_-_use_your_illusion_ii/guns_n\'_roses_-_don\'t_cry_[alternate_lyrics].mp3',4),(351,33,'Estranged','music/guns_n_roses_-_use_your_illusion_ii/guns_n\'_roses_-_estranged.mp3',5),(352,33,'Get in the Ring','music/guns_n_roses_-_use_your_illusion_ii/guns_n\'_roses_-_get_in_the_ring.mp3',6),(353,33,'Knockin\' on Heaven\'s Door','music/guns_n_roses_-_use_your_illusion_ii/guns_n\'_roses_-_knockin\'_on_heaven\'s_door.mp3',7),(354,33,'Locomotive (Complicity)','music/guns_n_roses_-_use_your_illusion_ii/guns_n\'_roses_-_locomotive_(complicity).mp3',8),(355,33,'My World','music/guns_n_roses_-_use_your_illusion_ii/guns_n\'_roses_-_my_world.mp3',9),(356,33,'Pretty Tied Up (The Perils of Rock & Roll De','music/guns_n_roses_-_use_your_illusion_ii/guns_n\'_roses_-_pretty_tied_up_(the_perils_of_rock_&_roll_de.mp3',10),(357,33,'Shotgun Blues','music/guns_n_roses_-_use_your_illusion_ii/guns_n\'_roses_-_shotgun_blues.mp3',11),(358,33,'So Fine','music/guns_n_roses_-_use_your_illusion_ii/guns_n\'_roses_-_so_fine.mp3',12),(359,33,'Yesterdays','music/guns_n_roses_-_use_your_illusion_ii/guns_n\'_roses_-_yesterdays.mp3',13),(360,33,'You Could Be Mine','music/guns_n_roses_-_use_your_illusion_ii/guns_n\'_roses_-_you_could_be_mine.mp3',14),(361,34,'Only Love Can Break Your Heart','music/the_coors_-_live_in_dublin/the_corrs_-__only_love_can_break_your_heart.mp3',1),(362,34,'So Young','music/the_coors_-_live_in_dublin/the_corrs_-__so_young.mp3',2),(363,34,'Would You Be Happier-','music/the_coors_-_live_in_dublin/the_corrs_-__would_you_be_happier-.mp3',3),(364,34,'Bono - When the Stars Go Blue','music/the_coors_-_live_in_dublin/the_corrs_-_bono_-_when_the_stars_go_blue.mp3',4),(365,34,'Breathless','music/the_coors_-_live_in_dublin/the_corrs_-_breathless.mp3',5),(366,34,'Joy of Life-Trout in the Bath','music/the_coors_-_live_in_dublin/the_corrs_-_joy_of_life-trout_in_the_bath.mp3',6),(367,34,'Radio','music/the_coors_-_live_in_dublin/the_corrs_-_radio.mp3',7),(368,34,'Ron Wood - Little Wing','music/the_coors_-_live_in_dublin/the_corrs_-_ron_wood_-_little_wing.mp3',8),(369,34,'Ron Wood - Ruby Tuesday','music/the_coors_-_live_in_dublin/the_corrs_-_ron_wood_-_ruby_tuesday.mp3',9),(370,34,'Runaway','music/the_coors_-_live_in_dublin/the_corrs_-_runaway.mp3',10),(371,34,'Bono - Summer Wine','music/the_coors_-_live_in_dublin/zthe_corrs_-_bono_-_summer_wine.mp3',11),(372,35,'D.T.','music/ac-dc_-_who_made_who/ac-dc_-_d.t..mp3',1),(373,35,'For Those About to Rock (We Salute You)','music/ac-dc_-_who_made_who/ac-dc_-_for_those_about_to_rock_(we_salute_you).mp3',2),(374,35,'Hells Bells','music/ac-dc_-_who_made_who/ac-dc_-_hells_bells.mp3',3),(375,35,'Ride On','music/ac-dc_-_who_made_who/ac-dc_-_ride_on.mp3',4),(376,35,'Shake Your Foundations','music/ac-dc_-_who_made_who/ac-dc_-_shake_your_foundations.mp3',5),(377,35,'Sink the Pink','music/ac-dc_-_who_made_who/ac-dc_-_sink_the_pink.mp3',6),(378,35,'Who Made Who','music/ac-dc_-_who_made_who/ac-dc_-_who_made_who.mp3',7),(379,35,'You Shook Me All Night Long','music/ac-dc_-_who_made_who/ac-dc_-_you_shook_me_all_night_long.mp3',8),(380,35,'Chase the Ace','music/ac-dc_-_who_made_who/ac-dc_-chase_the_ace.mp3',9);
/*!40000 ALTER TABLE `songs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_addresses`
--

DROP TABLE IF EXISTS `user_addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_addresses` (
  `address_id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL,
  `bill_to` varchar(1) NOT NULL,
  `ship_to` varchar(1) DEFAULT NULL,
  `line1` varchar(45) NOT NULL,
  `line2` varchar(45) DEFAULT NULL,
  `city` varchar(45) NOT NULL,
  `state` varchar(2) NOT NULL,
  `zip5` int(5) NOT NULL,
  PRIMARY KEY (`address_id`),
  KEY `Customer_Address_idx` (`user_id`),
  CONSTRAINT `Customer_Address` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_addresses`
--

LOCK TABLES `user_addresses` WRITE;
/*!40000 ALTER TABLE `user_addresses` DISABLE KEYS */;
INSERT INTO `user_addresses` VALUES (1,1,'y','y','1234 Cherry Street',NULL,'Fairfax','VA',22032),(2,2,'y','y','19 Williams St',NULL,'Clinton','NY',13323),(3,3,'y','y','123 main',NULL,'asdf','VA',20194),(4,4,'y','y','1234 Cherry Street',NULL,'Reston','VA',22314);
/*!40000 ALTER TABLE `user_addresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `user_id` int(10) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) NOT NULL,
  `password` char(40) NOT NULL,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `middle_initial` varchar(1) DEFAULT NULL,
  `email_address` varchar(255) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'cren','pw','Cheng','Ren','','cheng.q.ren@gmail.com'),(2,'test','test','Jonathan','Sage','C','jsage8@gmail.com'),(3,'iserman','iserman','Mike','Iserman','','iserman53@yahoo.com'),(4,'Happy','newpassword','Happy','Gilmore','G','cheng.q.ren@gmail.com');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-09-19  1:09:44
