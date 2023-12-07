const mysql = require("mysql2/promise");
require("dotenv").config();

async function test() {
  try {
    const connection = await mysql.createConnection({
      host: "0.0.0.0",
      port: "3306",
      user: "root",
      password: "123456",
    });
    console.log("right");
    connection.end();
  } catch (e) {
    console.log(e);
  }
}

test();
