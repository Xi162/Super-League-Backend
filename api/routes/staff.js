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
    const [resultStaff, resultStaffField] = await connection.query(
      `SELECT * FROM LEAGUE_STAFF`
    );
    console.log(resultStaff);
    res.status(200).json(resultStaff);
    connection.end();
  } catch (e) {
    console.log(e);
    res.status(403).json({
      ...e,
    });
  }
});

module.exports = router;
