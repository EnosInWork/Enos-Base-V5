CREATE TABLE `avaible_boat` (
  `id` int(11) NOT NULL,
  `model` varchar(255) NOT NULL,
  `label` varchar(50) NOT NULL,
  `price` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `avaible_boat`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `avaible_boat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

-- Part 2

CREATE TABLE `owned_boat` (
  `id` int(11) NOT NULL,
  `license` varchar(255) NOT NULL,
  `model` varchar(255) NOT NULL,
  `props` text NOT NULL,
  `outside` int(11) NOT NULL DEFAULT '0',
  `ownedAt` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `owned_boat`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `owned_boat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;