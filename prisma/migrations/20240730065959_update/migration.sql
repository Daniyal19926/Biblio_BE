/*
  Warnings:

  - Made the column `type` on table `AudioBook` required. This step will fail if there are existing NULL values in that column.
  - Made the column `type` on table `Book` required. This step will fail if there are existing NULL values in that column.
  - Made the column `type` on table `Dvd` required. This step will fail if there are existing NULL values in that column.
  - Made the column `type` on table `ReferenceBook` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "AudioBook" ALTER COLUMN "type" SET NOT NULL;

-- AlterTable
ALTER TABLE "Book" ALTER COLUMN "type" SET NOT NULL;

-- AlterTable
ALTER TABLE "Dvd" ALTER COLUMN "type" SET NOT NULL;

-- AlterTable
ALTER TABLE "ReferenceBook" ALTER COLUMN "type" SET NOT NULL;
