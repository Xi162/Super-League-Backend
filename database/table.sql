CREATE SCHEMA IF NOT EXISTS SUPER_LEAGUE;

USE SUPER_LEAGUE;

CREATE TABLE
    IF NOT EXISTS CLUB(
        Club_id INT AUTO_INCREMENT,
        Website_URL VARCHAR(300),
        Name VARCHAR(60) NOT NULL,
        PRIMARY KEY (Club_id)
    );

CREATE TABLE
    IF NOT EXISTS SEASON(
        Season_year INT CHECK(Season_year >= 0),
        PRIMARY KEY (Season_year)
    );

CREATE TABLE
    IF NOT EXISTS PARTNER(
        Name VARCHAR(50),
        URL VARCHAR(300),
        Partner_type ENUM(
            'official',
            'license',
            'broadcast',
            'radio'
        ),
        PRIMARY KEY (Name)
    );

CREATE TABLE
    IF NOT EXISTS SEASON_PARTNER(
        Season_year INT,
        Partner_name VARCHAR(50),
        PRIMARY KEY (Season_year, Partner_name),
        FOREIGN KEY (Season_year) REFERENCES SEASON(Season_year) ON DELETE CASCADE ON UPDATE CASCADE,
        FOREIGN KEY (Partner_name) REFERENCES PARTNER(Name) ON DELETE CASCADE ON UPDATE CASCADE
    );

CREATE TABLE
    IF NOT EXISTS CLUB_SEASON (
        Club_id INT,
        Season_year INT,
        Home_stadium VARCHAR(50),
        Point INT DEFAULT 0,
        Goal_for INT DEFAULT 0,
        Goal_against INT DEFAULT 0,
        PRIMARY KEY (Club_id, Season_year),
        FOREIGN KEY (Club_id) REFERENCES CLUB(Club_id) ON DELETE CASCADE ON UPDATE CASCADE,
        FOREIGN KEY (Season_year) REFERENCES SEASON(Season_year) ON DELETE CASCADE ON UPDATE CASCADE,
        CONSTRAINT CHECK(Point >= 0)
    );

CREATE TABLE
    IF NOT EXISTS COMPETITOR(
        Competitor_id INT AUTO_INCREMENT,
        First_name VARCHAR(30) NOT NULL,
        Last_name VARCHAR(30) NOT NULL,
        Nationality VARCHAR(60),
        Date_of_birth DATE,
        PRIMARY KEY (Competitor_id)
    );

CREATE TABLE
    IF NOT EXISTS COACH (
        Competitor_id INT,
        Coach_type VARCHAR(20),
        PRIMARY KEY (Competitor_id),
        FOREIGN KEY (Competitor_id) REFERENCES COMPETITOR(Competitor_id) ON DELETE CASCADE ON UPDATE CASCADE
    );

CREATE TABLE
    IF NOT EXISTS PLAYER (
        Competitor_id INT,
        Position ENUM(
            'goal_keeper',
            'defender',
            'forward',
            'midfielder'
        ),
        Num_start INT DEFAULT 0 CHECK(Num_start >= 0),
        Num_sub INT DEFAULT 0 CHECK(Num_sub >= 0),
        Status ENUM('active', 'suspended') DEFAULT 'active',
        PRIMARY KEY (Competitor_id),
        FOREIGN KEY (Competitor_id) REFERENCES COMPETITOR(Competitor_id) ON DELETE CASCADE ON UPDATE CASCADE
    );

CREATE TABLE
    IF NOT EXISTS CLUB_COMPETITOR_PERIOD (
        Club_id INT,
        Competitor_id INT,
        Start_date DATE NOT NULL,
        End_date DATE,
        Transfer_fee INT DEFAULT 0,
        PRIMARY KEY (
            Club_id,
            Competitor_id,
            Start_date
        ),
        FOREIGN KEY (Club_id) REFERENCES CLUB(Club_id) ON DELETE CASCADE ON UPDATE CASCADE,
        FOREIGN KEY (Competitor_id) REFERENCES COMPETITOR (Competitor_id) ON DELETE CASCADE ON UPDATE CASCADE,
        CONSTRAINT CHECK(
            End_date = NULL
            OR End_date > Start_date
        )
    );

