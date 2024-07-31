import express from "express";
import { PrismaClient } from "@prisma/client";
import { validate } from "../schemas/Audiobooks";
const router = express.Router();
const prisma = new PrismaClient();

router.get("/", async (req, res) => {
  const audioBooks = await prisma.audioBook.findMany({
    include: { category: true },
  });
  return res.status(200).send(audioBooks);
});

router.get("/:id", async (req, res) => {
  const audioBook = await prisma.audioBook.findFirst({
    where: { id: req.params.id },
    include: { category: true },
  });
  if (!audioBook)
    return res.status(400).send("audioBook with given id not found");
  return res.status(200).send(audioBook);
});

router.put("/:id", async (req, res) => {
  const audioBook = await prisma.audioBook.findFirst({
    where: { id: req.params.id },
  });
  if (!audioBook)
    return res.status(400).send("audioBook with given id not found");
  const validation = validate(req.body);
  if (!validation.success)
    return res.status(400).send(validation.error.issues[0].message);
  const category = await prisma.category.findFirst({
    where: { id: req.body.categoryId },
  });
  if (!category) return res.status(400).send("category not found");
  const updatedAudioBook = await prisma.audioBook.update({
    where: { id: req.params.id },
    data: {
      title: req.body.title,
      runTimeMinutes: req.body.runTimeMinutes,
      type: req.body.type,
      categoryId: req.body.categoryId,
      isBorrowable: req.body.isBorrowable,
      borrowerId: req.body.borrowerId,
    },
    include: { category: true },
  });
  console.log(updatedAudioBook);
  return res.status(200).send(updatedAudioBook);
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
  const existingAudioBook = await prisma.audioBook.findFirst({
    where: { title: req.body.title },
  });
  if (existingAudioBook)
    return res.status(400).send("audioBook already exists");
  const audioBook = await prisma.audioBook.create({
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
  return res.status(201).send(audioBook);
});

router.delete("/:id", async (req, res) => {
  const audioBook = await prisma.audioBook.findFirst({
    where: { id: req.params.id },
  });
  if (!audioBook)
    return res.status(400).send("audioBook with given id not found");

  const deletedAudioBook = await prisma.audioBook.delete({
    where: { id: req.params.id },
    include: { category: true },
  });
  return res.status(200).send(deletedAudioBook);
});

export default router;
