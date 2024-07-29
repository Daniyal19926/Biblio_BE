-- DropForeignKey
ALTER TABLE "Bok" DROP CONSTRAINT "Bok_borrowerId_fkey";

-- DropForeignKey
ALTER TABLE "DVD" DROP CONSTRAINT "DVD_borrowerId_fkey";

-- DropForeignKey
ALTER TABLE "Ljudbok" DROP CONSTRAINT "Ljudbok_borrowerId_fkey";

-- AlterTable
ALTER TABLE "Bok" ALTER COLUMN "borrowerId" DROP NOT NULL;

-- AlterTable
ALTER TABLE "DVD" ALTER COLUMN "borrowerId" DROP NOT NULL;

-- AlterTable
ALTER TABLE "Ljudbok" ALTER COLUMN "borrowerId" DROP NOT NULL;

-- AddForeignKey
ALTER TABLE "Bok" ADD CONSTRAINT "Bok_borrowerId_fkey" FOREIGN KEY ("borrowerId") REFERENCES "Borrower"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DVD" ADD CONSTRAINT "DVD_borrowerId_fkey" FOREIGN KEY ("borrowerId") REFERENCES "Borrower"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Ljudbok" ADD CONSTRAINT "Ljudbok_borrowerId_fkey" FOREIGN KEY ("borrowerId") REFERENCES "Borrower"("id") ON DELETE SET NULL ON UPDATE CASCADE;
