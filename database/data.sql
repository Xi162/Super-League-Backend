USE SUPER_LEAGUE;

-- add club
INSERT INTO CLUB(Website_URL, Name) VALUES ('www.ThunderboltsUnited.com', "Thunderbolts United");
INSERT INTO CLUB(Website_URL, Name) VALUES ('www.PhoenixFC.com', "Phoenix FC");
INSERT INTO CLUB(Website_URL, Name) VALUES ('www.VanguardCity.com', "Vanguard City");
INSERT INTO CLUB(Website_URL, Name) VALUES ('www.DynamoLions.com', "Dynamo Lions");
INSERT INTO CLUB(Website_URL, Name) VALUES ('www.StellarStrikers.com', "Stellar Strikers");
INSERT INTO CLUB(Website_URL, Name) VALUES ('www.EmeraldStars.com', "Emerald Stars FC");

-- add season
INSERT INTO SEASON (Season_year) VALUES (2019);
INSERT INTO SEASON (Season_year) VALUES (2020);
INSERT INTO SEASON (Season_year) VALUES (2021);
INSERT INTO SEASON (Season_year) VALUES (2022);
INSERT INTO SEASON (Season_year) VALUES (2023);

-- add partner
INSERT INTO PARTNER (Name, URL, Partner_type) VALUES ("Velocity Sports", "www.VelocitySports.com", "official");
INSERT INTO PARTNER (Name, URL, Partner_type) VALUES ("Apex Solutions", "www.ApexSolutions.com", "radio");
INSERT INTO PARTNER (Name, URL, Partner_type) VALUES ("Global Reach Partners", "www.GlobalReachPartners.com", "license");
INSERT INTO PARTNER (Name, URL, Partner_type) VALUES ("QuantumLeap Industries", "www.QuantumLeapIndustries.com", "broadcast");
INSERT INTO PARTNER (Name, URL, Partner_type) VALUES ("SwiftTech Systems", "www.SwiftTechSystems.com", "radio");
INSERT INTO PARTNER (Name, URL, Partner_type) VALUES ("FusionX Innovations", "www.FusionXInnovations.com", "official");
INSERT INTO PARTNER (Name, URL, Partner_type) VALUES ('ABC Company', 'www.abc.com', 'official');
INSERT INTO PARTNER (Name, URL, Partner_type) VALUES ('XYZ Corporation', 'www.xyzcorp.com', 'license');
INSERT INTO PARTNER (Name, URL, Partner_type) VALUES ('Tech Innovators', 'www.techinnovators.com', 'broadcast');
INSERT INTO PARTNER (Name, URL, Partner_type) VALUES ('Global Solutions', 'www.globalsolutions.com', 'official');
INSERT INTO PARTNER (Name, URL, Partner_type) VALUES ('Infinite Technologies', 'www.infinitetech.com', 'radio');
INSERT INTO PARTNER (Name, URL, Partner_type) VALUES ('Dynamic Ventures', 'www.dynamicventures.com', 'broadcast');

-- add official partner
INSERT INTO SEASON_PARTNER (Season_year, Partner_name)
VALUES
    (2019, 'Velocity Sports'),
    (2020, 'ABC Company'),
    (2021, 'Global Solutions'),
    (2022, 'FusionX Innovations'),
    (2023, 'Velocity Sports');

-- add radio partner
INSERT INTO SEASON_PARTNER (Season_year, Partner_name)
VALUES
    (2019, 'Apex Solutions'),
    (2020, 'Infinite Technologies'),
    (2021, 'SwiftTech Systems'),
    (2022, 'Infinite Technologies'),
    (2023, 'SwiftTech Systems');

-- add license patner
INSERT INTO SEASON_PARTNER (Season_year, Partner_name)
VALUES
    (2019, 'Global Reach Partners'),
    (2020, 'XYZ Corporation'),
    (2021, 'XYZ Corporation'),
    (2022, 'Global Reach Partners'),
    (2023, 'Global Reach Partners');

-- add broadcast patner
INSERT INTO SEASON_PARTNER (Season_year, Partner_name)
VALUES
    (2019, 'QuantumLeap Industries'),
    (2020, 'Dynamic Ventures'),
    (2021, 'Tech Innovators'),
    (2022, 'QuantumLeap Industries'),
    (2023, 'Dynamic Ventures');
    
-- add club season
-- For the 2019 season
INSERT INTO CLUB_SEASON (Club_id, Season_year, Home_stadium) VALUES (1, 2019, 'Thunder Arena');
INSERT INTO CLUB_SEASON (Club_id, Season_year, Home_stadium) VALUES (2, 2019, 'Phoenix Stadium');
INSERT INTO CLUB_SEASON (Club_id, Season_year, Home_stadium) VALUES (3, 2019, 'Vanguard Dome');
INSERT INTO CLUB_SEASON (Club_id, Season_year, Home_stadium) VALUES (4, 2019, 'Dynamo Park');
INSERT INTO CLUB_SEASON (Club_id, Season_year, Home_stadium) VALUES (5, 2019, 'Stellar Ground');

