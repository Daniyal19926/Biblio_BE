/*
  Warnings:

  - You are about to drop the column `typeId` on the `ReferenceBook` table. All the data in the column will be lost.
  - You are about to drop the `Type` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "Book" DROP CONSTRAINT "Book_typeName_fkey";

-- DropForeignKey
ALTER TABLE "ReferenceBook" DROP CONSTRAINT "ReferenceBook_typeId_fkey";

-- AlterTable
ALTER TABLE "AudioBook" ADD COLUMN     "type" TEXT;

-- AlterTable
ALTER TABLE "Book" ADD COLUMN     "type" TEXT;

-- AlterTable
ALTER TABLE "Dvd" ADD COLUMN     "type" TEXT;

-- AlterTable
ALTER TABLE "ReferenceBook" DROP COLUMN "typeId",
ADD COLUMN     "isBorrowable" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "type" TEXT;

-- DropTable
DROP TABLE "Type";