CREATE TABLE
    IF NOT EXISTS LEAGUE_STAFF(
        Staff_id INT AUTO_INCREMENT,
        First_name VARCHAR(30) NOT NULL,
        Last_name VARCHAR(30) NOT NULL,
        Date_of_birth DATE,
        Staff_type VARCHAR(20),
        PRIMARY KEY (Staff_id)
    );

CREATE TABLE
    IF NOT EXISTS MATCHES (
        Match_id INT AUTO_INCREMENT,
        Season_year INT,
        Home_club_id INT,
        Away_club_id INT,
        DateTime DATETIME,
        Home_score INT DEFAULT 0 CHECK(Home_score >= 0),
        Away_score INT DEFAULT 0 CHECK(Away_score >= 0),
        Main_ref_id INT,
        Side_ref_1_id INT,
        Side_ref_2_id INT,
        Var_ref_id INT,
        Main_ref_ovarall_score FLOAT,
        PRIMARY KEY (Match_id),
        FOREIGN KEY (Season_year) REFERENCES SEASON(Season_year) ON DELETE CASCADE ON UPDATE CASCADE,
        FOREIGN KEY (Home_club_id) REFERENCES CLUB(Club_id) ON DELETE CASCADE ON UPDATE CASCADE,
        FOREIGN KEY (Away_club_id) REFERENCES CLUB(Club_id) ON DELETE CASCADE ON UPDATE CASCADE,
        FOREIGN KEY (Main_ref_id) REFERENCES LEAGUE_STAFF(Staff_id) ON DELETE
        SET
            NULL ON UPDATE CASCADE,
            FOREIGN KEY (Side_ref_1_id) REFERENCES LEAGUE_STAFF(Staff_id) ON DELETE
        SET
            NULL ON UPDATE CASCADE,
            FOREIGN KEY (Side_ref_2_id) REFERENCES LEAGUE_STAFF(Staff_id) ON DELETE
        SET
            NULL ON UPDATE CASCADE,
            FOREIGN KEY (Var_ref_id) REFERENCES LEAGUE_STAFF(Staff_id) ON DELETE
        SET NULL ON UPDATE CASCADE
    );

CREATE TABLE
    IF NOT EXISTS MATCH_VOLUNTEER(
        Match_id INT,
        Volunteer_id INT,
        PRIMARY KEY (Match_id, Volunteer_id),
        FOREIGN KEY (Match_id) REFERENCES MATCHES(Match_id) ON DELETE CASCADE ON UPDATE CASCADE,
        FOREIGN KEY (Volunteer_id) REFERENCES LEAGUE_STAFF(Staff_id) ON DELETE CASCADE ON UPDATE CASCADE
    );

CREATE TABLE
    IF NOT EXISTS FEATURE_IN_MATCH(
        Match_id INT,
        Competitor_id INT,
        Overall_rating FLOAT CHECK(
            Overall_rating >= 0
            AND Overall_rating <= 10
        ),
        PRIMARY KEY (Match_id, Competitor_id),
        FOREIGN KEY (Match_id) REFERENCES MATCHES(Match_id) ON DELETE CASCADE ON UPDATE CASCADE,
        FOREIGN KEY (Competitor_id) REFERENCES COMPETITOR(Competitor_id) ON DELETE CASCADE ON UPDATE CASCADE
    );

CREATE TABLE
    IF NOT EXISTS MATCH_ACTIVITY(
        Match_id INT,
        Activity_id INT,
        Is_home BOOLEAN,
        Is_first_half BOOLEAN,
        Activity_time INT CHECK(Activity_time >= 0),
        Activity_type ENUM('goal', 'card', 'sub') NOT NULL,
        PRIMARY KEY (Match_id, Activity_id),
        FOREIGN KEY (Match_id) REFERENCES MATCHES(Match_id) ON DELETE CASCADE ON UPDATE CASCADE
    );

