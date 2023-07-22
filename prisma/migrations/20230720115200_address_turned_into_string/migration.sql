/*
  Warnings:

  - You are about to drop the column `city_id` on the `address` table. All the data in the column will be lost.
  - You are about to drop the column `customerId` on the `address` table. All the data in the column will be lost.
  - You are about to drop the column `district_id` on the `address` table. All the data in the column will be lost.
  - You are about to drop the column `state_id` on the `address` table. All the data in the column will be lost.
  - Added the required column `city` to the `Address` table without a default value. This is not possible if the table is not empty.
  - Added the required column `district` to the `Address` table without a default value. This is not possible if the table is not empty.
  - Added the required column `state` to the `Address` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `address` DROP FOREIGN KEY `Address_city_id_fkey`;

-- DropForeignKey
ALTER TABLE `address` DROP FOREIGN KEY `Address_customerId_fkey`;

-- DropForeignKey
ALTER TABLE `address` DROP FOREIGN KEY `Address_district_id_fkey`;

-- DropForeignKey
ALTER TABLE `address` DROP FOREIGN KEY `Address_state_id_fkey`;

-- AlterTable
ALTER TABLE `address` DROP COLUMN `city_id`,
    DROP COLUMN `customerId`,
    DROP COLUMN `district_id`,
    DROP COLUMN `state_id`,
    ADD COLUMN `city` VARCHAR(191) NOT NULL,
    ADD COLUMN `customer_id` VARCHAR(191) NULL,
    ADD COLUMN `district` VARCHAR(191) NOT NULL,
    ADD COLUMN `state` VARCHAR(191) NOT NULL;

-- CreateIndex
CREATE INDEX `Address_customerId_fkey` ON `Address`(`customer_id`);

-- AddForeignKey
ALTER TABLE `Address` ADD CONSTRAINT `Address_customerId_fkey` FOREIGN KEY (`customer_id`) REFERENCES `Customer`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
