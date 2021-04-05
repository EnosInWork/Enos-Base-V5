INSERT INTO `addon_account` (name, label, shared) VALUES 
	('society_mafia','mafia',1)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
	('society_mafia','mafia',1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES 
	('society_mafia', 'mafia', 1)
;

INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
('mafia', 'Mafia', 1);

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
('mafia', 0, 'soldato', 'Dealer', 200, 'null', 'null'),
('mafia', 1, 'capo', 'Braqueur', 400, 'null', 'null'),
('mafia', 2, 'consigliere', 'Bandit', 600, 'null', 'null'),
('mafia', 3, 'boss', 'Chef', 1000, 'null', 'null');