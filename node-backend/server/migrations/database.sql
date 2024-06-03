CREATE OR REPLACE TABLE TABLE `login_details` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`username` VARCHAR(255) NOT NULL UNIQUE,
	`password` VARCHAR(255) NOT NULL,
	`ctime` TIMESTAMP NOT NULL DEFAULT current_timestamp,
	`mtime` TIMESTAMP NOT NULL DEFAULT current_timestamp,
  PRIMARY KEY(`id`)
);

CREATE OR REPLACE TABLE `member_table` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`detail_id` INT NOT NULL,
	`address_id` INT NOT NULL,
	`ec_id` INT NOT NULL,
  `package_id` INT NOT NULL,
	`health_condition` VARCHAR(255),
	`ctime` TIMESTAMP NOT NULL DEFAULT current_timestamp,
	`mtime` TIMESTAMP NOT NULL DEFAULT current_timestamp,
	PRIMARY KEY(`id`)
);

CREATE OR REPLACE TABLE `address_table` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`street` VARCHAR(255) NOT NULL,
	`brgy` VARCHAR(255) NOT NULL,
	`city` VARCHAR(255) NOT NULL,
	`province` VARCHAR(255) NOT NULL,
	`ctime` TIMESTAMP NOT NULL DEFAULT current_timestamp,
	`mtime` TIMESTAMP NOT NULL DEFAULT current_timestamp,
	PRIMARY KEY(`id`)
);

CREATE OR REPLACE TABLE `emergency_contact_table` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`first_name` VARCHAR(255) NOT NULL,
	`last_name` VARCHAR(255) NOT NULL,
	`relationship` VARCHAR(255) NOT NULL,
	`phone_number` VARCHAR(11) NOT NULL,
	`ctime` TIMESTAMP NOT NULL DEFAULT current_timestamp,
	`mtime` TIMESTAMP NOT NULL DEFAULT current_timestamp,
	PRIMARY KEY(`id`)
);

CREATE OR REPLACE TABLE `trainers_table` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`detail_id` INT NOT NULL,
	`address_id` INT NOT NULL,
	`ec_id` INT NOT NULL,
	`specialization` VARCHAR(255) NOT NULL,
	`certifications` VARCHAR(255) NOT NULL,
	`experience_years` INT NOT NULL,
	`hire_date` VARCHAR(255) NOT NULL,
	`availability` VARCHAR(255) NOT NULL,
	`trainer_status` ENUM('active', 'inactive', 'removed') NOT NULL DEFAULT 'active',
	`ctime` TIMESTAMP NOT NULL DEFAULT current_timestamp,
	`mtime` TIMESTAMP NOT NULL DEFAULT current_timestamp,
	PRIMARY KEY(`id`)
);

CREATE OR REPLACE TABLE `details_table` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`first_name` VARCHAR(255) NOT NULL,
	`middle_name` VARCHAR(255) NOT NULL,
	`last_name` VARCHAR(255) NOT NULL,
	`phone_number` VARCHAR(11) NOT NULL,
	`email_address` VARCHAR(255) NOT NULL,
	`date_of_birth` DATE NOT NULL,
	`gender` ENUM('male', 'female', 'other') NOT NULL,
	PRIMARY KEY(`id`)
);

CREATE OR REPLACE TABLE TABLE `staff_table` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`detail_id` INT NOT NULL,
	`address_id` INT NOT NULL,
	`ec_id` INT NOT NULL,
	`role` ENUM('receptionis', 'cleaner', 'encoder', "maintenance", "attendant", "officer", "childcare", "dietitian", "consultant", "instructor", "manager") NOT NULL,
	`hire_date` TIMESTAMP NOT NULL DEFAULT current_timestamp,
	`shift_schedule` VARCHAR(255) NOT NULL,
	`login_id` INT NOT NULL,
	`ctime` TIMESTAMP NOT NULL DEFAULT current_timestamp,
	`mtime` TIMESTAMP NOT NULL DEFAULT current_timestamp,
	`staff_status` ENUM('active', 'inactive', 'removed') NOT NULL DEFAULT 'active',
	PRIMARY KEY(`id`)
);

CREATE OR REPLACE TABLE TABLE `admin_table` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`detail_id` INT NOT NULL,
	`address_id` INT NOT NULL,
	`role` ENUM('super', 'admin', 'subadmin') NOT NULL DEFAULT 'admin',
	`permission_level` SMALLINT NOT NULL DEFAULT 1,
	`login_id` INT NOT NULL,
	`ctime` TIMESTAMP NOT NULL DEFAULT current_timestamp,
	`mtime` TIMESTAMP NOT NULL DEFAULT current_timestamp,
	PRIMARY KEY(`id`)
);

CREATE OR REPLACE TABLE `schedules_table` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`class_name` VARCHAR(255) NOT NULL,
	`trainer_id` INT NOT NULL,
	`start_time` TIME NOT NULL,
	`end_time` TIME NOT NULL,
	`days_of_week` VARCHAR(255) NOT NULL,
	`location` VARCHAR(255) NOT NULL,
  `status` ENUM('available', 'unavailable'),
	`ctime` TIMESTAMP NOT NULL DEFAULT current_timestamp,
	`mtime` TIMESTAMP NOT NULL DEFAULT current_timestamp,
	PRIMARY KEY(`id`)
);

CREATE OR REPLACE TABLE `attendance_table` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`member_id` INT NOT NULL,
	`class_id` INT NOT NULL,
	`attendance_date` DATE NOT NULL,
	`attendance_status` ENUM('absent', 'late', 'present', 'early') NOT NULL DEFAULT 'present',
	`ctime` TIMESTAMP NOT NULL DEFAULT current_timestamp,
	`mtime` TIMESTAMP NOT NULL DEFAULT current_timestamp,
	PRIMARY KEY(`id`)
);

CREATE OR REPLACE TABLE `payments_table` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`member_id` INT NOT NULL,
	`amount` DECIMAL(10,2) NOT NULL,
	`payment_date` DATE NOT NULL,
	`payment_method` ENUM('cash', 'card', 'ecash') NOT NULL DEFAULT 'cash',
	`package_id` INT NOT NULL,
	`payment_status` ENUM('active','late','early','removed'),
	`ctime` TIMESTAMP NOT NULL DEFAULT current_timestamp,
	`mtime` TIMESTAMP NOT NULL DEFAULT current_timestamp,
	PRIMARY KEY(`id`)
);

CREATE OR REPLACE TABLE `package_table` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`package_name` VARCHAR(255) NOT NULL,
	`duration` INT NOT NULL,
  `package_type` ENUM('week','month','year') DEFAULT 'month',
	`price` DECIMAL(10, 2) NOT NULL,
	`benefits` VARCHAR(255) NOT NULL,
  `status` ENUM('active','inactive', 'removed') DEFAULT 'active',
	`ctime` TIMESTAMP NOT NULL DEFAULT current_timestamp,
	`mtime` TIMESTAMP NOT NULL DEFAULT current_timestamp,
	PRIMARY KEY(`id`)
);

CREATE OR REPLACE TABLE `refresh_token` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`username` VARCHAR(255) NOT NULL,
	`refresh_token` VARCHAR(255) NOT NULL,
	`ctime` TIMESTAMP NOT NULL DEFAULT current_timestamp,
	PRIMARY KEY(`id`)
);
