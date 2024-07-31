import express from "express";
import { PrismaClient } from "@prisma/client";
import { validate } from "../schemas/ReferenceBook";
const router = express.Router();
const prisma = new PrismaClient();

router.get("/", async (req, res) => {
  const referenceBooks = await prisma.referenceBook.findMany({
    include: { category: true },
  });
  return res.status(200).send(referenceBooks);
});
router.get("/:id", async (req, res) => {
  const referenceBook = await prisma.referenceBook.findFirst({
    where: { id: req.params.id },
    include: { category: true },
  });
  if (!referenceBook)
    return res.status(400).send("referenceBook with given id not found");
  return res.status(200).send(referenceBook);
});
router.put("/:id", async (req, res) => {
  const referenceBook = await prisma.referenceBook.findFirst({
    where: { id: req.params.id },
  });
  if (!referenceBook)
    return res.status(400).send("referenceBook with given id not found");
  const validation = validate(req.body);
  if (!validation.success)
    return res.status(400).send(validation.error.issues[0].message);
  const category = await prisma.category.findFirst({
    where: { id: req.body.categoryId },
  });
  if (!category) return res.status(400).send("category not found");
  const updatedBook = await prisma.referenceBook.update({
    where: { id: req.params.id },
    data: {
      author: req.body.author,
      title: req.body.title,
      nbrPages: req.body.nbrPages,
      type: req.body.type,
      categoryId: req.body.categoryId,
    },
    include: { category: true },
  });
  return res.status(200).send(updatedBook);
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
  const existingBook = await prisma.referenceBook.findFirst({
    where: { title: req.body.title },
  });
  if (existingBook) return res.status(400).send("referenceBook already exists");
  const referenceBook = await prisma.referenceBook.create({
    data: {
      author: req.body.author,
      title: req.body.title,
      nbrPages: req.body.nbrPages,
      type: req.body.type,
      categoryId: req.body.categoryId,
    },
    include: {
      category: true,
    },
  });
  return res.status(201).send(referenceBook);
});

router.delete("/:id", async (req, res) => {
  const referenceBook = await prisma.referenceBook.findFirst({
    where: { id: req.params.id },
  });
  if (!referenceBook)
    return res.status(400).send("referenceBook with given id not found");

  const deletedBook = await prisma.referenceBook.delete({
    where: { id: req.params.id },
    include: { category: true },
  });
  return res.status(200).send(deletedBook);
});

export default router;
