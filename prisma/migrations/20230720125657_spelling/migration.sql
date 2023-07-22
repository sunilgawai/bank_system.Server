/*
  Warnings:

  - The values [LICENCE] on the enum `Document_document_type` will be removed. If these variants are still used in the database, this will fail.

*/
-- AlterTable
ALTER TABLE `document` MODIFY `document_type` ENUM('PANCARD', 'UID', 'LICENSE') NOT NULL DEFAULT 'UID';
