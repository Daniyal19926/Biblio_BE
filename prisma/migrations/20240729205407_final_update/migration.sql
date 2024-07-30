/*
  Warnings:

  - You are about to drop the column `type` on the `AudioBook` table. All the data in the column will be lost.
  - You are about to drop the column `nbrPage` on the `Book` table. All the data in the column will be lost.
  - You are about to drop the column `type` on the `Book` table. All the data in the column will be lost.
  - You are about to drop the column `type` on the `ReferenceBook` table. All the data in the column will be lost.
  - Added the required column `nbrPages` to the `Book` table without a default value. This is not possible if the table is not empty.
  - Added the required column `typeName` to the `Book` table without a default value. This is not possible if the table is not empty.
  - Added the required column `typeId` to the `ReferenceBook` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "AudioBook" DROP COLUMN "type";

-- AlterTable
ALTER TABLE "Book" DROP COLUMN "nbrPage",
DROP COLUMN "type",
ADD COLUMN     "nbrPages" INTEGER NOT NULL,
ADD COLUMN     "typeName" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "ReferenceBook" DROP COLUMN "type",
ADD COLUMN     "typeId" TEXT NOT NULL;

-- CreateTable
CREATE TABLE "Type" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "Type_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Type_name_key" ON "Type"("name");

-- AddForeignKey
ALTER TABLE "Book" ADD CONSTRAINT "Book_typeName_fkey" FOREIGN KEY ("typeName") REFERENCES "Type"("name") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ReferenceBook" ADD CONSTRAINT "ReferenceBook_typeId_fkey" FOREIGN KEY ("typeId") REFERENCES "Type"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
