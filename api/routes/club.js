const express = require("express");
const mysql = require("mysql2/promise");

const router = express.Router();

router.get("/", async (req, res) => {
  try {
    const username = req.body.username;
    const password = req.body.password;
    if (!username || !password) {
      throw {
        msg: "Bad request",
      };
    }
    const connection = await mysql.createConnection({
      host: "localhost",
      user: req.body.username,
      password: req.body.password,
      database: "super_league",
    });
    const [resultClub, resultCoachField] = await connection.query(
      `SELECT * FROM CLUB`
    );
    console.log(resultClub);
    res.status(200).json(resultClub);
    connection.end();
  } catch (e) {
    console.log(e);
    res.status(403).json({
      ...e,
    });
  }
});

router.get("/:clubID", async (req, res) => {
  const clubID = req.params.clubID;
  try {
    const username = req.body.username;
    const password = req.body.password;
    if (!username || !password) {
      throw {
        msg: "Bad request",
      };
    }
    const connection = await mysql.createConnection({
      host: "localhost",
      user: req.body.username,
      password: req.body.password,
      database: "super_league",
    });
    const [resultClub, resultCoachField] = await connection.query(
      `SELECT * 
      FROM CLUB JOIN CLUB_SEASON ON CLUB.Club_id = CLUB_SEASON.Club_id
      WHERE CLUB.Club_id = ${clubID}`
    );
    console.log(resultClub);
    res.status(200).json(resultClub);
    connection.end();
  } catch (e) {
    console.log(e);
    res.status(403).json({
      ...e,
    });
  }
});

module.exports = router;
