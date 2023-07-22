/*
  Warnings:

  - You are about to drop the column `type` on the `document` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE `document` DROP COLUMN `type`,
    ADD COLUMN `document_type` ENUM('PANCARD', 'UID', 'LICENCE') NOT NULL DEFAULT 'UID';
