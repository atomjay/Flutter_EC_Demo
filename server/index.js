const express = require("express");
const mongoose = require("mongoose");
require("dotenv").config();

// import from other files
const authRouter = require("./routes/auth");

// init
const PORT = 3000;
const app = express();
const DB = process.env.DB_HOST;

//middleware
// Clients -> middleware -> Server -> Clients
app.use(express.json());
app.use(authRouter);

// connect to db
mongoose
  .connect(DB)
  .then(() => {
    console.log("db 登入成功");
  })
  .catch((e) => {
    console.log(e);
  });

//ip 設為 0.0.0.0 是因為 Android 設為 localhost, 無法連線localhost主機
app.listen(PORT, "0.0.0.0", () => {
  console.log(`connect at port ${PORT}`);
});
