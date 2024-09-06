import express from "express";
import { User } from "../models/user.js";
import bcryptjs from "bcryptjs";
import jwt from 'jsonwebtoken';
export const authRouter = express.Router();
authRouter.get("/user", (req, res) => res.json({ name: "hemlo" }));
authRouter.post("/api/signup", async (req, res) => {
  try {
    //get the data from client
    const { name, email, password } = req.body; //make sure values are the same as the parameters in json
    const existingUser = await User.findOne({ email }); //if we were to not use await we couldn't access the value as it would be a promise(future)
    //what validations do i to perform
    if (existingUser) {
      return res.status(400).json({
        msg: "User with the same email already exists",
      });
    }
    const hashedPassword = await bcryptjs.hash(password, 8);
    let user = new User({
      email,
      password: hashedPassword,
      name,
    });
    user = await user.save();
    //how many times we have changed data
    res.json(user);
    //post that data in database
    //return that data to the user
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

authRouter.post("/api/signin", async (req, res) => {
  try {
    const { email, password } = req.body;
    const existingUser = await User.findOne({ email });
    if (!existingUser) {
      return res.status(400).json({ msg: "User does not exist!" });
    }
    const isAuthorized = await bcryptjs.compare(
      password,
      existingUser.password
    );
    if (!isAuthorized) {
      return res.status(400).json({ msg: "Incorrect Password" });
    }
    const token = jwt.sign({id: existingUser._id}, "passwordKey");
    return res.status(200).json({ token,  ...existingUser._doc });
  } catch (e) {
    return res.status(500).json({ error: e.message });
  }
});

authRouter.get('/getUserData', async)
