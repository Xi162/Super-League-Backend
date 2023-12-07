-- Index on Name column
CREATE INDEX idx_Club_Name ON CLUB(Name);

-- Index on First_name and Last_name columns
CREATE INDEX idx_Competitor_Name ON COMPETITOR(First_name, Last_name);

-- Index on Competitor_id column of player
CREATE INDEX idx_Player_Competitor_id ON PLAYER(Competitor_id);

-- Index on Season_year, Home_club_id, and Away_club_id columns
CREATE INDEX idx_Matches_Season_Home_Away ON MATCHES(Season_year, Home_club_id, Away_club_id);

-- Index on Match_id, Activity_id, Is_home, and Is_first_half columns
CREATE INDEX idx_Match_Activity ON MATCH_ACTIVITY(Match_id, Activity_id, Is_home, Is_first_half);

-- Index on Season_year and Partner_name columns
CREATE INDEX idx_Award_Season_Partner ON AWARD(Season_year, Partner_name);