-- For the 2020 season
INSERT INTO CLUB_SEASON (Club_id, Season_year, Home_stadium) VALUES (1, 2020, 'Thunder Arena');
INSERT INTO CLUB_SEASON (Club_id, Season_year, Home_stadium) VALUES (2, 2020, 'Phoenix Stadium');
INSERT INTO CLUB_SEASON (Club_id, Season_year, Home_stadium) VALUES (3, 2020, 'Vanguard Dome');
INSERT INTO CLUB_SEASON (Club_id, Season_year, Home_stadium) VALUES (4, 2020, 'Dynamo Park');
INSERT INTO CLUB_SEASON (Club_id, Season_year, Home_stadium) VALUES (6, 2020, 'Emerald Arena');

-- For the 2021 season
INSERT INTO CLUB_SEASON (Club_id, Season_year, Home_stadium) VALUES (1, 2021, 'Thunder Arena');
INSERT INTO CLUB_SEASON (Club_id, Season_year, Home_stadium) VALUES (2, 2021, 'Emerald Arena');
INSERT INTO CLUB_SEASON (Club_id, Season_year, Home_stadium) VALUES (6, 2021, 'Emerald Arena');
INSERT INTO CLUB_SEASON (Club_id, Season_year, Home_stadium) VALUES (4, 2021, 'Dynamo Park');
INSERT INTO CLUB_SEASON (Club_id, Season_year, Home_stadium) VALUES (5, 2021, 'Stellar Field');

-- For the 2022 season
INSERT INTO CLUB_SEASON (Club_id, Season_year, Home_stadium) VALUES (1, 2022, 'Thunder Arena');
INSERT INTO CLUB_SEASON (Club_id, Season_year, Home_stadium) VALUES (2, 2022, 'Phoenix Stadium');
INSERT INTO CLUB_SEASON (Club_id, Season_year, Home_stadium) VALUES (3, 2022, 'Vanguard Dome');
INSERT INTO CLUB_SEASON (Club_id, Season_year, Home_stadium) VALUES (4, 2022, 'Dynamo Park');
INSERT INTO CLUB_SEASON (Club_id, Season_year, Home_stadium) VALUES (6, 2022, 'Emerald Arena');

-- For the 2023 season
INSERT INTO CLUB_SEASON (Club_id, Season_year, Home_stadium) VALUES (1, 2023, 'Thunder Park');
INSERT INTO CLUB_SEASON (Club_id, Season_year, Home_stadium) VALUES (6, 2023, 'Emerald Arena');
INSERT INTO CLUB_SEASON (Club_id, Season_year, Home_stadium) VALUES (3, 2023, 'Vanguard Dome');
INSERT INTO CLUB_SEASON (Club_id, Season_year, Home_stadium) VALUES (4, 2023, 'Dynamo Park');
INSERT INTO CLUB_SEASON (Club_id, Season_year, Home_stadium) VALUES (5, 2023, 'Stellar Stadium');

-- add referee
INSERT INTO LEAGUE_STAFF (First_name, Last_name, Date_of_birth, Staff_type) VALUES ('John', 'Smith', '1990-05-15', 'Referee');
INSERT INTO LEAGUE_STAFF (First_name, Last_name, Date_of_birth, Staff_type) VALUES ('Emily', 'Johnson', '1985-08-22', 'Referee');
INSERT INTO LEAGUE_STAFF (First_name, Last_name, Date_of_birth, Staff_type) VALUES ('Michael', 'Brown', '1978-12-03', 'Referee');
INSERT INTO LEAGUE_STAFF (First_name, Last_name, Date_of_birth, Staff_type) VALUES ('Sarah', 'Davis', '1995-06-10', 'Referee');
INSERT INTO LEAGUE_STAFF (First_name, Last_name, Date_of_birth, Staff_type) VALUES ('David', 'Wilson', '1982-03-27', 'Referee');
INSERT INTO LEAGUE_STAFF (First_name, Last_name, Date_of_birth, Staff_type) VALUES ('Jessica', 'Miller', '1993-09-18', 'Referee');
INSERT INTO LEAGUE_STAFF (First_name, Last_name, Date_of_birth, Staff_type) VALUES ('Christopher', 'Wilson', '1987-07-11', 'Referee');
INSERT INTO LEAGUE_STAFF (First_name, Last_name, Date_of_birth, Staff_type) VALUES ('Olivia', 'Anderson', '1991-04-25', 'Referee');
INSERT INTO LEAGUE_STAFF (First_name, Last_name, Date_of_birth, Staff_type) VALUES ('Daniel', 'Taylor', '1984-11-29', 'Referee');
INSERT INTO LEAGUE_STAFF (First_name, Last_name, Date_of_birth, Staff_type) VALUES ('Sophia', 'Martin', '1997-02-08', 'Referee');

