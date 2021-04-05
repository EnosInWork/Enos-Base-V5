INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
('society_fbi', 'Police', 1);

INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
('society_fbi', 'Police', 1);

INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
('fbi', 'Police', 1);

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`) VALUES
('fbi', 0, 'cadet', 'Agent', 100),
('fbi', 1, 'officier', 'Agent Fédéral', 100),
('fbi', 2, 'sergent', 'Agent spécial', 100),
('fbi', 3, 'lieutenant', 'Superviseur', 100),
('fbi', 4, 'boss', 'Directeur', 100);
