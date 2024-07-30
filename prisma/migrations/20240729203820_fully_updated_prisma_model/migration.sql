/*
  Warnings:

  - You are about to drop the `Bok` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `DVD` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Ljudbok` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Uppslagsbok` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "Bok" DROP CONSTRAINT "Bok_borrowerId_fkey";

-- DropForeignKey
ALTER TABLE "Bok" DROP CONSTRAINT "Bok_categoryId_fkey";

-- DropForeignKey
ALTER TABLE "DVD" DROP CONSTRAINT "DVD_borrowerId_fkey";

-- DropForeignKey
ALTER TABLE "DVD" DROP CONSTRAINT "DVD_categoryId_fkey";

-- DropForeignKey
ALTER TABLE "Ljudbok" DROP CONSTRAINT "Ljudbok_borrowerId_fkey";

-- DropForeignKey
ALTER TABLE "Ljudbok" DROP CONSTRAINT "Ljudbok_categoryId_fkey";

-- DropForeignKey
ALTER TABLE "Uppslagsbok" DROP CONSTRAINT "Uppslagsbok_categoryId_fkey";

-- DropTable
DROP TABLE "Bok";

-- DropTable
DROP TABLE "DVD";

-- DropTable
DROP TABLE "Ljudbok";

-- DropTable
DROP TABLE "Uppslagsbok";

-- CreateTable
CREATE TABLE "Book" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "author" TEXT NOT NULL,
    "nbrPage" INTEGER NOT NULL,
    "type" TEXT,
    "categoryId" TEXT NOT NULL,
    "isBorrowable" BOOLEAN NOT NULL DEFAULT true,
    "borrowerId" TEXT,

    CONSTRAINT "Book_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Dvd" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "runTimeMinutes" INTEGER NOT NULL,
    "categoryId" TEXT NOT NULL,
    "isBorrowable" BOOLEAN NOT NULL DEFAULT true,
    "borrowerId" TEXT,

    CONSTRAINT "Dvd_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AudioBook" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "runTimeMinutes" INTEGER NOT NULL,
    "type" TEXT,
    "categoryId" TEXT NOT NULL,
    "isBorrowable" BOOLEAN NOT NULL DEFAULT true,
    "borrowerId" TEXT,

    CONSTRAINT "AudioBook_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ReferenceBook" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "author" TEXT NOT NULL,
    "nbrPages" INTEGER NOT NULL,
    "type" TEXT,
    "categoryId" TEXT NOT NULL,

    CONSTRAINT "ReferenceBook_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Book_title_key" ON "Book"("title");

-- CreateIndex
CREATE UNIQUE INDEX "Dvd_title_key" ON "Dvd"("title");

-- CreateIndex
CREATE UNIQUE INDEX "AudioBook_title_key" ON "AudioBook"("title");

-- CreateIndex
CREATE UNIQUE INDEX "ReferenceBook_title_key" ON "ReferenceBook"("title");

-- AddForeignKey
ALTER TABLE "Book" ADD CONSTRAINT "Book_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES "Category"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Book" ADD CONSTRAINT "Book_borrowerId_fkey" FOREIGN KEY ("borrowerId") REFERENCES "Borrower"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Dvd" ADD CONSTRAINT "Dvd_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES "Category"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Dvd" ADD CONSTRAINT "Dvd_borrowerId_fkey" FOREIGN KEY ("borrowerId") REFERENCES "Borrower"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AudioBook" ADD CONSTRAINT "AudioBook_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES "Category"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AudioBook" ADD CONSTRAINT "AudioBook_borrowerId_fkey" FOREIGN KEY ("borrowerId") REFERENCES "Borrower"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ReferenceBook" ADD CONSTRAINT "ReferenceBook_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES "Category"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
