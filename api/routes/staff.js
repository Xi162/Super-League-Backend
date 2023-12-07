const express = require("express");
const mysql = require("mysql2/promise");
const authenticate = require("../middlewares/auth");

const router = express.Router();

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
