/*
  Warnings:

  - You are about to drop the column `runtimeMinutes` on the `Ljudbok` table. All the data in the column will be lost.
  - Added the required column `runTimeMinutes` to the `Ljudbok` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Ljudbok" DROP COLUMN "runtimeMinutes",
ADD COLUMN     "runTimeMinutes" INTEGER NOT NULL;
