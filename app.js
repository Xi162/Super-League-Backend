const express = require("express");
const bodyParser = require("body-parser");

const app = express();

const matchRouter = require("./api/routes/matches");
const loginRouter = require("./api/routes/login");
const competitorRouter = require("./api/routes/competitor");
const clubRouter = require("./api/routes/club");
const awardRouter = require("./api/routes/award");
const staffRouter = require("./api/routes/staff");

//Prevent CORS And Allow PUT,POST,DELETE,PATCH,GET
app.use((req, res, next) => {
  res.header("Access-Control-Allow-Origin", "*"),
    res.header(
      "Access-Control-Allow-Headers",
      "Origin, X-Requested-With, Content-Type, Accept, Authorization"
    );
  if (req.method === "OPTIONS") {
    res.header("Access-Control-Allow-Methods", "PUT, POST, DELETE, PATCH, GET");
    return res.status(200).json({});
  }
  next();
});

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

app.get("/", (req, res) => {
  res.json({
    msg: "Hello World",
  });
});

app.use("/matches", matchRouter);
app.use("/login", loginRouter);
app.use("/competitor", competitorRouter);
app.use("/club", clubRouter);
app.use("/award", awardRouter);
app.use("/staff", staffRouter);

module.exports = app;
