-- Listage de la structure de la table nl. user_sim
CREATE TABLE IF NOT EXISTS user_sim (
  id int(11) NOT NULL AUTO_INCREMENT,
  identifier varchar(555) NOT NULL,
  number varchar(555) NOT NULL,
  label varchar(555) NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=utf8mb4;

INSERT INTO items (name, label) VALUES 
    ('tel', 'Téléphone'),
    ('sim', 'Carte-SIM')
;