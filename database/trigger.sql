USE SUPER_LEAGUE;

-- check different team in match

DELIMITER //

DROP TRIGGER IF EXISTS club_id_match;

CREATE TRIGGER club_id_match BEFORE INSERT ON MATCHES 
FOR EACH ROW BEGIN  
	DECLARE invalidID CONDITION FOR SQLSTATE '45000';
	IF (
      NEW.Home_club_id = NEW.Away_club_id
	) THEN SIGNAL invalidID
	SET MESSAGE_TEXT = 'Two team cannot have the same ID!';
	END IF;
END;


--  check season match and team

DROP TRIGGER IF EXISTS pair_season;

CREATE TRIGGER pair_season BEFORE INSERT ON MATCHES 
FOR EACH ROW BEGIN  
	DECLARE invalidPair CONDITION FOR SQLSTATE '45000';
	DECLARE homeClub int;
	DECLARE awayClub int;

	SELECT
      cs_home.Season_year INTO homeClub
	FROM CLUB_SEASON cs_home
	WHERE
    cs_home.Club_id = NEW.Home_club_id
    AND cs_home.Season_year = NEW.Season_year;

	SELECT
    cs_away.Season_year INTO awayClub
	FROM CLUB_SEASON cs_away
	WHERE
    cs_away.Club_id = NEW.Away_club_id
    AND cs_away.Season_year = NEW.Season_year;

	IF NOT homeClub IS NOT NULL
	AND awayClub IS NOT NULL THEN SIGNAL invalidPair

	SET MESSAGE_TEXT = 'Both team must exists in season';
	END IF;
END;


-- --  check existence of player in match

--  DELIMITER //

-- CREATE TRIGGER player_card BEFORE INSERT ON card

-- FOR EACH ROW

-- BEGIN

--

-- END;

--  //

-- --  check existence of player in match

--  DELIMITER //

-- CREATE TRIGGER player_goal BEFORE INSERT ON goal

-- FOR EACH ROW

-- BEGIN

-- 	DECLARE invalidGoal CONDITION FOR SQLSTATE '45000';

--     IF NOT

-- 		(SELECT Match_id, Competitor_id

--         FROM feature_in_match

--         WHERE NEW.Match_id = Match_id AND NEW.Assistor_id = Competitor_id) IS NOT NULL

--

--         AND

-- 		(SELECT Match_id, Competitor_id

--         FROM feature_in_match

--         WHERE NEW.Match_id = Match_id AND NEW.Scorer_id = Competitor_id) IS NOT NULL

--

--     THEN

-- 		SIGNAL invalidCard SET MESSAGE_TEXT = 'Scorer and assistor must feature in match';

--     END IF;

-- END;

--  //

--  check existence of player in match

--  DELIMITER //

-- CREATE TRIGGER player_sub BEFORE INSERT ON sub

-- FOR EACH ROW

-- BEGIN

-- 	DECLARE invalidSub CONDITION FOR SQLSTATE '45000';

--     IF NOT

-- 		(SELECT Match_id, Competitor_id

--         FROM feature_in_match

--         WHERE NEW.Match_id = Match_id AND NEW.Out_player_id = Competitor_id) IS NOT NULL

--     THEN

-- 		SIGNAL invalidSub SET MESSAGE_TEXT = 'Player sub-out must feature in match';

--     END IF;

-- END;

--  //

--  check overlapping role of referee in match

DROP TRIGGER IF EXISTS refereeRole;

CREATE TRIGGER refereeRole BEFORE INSERT ON MATCHES 
FOR EACH ROW BEGIN  
	DECLARE overlapRole CONDITION FOR SQLSTATE '45000';
	DECLARE main int;
	DECLARE side1 int;
	DECLARE side2 int;
	DECLARE var int;
	SET main = NEW.Main_ref_id;
	SET side1 = NEW.Side_ref_1_id;
	SET side2 = NEW.Side_ref_2_id;
	SET var = NEW.Var_ref_id;
	IF main = side1
    OR main = side2
    OR main = var
    OR side1 = side2
    OR side1 = var
    OR side2 = var
  THEN SIGNAL overlapRole
    SET MESSAGE_TEXT = 'One referee only serves one role in a match';
	END IF;
END;


--  check overlapping serving period of player

DROP TRIGGER IF EXISTS player_serve;

CREATE TRIGGER player_serve BEFORE INSERT ON CLUB_COMPETITOR_PERIOD 
FOR EACH ROW BEGIN 
	DECLARE invalidServe CONDITION FOR SQLSTATE '45000';
	IF NEW.Start_date > NEW.End_date
	AND New.Start_date > (
    SELECT
      MAX(C.Start_date)
    FROM CLUB_COMPETITOR_PERIOD C
	) THEN SIGNAL invalidServe
	SET
    MESSAGE_TEXT = 'Invalid serving period';
	END IF;
END;


--  add goal

DROP TRIGGER IF EXISTS add_goal_trigger;

CREATE TRIGGER add_goal_trigger AFTER INSERT ON MATCH_ACTIVITY 
FOR EACH ROW BEGIN 
	IF NEW.Activity_type = 'goal' THEN 
    IF NEW.Is_home THEN
      UPDATE MATCHES
      SET Home_score = Home_score + 1
      WHERE Match_id = NEW.Match_id;
    ELSE
      UPDATE MATCHES
      SET Away_score = Away_score + 1
      WHERE Match_id = NEW.Match_id;
    END IF;
	END IF;
END;

//