-- add volunteer
INSERT INTO LEAGUE_STAFF (First_name, Last_name, Date_of_birth, Staff_type) VALUES ('Matthew', 'Clark', '1992-06-27', 'Volunteer');
INSERT INTO LEAGUE_STAFF (First_name, Last_name, Date_of_birth, Staff_type) VALUES ('Ava', 'Thomas', '1988-09-14', 'Volunteer');
INSERT INTO LEAGUE_STAFF (First_name, Last_name, Date_of_birth, Staff_type) VALUES ('James', 'Moore', '1994-04-06', 'Volunteer');
INSERT INTO LEAGUE_STAFF (First_name, Last_name, Date_of_birth, Staff_type) VALUES ('Mia', 'Lee', '1999-01-12', 'Volunteer');
INSERT INTO LEAGUE_STAFF (First_name, Last_name, Date_of_birth, Staff_type) VALUES ('Daniel', 'Harris', '1993-08-30', 'Volunteer');
INSERT INTO LEAGUE_STAFF (First_name, Last_name, Date_of_birth, Staff_type) VALUES ('Sophia', 'Thompson', '1991-11-25', 'Volunteer');
INSERT INTO LEAGUE_STAFF (First_name, Last_name, Date_of_birth, Staff_type) VALUES ('Joseph', 'White', '1986-03-19', 'Volunteer');
INSERT INTO LEAGUE_STAFF (First_name, Last_name, Date_of_birth, Staff_type) VALUES ('Olivia', 'Hall', '1996-07-07', 'Volunteer');
INSERT INTO LEAGUE_STAFF (First_name, Last_name, Date_of_birth, Staff_type) VALUES ('Benjamin', 'Young', '1990-02-02', 'Volunteer');
INSERT INTO LEAGUE_STAFF (First_name, Last_name, Date_of_birth, Staff_type) VALUES ('Emma', 'Scott', '1989-05-21', 'Volunteer');

-- add coach
CALL add_coach('Mikel', 'Arteta', 'Spanish', '1980-07-02', 1, '2019-09-30', 1500000, 'head');
CALL add_coach('Pep', 'Arteta', 'Spanish', '1980-07-02',  2, '2019-09-30', 1500000, 'head');
CALL add_coach('Klopp', 'Arteta', 'Spanish', '1980-07-02', 3, '2019-09-30', 1500000, 'head');
CALL add_coach('Unai', 'Arteta', 'Spanish', '1980-07-02', 4, '2019-09-30', 1500000, 'head');
CALL add_coach('Jose', 'Arteta', 'Spanish', '1980-07-02', 5, '2019-09-30', 1500000, 'head');
CALL add_coach('Ange', 'Arteta', 'Spanish', '1980-07-02', 6, '2019-09-30', 1500000, 'head');

-- add player
-- team 1
CALL add_player('John', 'Doe', 'England', '1995-07-15', 1, '2019-09-30', 5000000, 'forward', 'active');
CALL add_player('Alex', 'Williams', 'England', '1994-03-12', 1, '2019-09-30', 5000000, 'goal_keeper', 'active');
CALL add_player('Gabriel', 'Rodriguez', 'Brazil', '1998-01-10', 1, '2019-09-30', 3500000, 'midfielder', 'active');
CALL add_player('Gabriel', 'Magahaes', 'Brazil', '1998-01-10', 1, '2019-09-30', 3500000, 'defender', 'active');
CALL add_player('Declan', 'Rice', 'England', '1998-01-10', 1, '2019-09-30', 3500000, 'midfielder', 'active');
CALL add_player('John', 'Beckham', 'England', '1995-07-15', 1, '2019-09-30', 5000000, 'forward', 'active');
CALL add_player('Alex', 'Fernandes', 'Spain', '1994-03-12', 1, '2019-09-30', 5000000, 'goal_keeper', 'active');
CALL add_player('Gabriel', 'Jesus', 'Brazil', '1998-01-10', 1, '2019-09-30', 3500000, 'midfielder', 'active');
CALL add_player('Alaba', 'Magahaes', 'Brazil', '1998-01-10', 1, '2019-09-30', 3500000, 'defender', 'active');
CALL add_player('Darwin', 'Rice', 'England', '1998-01-10', 1, '2019-09-30', 3500000, 'midfielder', 'active');

-- team 2
CALL add_player('Matteo', 'Rossi', 'Italy', '1994-08-18', 2, '2019-09-30', 4500000, 'defender', 'active');
CALL add_player('Marcus', 'Anderson', 'Spain', '1996-09-28', 2, '2019-09-30', 4000000, 'midfielder', 'active');
CALL add_player('Marcus', 'Rashford', 'Spain', '1996-09-28', 2, '2019-09-30', 4000000, 'forward', 'active');
CALL add_player('Jobe', 'Anderson', 'England', '1996-09-28', 2, '2019-09-30', 4000000, 'goal_keeper', 'active');
CALL add_player('Jane', 'Smith', 'USA', '1998-03-22', 2, '2019-09-30', 3000000, 'defender', 'active');
CALL add_player('Matteo', 'Kova', 'Italy', '1994-08-18', 2, '2019-09-30', 4500000, 'defender', 'active');
CALL add_player('Ipsy', 'Anderson', 'Spain', '1996-09-28', 2, '2019-09-30', 4000000, 'midfielder', 'active');
CALL add_player('Jackson', 'Rashford', 'Spain', '1996-09-28', 2, '2019-09-30', 4000000, 'forward', 'active');
CALL add_player('Jobe', 'Ramsdale', 'England', '1996-09-28', 2, '2019-09-30', 4000000, 'goal_keeper', 'active');
CALL add_player('Joe', 'Smith', 'USA', '1998-03-22', 2, '2019-09-30', 3000000, 'defender', 'active');

