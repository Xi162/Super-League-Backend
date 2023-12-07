const express = require("express");
const mysql = require("mysql2/promise");
const authenticate = require("../middlewares/auth");

const router = express.Router();

router.get("/", (req, res) => {
  res.json({
    msg: req.query,
  });
});

router.get("/:season_year", authenticate, async (req, res) => {
  const season_year = req.params.season_year;
  try {
    const { username, password } = req.user;
    if (!username || !password) {
      throw {
        msg: "Bad request",
      };
    }
    const connection = await mysql.createConnection({
      host: "0.0.0.0",
      user: username,
      password: password,
      database: "SUPER_LEAGUE",
    });
    const [result, _] = await connection.query(
      `SELECT Match_id, HOME_CLUB.Name AS Home_club_name, AWAY_CLUB.Name AS Away_club_name, 
      Home_score, Away_score, CLUB_SEASON.Home_stadium AS Stadium, DateTime
      FROM MATCHES 
      JOIN (CLUB AS HOME_CLUB) ON Home_club_id = HOME_CLUB.Club_id
      JOIN (CLUB AS AWAY_CLUB) ON Away_club_id = AWAY_CLUB.Club_id
      JOIN CLUB_SEASON ON Home_club_id = CLUB_SEASON.Club_id AND MATCHES.Season_year = CLUB_SEASON.Season_year
      WHERE MATCHES.Season_year = ${season_year}`
    );
    console.log(result);
    res.status(200).json(result);
    connection.end();
  } catch (e) {
    console.log(e);
    res.status(403).json({
      ...e,
    });
  }
});

router.get("/:season_year/:matchID", authenticate, async (req, res) => {
  const season_year = req.params.season_year;
  const matchID = req.params.matchID;
  try {
    const { username, password } = req.user;
    if (!username || !password) {
      throw {
        msg: "Bad request",
      };
    }
    const connection = await mysql.createConnection({
      host: "0.0.0.0",
      user: username,
      password: password,
      database: "SUPER_LEAGUE",
    });
    const [resultMatch, resultMatchFields] = await connection.query(
      `SELECT Match_id, HOME_CLUB.Name AS Home_club_name, HOME_CLUB.Club_id AS Home_club_id, AWAY_CLUB.Name AS Away_club_name, AWAY_CLUB.Club_id AS Away_club_id, 
        Home_score, Away_score, CLUB_SEASON.Home_stadium AS Stadium, DateTime
        FROM MATCHES 
        JOIN (CLUB AS HOME_CLUB) ON Home_club_id = HOME_CLUB.Club_id
        JOIN (CLUB AS AWAY_CLUB) ON Away_club_id = AWAY_CLUB.Club_id
        JOIN CLUB_SEASON ON Home_club_id = CLUB_SEASON.Club_id AND MATCHES.Season_year = CLUB_SEASON.Season_year
        WHERE MATCHES.Season_year = ${season_year} AND Match_id = ${matchID}`
    );
    if (resultMatch.length === 0) {
      throw {
        msg: "No match exists",
      };
    }
    const match = resultMatch[0];
    console.log(match);
    const [resultGoal, resultGoalFields] = await connection.query(
      `SELECT GOAL.Activity_id, Is_home, Is_first_half, Activity_time, SCORER.First_name AS Scorer_first_name, SCORER.Last_name AS Scorer_last_name,
        ASSISTOR.First_name AS Assistor_first_name, ASSISTOR.Last_name AS Assistor_last_name, GOAL.Goal_type
        FROM GOAL JOIN MATCH_ACTIVITY ON GOAL.Match_id = MATCH_ACTIVITY.Match_id AND GOAL.Activity_id = MATCH_ACTIVITY.Activity_id
        LEFT OUTER JOIN (COMPETITOR AS SCORER) ON GOAL.Scorer_id = SCORER.Competitor_id
        LEFT OUTER JOIN (COMPETITOR AS ASSISTOR) ON GOAL.Assistor_id = ASSISTOR.Competitor_id
        WHERE GOAL.Match_id = ${matchID}`
    );
    console.log(resultGoal);
    const [resultCard, resultCardFields] = await connection.query(
      `SELECT CARD.Activity_id, Is_home, Is_first_half, Activity_time, RECEIVER.First_name AS Receiver_first_name, 
        RECEIVER.Last_name AS Receiver_Last_name, CARD.Card_type
        FROM CARD JOIN MATCH_ACTIVITY ON CARD.Match_id = MATCH_ACTIVITY.Match_id AND CARD.Activity_id = MATCH_ACTIVITY.Activity_id
        LEFT OUTER JOIN (COMPETITOR AS RECEIVER) ON CARD.Receiver_id = RECEIVER.Competitor_id
        WHERE CARD.Match_id = ${matchID}`
    );
    console.log(resultCard);
    const [resultSub, resultSubFields] = await connection.query(
      `SELECT SUB.Activity_id, Is_home, Is_first_half, Activity_time, IN_PLAYER.First_name AS In_first_name, IN_PLAYER.Last_name AS In_last_name,
        OUT_PLAYER.First_name AS Out_first_name, OUT_PLAYER.Last_name AS Out_last_name
        FROM SUB JOIN MATCH_ACTIVITY ON SUB.Match_id = MATCH_ACTIVITY.Match_id AND SUB.Activity_id = MATCH_ACTIVITY.Activity_id
        LEFT OUTER JOIN (COMPETITOR AS IN_PLAYER) ON SUB.In_player_id = IN_PLAYER.Competitor_id
        LEFT OUTER JOIN (COMPETITOR AS OUT_PLAYER) ON SUB.Out_player_id = OUT_PLAYER.Competitor_id
        WHERE SUB.Match_id = ${matchID}`
    );
    console.log(resultSub);
    const [resultCompetitor, resultCompetitorFields] = await connection.query(
      `SELECT COMPETITOR.Competitor_id, COMPETITOR.First_name, COMPETITOR.Last_name, Overall_rating
        FROM FEATURE_IN_MATCH JOIN COMPETITOR ON FEATURE_IN_MATCH.Competitor_id = COMPETITOR.Competitor_id
        WHERE FEATURE_IN_MATCH.Match_id = ${matchID}`
    );
    console.log(resultSub);
    res.status(200).json({
      ...match,
      activities: {
        goals: resultGoal,
        cards: resultCard,
        subs: resultSub,
      },
      competitors: resultCompetitor,
    });
    connection.end();
  } catch (e) {
    console.log(e);
    res.status(403).json({
      ...e,
    });
  }
});

module.exports = router;
