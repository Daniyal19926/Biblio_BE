/*
  Warnings:

  - Added the required column `runtimeMinutes` to the `Ljudbok` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Ljudbok" ADD COLUMN     "runtimeMinutes" INTEGER NOT NULL;
