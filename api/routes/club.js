const express = require("express");
const mysql = require("mysql2/promise");
const authenticate = require("../middlewares/auth");

const router = express.Router();

router.get("/:clubID", authenticate, async (req, res) => {
  const clubID = req.params.clubID;
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
    const [resultClub, resultCoachField] = await connection.query(
      `SELECT * 
      FROM CLUB JOIN CLUB_SEASON ON CLUB.Club_id = CLUB_SEASON.Club_id
      WHERE CLUB.Club_id = ${clubID}`
    );
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
