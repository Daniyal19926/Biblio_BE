/*
  Warnings:

  - You are about to drop the column `borrowerId` on the `Uppslagsbok` table. All the data in the column will be lost.
  - You are about to drop the column `isBorrowable` on the `Uppslagsbok` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "Uppslagsbok" DROP CONSTRAINT "Uppslagsbok_borrowerId_fkey";

-- AlterTable
ALTER TABLE "Uppslagsbok" DROP COLUMN "borrowerId",
DROP COLUMN "isBorrowable";
