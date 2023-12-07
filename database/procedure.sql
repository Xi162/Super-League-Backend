USE SUPER_LEAGUE;

DELIMITER //

-- add goal procedure
DROP PROCEDURE IF EXISTS add_goal;
CREATE PROCEDURE add_goal (
	m_id int, 
  a_id int, 
  is_home boolean, 
  is_first_half boolean, 
  activity_time int, 
  assist_id int, 
  s_id int, 
  goal_type ENUM('normal', 'penalty', 'own_goal')
)
BEGIN
	DECLARE invalidGoal CONDITION FOR SQLSTATE '45000';
    IF NOT ((assist_id IS NULL OR (SELECT COUNT(*) 
      FROM FEATURE_IN_MATCH 
      WHERE Match_id = m_id AND Competitor_id = assist_id) > 0 )
      AND (SELECT COUNT(*) 
      FROM FEATURE_IN_MATCH 
      WHERE Match_id = m_id AND Competitor_id = s_id) > 0)
    THEN
      SIGNAL invalidGoal SET MESSAGE_TEXT = 'Scorer and assistor must feature in match';
    END IF;
	INSERT INTO MATCH_ACTIVITY (Match_id, Activity_id, Is_home, Is_first_half, Activity_time, Activity_type) 
	VALUES (m_id, a_id, is_home, is_first_half, activity_time, 'goal');
	
	INSERT INTO GOAL (Match_id, Activity_id, Assistor_id, Scorer_id, Goal_type) 
	VALUES (m_id, a_id, assist_id, s_id, goal_type);
END;


-- add card procedure
DROP PROCEDURE IF EXISTS add_card;
CREATE PROCEDURE  add_card   (
	m_id int, a_id int, is_home boolean, 
    is_first_half boolean, activity_time int, r_id int , card_type ENUM('red', 'yellow')
)
BEGIN
	DECLARE invalidCard CONDITION FOR SQLSTATE '45000';
    IF NOT (SELECT COUNT(*) 
        FROM FEATURE_IN_MATCH 
        WHERE Match_id = m_id AND Competitor_id = r_id) > 0
    THEN
		SIGNAL invalidCard SET MESSAGE_TEXT = 'Player receiving card must feature in match';
    END IF;
	INSERT INTO MATCH_ACTIVITY (Match_id, Activity_id, Is_home, Is_first_half, Activity_time, Activity_type) 
	VALUES (m_id, a_id, is_home, is_first_half, activity_time, 'card');
	
	IF(SELECT COUNT(*) FROM CARD WHERE Match_id = m_id AND Receiver_id = r_id) = 1 OR card_type = 'red' THEN
		INSERT INTO CARD (Match_id, Activity_id, Receiver_id ,Card_type)
		VALUES (m_id, a_id, r_id, 'red');
		UPDATE PLAYER SET Status = "suspended" WHERE Competitor_id = r_id;
	ELSE 
		INSERT INTO CARD (Match_id, Activity_id, Receiver_id ,Card_type)
		VALUES (m_id, a_id, r_id, 'yellow');
	END IF;
END;

-- add sub procedure
DROP PROCEDURE IF EXISTS add_sub;
CREATE PROCEDURE  add_sub   (
	m_id int, a_id int, is_home boolean, 
    is_first_half boolean, activity_time int, in_id int, out_id int
)
BEGIN
	DECLARE invalidSub CONDITION FOR SQLSTATE '45000';
    IF NOT (SELECT COUNT(*) 
        FROM FEATURE_IN_MATCH
        WHERE Match_id = m_id AND Competitor_id = out_id) > 0
    THEN
		SIGNAL invalidSub SET MESSAGE_TEXT = 'Player sub-out must feature in match';
    END IF;
	INSERT INTO FEATURE_IN_MATCH (Match_id, Competitor_id, Overall_rating) 
    VALUES (m_id, in_id, 0);
    
    UPDATE PLAYER SET num_sub = num_sub + 1 WHERE Competitor_id = in_id;

	INSERT INTO MATCH_ACTIVITY (Match_id, Activity_id, Is_home, Is_first_half, Activity_time, Activity_type) 
    VALUES (m_id, a_id, is_home, is_first_half, activity_time, 'sub');
    
    INSERT INTO SUB (Match_id, Activity_id, In_player_id, Out_player_id)
    VALUES (m_id, a_id, in_id, out_id);
END;


-- add in FEATURE_IN_MATCH
DROP PROCEDURE IF EXISTS add_start;
CREATE PROCEDURE add_start (
	m_id int, player_id int, score float
)
BEGIN
	INSERT INTO FEATURE_IN_MATCH (Match_id, Competitor_id, Overall_rating) 
    VALUES (m_id, player_id, score);
    
    UPDATE PLAYER SET num_start = num_start + 1 WHERE Competitor_id = player_id;
END; 


