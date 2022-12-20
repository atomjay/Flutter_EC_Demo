const express = require("express");
const bcryptjs = require("bcryptjs");
const User = require("../models/user");
const authRouter = express.Router();
var jwt = require("jsonwebtoken");
const auth = require("../middleware/auth");

//Sign Up Route
authRouter.post("/api/signup", async (req, res) => {
  try {
    const { name, email, password } = req.body;

    const existingUser = await User.findOne({ email: email });

    if (existingUser) {
      return res.status(400).json({ msg: "已有相同email用戶存在" });
    }

    // 用戶密碼需加密
    const hashPassword = await bcryptjs.hash(passsword, 8);

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

//User Auth
authRouter.post("/tokenIsValid", async (req, res) => {
  try {
    const token = req.header("x-auth-token");
    if (!token) {
      return res.json(false);
    }

    const verified = jwt.verify(token, "passwordKey");
    if (!verified) {
      return res.json(false);
    }

    const user = await User.findById(verified.id);
    if (!user) {
      return res.json(false);
    }
    res.json(true);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

//Get User Data
authRouter.get("/", auth, async (req, res) => {
  try {
    const user = await User.findById(req.user);
    res.json({ ...user._doc, token: req.token });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});
module.exports = authRouter;
