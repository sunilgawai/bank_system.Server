/*
  Warnings:

  - You are about to drop the column `documentId` on the `address` table. All the data in the column will be lost.
  - Added the required column `document_id` to the `Account` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `address` DROP FOREIGN KEY `Address_documentId_fkey`;

-- AlterTable
ALTER TABLE `account` ADD COLUMN `document_id` VARCHAR(191) NOT NULL;

-- AlterTable
ALTER TABLE `address` DROP COLUMN `documentId`;

-- AddForeignKey
ALTER TABLE `Account` ADD CONSTRAINT `Account_document_id_fkey` FOREIGN KEY (`document_id`) REFERENCES `Document`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
