INSERT INTO `addon_account` (name, label, shared) VALUES 
	('society_ammu','Armurerier',1)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
	('society_ammu','Armurerier',1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES 
	('society_ammu', 'Armurerier', 1)
;

INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
('ammu', 'Armurerier', 1);

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
('ammu', 0, 'soldato', 'Garde', 200, 'null', 'null'),
('ammu', 1, 'capo', 'Vendeur', 400, 'null', 'null'),
('ammu', 2, 'consigliere', 'Directeur', 600, 'null', 'null'),
('ammu', 3, 'boss', 'Patron', 1000, 'null', 'null');