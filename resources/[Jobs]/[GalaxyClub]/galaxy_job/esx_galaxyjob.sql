USE `essentialmode`;

INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_galaxy', 'galaxy', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_galaxy', 'galaxy', 1),
	('society_galaxy_fridge', 'galaxy (frigo)', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
 	('society_galaxy', 'galaxy', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('galaxy', 'Galaxy Club')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
  ('galaxy', 0, 'barman', 'Agent d\'accueil', 1200, '{}', '{}'),
  ('galaxy', 1, 'dancer', 'Barman / Danseur', 1400, '{}', '{}'),
  ('galaxy', 2, 'viceboss', 'Manager', 1600, '{}', '{}'),
  ('galaxy', 3, 'boss', 'Gérant', 2000, '{}', '{}')
;

INSERT INTO `items` (name, label, `limit`) VALUES 
	('jager', 'Jägermeister', 5),
	('bolcacahuetes', 'Bol de cacahuètes', 5),
	('bolnoixcajou', 'Bol de noix de cajou', 5),
	('bolpistache', 'Bol de pistaches', 5),
	('bolchips', 'Bol de chips', 5),
	('jagerbomb', 'Jägerbomb', 5),
	('mixapero', 'Mix Apéro', 5),
	('myrtealcool', 'Alcool de Myrte', 5),
	('alcool', 'Baileys', 5),
	('whiskycoc', 'Whisky-coca', 5),
	('redbull', 'RedBull', 5),
	('vodkrb', 'Vodka RedBull', 5),
    ('ice', 'Glaçon', 5),
    ('saucisson', 'Saucisson', 5),
    ('menthe', 'Feuille de menthe', 10),
    ('soda', 'Coca-Cola', 5),
    ('jusfruit', 'Jus de fruits', 5),
    ('energy', 'Monster', 5),
    ('drpepper', 'Dr. Pepper', 5),
    ('limonade', 'Limonade', 5),
    ('rhum', 'Rhum', 5),
    ('golem', 'Golem', 5),
    ('whiskycoca', 'Whisky-coca', 5),
    ('vodkaenergy', 'Vodka-Monster', 5),
    ('vodkafruit', 'Vodka-jus de fruits', 5),
    ('rhumfruit', 'Rhum-jus de fruits', 5),
    ('teqpaf', "Teq'paf", 5),
    ('rhumcoca', 'Rhum-coca', 5),
    ('mojito', 'Mojito', 5),
    ('metreshooter', 'Mètre de shooter', 3),
    ('jagercerbere', 'Jäger Cerbère', 3),
    ('martini', 'Martini blanc', 5)
;