-- team 3
CALL add_player('Michael', 'Johnson', 'Brazil', '1993-11-10', 3, '2019-09-30', 4000000, 'forward', 'active');
CALL add_player('Michael', 'Pulisic', 'USA', '1993-11-10', 3, '2019-09-30', 4000000, 'midfielder', 'active');
CALL add_player('Mitoma', 'Tomiyasu', 'Japan', '1993-11-10', 3, '2019-09-30', 4000000, 'defender', 'active');
CALL add_player('Lucas', 'Martinez', 'Argentina', '1993-11-05', 3, '2019-09-30', 6000000, 'midfielder', 'active');
CALL add_player('Andreas', 'Jensen', 'Denmark', '1997-03-27', 3, '2019-09-30', 3000000, 'goal_keeper', 'active');
CALL add_player('Michael', 'Klavia', 'Brazil', '1993-11-10', 3, '2019-09-30', 4000000, 'forward', 'active');
CALL add_player('Micale', 'Lacas', 'USA', '1993-11-10', 3, '2019-09-30', 4000000, 'midfielder', 'active');
CALL add_player('Mitoma', 'Doan', 'Japan', '1993-11-10', 3, '2019-09-30', 4000000, 'defender', 'active');
CALL add_player('Enzo', 'Martinez', 'Argentina', '1993-11-05', 3, '2019-09-30', 6000000, 'midfielder', 'active');
CALL add_player('Hojlund', 'Jensen', 'Denmark', '1997-03-27', 3, '2019-09-30', 3000000, 'goal_keeper', 'active');


-- team 4
CALL add_player('Sebastian', 'Garcia', 'Brazil', '1997-07-19', 4, '2019-09-30', 5500000, 'forward', 'active');
CALL add_player('Florian', 'Garcia', 'Brazil', '1997-07-19', 4, '2019-09-30', 5500000, 'midfielder', 'active');
CALL add_player('Vinicus', 'Garcia', 'Brazil', '1997-07-19', 4, '2019-09-30', 5500000, 'goal_keeper', 'active');
CALL add_player('Amrabat', 'Schneider', 'Germany', '1996-11-02', 4, '2019-09-30', 4000000, 'defender', 'active');
CALL add_player('Maximilian', 'Schneider', 'Germany', '1996-11-02', 4, '2019-09-30', 4000000, 'midfielder', 'active');
CALL add_player('Kala', 'Kuku', 'Brazil', '1997-07-19', 4, '2019-09-30', 5500000, 'forward', 'active');
CALL add_player('Lukaku', 'Trovic', 'Brazil', '1997-07-19', 4, '2019-09-30', 5500000, 'midfielder', 'active');
CALL add_player('Junior', 'Garcia', 'Brazil', '1997-07-19', 4, '2019-09-30', 5500000, 'goal_keeper', 'active');
CALL add_player('Jacson', 'Schneider', 'Germany', '1996-11-02', 4, '2019-09-30', 4000000, 'defender', 'active');
CALL add_player('Kai', 'Brandt', 'Germany', '1996-11-02', 4, '2019-09-30', 4000000, 'midfielder', 'active');


-- team 5
CALL add_player('Luiz', 'Lopez', 'Italy', '1995-05-02', 5, '2019-09-30', 4500000, 'forward', 'active');
CALL add_player('Daniel', 'Lopez', 'Italy', '1995-05-02', 5, '2019-09-30', 4500000, 'midfielder', 'active');
CALL add_player('Martin', 'Aguero', 'Italy', '1995-05-02', 5, '2019-09-30', 4500000, 'midfielder', 'active');
CALL add_player('Hugo', 'Saliba', 'Spain', '1995-07-05', 5, '2019-09-30', 2500000, 'defender', 'active');
CALL add_player('Hugo', 'Garcia', 'Spain', '1995-07-05', 5, '2019-09-30', 2500000, 'goal_keeper', 'active');
CALL add_player('Ian', 'Fer', 'Italy', '1995-05-02', 5, '2019-09-30', 4500000, 'forward', 'active');
CALL add_player('Daniel', 'King', 'Italy', '1995-05-02', 5, '2019-09-30', 4500000, 'midfielder', 'active');
CALL add_player('Oips', 'Abala', 'Italy', '1995-05-02', 5, '2019-09-30', 4500000, 'midfielder', 'active');
CALL add_player('Hector', 'Sono', 'Spain', '1995-07-05', 5, '2019-09-30', 2500000, 'defender', 'active');
CALL add_player('Okala', 'Lipen', 'Spain', '1995-07-05', 5, '2019-09-30', 2500000, 'goal_keeper', 'active');

