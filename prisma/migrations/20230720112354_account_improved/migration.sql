/*
  Warnings:

  - You are about to alter the column `account_number` on the `account` table. The data in that column could be lost. The data in that column will be cast from `VarChar(15)` to `BigInt`.
  - You are about to alter the column `ifsc_code` on the `account` table. The data in that column could be lost. The data in that column will be cast from `VarChar(8)` to `Enum(EnumId(4))`.
  - You are about to alter the column `account_balance` on the `account` table. The data in that column could be lost. The data in that column will be cast from `VarChar(999)` to `Double`.
  - You are about to drop the column `password` on the `customer` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE `account` ADD COLUMN `customer_id` VARCHAR(191) NULL,
    MODIFY `account_number` BIGINT NOT NULL,
    MODIFY `ifsc_code` ENUM('BANK0007') NOT NULL DEFAULT 'BANK0007',
    MODIFY `account_balance` DOUBLE NOT NULL DEFAULT 0.00;

-- AlterTable
ALTER TABLE `customer` DROP COLUMN `password`;

-- AddForeignKey
ALTER TABLE `Account` ADD CONSTRAINT `Account_customer_id_fkey` FOREIGN KEY (`customer_id`) REFERENCES `Customer`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
