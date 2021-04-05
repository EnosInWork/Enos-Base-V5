INSERT INTO `addon_account` (name, label, shared) VALUES 
	('society_ballas','ballas',1)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
	('society_ballas','ballas',1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES 
	('society_ballas', 'ballas', 1)
;

INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
('ballas', 'ballas', 1);

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
('ballas', 0, 'soldato', 'Dealer', 200, 'null', 'null'),
('ballas', 1, 'capo', 'Braqueur', 400, 'null', 'null'),
('ballas', 2, 'consigliere', 'Bandit', 600, 'null', 'null'),
('ballas', 3, 'boss', 'Chef du Gang', 1000, 'null', 'null');