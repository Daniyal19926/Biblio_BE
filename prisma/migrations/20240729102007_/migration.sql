-- CreateTable
CREATE TABLE "Borrower" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "borrowDate" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Borrower_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Category" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "Category_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Bok" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "author" TEXT NOT NULL,
    "nbrPage" INTEGER NOT NULL,
    "categoryId" TEXT NOT NULL,
    "isBorrowable" BOOLEAN NOT NULL DEFAULT true,
    "borrowerId" TEXT NOT NULL,

    CONSTRAINT "Bok_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DVD" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "runTimeMinutes" INTEGER NOT NULL,
    "categoryId" TEXT NOT NULL,
    "isBorrowable" BOOLEAN NOT NULL DEFAULT true,
    "borrowerId" TEXT NOT NULL,

    CONSTRAINT "DVD_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Ljudbok" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "categoryId" TEXT NOT NULL,
    "isBorrowable" BOOLEAN NOT NULL DEFAULT true,
    "borrowerId" TEXT NOT NULL,

    CONSTRAINT "Ljudbok_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Uppslagsbok" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "author" TEXT NOT NULL,
    "nbrPages" INTEGER NOT NULL,
    "categoryId" TEXT NOT NULL,
    "isBorrowable" BOOLEAN NOT NULL DEFAULT false,
    "borrowerId" TEXT,

    CONSTRAINT "Uppslagsbok_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Category_name_key" ON "Category"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Bok_title_key" ON "Bok"("title");

-- CreateIndex
CREATE UNIQUE INDEX "DVD_title_key" ON "DVD"("title");

-- CreateIndex
CREATE UNIQUE INDEX "Ljudbok_title_key" ON "Ljudbok"("title");

-- CreateIndex
CREATE UNIQUE INDEX "Uppslagsbok_title_key" ON "Uppslagsbok"("title");

-- AddForeignKey
ALTER TABLE "Bok" ADD CONSTRAINT "Bok_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES "Category"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Bok" ADD CONSTRAINT "Bok_borrowerId_fkey" FOREIGN KEY ("borrowerId") REFERENCES "Borrower"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DVD" ADD CONSTRAINT "DVD_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES "Category"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DVD" ADD CONSTRAINT "DVD_borrowerId_fkey" FOREIGN KEY ("borrowerId") REFERENCES "Borrower"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Ljudbok" ADD CONSTRAINT "Ljudbok_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES "Category"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Ljudbok" ADD CONSTRAINT "Ljudbok_borrowerId_fkey" FOREIGN KEY ("borrowerId") REFERENCES "Borrower"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Uppslagsbok" ADD CONSTRAINT "Uppslagsbok_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES "Category"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Uppslagsbok" ADD CONSTRAINT "Uppslagsbok_borrowerId_fkey" FOREIGN KEY ("borrowerId") REFERENCES "Borrower"("id") ON DELETE SET NULL ON UPDATE CASCADE;
