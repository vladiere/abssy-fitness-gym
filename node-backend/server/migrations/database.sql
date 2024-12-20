CREATE OR REPLACE TABLE `inventory_table` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`base_count` INT NOT NULL,
	`total_count` INT NOT NULL,
	`ctime` TIMESTAMP NOT NULL DEFAULT current_timestamp,
	`mtime` TIMESTAMP NOT NULL DEFAULT current_timestamp,
	PRIMARY KEY(`id`)
);

CREATE OR REPLACE TABLE `equipment_table` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`inventory_id` INT NOT NULL,
	`brand_name` VARCHAR(255) NOT NULL,
	`equipment_type` VARCHAR(255) NOT NULL,
	PRIMARY KEY(`id`)
);

CREATE OR REPLACE TABLE `supplement_table` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`inventory_id` INT NOT NULL,
	`supplement_name` VARCHAR(255) NOT NULL,
	`classification` VARCHAR(255) NOT NULL,
	PRIMARY KEY(`id`)
);

CREATE OR REPLACE TABLE `inventory_log_table` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
    `inventory_id` INT NOT NULL,
    `count_added` INT NOT NULL,
    `classification_type` ENUM('supplement','equipment') NOT NULL,
    `log_state` ENUM('added','deducted'),
	`ctime` TIMESTAMP NOT NULL DEFAULT current_timestamp,
	PRIMARY KEY(`id`)
);

CREATE OR REPLACE TABLE `announcement` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
    `user_id` INT NOT NULL,
    `title` VARCHAR(128) NOT NULL,
    `message` TEXT NOT NULL,
    `stats` ENUM('active','inactive','removed') NOT NULL DEFAULT 'active',
    `announcement_type` ENUM('announcement','event') NOT NULL DEFAULT 'announcement',
	`ctime` TIMESTAMP NOT NULL DEFAULT current_timestamp,
	`mtime` TIMESTAMP NOT NULL DEFAULT current_timestamp,
    PRIMARY KEY(`id`)
);

CREATE OR REPLACE TABLE `login_details` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`username` VARCHAR(255) NOT NULL UNIQUE,
	`password` VARCHAR(255) NOT NULL,
	`ctime` TIMESTAMP NOT NULL DEFAULT current_timestamp,
	`mtime` TIMESTAMP NOT NULL DEFAULT current_timestamp,
    PRIMARY KEY(`id`)
) AUTO_INCREMENT=0;

CREATE OR REPLACE TABLE `member_table` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`detail_id` INT NOT NULL,
	`address_id` INT NOT NULL,
	`ec_id` INT NOT NULL,
    `package_id` INT NULL,
    `login_id` INT NULL,
	`health_condition` VARCHAR(255) NULL,
    `member_status` ENUM('active','inactive','removed') NOT NULL DEFAULT 'inactive',
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
	`phone_number` VARCHAR(13) NOT NULL,
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
	`phone_number` VARCHAR(13) NOT NULL,
	`email_address` VARCHAR(255) NOT NULL UNIQUE,
	`date_of_birth` DATE NOT NULL,
	`gender` ENUM('male', 'female', 'other') NOT NULL,
	`email_verified_at` VARCHAR(255) NULL,
	PRIMARY KEY(`id`)
);

CREATE OR REPLACE TABLE `staff_table` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`detail_id` INT NOT NULL,
	`address_id` INT NOT NULL,
	`ec_id` INT NOT NULL,
	`role` ENUM('receptionist', 'cleaner', 'encoder', "maintenance", "attendant", "officer", "childcare", "dietitian", "consultant", "instructor", "manager") NOT NULL,
	`hire_date` TIMESTAMP NOT NULL DEFAULT current_timestamp,
	`shift_schedule` VARCHAR(255) NOT NULL,
	`login_id` INT NOT NULL,
	`ctime` TIMESTAMP NOT NULL DEFAULT current_timestamp,
	`mtime` TIMESTAMP NOT NULL DEFAULT current_timestamp,
	`staff_status` ENUM('active', 'inactive', 'removed') NOT NULL DEFAULT 'active',
	PRIMARY KEY(`id`)
);

CREATE OR REPLACE TABLE `admin_table` (
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
	`package_id` INT NOT NULL,
	`member_id` INT NOT NULL,
	`amount` DECIMAL(10,2) NOT NULL,
	`payment_date` DATE NOT NULL,
	`payment_method` ENUM('cash', 'card', 'ecash') NOT NULL DEFAULT 'cash',
	`payment_status` ENUM('active','late','early','removed'),
	`ctime` TIMESTAMP NOT NULL DEFAULT current_timestamp,
	`mtime` TIMESTAMP NOT NULL DEFAULT current_timestamp,
	PRIMARY KEY(`id`)
);

CREATE OR REPLACE TABLE `package_table` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`package_name` VARCHAR(255) NOT NULL UNIQUE,
	`duration` INT NOT NULL,
    `package_type` ENUM('day','days', 'week','month','year', 'weeks', 'months', 'years') DEFAULT 'month',
	`price` DECIMAL(10, 2) NOT NULL,
	`benefits` VARCHAR(255) NOT NULL,
    `purchase_count` INT NOT NULL DEFAULT 0,
    `status` ENUM('active','inactive', 'removed') DEFAULT 'active',
	`ctime` TIMESTAMP NOT NULL DEFAULT current_timestamp,
	`mtime` TIMESTAMP NOT NULL DEFAULT current_timestamp,
	PRIMARY KEY(`id`)
);


CREATE OR REPLACE TABLE `sales_table` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
    `package_id` INT NOT NULL,
	`amount` DECIMAL(10, 2) NOT NULL,
   	`trans_id` VARCHAR(255),
    `ref_no` VARCHAR(255),
    `acc_name` VARCHAR(255),
    `email_add` VARCHAR(255),
    `phone_number` VARCHAR(13),
    `description` VARCHAR(255),
    `date_paid` DATETIME,
    `stat` VARCHAR(25),
	`ctime` TIMESTAMP NOT NULL DEFAULT current_timestamp,
	`mtime` TIMESTAMP NOT NULL DEFAULT current_timestamp,
	PRIMARY KEY(`id`)
);

CREATE OR REPLACE TABLE `purchased_package_table` (
   	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
    `package_id` INT NOT NULL,
    `member_id` INT NOT NULL,
    `reference_number` VARCHAR(255) NOT NULL,
    `purchased_id` VARCHAR(255) NOT NULL,
	`ctime` TIMESTAMP NOT NULL DEFAULT current_timestamp,
	`mtime` TIMESTAMP NOT NULL DEFAULT current_timestamp,
	PRIMARY KEY(`id`)
);

CREATE OR REPLACE TABLE `event_table` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
    `title` VARCHAR(255) NOT NULL,
    `details` TEXT NOT NULL,
    `responsibles` VARCHAR(128) NULL,
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
