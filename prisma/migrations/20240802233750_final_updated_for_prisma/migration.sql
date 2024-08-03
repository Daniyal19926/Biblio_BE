/*
  Warnings:

  - You are about to drop the column `borrowerId` on the `AudioBook` table. All the data in the column will be lost.
  - You are about to drop the column `borrowerId` on the `Book` table. All the data in the column will be lost.
  - You are about to drop the column `borrowerId` on the `Dvd` table. All the data in the column will be lost.
  - You are about to drop the `Borrower` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "AudioBook" DROP CONSTRAINT "AudioBook_borrowerId_fkey";

-- DropForeignKey
ALTER TABLE "Book" DROP CONSTRAINT "Book_borrowerId_fkey";

-- DropForeignKey
ALTER TABLE "Dvd" DROP CONSTRAINT "Dvd_borrowerId_fkey";

-- AlterTable
ALTER TABLE "AudioBook" DROP COLUMN "borrowerId",
ADD COLUMN     "borrowDate" TIMESTAMP(3),
ADD COLUMN     "borrowerName" TEXT;

-- AlterTable
ALTER TABLE "Book" DROP COLUMN "borrowerId",
ADD COLUMN     "borrowDate" TIMESTAMP(3),
ADD COLUMN     "borrowerName" TEXT;

-- AlterTable
ALTER TABLE "Dvd" DROP COLUMN "borrowerId",
ADD COLUMN     "borrowDate" TIMESTAMP(3),
ADD COLUMN     "borrowerName" TEXT;

-- DropTable
DROP TABLE "Borrower";