-- team 6
CALL add_player('Kompany', 'Garcia', 'Spain', '1995-07-05', 6, '2019-09-30', 2500000, 'forward', 'active');
CALL add_player('Nico', 'Paz', 'Spain', '1995-07-05', 6, '2019-09-30', 2500000, 'midfielder', 'active');
CALL add_player('Kompany', 'Diaz', 'Spain', '1995-07-05', 6, '2019-09-30', 2500000, 'midfielder', 'active');
CALL add_player('Andre', 'Garcia', 'Spain', '1995-07-05', 6, '2019-09-30', 2500000, 'defender', 'active');
CALL add_player('Kompany', 'Onana', 'Spain', '1995-07-05', 6, '2019-09-30', 2500000, 'goal_keeper', 'active');
CALL add_player('Lompa', 'Jicky', 'Spain', '1995-07-05', 6, '2019-09-30', 2500000, 'forward', 'active');
CALL add_player('Kingla', 'Pazio', 'Spain', '1995-07-05', 6, '2019-09-30', 2500000, 'midfielder', 'active');
CALL add_player('Arsio', 'Lozano', 'Spain', '1995-07-05', 6, '2019-09-30', 2500000, 'midfielder', 'active');
CALL add_player('Josko', 'Canilo', 'Spain', '1995-07-05', 6, '2019-09-30', 2500000, 'defender', 'active');
CALL add_player('Pinic', 'Lokon', 'Spain', '1995-07-05', 6, '2019-09-30', 2500000, 'goal_keeper', 'active');

-- add match for first season
-- match 1
INSERT INTO MATCHES(`Season_year`, `Home_club_id`, `Away_club_id`, `DateTime`, `Main_ref_id`, `Side_ref_1_id`, `Side_ref_2_id`, `Var_ref_id`, `Main_ref_ovarall_score`) 
VALUES (2019, 1, 2, '2019-10-2 16:30:00', 1, 2, 3, 4, 9.0);
CALL add_match_player(1, 7);
CALL add_match_player(1, 8);
CALL add_match_player(1, 9);
CALL add_match_player(1, 10);
CALL add_match_player(1, 11);
CALL add_match_player(1, 17);
CALL add_match_player(1, 18);
CALL add_match_player(1, 19);
CALL add_match_player(1, 20);
CALL add_match_player(1, 21);

CALL add_goal(1, 1, TRUE, TRUE, 23, 8, 7, 'normal');
CALL add_goal(1, 2, FALSE, TRUE, 46, NULL, 17, 'penalty');
CALL add_card(1, 3, TRUE, FALSE, 10, 9, 'yellow');
CALL add_sub(1, 4, TRUE, FALSE, 25, 12, 7);
CALL add_sub(1, 5, FALSE, FALSE, 30, 23, 18);
CALL add_goal(1, 6, TRUE, FALSE, 46, NULL, 12, 'penalty');

INSERT INTO MATCH_JOURNALIST (Match_id, Name, License_number)
VALUES (1, "Olivia", "123456");

CALL update_point_from_match(1);

-- match 2
INSERT INTO MATCHES(`Season_year`, `Home_club_id`, `Away_club_id`, `DateTime`, `Main_ref_id`, `Side_ref_1_id`, `Side_ref_2_id`, `Var_ref_id`, `Main_ref_ovarall_score`) 
VALUES (2019, 3, 4, '2019-10-2 16:30:00', 5, 6, 7, 8, 8.0);
CALL add_match_player(2, 27);
CALL add_match_player(2, 28);
CALL add_match_player(2, 29);
CALL add_match_player(2, 30);
CALL add_match_player(2, 31);
CALL add_match_player(2, 37);
CALL add_match_player(2, 38);
CALL add_match_player(2, 39);
CALL add_match_player(2, 40);
CALL add_match_player(2, 41);

CALL add_card(2, 1, TRUE, TRUE, 10, 29, 'yellow');
CALL add_card(2, 2, FALSE, FALSE, 10, 39, 'yellow');
INSERT INTO MATCH_JOURNALIST (Match_id, Name, License_number)
VALUES (2, "Ethan", "72723");
CALL update_point_from_match(2);

-- match 3
INSERT INTO MATCHES(`Season_year`, `Home_club_id`, `Away_club_id`, `DateTime`, `Main_ref_id`, `Side_ref_1_id`, `Side_ref_2_id`, `Var_ref_id`, `Main_ref_ovarall_score`) 
VALUES (2019, 5, 1, '2019-10-9 16:30:00', 1, 2, 3, 4, 9.0);
CALL add_match_player(3, 47);
CALL add_match_player(3, 48);
CALL add_match_player(3, 49);
CALL add_match_player(3, 50);
CALL add_match_player(3, 51);
CALL add_match_player(3, 7);
CALL add_match_player(3, 8);
CALL add_match_player(3, 9);
CALL add_match_player(3, 10);
CALL add_match_player(3, 11);

