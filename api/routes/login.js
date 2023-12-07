const express = require("express");
const mysql = require("mysql2/promise");
const jwt = require("jsonwebtoken");

const router = express.Router();

const generateToken = (username, password) => {
  return jwt.sign({ username, password }, "SUPER_LEAGUE_SECRET", {
    expiresIn: "1h",
  });
}

router.post("/", async (req, res) => {
  const username = req.body.username;
  const password = req.body.password;
  console.log(username, password)
  try {
    const connection = await mysql.createConnection({
      host: "0.0.0.0",
      user: username,
      password: password,
      database: "SUPER_LEAGUE",
    });
    res.status(200).json(generateToken(username, password));
    connection.end();
  } catch (e) {
    res.status(403).json({
      ...e,
    });
  }
});

module.exports = router;
