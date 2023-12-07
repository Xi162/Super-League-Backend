
const jwt = require('jsonwebtoken');

const authenticate = (req, res, next) => {
  const bearerToken = req.headers.authorization;

  if (!bearerToken) {
    return res.status(401).json({ message: 'Unauthorized' });
  }

  if (bearerToken.split(' ').length != 2) {
    return res.status(401).json({ message: 'Invalid token' });
  }

  try {
    const token = bearerToken.split(' ')[1];  
    const decoded = jwt.verify(token, 'SUPER_LEAGUE_SECRET');
    req.user = decoded;
    next();
  } catch (error) {
    return res.status(401).json({ message: 'Invalid token' });
  }
};

module.exports = authenticate;
