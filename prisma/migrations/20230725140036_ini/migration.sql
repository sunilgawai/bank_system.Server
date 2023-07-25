/*
  Warnings:

  - You are about to drop the column `customer_id` on the `otp` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[email]` on the table `Otp` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `email` to the `Otp` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `otp` DROP FOREIGN KEY `Otp_customer_id_fkey`;

-- AlterTable
ALTER TABLE `otp` DROP COLUMN `customer_id`,
    ADD COLUMN `email` VARCHAR(191) NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX `Otp_email_key` ON `Otp`(`email`);