-- add AWARD player and check
DROP PROCEDURE IF EXISTS add_award_player;
CREATE PROCEDURE  add_award_player   (
	s_year int, p_name varchar (50), season boolean, 
    award_month int, r_id int
)
BEGIN
	IF season THEN
		IF (SELECT COUNT(*) FROM AWARD INNER JOIN PLAYER_AWARD ON AWARD.Award_id = PLAYER_AWARD.Award_id
    WHERE Season_year = s_year AND Is_season) > 0 THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Award has already existed';
		ELSE
			INSERT INTO AWARD (Season_year, Partner_name, Is_season, Month)
			VALUES (s_year, p_name, season, award_month);
		
			INSERT INTO PLAYER_AWARD (Award_id, Receiver_id)
			VALUES (LAST_INSERT_ID(), r_id);
		END IF;
	ELSE
		IF (SELECT COUNT(*) FROM AWARD INNER JOIN PLAYER_AWARD ON AWARD.Award_id = PLAYER_AWARD.Award_id
		WHERE Season_year = s_year AND Month = award_month) > 0 THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Award has already existed';
		ELSE
			INSERT INTO AWARD (Season_year, Partner_name, Is_season, Month)
			VALUES (s_year, p_name, season, award_month);
			
			INSERT INTO PLAYER_AWARD (Award_id, Receiver_id)
			VALUES (LAST_INSERT_ID(), r_id);
		END IF;
	END IF;
END;


--  add AWARD coach (like player)
DROP PROCEDURE IF EXISTS add_award_coach;
CREATE PROCEDURE  add_award_coach    (
	s_year int, p_name varchar (50), season boolean, 
    award_month int, r_id int
)
BEGIN
	IF season THEN
		IF (SELECT COUNT(*) FROM AWARD INNER JOIN COACH_AWARD ON AWARD.Award_id = COACH_AWARD.Award_id
    WHERE Season_year = s_year AND Is_season) > 0 THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Award has already existed';
		ELSE
			INSERT INTO AWARD (Season_year, Partner_name, Is_season, Month)
			VALUES (s_year, p_name, season, award_month);
		
			INSERT INTO COACH_AWARD (Award_id, Receiver_id)
			VALUES (LAST_INSERT_ID(), r_id);
		END IF;
	ELSE
		IF (SELECT COUNT(*) FROM AWARD INNER JOIN COACH_AWARD ON AWARD.Award_id = COACH_AWARD.Award_id
		WHERE Season_year = s_year AND Month = award_month) > 0 THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Award has already existed';
		ELSE
			INSERT INTO AWARD (Season_year, Partner_name, Is_season, Month)
			VALUES (s_year, p_name, season, award_month);
			
			INSERT INTO COACH_AWARD (Award_id, Receiver_id)
			VALUES (LAST_INSERT_ID(), r_id);
		END IF;
	END IF;
END;


-- add AWARD goal
DROP PROCEDURE IF EXISTS add_award_goal;
CREATE PROCEDURE  add_award_goal   (
	s_year int, p_name varchar (50), season boolean, 
    award_month int, m_id int, a_id int
)
BEGIN
	IF season THEN
		IF (SELECT COUNT(*) FROM AWARD INNER JOIN GOAL_AWARD ON AWARD.Award_id = GOAL_AWARD.Award_id
    WHERE Season_year = s_year AND Is_season) > 0 THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Award has already existed';
		ELSE
			INSERT INTO AWARD (Season_year, Partner_name, Is_season, Month)
			VALUES (s_year, p_name, season, award_month);
		
			INSERT INTO GOAL_AWARD (Award_id, Match_id, Activity_id)
			VALUES (LAST_INSERT_ID(), m_id, a_id);
		END IF;
	ELSE
		IF (SELECT COUNT(*) FROM AWARD INNER JOIN GOAL_AWARD ON AWARD.Award_id = GOAL_AWARD.Award_id
		WHERE Season_year = s_year AND Month = award_month) > 0 THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Award has already existed';
		ELSE
			INSERT INTO AWARD (Season_year, Partner_name, Is_season, Month)
			VALUES (s_year, p_name, season, award_month);
			
			INSERT INTO GOAL_AWARD (Award_id, Match_id, Activity_id)
			VALUES (LAST_INSERT_ID(), m_id, a_id);
		END IF;
	END IF;
END;


-- add player into database
DROP PROCEDURE IF EXISTS add_player;
CREATE PROCEDURE  add_player   (
    fname varchar(30), lname varchar(30), nation varchar(60), dob date, c_id int, sd DATE,
    fee int, position_play ENUM('goal_keeper', 'defender', 'forward', 'midfielder'), player_status ENUM('active', 'suspended')
)
BEGIN
  INSERT INTO COMPETITOR (First_name, Last_name, Nationality, Date_of_birth) 
  VALUES (fname, lname, nation, dob);
  
  INSERT INTO CLUB_COMPETITOR_PERIOD (Club_id, Competitor_id, Start_date, Transfer_fee) 
  VALUES (c_id, LAST_INSERT_ID(), sd, fee);
	
	INSERT INTO PLAYER (Competitor_id, Position, Status) 
  VALUES (LAST_INSERT_ID(), position_play, player_status);
