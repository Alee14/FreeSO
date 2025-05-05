-- User table, does not include password info so we dont return this into RAM unless we absolutely need to. Also will help do SSO eventually
CREATE TABLE IF NOT EXISTS `fso_users` (
  `user_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `email` varchar(120) NOT NULL,
  `user_state` enum('valid','email_confirm','moderated') NOT NULL DEFAULT 'email_confirm',
  `register_date` int(10) NOT NULL,
  `is_admin` tinyint(3) NOT NULL,
  `is_moderator` tinyint(3) NOT NULL,
  `is_banned` tinyint(3) NOT NULL,
  `register_ip` varchar(50) NOT NULL DEFAULT '127.0.0.1',
  `last_ip` varchar(50) NOT NULL DEFAULT '127.0.0.1',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`)
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB;

-- Stores password hashes
CREATE TABLE IF NOT EXISTS `fso_user_authenticate` (
  `user_id` int(10) unsigned NOT NULL,
  `scheme_class` varchar(75) NOT NULL,
  `data` mediumblob NOT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `fk_users_pass` FOREIGN KEY (`user_id`) REFERENCES `fso_users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

