USE beths_new_food_pantry;
CREATE TABLE app_users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(250) NOT NULL,
    enabled BOOLEAN DEFAULT TRUE # TRUE by default — so new users are enabled unless you say otherwise. If set to FALSE, Spring Security can block login for that user.
);

INSERT INTO app_users (username, password) VALUES ('demoUser1', '$2a$10$N4fW48FxefiHrHUD5MVqieqReeGZRa6tDHnbjJYFKDw7yl88wgrSW');   
INSERT INTO app_users (username, password) VALUES ('demoUser2', '$2a$10$hpBN9zxZw1LwgP8Dd9Mc3Otx1T6TQ2eHGMUOh3L50KJZ55RmDiZj2');   
INSERT INTO app_users (username, password) VALUES ('demoUser3', '$2a$10$tO7jVthj3kSwJMnAprdDoOw0DWoVsGI2EtBEk43fxII8JdrLZPFTy');   
INSERT INTO app_users (username, password) VALUES ('demoUser4', '$2a$10$CHzsBsyWCE4UA/yqOtm7HuBNsqzo.GCrRKMVNmMtxTKKIKu9xF0ZK');   
INSERT INTO app_users (username, password) VALUES ('demoUser5', '$2a$10$uJNRbqVy22zleJ/2scRUk.wNritECj3h3zBnlSCFc8sRv5YitcTBO'); 

# "demoPass1", "demoPass2", "demoPass3", "demoPass4", "demoPass5"
