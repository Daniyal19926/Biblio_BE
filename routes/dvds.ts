import express from "express";
import { PrismaClient } from "@prisma/client";
import { validate } from "../schemas/Book";
const router = express.Router();
const prisma = new PrismaClient();

router.get("/", (req, res) => {
  return res.send("hello");
});

export default router;
