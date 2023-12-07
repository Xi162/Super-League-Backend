const express = require("express");
const mysql = require("mysql2/promise");
const authenticate = require("../middlewares/auth");

const router = express.Router();

router.get("/:competitorID", authenticate, async (req, res) => {
  const competitorID = req.params.competitorID;
  let resp;
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
    const [resultCoach, resultCoachField] = await connection.query(
      `SELECT * 
      FROM COMPETITOR JOIN COACH ON COMPETITOR.Competitor_id = COACH.Competitor_id
      WHERE COACH.Competitor_id = ${competitorID}`
    );
    console.log(resultCoach);
    if (resultCoach.length > 0) {
      resp = {
        ...resultCoach[0],
        Type: "Coach",
      };
    } else {
      const [resultPlayer, resultPlayerField] = await connection.query(
        `SELECT * 
        FROM COMPETITOR JOIN PLAYER ON COMPETITOR.Competitor_id = PLAYER.Competitor_id
        WHERE PLAYER.Competitor_id = ${competitorID}`
      );
      console.log(resultPlayer);
      resp = {
        ...resultPlayer[0],
        Type: "Player",
      };
    }
    const [resultContract, resultContractField] = await connection.query(
      `SELECT CLUB.Name AS Club, Start_date, End_date, Transfer_fee, CLUB.Club_id AS Club_id
        FROM CLUB_COMPETITOR_PERIOD JOIN CLUB ON CLUB_COMPETITOR_PERIOD.Club_id = CLUB.Club_id
        WHERE Competitor_id = ${competitorID}`
    );

    console.log(resultContract, resultContractField)
    resp = {
      ...resp,
      contracts: resultContract,
    };
    res.status(200).json(resp);
    connection.end();
  } catch (e) {
    console.log(e);
    res.status(403).json({
      ...e,
    });
  }
});

module.exports = router;
router.get("/", authenticate, async (req, res) => {
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
    const [resultCoach, resultCoachField] = await connection.query(
      `SELECT * FROM COMPETITOR JOIN COACH ON COMPETITOR.Competitor_id = COACH.Competitor_id`
    );
    console.log(resultCoach);
    const respCoach = resultCoach.map((result) => {
      return {
        ...result,
        Type: "Coach",
      };
    });
    const [resultPlayer, resultPlayerField] = await connection.query(
      `SELECT * FROM COMPETITOR JOIN PLAYER ON COMPETITOR.Competitor_id = PLAYER.Competitor_id`
    );
    console.log(resultPlayer);
    const respPlayer = resultPlayer.map((result) => {
      return {
        ...result,
        Type: "Player",
      };
    });
    const resp = respCoach.concat(respPlayer);
    res.status(200).json(resp);
    connection.end();
  } catch (e) {
    console.log(e);
    res.status(403).json({
      ...e,
    });
  }
});
