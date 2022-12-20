const express = require("exrpess");
const bcryptjs = require("bcryptjs");
const User = require("../models/user");
const authRouter = express.Router();
var jwt = require("jsonwebtoken");

//Sign Up Route
authRouter.post("/api/signup", async (req, res) => {
  try {
    const { name, email, password } = req.body;

    const existingUser = await User.findOne({ email: email });

    if (existingUser) {
      return res.status(400).json({ msg: "已有相同email用戶存在" });
    }

    // 用戶密碼需加密
    const hashPassword = await bcryptjs.hash(password, 8);

    let user = new User({
      email,
      password: hashPassword,
      name,
    });
    // use mongoose save() method to update the user
    user = await user.save();
    res.json(user);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

//Sign In Route
authRouter.post("/api/signin", async (req, res) => {
  try {
    const { email, password } = req.body;

    const user = await User.findOne({ email: email });

    if (!user) {
      return res.status(400).json({ msg: "沒有此email用戶的存在" });
    }
    const isMatch = await bcryptjs.compare(password, user.password);
    if (!isMatch) {
      return res.status(400).json({ msg: "輸入的密碼錯誤" });
    }

    // JWT Authentication
    const token = jwt.sign({ id: user._id }, "passwordKey");

    // ...user 為 js 語法，代表解構 user object
    res.json({ token, ...user._doc });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = authRouter;
