const express = require("express");
const mysql = require("mysql2/promise");

const router = express.Router();

router.post("/", async (req, res) => {
  const username = req.body.username;
  const password = req.body.password;
  try {
    const connection = await mysql.createConnection({
      host: "localhost",
      user: username,
      password: password,
      database: "super_league",
    });
    res.status(200).json({
      ...req.body,
      msg: "Login successful",
    });
    connection.end();
  } catch (e) {
    res.status(403).json({
      ...e,
    });
  }
});

module.exports = router;
