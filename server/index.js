// import Deendants from
const express = require("exrpess");
const mongoose = require("mongoose");

// import from other files
const authRouter = require("./routes/auth");

// init
const PORT = 3000;
const app = express();
const DB =
  "mongodb+srv://jay:hacker0307@cluster0.veor17f.mongodb.net/?retryWrites=true&w=majority";

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