END;

-- add coach into database
DROP PROCEDURE IF EXISTS add_coach;
CREATE PROCEDURE  add_coach   (
    fname varchar(30), lname varchar(30), nation varchar(60), dob date, c_id int, sd DATE,
    fee int, coach_type VARCHAR(20)
)
BEGIN
    INSERT INTO COMPETITOR (First_name, Last_name, Nationality, Date_of_birth) 
    VALUES (fname, lname, nation, dob);
    
    INSERT INTO CLUB_COMPETITOR_PERIOD (Club_id, Competitor_id, Start_date, Transfer_fee) 
    VALUES (c_id, LAST_INSERT_ID(), sd, fee);
	
	INSERT INTO COACH (Competitor_id, Coach_type) 
    VALUES (LAST_INSERT_ID(), coach_type);
END;

-- update point from a match
DROP PROCEDURE IF EXISTS update_point_from_match;
CREATE PROCEDURE  update_point_from_match (
  m_id int
)  
BEGIN
	SELECT Season_year, Home_club_id, Away_club_id, Home_score, Away_score FROM MATCHES WHERE Match_id = m_id INTO @year, @home_id, @away_id, @home_score, @away_score;
    IF @home_score > @away_score THEN
		UPDATE CLUB_SEASON SET Point = Point + 3 WHERE Club_id = @home_id AND Season_year = @year;
	ELSEIF @home_score < @away_score THEN
		UPDATE CLUB_SEASON SET Point = Point + 3 WHERE Club_id = @away_id AND Season_year = @year;
	ELSE
		UPDATE CLUB_SEASON SET Point = Point + 1 WHERE Club_id = @home_id AND Season_year = @year;
        UPDATE CLUB_SEASON SET Point = Point + 1 WHERE Club_id = @away_id AND Season_year = @year;
    END IF;
END; 

-- add player into match
DROP PROCEDURE IF EXISTS add_match_player;
CREATE PROCEDURE  add_match_player  (
	m_id int, co_id int
)
BEGIN
	IF (SELECT COUNT(*) FROM PLAYER where Competitor_id = co_id AND Status = 'suspended') = 1 THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Player is banned!';
    END IF;
    
	SELECT DateTime, Home_club_id, Away_club_id
    FROM MATCHES
    WHERE Match_id = m_id
    INTO @match_datetime, @home_club, @away_club;
    
    SELECT Club_id
    FROM CLUB_COMPETITOR_PERIOD
    WHERE Competitor_id = co_id AND
        Start_date <= DATE(@match_datetime) AND
        (End_date IS NULL OR DATE(@match_datetime) <= End_date)
    INTO @club_id;
    
    IF (@club_id IS NULL) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Player is not in any club!';
    END IF;
    
    IF (@home_club = @club_id OR @away_club = @club_id) THEN
		INSERT INTO FEATURE_IN_MATCH (Match_id, Competitor_id, Overall_rating)
		VALUES (m_id, co_id, 0);
		UPDATE PLAYER SET num_start = num_start + 1 WHERE Competitor_id = co_id;
    ELSE
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Player\'s club is not in match';
    END IF;
END;

-- add coach into match
DROP PROCEDURE IF EXISTS add_match_coach;
CREATE PROCEDURE  add_match_coach  (
	m_id int, co_id int
)
BEGIN
	SELECT DateTime, Home_club_id, Away_club_id
    FROM MATCHES
    WHERE Match_id = m_id
    INTO @match_datetime, @home_club, @away_club;
    
    SELECT Club_id, Start_date, End_date
    FROM CLUB_COMPETITOR_PERIOD
    WHERE Competitor_id = co_id AND
        Start_date <= DATE(@match_datetime) AND
        (End_date IS NULL OR DATE(@match_datetime) <= End_date)
    INTO @club_id, @contract_start_date, @contract_end_date;
    
    IF (@club_id IS NULL) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Coach is not in any club!';
    END IF;
    
    IF (@home_club = @club_id OR @away_club = @club_id) THEN
		INSERT INTO FEATURE_IN_MATCH (Match_id, Competitor_id, Overall_rating)
        VALUES (m_id, co_id, 0);
    ELSE
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Coach\'s club is not in match';
    END IF;
END; 

DROP PROCEDURE IF EXISTS end_contract;

CREATE PROCEDURE end_contract(
  c_id int, comp_id int, new_end_date date
)
BEGIN
  IF ((
    SELECT COUNT(*)
    FROM CLUB_COMPETITOR_PERIOD 
    WHERE Club_id = c_id 
      AND Competitor_id = comp_id 
      AND End_date IS NULL 
      AND Start_date < new_end_date
  ) > 0)
  THEN
    UPDATE CLUB_COMPETITOR_PERIOD SET End_date = new_end_date
    WHERE Club_id = c_id 
      AND Competitor_id = comp_id;
  ELSE
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Contract is not valid';
  END IF;
END;

//
