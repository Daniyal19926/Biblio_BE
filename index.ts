import cors from "cors";
import express, { Router } from "express";
import categories from "./routes/categories";
import books from "./routes/books";
import dvds from "./routes/dvds";
import audioBooks from "./routes/audioBooks";
import referenceBooks from "./routes/referenceBooks";

const app = express();

const PORT = 5557;
app.listen(PORT, () => console.log("listning on port", PORT));
app.use(cors());
app.use(express.json());
app.use("/api/categories", categories);
app.use("/api/books", books);
app.use("/api/referenceBooks", referenceBooks);
app.use("/api/dvds", dvds);
app.use("/api/audioBooks", audioBooks);