CALL add_goal(3, 1, FALSE, FALSE, 44, NULL, 9, 'normal');
INSERT INTO MATCH_JOURNALIST (Match_id, Name, License_number)
VALUES (3, "Maya", "93782");
CALL update_point_from_match(3);

-- match 4
INSERT INTO MATCHES(`Season_year`, `Home_club_id`, `Away_club_id`, `DateTime`, `Main_ref_id`, `Side_ref_1_id`, `Side_ref_2_id`, `Var_ref_id`, `Main_ref_ovarall_score`) 
VALUES (2019, 2, 3, '2019-10-9 16:30:00', 5, 6, 7, 8, 8.0);
CALL add_match_player (4, 17);
CALL add_match_player(4, 18);
CALL add_match_player(4, 19);
CALL add_match_player(4, 20);
CALL add_match_player(4, 21);
CALL add_match_player(4, 27);
CALL add_match_player(4, 28);
CALL add_match_player(4, 29);
CALL add_match_player(4, 30);
CALL add_match_player(4, 31);

CALL add_goal(4, 1, TRUE, TRUE, 5, 20, 17, 'normal');
CALL add_goal(4, 2, TRUE, TRUE, 10, 19, 17, 'normal');
CALL add_goal(4, 3, TRUE, TRUE, 15, 19, 17, 'normal');
CALL add_card(4, 4, FALSE, FALSE, 10, 28, 'yellow');
CALL add_card(4, 5, FALSE, FALSE, 25, 30, 'yellow');
CALL add_card(4, 6, FALSE, FALSE, 40, 29, 'yellow');
INSERT INTO MATCH_JOURNALIST (Match_id, Name, License_number)
VALUES (4, "Maya", "19729");
CALL update_point_from_match(4);


-- match 5
INSERT INTO MATCHES(`Season_year`, `Home_club_id`, `Away_club_id`, `DateTime`, `Main_ref_id`, `Side_ref_1_id`, `Side_ref_2_id`, `Var_ref_id`, `Main_ref_ovarall_score`) 
VALUES (2019, 4, 5, '2019-10-16 16:30:00', 1, 2, 3, 4, 9.0);
CALL add_match_player(5, 37);
CALL add_match_player(5, 38);
CALL add_match_player(5, 39);
CALL add_match_player(5, 40);
CALL add_match_player(5, 41);
CALL add_match_player(5, 47);
CALL add_match_player(5, 48);
CALL add_match_player(5, 49);
CALL add_match_player(5, 50);
CALL add_match_player(5, 51);

CALL add_goal(5, 1, FALSE, TRUE, 5, 47, 48, 'normal');
CALL add_card(5, 2, FALSE, TRUE, 10, 50, 'yellow');
CALL add_card(5, 3, TRUE, TRUE, 20, 40, 'yellow');
CALL add_goal(5, 4, TRUE, FALSE, 10, 39, 37, 'normal');
CALL add_card(5, 5, TRUE, FALSE, 28, 40, 'yellow');
CALL add_goal(5, 6, FALSE, FALSE, 30, NULL, 47, 'penalty');
CALL add_sub(5, 7, TRUE, FALSE, 35, 45, 37);
CALL add_goal(5, 8, FALSE, FALSE, 40, 49, 48, 'normal');
INSERT INTO MATCH_JOURNALIST (Match_id, Name, License_number)
VALUES (5, "Maya", "19729");

CALL update_point_from_match(5);

-- match 6
INSERT INTO MATCHES(`Season_year`, `Home_club_id`, `Away_club_id`, `DateTime`, `Main_ref_id`, `Side_ref_1_id`, `Side_ref_2_id`, `Var_ref_id`, `Main_ref_ovarall_score`) 
VALUES (2019, 3, 1, '2019-10-16 16:30:00', 5, 6, 7, 8, 8.0);
CALL add_match_player(6, 27);
CALL add_match_player(6, 28);
CALL add_match_player(6, 29);
CALL add_match_player(6, 30);
CALL add_match_player(6, 31);
CALL add_match_player(6, 7);
CALL add_match_player(6, 8);
CALL add_match_player(6, 9);
CALL add_match_player(6, 10);
CALL add_match_player(6, 11);
CALL add_card(6, 1, FALSE, TRUE, 10, 8, 'yellow');
CALL add_goal(6, 2, FALSE, FALSE, 30, 10, 7, 'normal');
CALL add_sub(6, 3, TRUE, FALSE, 35, 35, 30);
INSERT INTO MATCH_JOURNALIST (Match_id, Name, License_number)
VALUES (6, "Maya", "19729");

CALL update_point_from_match(6);

