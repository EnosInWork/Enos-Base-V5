INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_karting', 'Karting', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_karting', 'Karting', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('karting', 'Karting')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('karting',0,'recrue','Stagiaire',12,'{}','{}'),
	('karting',1,'novice','Employee',24,'{}','{}'),
	('karting',2,'experimente','Gérant piste',36,'{}','{}'),
	('karting',3,'chief','Manager',48,'{}','{}'),
	('karting',4,'boss','Boss',0,'{}','{}')
;
