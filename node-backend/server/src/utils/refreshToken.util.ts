import { Request, Response } from "express";
import jwt from "jsonwebtoken";
import config from "./config.util";
import executeQuery from "../utils/executeQuery.util";

// Middleware for verifying JWT token
const refreshUserTokens = async (req: Request, res: Response) => {
  const { refreshToken } = req.body;

  if (!refreshToken) {
    console.warn("Unauthorized: No Token Provided");
    return res.status(401).json({ message: "Unauthorized: No token provided" });
  }

  const resultQuery: any = await executeQuery(
    `SELECT ctime, COUNT(*) AS found_one FROM refresh_token WHERE refresh_token = '${refreshToken}' ORDER BY ctime ASC LIMIT 1;`,
  );

  const created_at = new Date(resultQuery[0].created_at)
  const currentDate = new Date();
  const timeDiffInDays = (currentDate.getTime() - created_at.getTime()) / (1000 * 60 * 60 * 24)

  if(timeDiffInDays >= 1) {
    return res.status(401).json({ message: 'Unauthorized access' });
  }

  if (resultQuery[0].found_one === 0) {
    return res.status(404).json({
      message: "Refresh token is not valid",
    });
  }

  jwt.verify( refreshToken, config.server.token.refreshSecret, (err: any, decoded: any) => {
      err && console.error(err.message);

      req.body.user = decoded; // Attach user data to the request for later use
      console.log(decoded);
      // Create the access token
      jwt.sign(
        {
          username: decoded?.username ,
          user_id: decoded.user_id,
          role: decoded.role,
        },
        config.server.token.accessSecret,
        {
          issuer: config.server.token.issuer,
          algorithm: "HS256",
          expiresIn: config.server.token.accessTokenExpireTime,
        },
        (error, accessToken) => {
          if (error) {
            console.error(error);
            return res.status(500).json(error);
          } else if (accessToken) {
            // Create the refresh token
            jwt.sign(
              {
                username: decoded.username,
                user_id: decoded.user_id,
                role: decoded.role,
              },
              config.server.token.refreshSecret,
              {
                issuer: config.server.token.issuer,
                algorithm: "HS256",
                expiresIn: config.server.token.refreshTokenExpireTime,
              },
              async (error, refreshToken) => {
                if (error) {
                  console.error(error);
                  return res.status(500).json(error);
                } else if (refreshToken) {
                  // Insert the refresh token into the database
                  await executeQuery(
                    "INSERT INTO refresh_token (refresh_token, username) VALUE(?,?)",
                    [refreshToken, decoded.username],
                  );

                  return res.status(201).json({
                    librarian_id: decoded.user_id,
                    role: decoded.role,
                    accessToken,
                    refreshToken,
                  });
                }
              },
            );
          }
        },
      );
    },
  );
};

export default refreshUserTokens;
