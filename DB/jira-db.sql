CREATE DATABASE IF NOT EXISTS jira_db;

USE jira_db;

-- Create 'project' table
CREATE TABLE IF NOT EXISTS project (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pkey VARCHAR(50) NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT
);

-- Create 'issuetype' table
CREATE TABLE IF NOT EXISTS issuetype (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description TEXT
);

-- Create 'priority' table
CREATE TABLE IF NOT EXISTS priority (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description TEXT
);

-- Create 'status' table
CREATE TABLE IF NOT EXISTS status (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description TEXT
);

-- Create 'user' table
CREATE TABLE IF NOT EXISTS user (
    user_key VARCHAR(50) PRIMARY KEY,
    display_name VARCHAR(255) NOT NULL,
    email_address VARCHAR(255),
    active BOOLEAN DEFAULT TRUE
);

-- Create 'jiraissue' table
CREATE TABLE IF NOT EXISTS jiraissue (
    id INT AUTO_INCREMENT PRIMARY KEY,
    summary VARCHAR(255) NOT NULL,
    description TEXT,
    status_id INT,
    priority_id INT,
    project_id INT,
    reporter_key VARCHAR(50),
    assignee_key VARCHAR(50),
    created DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (status_id) REFERENCES status(id),
    FOREIGN KEY (priority_id) REFERENCES priority(id),
    FOREIGN KEY (project_id) REFERENCES project(id),
    FOREIGN KEY (reporter_key) REFERENCES user(user_key),
    FOREIGN KEY (assignee_key) REFERENCES user(user_key)
);

-- Create 'customfield' table
CREATE TABLE IF NOT EXISTS customfield (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description TEXT
);

-- Create 'customfieldvalue' table
CREATE TABLE IF NOT EXISTS customfieldvalue (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customfield_id INT,
    issue_id INT,
    value TEXT,
    FOREIGN KEY (customfield_id) REFERENCES customfield(id),
    FOREIGN KEY (issue_id) REFERENCES jiraissue(id)
);

-- Create 'changegroup' table
CREATE TABLE IF NOT EXISTS changegroup (
    id INT AUTO_INCREMENT PRIMARY KEY,
    issue_id INT,
    author_key VARCHAR(50),
    created DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (issue_id) REFERENCES jiraissue(id),
    FOREIGN KEY (author_key) REFERENCES user(user_key)
);

-- Create 'changeitem' table
CREATE TABLE IF NOT EXISTS changeitem (
    id INT AUTO_INCREMENT PRIMARY KEY,
    group_id INT,
    field VARCHAR(50),
    old_value TEXT,
    new_value TEXT,
    FOREIGN KEY (group_id) REFERENCES changegroup(id)
);

-- Insert sample data
INSERT INTO project (pkey, name, description) VALUES ('PROJ1', 'Project One', 'Description of Project One');
INSERT INTO issuetype (name, description) VALUES ('Bug', 'A problem or defect');
INSERT INTO priority (name, description) VALUES ('High', 'High priority issue');
INSERT INTO status (name, description) VALUES ('To Do', 'Task is not yet started');
INSERT INTO user (user_key, display_name, email_address, active) VALUES ('user1', 'John Doe', 'john.doe@example.com', TRUE);
INSERT INTO jiraissue (summary, description, status_id, priority_id, project_id, reporter_key, assignee_key) 
VALUES ('Issue Summary', 'Issue Description', 1, 1, 1, 'user1', 'user1');
INSERT INTO customfield (name, description) VALUES ('Custom Field 1', 'Description of custom field 1');
INSERT INTO customfieldvalue (customfield_id, issue_id, value) VALUES (1, 1, 'Custom Value');
INSERT INTO changegroup (issue_id, author_key) VALUES (1, 'user1');
INSERT INTO changeitem (group_id, field, old_value, new_value) VALUES (1, 'status', 'To Do', 'In Progress');