-- match 7
INSERT INTO MATCHES(`Season_year`, `Home_club_id`, `Away_club_id`, `DateTime`, `Main_ref_id`, `Side_ref_1_id`, `Side_ref_2_id`, `Var_ref_id`, `Main_ref_ovarall_score`) 
VALUES (2019, 2, 4, '2019-10-23 16:30:00', 1, 2, 3, 4, 9.0);
CALL add_match_player(7, 17);
CALL add_match_player(7, 18);
CALL add_match_player(7, 19);
CALL add_match_player(7, 20);
CALL add_match_player(7, 21);
CALL add_match_player(7, 37);
CALL add_match_player(7, 38);
CALL add_match_player(7, 39);
CALL add_match_player(7, 45);
CALL add_match_player(7, 41);

CALL add_goal(7, 1, TRUE, TRUE, 30, 20, 21, 'normal');
CALL add_goal(7, 2, FALSE, FALSE, 10, NULL, 19, 'own_goal');
CALL add_sub(7, 3, TRUE, FALSE, 15, 22, 19);
CALL add_sub(7, 4, FALSE, FALSE, 20, 42, 38);
INSERT INTO MATCH_JOURNALIST (Match_id, Name, License_number)
VALUES (7, "Maya", "19729");

CALL update_point_from_match(7);
-- unban a player
UPDATE PLAYER SET `Status` = 'active' WHERE `Competitor_id` = 40;

-- match 8
INSERT INTO MATCHES(`Season_year`, `Home_club_id`, `Away_club_id`, `DateTime`, `Main_ref_id`, `Side_ref_1_id`, `Side_ref_2_id`, `Var_ref_id`, `Main_ref_ovarall_score`) 
VALUES (2019, 5, 3, '2019-10-23 16:30:00', 9, 6, 7, 8, 8.0);

CALL add_match_player(8, 47);
CALL add_match_player(8, 48);
CALL add_match_player(8, 49);
CALL add_match_player(8, 50);
CALL add_match_player(8, 51);


CALL add_match_player(8, 27);
CALL add_match_player(8, 28);
CALL add_match_player(8, 29);
CALL add_match_player(8, 30);
CALL add_match_player(8, 31);
CALL add_goal(8, 1, TRUE, FALSE, 30, 47, 48, 'normal');
CALL add_goal(8, 2, TRUE, FALSE, 31, 47, 48, 'normal');
CALL add_goal(8, 3, TRUE, FALSE, 32, 47, 48, 'normal');
INSERT INTO MATCH_JOURNALIST (Match_id, Name, License_number)
VALUES (8, "Maya", "19729");
CALL update_point_from_match(8);

-- match 9
INSERT INTO MATCHES(`Season_year`, `Home_club_id`, `Away_club_id`, `DateTime`, `Main_ref_id`, `Side_ref_1_id`, `Side_ref_2_id`, `Var_ref_id`, `Main_ref_ovarall_score`) 
VALUES (2019, 4, 1, '2019-10-30 16:30:00', 1, 2, 3, 4, 9.0);
CALL add_match_player(9, 42);
CALL add_match_player(9, 41);
CALL add_match_player(9, 40);
CALL add_match_player(9, 39);
CALL add_match_player(9, 38);

CALL add_match_player(9, 9);
CALL add_match_player(9, 10);
CALL add_match_player(9, 11);
CALL add_match_player(9, 12);
CALL add_match_player(9, 13);
CALL add_goal(9, 1, TRUE, FALSE, 30, 42, 41, 'normal');
CALL add_goal(9, 2, TRUE, FALSE, 31, 41, 42, 'normal');
CALL add_goal(9, 3, FALSE, FALSE, 32, 11, 10, 'normal');
INSERT INTO MATCH_JOURNALIST (Match_id, Name, License_number)
VALUES (9, "Maya", "19729");
CALL update_point_from_match(9);

-- match 10
INSERT INTO MATCHES (`Season_year`, `Home_club_id`, `Away_club_id`, `DateTime`, `Main_ref_id`, `Side_ref_1_id`, `Side_ref_2_id`, `Var_ref_id`, `Main_ref_ovarall_score`) 
VALUES (2019, 5, 2, '2019-10-30 16:30:00', 9, 6, 7, 8, 8.0);
CALL add_match_player(10, 47);
CALL add_match_player(10, 48);
CALL add_match_player(10, 49);
CALL add_match_player(10, 50);
CALL add_match_player(10, 51);

CALL add_match_player(10, 17);
CALL add_match_player(10, 18);
CALL add_match_player(10, 19);
CALL add_match_player(10, 20);
CALL add_match_player(10, 21);

CALL add_goal(10, 1, TRUE, FALSE, 30, 49, 51, 'normal');
CALL add_goal(10, 2, TRUE, TRUE, 30, 49, 51, 'own_goal');
INSERT INTO MATCH_JOURNALIST (Match_id, Name, License_number)
VALUES (10, "Maya", "19729");
CALL update_point_from_match(10);

-- Add monthly award (Oct)
CALL add_award_player (2019, 'Apex Solutions', FALSE, 10, 49);
CALL add_award_coach (2019, 'Apex Solutions', FALSE, 10, 1);
CALL add_award_goal (2019, 'Apex Solutions', FALSE, 10, 3, 1);

