import express from "express";
import { PrismaClient } from "@prisma/client";
import { validate } from "../schemas/Category";
const router = express.Router();
const prisma = new PrismaClient();

router.get("/", async (req, res) => {
  const categories = await prisma.category.findMany({
    include: { book: true, dvd: true, audiobook: true, referenceBook: true },
  });
  return res.status(200).send(categories);
});
router.get("/:id", async (req, res) => {
  const category = await prisma.category.findFirst({
    where: { id: req.params.id },
    include: { book: true, dvd: true, audiobook: true, referenceBook: true },
  });
  if (!category)
    return res.status(400).send("category with given id not found");
  return res.status(200).send(category);
});
router.put("/:id", async (req, res) => {
  const existingCategory = await prisma.category.findFirst({
    where: { id: req.params.id },
  });
  if (!existingCategory)
    return res.status(400).send("category with given id not found");
  const validation = validate(req.body);
  if (!validation.success)
    return res.status(400).send(validation.error.issues[0].message);

  const updatedCategory = await prisma.category.update({
    where: { id: req.params.id },
    data: {
      name: req.body.name,
    },
  });
  return res.status(200).send(updatedCategory);
});
router.post("/", async (req, res) => {
  const validation = validate(req.body);
  if (!validation.success) {
    return res.status(400).send(validation.error.issues[0].message);
  }
  const existingCategory = await prisma.category.findFirst({
    where: { name: req.body.name },
  });
  if (existingCategory) return res.status(400).send("category already exists");
  const newCategory = await prisma.category.create({
    data: {
      name: req.body.name,
    },
  });
  return res.status(201).send(newCategory);
});

router.delete("/:id", async (req, res) => {
  const existingCategory = await prisma.category.findFirst({
    where: { id: req.params.id },
  });
  if (!existingCategory)
    return res.status(400).send("category with given id not found");
  const books = await prisma.book.findFirst({
    where: { categoryId: req.params.id },
  });

  const dvds = await prisma.dvd.findFirst({
    where: { categoryId: req.params.id },
  });
  const audiobooks = await prisma.audioBook.findFirst({
    where: { categoryId: req.params.id },
  });
  const referenceBooks = await prisma.referenceBook.findFirst({
    where: { categoryId: req.params.id },
  });
  if (books || dvds || audiobooks || referenceBooks) {
    return res.send("category not empty");
  } else {
    const deletedCategory = await prisma.category.delete({
      where: { id: req.params.id },
    });
    return res.status(200).send(deletedCategory);
  }
});

export default router;
