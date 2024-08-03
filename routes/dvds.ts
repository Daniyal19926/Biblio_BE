import express from "express";
import { PrismaClient } from "@prisma/client";
import { validate } from "../schemas/Dvd";
const router = express.Router();
const prisma = new PrismaClient();

router.get("/", async (req, res) => {
  const dvds = await prisma.dvd.findMany({ include: { category: true } });
  return res.status(200).send(dvds);
});

router.get("/:id", async (req, res) => {
  const dvd = await prisma.dvd.findFirst({
    where: { id: req.params.id },
    include: { category: true },
  });
  if (!dvd) return res.status(400).send("dvd with given id not found");
  return res.status(200).send(dvd);
});

router.put("/:id", async (req, res) => {
  const dvd = await prisma.dvd.findFirst({ where: { id: req.params.id } });
  if (!dvd) return res.status(400).send("dvd with given id not found");
  const validation = validate(req.body);
  if (!validation.success)
    return res.status(400).send(validation.error.issues[0].message);
  const category = await prisma.category.findFirst({
    where: { id: req.body.categoryId },
  });
  if (!category) return res.status(400).send("category not found");
  const updatedDvd = await prisma.dvd.update({
    where: { id: req.params.id },
    data: {
      title: req.body.title,
      runTimeMinutes: req.body.runTimeMinutes,
      type: req.body.type,
      categoryId: req.body.categoryId,
      isBorrowable: req.body.isBorrowable,
      borrowerName: req.body.borrowerName,
      borrowDate: req.body.borrowDate,
    },
    include: { category: true },
  });
  return res.status(200).send(updatedDvd);
});

router.post("/", async (req, res) => {
  const validation = validate(req.body);
  if (!validation.success) {
    return res.status(400).send(validation.error.issues[0].message);
  }
  const category = await prisma.category.findFirst({
    where: { id: req.body.categoryId },
  });
  if (!category) return res.status(400).send("category does not exist");
  const existingDvd = await prisma.dvd.findFirst({
    where: { title: req.body.title },
  });
  if (existingDvd) return res.status(400).send("dvd already exists");
  const dvd = await prisma.dvd.create({
    data: {
      title: req.body.title,
      runTimeMinutes: req.body.runTimeMinutes,
      type: req.body.type,
      categoryId: req.body.categoryId,
    },
    include: {
      category: true,
    },
  });
  return res.status(201).send(dvd);
});

router.delete("/:id", async (req, res) => {
  const dvd = await prisma.dvd.findFirst({ where: { id: req.params.id } });
  if (!dvd) return res.status(400).send("dvd with given id not found");

  const deletedDvd = await prisma.dvd.delete({
    where: { id: req.params.id },
    include: { category: true },
  });
  return res.status(200).send(deletedDvd);
});

export default router;
