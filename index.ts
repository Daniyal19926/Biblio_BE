import express, { Router } from "express";
import books from "./routes/books";
const app = express();
const PORT = 5557;
app.listen(PORT, () => console.log("listning on port", PORT));
app.use(express.json());
app.use("/api/books", books);
