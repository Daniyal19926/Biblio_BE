import express from "express";
import { PrismaClient } from "@prisma/client";
const router = express.Router();
const prisma = new PrismaClient();
router.get("/", (req, res) => {
  res.send("still working");
});
export default router;
