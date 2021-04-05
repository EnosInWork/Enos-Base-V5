INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
('society_gouv', 'Police', 1);

INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
('society_gouv', 'Police', 1);

INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
('gouv', 'Police', 1);

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`) VALUES
('gouv', 0, 'cadet', 'Garde du corp', 1500),
('gouv', 1, 'officier', 'Secretaire', 2000),
('gouv', 2, 'sergent', 'Juge', 2500),
('gouv', 3, 'lieutenant', 'Ministre', 3000),
('gouv', 4, 'boss', 'Président', 5000);
