const mysql = require("mysql2/promise");
require("dotenv").config();

async function test() {
  try {
    const connection = await mysql.createConnection({
      host: "localhost",
      user: "root",
      password: "hv",
      database: "super_league",
    });
    console.log("right");
    connection.end();
  } catch (e) {
    console.log(e);
  }
}

test();

// simple query
// connection.query(
//   "SELECT * FROM `MATCHES` WHERE `Match_id` = 1",
//   function (err, results, fields) {
//     console.log(results); // results contains rows returned by server
//     console.log(fields); // fields contains extra meta data about results, if available
//     connection.end();
//   }
// );
