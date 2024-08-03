import express from "express";
import { PrismaClient } from "@prisma/client";
import { validate } from "../schemas/Book";
const router = express.Router();
const prisma = new PrismaClient();
router.get("/", async (req, res) => {
  const books = await prisma.book.findMany({ include: { category: true } });
  return res.status(200).send(books);
});
router.get("/:id", async (req, res) => {
  const book = await prisma.book.findFirst({
    where: { id: req.params.id },
    include: { category: true },
  });
  if (!book) return res.status(400).send("book with given id not found");
  return res.status(200).send(book);
});
router.put("/:id", async (req, res) => {
  const book = await prisma.book.findFirst({ where: { id: req.params.id } });
  if (!book) return res.status(400).send("book with given id not found");
  const validation = validate(req.body);
  if (!validation.success)
    return res.status(400).send(validation.error.issues[0].message);
  const category = await prisma.category.findFirst({
    where: { id: req.body.categoryId },
  });
  if (!category) return res.status(400).send("category not found");

  const updatedBook = await prisma.book.update({
    where: { id: req.params.id },

    data: {
      author: req.body.author,
      title: req.body.title,
      nbrPages: req.body.nbrPages,
      type: req.body.type,
      categoryId: req.body.categoryId,
      isBorrowable: req.body.isBorrowable,
      borrowerName: req.body.borrowerName,
      borrowDate: req.body.borrowDate,
    },
    include: { category: true },
  });
  return res.status(200).send("ok");
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
  const existingBook = await prisma.book.findFirst({
    where: { title: req.body.title },
  });
  if (existingBook) return res.status(400).send("book already exists");
  const book = await prisma.book.create({
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
  return res.status(201).send(book);
});

router.delete("/:id", async (req, res) => {
  const book = await prisma.book.findFirst({ where: { id: req.params.id } });
  if (!book) return res.status(400).send("book with given id not found");

  const deletedBook = await prisma.book.delete({
    where: { id: req.params.id },
    include: { category: true },
  });
  return res.status(200).send(deletedBook);
});

export default router;
