-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Erstellungszeit: 03. Mrz 2020 um 13:10
-- Server-Version: 5.7.29
-- PHP-Version: 7.1.33-8+0~20200202.31+debian9~1.gbp266c28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `lakesideONSET`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `bans`
--

CREATE TABLE `bans` (
  `Admin` varchar(50) NOT NULL,
  `TargetSteamID` varchar(50) NOT NULL,
  `Reason` text NOT NULL,
  `Time` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `factiondepots`
--

CREATE TABLE `factiondepots` (
  `Faction` varchar(20) NOT NULL DEFAULT 'none',
  `Money` int(11) NOT NULL DEFAULT '0',
  `Weed` int(11) NOT NULL DEFAULT '0',
  `Mats` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Daten für Tabelle `factiondepots`
--

INSERT INTO `factiondepots` (`Faction`, `Money`, `Weed`, `Mats`) VALUES
('Ballas', 0, 0, 500),
('Mafia', 0, 0, 500),
('Police', 0, 0, 0);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `inventory`
--

CREATE TABLE `inventory` (
  `ID` int(11) NOT NULL,
  `SteamID` text NOT NULL,
  `Username` varchar(50) NOT NULL,
  `Burger` int(11) NOT NULL DEFAULT '0',
  `Donut` int(11) NOT NULL DEFAULT '0',
  `Cola` int(11) NOT NULL DEFAULT '0',
  `Sprite` int(11) NOT NULL DEFAULT '0',
  `Fuelcan` int(11) NOT NULL DEFAULT '0',
  `Repairkit` int(11) NOT NULL DEFAULT '0',
  `Armor` int(11) NOT NULL DEFAULT '0',
  `Weed` int(11) NOT NULL DEFAULT '0',
  `Mats` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `level`
--

CREATE TABLE `level` (
  `ID` int(11) NOT NULL,
  `SteamID` text NOT NULL,
  `Username` varchar(50) NOT NULL,
  `TruckLVL` int(11) NOT NULL DEFAULT '0',
  `TruckEXP` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `licenses`
--

CREATE TABLE `licenses` (
  `ID` int(11) NOT NULL,
  `SteamID` text NOT NULL,
  `Username` varchar(50) NOT NULL,
  `Gun` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `logs`
--

CREATE TABLE `logs` (
  `ID` int(11) NOT NULL,
  `Time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Action` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `userdata`
--

CREATE TABLE `userdata` (
  `ID` int(11) NOT NULL,
  `SteamID` text NOT NULL,
  `Username` varchar(50) NOT NULL,
  `Password` text NOT NULL,
  `Gender` varchar(10) NOT NULL,
  `Health` int(11) NOT NULL DEFAULT '100',
  `Armor` int(11) NOT NULL DEFAULT '0',
  `AdminLVL` int(11) NOT NULL DEFAULT '0',
  `Playtime` int(11) NOT NULL DEFAULT '0',
  `Money` int(11) NOT NULL DEFAULT '0',
  `Bankmoney` int(11) NOT NULL DEFAULT '0',
  `Jobmoney` int(11) NOT NULL DEFAULT '0',
  `Faction` varchar(14) NOT NULL DEFAULT 'Civilian',
  `Factionrank` int(11) NOT NULL DEFAULT '0',
  `hunger` int(11) NOT NULL DEFAULT '100',
  `thirst` int(11) NOT NULL DEFAULT '100',
  `spawnX` varchar(50) NOT NULL DEFAULT '115070',
  `spawnY` varchar(50) NOT NULL DEFAULT '164073',
  `spawnZ` varchar(50) NOT NULL DEFAULT '3029',
  `spawnROT` varchar(50) NOT NULL DEFAULT '90',
  `Clothing` int(11) NOT NULL DEFAULT '1',
  `Tutorial` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `vehicles`
--

CREATE TABLE `vehicles` (
  `ID` int(11) NOT NULL,
  `VehID` int(11) NOT NULL,
  `SteamID` text NOT NULL,
  `Owner` varchar(50) NOT NULL,
  `Slot` int(11) NOT NULL,
  `Fuel` int(11) NOT NULL DEFAULT '100',
  `Health` int(11) NOT NULL DEFAULT '3500',
  `spawnX` varchar(50) NOT NULL,
  `spawnY` varchar(50) NOT NULL,
  `spawnZ` varchar(50) NOT NULL,
  `spawnROT` varchar(50) NOT NULL,
  `Burger` int(11) NOT NULL DEFAULT '0',
  `Donut` int(11) NOT NULL DEFAULT '0',
  `Cola` int(11) NOT NULL DEFAULT '0',
  `Sprite` int(11) NOT NULL DEFAULT '0',
  `Fuelcan` int(11) NOT NULL DEFAULT '0',
  `Weed` int(11) NOT NULL DEFAULT '0',
  `Mats` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `whitelist`
--

CREATE TABLE `whitelist` (
  `SteamID` text NOT NULL,
  `Username` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `bans`
--
ALTER TABLE `bans`
  ADD PRIMARY KEY (`TargetSteamID`);

--
-- Indizes für die Tabelle `factiondepots`
--
ALTER TABLE `factiondepots`
  ADD PRIMARY KEY (`Faction`);

--
-- Indizes für die Tabelle `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`ID`);

--
-- Indizes für die Tabelle `level`
--
ALTER TABLE `level`
  ADD PRIMARY KEY (`ID`);

--
-- Indizes für die Tabelle `licenses`
--
ALTER TABLE `licenses`
  ADD PRIMARY KEY (`ID`);

--
-- Indizes für die Tabelle `logs`
--
ALTER TABLE `logs`
  ADD PRIMARY KEY (`ID`);

--
-- Indizes für die Tabelle `userdata`
--
ALTER TABLE `userdata`
  ADD PRIMARY KEY (`ID`);

--
-- Indizes für die Tabelle `vehicles`
--
ALTER TABLE `vehicles`
  ADD PRIMARY KEY (`ID`);

--
-- Indizes für die Tabelle `whitelist`
--
ALTER TABLE `whitelist`
  ADD PRIMARY KEY (`Username`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `inventory`
--
ALTER TABLE `inventory`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `level`
--
ALTER TABLE `level`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `licenses`
--
ALTER TABLE `licenses`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `logs`
--
ALTER TABLE `logs`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `userdata`
--
ALTER TABLE `userdata`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `vehicles`
--
ALTER TABLE `vehicles`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
