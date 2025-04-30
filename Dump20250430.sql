-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: decarton
-- ------------------------------------------------------
-- Server version	5.7.44-log

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
-- Table structure for table `carrito`
--

DROP TABLE IF EXISTS `carrito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `carrito` (
  `idcompra` int(11) NOT NULL AUTO_INCREMENT,
  `cantidad` int(11) NOT NULL,
  `descripccion` varchar(255) NOT NULL,
  `idUsuario` int(11) NOT NULL,
  `nombreProducto` varchar(255) NOT NULL,
  `precio` double NOT NULL,
  `productId` int(11) NOT NULL,
  PRIMARY KEY (`idcompra`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carrito`
--

LOCK TABLES `carrito` WRITE;
/*!40000 ALTER TABLE `carrito` DISABLE KEYS */;
INSERT INTO `carrito` VALUES (10,1,'Mochila con sistema de hidratación integrado.',1,'Mochila Hidratación Runner',29.99,7);
/*!40000 ALTER TABLE `carrito` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `descripccion` varchar(255) NOT NULL,
  `precio` double NOT NULL,
  `stock` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` VALUES (1,'Zapatillas Running X-Trail','Zapatillas ligeras para correr en asfalto.',49.99,49),(2,'Camiseta Running ProFit','Camiseta transpirable para correr.',19.99,91),(3,'Pantalón Corto Running Aero','Pantalón corto con cintura elástica.',24.99,58),(4,'Calcetines Running Elite','Calcetines técnicos para largas distancias.',9.99,99),(5,'Reloj GPS Running 3000','Reloj con GPS y monitor de ritmo cardíaco.',149.99,30),(6,'Chaqueta Impermeable RunPro','Chaqueta ligera para correr bajo la lluvia.',39.99,40),(7,'Mochila Hidratación Runner','Mochila con sistema de hidratación integrado.',29.99,25),(8,'Cinturón Portaobjetos Running','Cinturón ajustable para llevar objetos pequeños.',14.99,79),(9,'Bicicleta Montaña XC-500','Bicicleta de montaña con suspensión total.',249.99,15),(10,'Casco Ciclismo ProShield','Casco ligero y ventilado para ciclismo.',49.99,50),(11,'Guantes Ciclismo GripMax','Guantes con agarre antideslizante.',19.99,70),(12,'Luces LED Bicicleta','Juego de luces delanteras y traseras.',29.99,60),(13,'Portabidones Bicicleta','Soporte para bidón de agua.',9.99,100),(14,'Cadena Antirrobo Bici','Cadena resistente para asegurar tu bicicleta.',34.99,40),(15,'Ruedas MTB ProX','Ruedas ligeras para bicicletas de montaña.',99.99,20),(16,'Kit Reparación Cubiertas','Kit para reparar pinchazos en ruedas.',12.99,90),(17,'Banda Elástica Fitness','Banda elástica para ejercicios de fuerza.',7.99,120),(18,'Kettlebell 10kg','Pesas rusas para entrenamiento funcional.',29.99,35),(19,'Colchoneta Yoga EcoFlex','Colchoneta antideslizante para yoga.',19.99,80),(20,'Set Pesas Ajustables','Pesas ajustables hasta 20kg.',89.99,25),(21,'Rueda Abdominales ProCore','Rueda para ejercitar los abdominales.',14.99,60),(22,'Banco Musculación MultiGym','Banco multifuncional para entrenar en casa.',129.99,15),(23,'Gorra Fitness AeroCool','Gorra transpirable para entrenamientos intensos.',12.99,70),(24,'Rodilleras Fitness Protect','Rodilleras para proteger articulaciones.',24.99,40),(25,'Gafas Natación AquaPro','Gafas ajustables con protección UV.',14.99,90),(26,'Traje Baño Competición','Traje de baño ajustado para competiciones.',39.99,50),(27,'Aletas Natación SpeedWave','Aletas para mejorar la técnica de patada.',29.99,40),(28,'Tapones Oídos SwimSafe','Tapones de silicona para proteger los oídos.',5.99,150),(29,'Boya Flotación SwimPro','Boya para seguridad en aguas abiertas.',19.99,60),(30,'Gorro Natación Silicona','Gorro ajustable para reducir resistencia en el agua.',9.99,100),(31,'Tabla Natación FloatBoard','Tabla para mejorar brazadas en piscina.',12.99,80),(32,'Botella Agua Natación','Botella diseñada para usar en piscinas.',7.99,120),(33,'Mochila Trekking Summit','Mochila de 40L para senderismo.',59.99,30),(34,'Botas Montaña GTX','Botas impermeables para senderismo.',89.99,25),(35,'Tienda Campaña Compact','Tienda de campaña para dos personas.',79.99,20),(36,'Saco Dormir Térmico','Saco de dormir para temperaturas bajas.',49.99,35),(37,'Linterna Frontal NightHike','Linterna frontal recargable.',19.99,50),(38,'Bastones Trekking Aluminio','Bastones ajustables para senderismo.',29.99,40),(39,'Brújula Profesional','Brújula precisa para orientación.',14.99,60),(40,'Estufa Camping MiniFlame','Estufa portátil para cocinar al aire libre.',39.99,25),(41,'Balón Fútbol Premium','Balón oficial para partidos profesionales.',29.99,50),(42,'Espinilleras ProShield','Espinilleras ligeras y protectoras.',14.99,70),(43,'Red Portería Fútbol','Red resistente para porterías de fútbol.',24.99,30),(44,'Botas Fútbol Campo','Botas con tacos para césped natural.',59.99,25),(45,'Petos Entrenamiento','Petos para identificar equipos en entrenamientos.',9.99,100),(46,'Portería Plegable Mini','Portería plegable para uso recreativo.',39.99,15),(47,'Guantes Portero UltraGrip','Guantes con agarre excepcional.',29.99,40),(48,'Conos Entrenamiento','Conos para ejercicios de agilidad.',4.99,200),(49,'Balón Baloncesto ProCourt','Balón oficial para canchas interiores.',24.99,50),(50,'Aro Baloncesto Regulable','Aro ajustable para diferentes alturas.',49.99,20),(51,'Muñequeras Transpirables','Muñequeras para absorber el sudor.',9.99,80),(52,'Tabla Ejercicios Dribbling','Tabla para mejorar el dribbling.',19.99,30),(53,'Zapatillas Baloncesto JumpMax','Zapatillas con amortiguación reforzada.',69.99,15),(54,'Mochila Baloncesto SportPack','Mochila con compartimento para balón.',29.99,40),(55,'Rodilleras Baloncesto Protect','Rodilleras para evitar lesiones.',19.99,35),(56,'Bandas Elásticas Entrenamiento','Bandas para fortalecer piernas.',7.99,120),(57,'Raqueta Tenis PowerHit','Raqueta ligera para jugadores avanzados.',99.99,20),(58,'Pelota Tenis Duramax','Pelotas duraderas para entrenamiento.',12.99,100),(59,'Overgrip Absorbente','Overgrip para mejorar el agarre.',4.99,200),(60,'Mochila Tenis ProCarry','Mochila con compartimento para raqueta.',39.99,25),(61,'Muñequeras Tenis DryFit','Muñequeras para absorber el sudor.',9.99,80),(62,'Rodilleras Tenis Protect','Rodilleras para evitar lesiones.',19.99,35),(63,'Cordaje Raqueta Tenis','Cordaje profesional para raquetas.',14.99,60),(64,'Protector Cabeza Raqueta','Protector para evitar daños en la raqueta.',5.99,150),(65,'Balón Voleibol Arena','Balón diseñado para jugar en la arena.',19.99,40),(66,'Red Voleibol Profesional','Red resistente para partidos profesionales.',39.99,15),(67,'Balón Balonmano ProGrip','Balón con textura antideslizante.',24.99,50),(68,'Guantes Balonmano Protect','Guantes para proteger las manos.',14.99,60),(69,'Pelota Rugby Oval','Pelota oval para rugby.',29.99,30),(70,'Botas Rugby Campo','Botas con tacos para césped natural.',59.99,25),(71,'Casco Rugby SafePlay','Casco protector para jugadores de rugby.',39.99,20),(72,'Mochila Rugby SportPack','Mochila con compartimento para pelota.',29.99,39),(73,'Botella Agua Deportiva','Botella con boquilla ergonómica.',7.99,120),(74,'Toalla Deportiva Microfibra','Toalla absorbente para secarse rápido.',12.99,80),(75,'Cinta Resistente Velcro','Cinta para ajustar accesorios deportivos.',5.99,150),(76,'Reloj Deportivo Multifunción','Reloj con cronómetro y contador de pasos.',59.99,25),(77,'Pulsómetro CardioFit','Monitor de frecuencia cardíaca.',39.99,30),(78,'Bolsa Deporte Grande','Bolsa espaciosa para llevar equipamiento.',29.99,40),(79,'Calcetines Deporte Ajustados','Calcetines con soporte para el arco.',9.99,100),(80,'Cinturón Portaobjetos Deporte','Cinturón ajustable para llevar objetos pequeños.',14.99,80);
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `login_count` int(11) NOT NULL DEFAULT '0',
  `last_login` datetime DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_admin` tinyint(1) NOT NULL DEFAULT '0',
  `isAdmin` tinyint(1) NOT NULL DEFAULT '0',
  `lastLogin` datetime(6) DEFAULT NULL,
  `loginCount` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','admin',0,NULL,'2025-04-29 16:19:45','2025-04-29 16:19:45',0,0,NULL,0),(2,'hola','adios',0,NULL,'2025-04-29 16:21:18','2025-04-29 16:21:18',0,0,NULL,0),(3,'kok','kok',0,NULL,'2025-04-30 17:18:46','2025-04-30 17:18:46',0,0,NULL,0);
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

-- Dump completed on 2025-04-30 20:38:44
