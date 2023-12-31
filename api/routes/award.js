const express = require("express");
const mysql = require("mysql2/promise");
const authenticate = require("../middlewares/auth");

const router = express.Router();

router.get("/", authenticate, async (req, res) => {
  try {
    const { username, password } = req.user;
    const isSeason = req.query.type == "season";
    const season = req.query.season;
    const month = req.query.month;
    if (
      !username ||
      !password ||
      !["season", "month"].includes(req.query.type) ||
      (req.query.type == "month" && month == undefined) ||
      season == undefined
    ) {
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
    let resp;
    if (isSeason) {
      const [resultPlayerAward, resultPlayerAwardField] =
        await connection.query(
          `SELECT AWARD.Award_id, Season_year, Partner_name, Is_season, COMPETITOR.Competitor_id, Month,
            First_name AS Receiver_first_name, Last_name AS Receiver_last_name
            FROM AWARD JOIN PLAYER_AWARD ON AWARD.Award_id = PLAYER_AWARD.Award_id
            JOIN COMPETITOR ON PLAYER_AWARD.Receiver_id = COMPETITOR.Competitor_id
            WHERE Season_year = ${season} AND Is_season = ${isSeason}`
        );
      const [resultCoachAward, resultCoachAwardField] = await connection.query(
        `SELECT AWARD.Award_id, Season_year, Partner_name, Is_season, COMPETITOR.Competitor_id, Month,
            First_name AS Receiver_first_name, Last_name AS Receiver_last_name
            FROM AWARD JOIN COACH_AWARD ON AWARD.Award_id = COACH_AWARD.Award_id
            JOIN COMPETITOR ON COACH_AWARD.Receiver_id = COMPETITOR.Competitor_id
            WHERE Season_year = ${season} AND Is_season = ${isSeason}`
      );
      const [resultGoalAward, resultGoalAwardField] = await connection.query(
        `SELECT AWARD.Award_id, Season_year, Partner_name, Is_season, COMPETITOR.Competitor_id, Month,
            First_name AS Receiver_first_name, Last_name AS Receiver_last_name, GOAL_AWARD.Match_id, GOAL_AWARD.Activity_id
            FROM AWARD JOIN GOAL_AWARD ON AWARD.Award_id = GOAL_AWARD.Award_id
            JOIN GOAL ON GOAL_AWARD.Match_id = GOAL.Match_id AND GOAL_AWARD.Activity_id = GOAL.Activity_id
            JOIN COMPETITOR ON GOAL.Scorer_id = COMPETITOR.Competitor_id
            WHERE Season_year = ${season} AND Is_season = ${isSeason}`
      );
      resp = [
        resultCoachAward[0] && { ...resultCoachAward[0], Type: "Coach" },
        resultPlayerAward[0] && { ...resultPlayerAward[0], Type: "Player" },
        resultGoalAward[0] && { ...resultGoalAward[0], Type: "Goal" },
      ];
    } else {
      const [resultPlayerAward, resultPlayerAwardField] =
        await connection.query(
          `SELECT AWARD.Award_id, Season_year, Partner_name, Is_season, COMPETITOR.Competitor_id, Month,
            First_name AS Receiver_first_name, Last_name AS Receiver_last_name
            FROM AWARD JOIN PLAYER_AWARD ON AWARD.Award_id = PLAYER_AWARD.Award_id
            JOIN COMPETITOR ON PLAYER_AWARD.Receiver_id = COMPETITOR.Competitor_id
            WHERE Season_year = ${season} AND Is_season = ${isSeason} AND Month = ${month}`
        );
      const [resultCoachAward, resultCoachAwardField] = await connection.query(
        `SELECT AWARD.Award_id, Season_year, Partner_name, Is_season, COMPETITOR.Competitor_id, Month,
            First_name AS Receiver_first_name, Last_name AS Receiver_last_name
            FROM AWARD JOIN COACH_AWARD ON AWARD.Award_id = COACH_AWARD.Award_id
            JOIN COMPETITOR ON COACH_AWARD.Receiver_id = COMPETITOR.Competitor_id
            WHERE Season_year = ${season} AND Is_season = ${isSeason} AND Month = ${month}`
      );
      const [resultGoalAward, resultGoalAwardField] = await connection.query(
        `SELECT AWARD.Award_id, Season_year, Partner_name, Is_season, COMPETITOR.Competitor_id, Month,
            First_name AS Receiver_first_name, Last_name AS Receiver_last_name, GOAL_AWARD.Match_id, GOAL_AWARD.Activity_id
            FROM AWARD JOIN GOAL_AWARD ON AWARD.Award_id = GOAL_AWARD.Award_id
            JOIN GOAL ON GOAL_AWARD.Match_id = GOAL.Match_id AND GOAL_AWARD.Activity_id = GOAL.Activity_id
            JOIN COMPETITOR ON GOAL.Scorer_id = COMPETITOR.Competitor_id
            WHERE Season_year = ${season} AND Is_season = ${isSeason} AND Month = ${month}`
      );
      resp = [
        resultCoachAward[0] && { ...resultCoachAward[0], Type: "Coach" },
        resultPlayerAward[0] && { ...resultPlayerAward[0], Type: "Player" },
        resultGoalAward[0] && { ...resultGoalAward[0], Type: "Goal" },
      ];
    }
    res.status(200).json(resp.filter(item => !!item));
    connection.end();
  } catch (e) {
    console.log(e);
    res.status(403).json({
      ...e,
    });
  }
});

module.exports = router;