-- Add seasonly award 
CALL add_award_player (2019, 'Apex Solutions', TRUE, NULL, 48);
CALL add_award_coach (2019, 'Apex Solutions', TRUE, NULL, 2);
CALL add_award_goal (2019, 'Apex Solutions', TRUE, NULL, 3, 1);

-- --------------------------------------------------------------------
-- Transfer section
-- Transfer coach 1 to club 2 and coach 2 to club 1
CALL end_contract(1, 1, '2020-09-29');
CALL end_contract(2, 2, '2020-09-29');
INSERT INTO CLUB_COMPETITOR_PERIOD (Club_id, Competitor_id, Start_date, Transfer_fee) 
VALUES (1, 2, '2020-09-30', 1236);
INSERT INTO CLUB_COMPETITOR_PERIOD (Club_id, Competitor_id, Start_date, Transfer_fee) 
VALUES (2, 1, '2020-09-30', 1236);

-- End contract of player 62 (club 6) and add a new player outside the league
CALL end_contract(6, 62, '2020-09-29');
CALL add_player('Cristiano','Ronaldo','Portugal','1985-02-05',6,'2023-09-30',90000000,'forward','active');

-- Transfer player 20 (club 2 -> 1), player 30 (club 3 -> 2), player 10 (club 1 -> 3)

CALL end_contract(1, 10, '2020-09-29');
CALL end_contract(2, 20, '2020-09-29');
CALL end_contract(3, 30, '2020-09-29');
INSERT INTO CLUB_COMPETITOR_PERIOD (Club_id, Competitor_id, Start_date, Transfer_fee) 
VALUES (1, 20, '2020-09-30', 10000);
INSERT INTO CLUB_COMPETITOR_PERIOD (Club_id, Competitor_id, Start_date, Transfer_fee) 
VALUES (2, 30, '2020-09-30', 20000);
INSERT INTO CLUB_COMPETITOR_PERIOD (Club_id, Competitor_id, Start_date, Transfer_fee) 
VALUES (3, 10, '2020-09-30', 5000);

-- --------------------------------------------------------------------
-- Season 2020

-- match 11
INSERT INTO MATCHES(`Season_year`, `Home_club_id`, `Away_club_id`, `DateTime`, `Main_ref_id`, `Side_ref_1_id`, `Side_ref_2_id`, `Var_ref_id`, `Main_ref_ovarall_score`) 
VALUES (2020, 1, 4, '2020-10-2 16:30:00', 1, 2, 3, 4, 9.0);
CALL add_match_player(11, 7);
CALL add_match_player(11, 8);
CALL add_match_player(11, 9);
CALL add_match_player(11, 20); -- newly transfered
CALL add_match_player(11, 11);
CALL add_match_player(11, 37);
CALL add_match_player(11, 38);
CALL add_match_player(11, 39);
CALL add_match_player(11, 40); 
CALL add_match_player(11, 41);


CALL add_goal(11, 1, TRUE, TRUE, 30, 8, 7, 'normal');
CALL add_goal(11, 2, FALSE, TRUE, 50, NULL, 20, 'penalty');
CALL add_card(11, 3, TRUE, FALSE, 20, 9, 'yellow');
CALL add_sub(11, 4, TRUE, FALSE, 25, 12, 7);
CALL add_sub(11, 5, FALSE, FALSE, 30, 42, 40);

INSERT INTO MATCH_JOURNALIST (Match_id, Name, License_number)
VALUES (11, "Olivia", "123456");
CALL update_point_from_match(11);

-- match 12
INSERT INTO MATCHES(`Season_year`, `Home_club_id`, `Away_club_id`, `DateTime`, `Main_ref_id`, `Side_ref_1_id`, `Side_ref_2_id`, `Var_ref_id`, `Main_ref_ovarall_score`) 
VALUES (2020, 6, 3, '2020-10-23 16:00:00', 9, 6, 7, 8, 8.0);

CALL add_match_player(12, 57);
CALL add_match_player(12, 58);
CALL add_match_player(12, 59);
CALL add_match_player(12, 60);
CALL add_match_player(12, 61);


CALL add_match_player(12, 27);
CALL add_match_player(12, 28);
CALL add_match_player(12, 29);
CALL add_match_player(12, 10); -- newly transfered
CALL add_match_player(12, 31);
CALL add_goal(12, 1, TRUE, FALSE, 30, 57, 58, 'normal');
CALL add_goal(12, 2, TRUE, FALSE, 31, 58, 57, 'normal');
CALL add_goal(12, 3, FALSE, FALSE, 32, 31, 10, 'normal');
INSERT INTO MATCH_JOURNALIST (Match_id, Name, License_number)
VALUES (12, "Maya", "19729");
CALL update_point_from_match(12);

-- Add monthly award 
CALL add_award_player (2020, 'Dynamic Ventures', FALSE, 9, 10);
CALL add_award_coach (2020, 'Dynamic Ventures', FALSE, 9, 2);
CALL add_award_goal (2020, 'Dynamic Ventures', FALSE, 9, 12, 3);
