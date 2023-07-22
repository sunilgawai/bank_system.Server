/*
  Warnings:

  - You are about to drop the column `number` on the `document` table. All the data in the column will be lost.
  - Added the required column `document_number` to the `Document` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `document` DROP COLUMN `number`,
    ADD COLUMN `document_number` VARCHAR(191) NOT NULL;
