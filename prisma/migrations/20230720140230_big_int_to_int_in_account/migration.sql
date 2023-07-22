/*
  Warnings:

  - You are about to alter the column `account_number` on the `account` table. The data in that column could be lost. The data in that column will be cast from `BigInt` to `Int`.

*/
-- AlterTable
ALTER TABLE `account` MODIFY `account_number` INTEGER NOT NULL;