CREATE TABLE
    IF NOT EXISTS GOAL(
        Match_id INT,
        Activity_id INT,
        Assistor_id INT,
        Scorer_id INT NOT NULL,
        Goal_type ENUM(
            'normal',
            'penalty',
            'own_goal'
        ) NOT NULL DEFAULT 'normal',
        PRIMARY KEY (Match_id, Activity_id),
        FOREIGN KEY (Match_id, Activity_id) REFERENCES MATCH_ACTIVITY(Match_id, Activity_id) ON DELETE CASCADE ON UPDATE CASCADE,
        FOREIGN KEY (Assistor_id) REFERENCES PLAYER(Competitor_id) ON DELETE
        SET
            NULL ON UPDATE CASCADE,
            FOREIGN KEY (Scorer_id) REFERENCES PLAYER(Competitor_id) ON DELETE CASCADE ON UPDATE CASCADE
    );

CREATE TABLE
    IF NOT EXISTS CARD(
        Match_id INT,
        Activity_id INT,
        Receiver_id INT NOT NULL,
        Card_type ENUM('red', 'yellow') NOT NULL,
        PRIMARY KEY (Match_id, Activity_id),
        FOREIGN KEY (Match_id, Activity_id) REFERENCES MATCH_ACTIVITY(Match_id, Activity_id) ON DELETE CASCADE ON UPDATE CASCADE,
        FOREIGN KEY (Receiver_id) REFERENCES PLAYER(Competitor_id) ON DELETE CASCADE ON UPDATE CASCADE
    );

CREATE TABLE
    IF NOT EXISTS SUB(
        Match_id INT,
        Activity_id INT,
        In_player_id INT NOT NULL,
        Out_player_id INT NOT NULL,
        PRIMARY KEY (Match_id, Activity_id),
        FOREIGN KEY (Match_id, Activity_id) REFERENCES MATCH_ACTIVITY(Match_id, Activity_id) ON DELETE CASCADE ON UPDATE CASCADE,
        FOREIGN KEY (In_player_id) REFERENCES PLAYER(Competitor_id) ON DELETE CASCADE ON UPDATE CASCADE,
        FOREIGN KEY (Out_player_id) REFERENCES PLAYER(Competitor_id) ON DELETE CASCADE ON UPDATE CASCADE
    );

CREATE TABLE
    IF NOT EXISTS AWARD(
        Award_id INT AUTO_INCREMENT,
        Season_year INT NOT NULL,
        Partner_name VARCHAR(50) NOT NULL,
        Is_season BOOLEAN NOT NULL,
        Month INT,
        PRIMARY KEY (Award_id),
        FOREIGN KEY (Season_year) REFERENCES SEASON(Season_year) ON DELETE CASCADE ON UPDATE CASCADE,
        FOREIGN KEY (Partner_name) REFERENCES PARTNER(Name) ON DELETE CASCADE ON UPDATE CASCADE
    );

CREATE TABLE
    IF NOT EXISTS GOAL_AWARD(
        Award_id INT,
        Match_id INT NOT NULL,
        Activity_id INT NOT NULL,
        PRIMARY KEY (Award_id),
        FOREIGN KEY (Match_id, Activity_id) REFERENCES GOAL(Match_id, Activity_id) ON DELETE CASCADE ON UPDATE CASCADE
    );

CREATE TABLE
    IF NOT EXISTS PLAYER_AWARD(
        Award_id INT,
        Receiver_id INT NOT NULL,
        PRIMARY KEY (Award_id),
        FOREIGN KEY (Receiver_id) REFERENCES PLAYER(Competitor_id) ON DELETE CASCADE ON UPDATE CASCADE
    );

CREATE TABLE
    IF NOT EXISTS COACH_AWARD(
        Award_id INT,
        Receiver_id INT NOT NULL,
        PRIMARY KEY (Award_id),
        FOREIGN KEY (Receiver_id) REFERENCES COACH(Competitor_id) ON DELETE CASCADE ON UPDATE CASCADE
    );

CREATE TABLE
    IF NOT EXISTS MATCH_JOURNALIST(
        Match_id INT,
        Name VARCHAR(50) NOT NULL,
        License_number VARCHAR(12) NOT NULL,
        PRIMARY KEY (Match_id, Name, License_number),
        FOREIGN KEY (Match_id) REFERENCES MATCHES(Match_id) ON DELETE CASCADE ON UPDATE CASCADE
    );
