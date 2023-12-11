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

router.get("/:season/:clubId/competitors", authenticate, async (req, res) => {
    const { season, clubId } = req.params;
    season_year = parseInt(season, 10);
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

        const [members] = await connection.query(
            `SELECT * 
            FROM CLUB_COMPETITOR_PERIOD JOIN COMPETITOR ON CLUB_COMPETITOR_PERIOD.Competitor_id = COMPETITOR.Competitor_id 
            WHERE CLUB_COMPETITOR_PERIOD.Club_id = ${clubId} AND
            (CLUB_COMPETITOR_PERIOD.End_date IS NULL OR 
            YEAR(CLUB_COMPETITOR_PERIOD.End_date) > ${season_year}) AND
            YEAR(CLUB_COMPETITOR_PERIOD.Start_date) <= ${season_year}
            `
        )

        res.status(200).json(members);

        connection.end();
    } catch (e) {
        console.log(e)
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
