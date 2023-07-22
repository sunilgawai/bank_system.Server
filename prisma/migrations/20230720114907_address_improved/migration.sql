/*
  Warnings:

  - You are about to drop the column `city` on the `address` table. All the data in the column will be lost.
  - You are about to drop the column `local` on the `address` table. All the data in the column will be lost.
  - You are about to drop the column `state` on the `address` table. All the data in the column will be lost.
  - You are about to alter the column `country` on the `address` table. The data in that column could be lost. The data in that column will be cast from `VarChar(191)` to `Enum(EnumId(6))`.
  - Added the required column `city_id` to the `Address` table without a default value. This is not possible if the table is not empty.
  - Added the required column `district_id` to the `Address` table without a default value. This is not possible if the table is not empty.
  - Added the required column `landmark` to the `Address` table without a default value. This is not possible if the table is not empty.
  - Added the required column `state_id` to the `Address` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `address` DROP COLUMN `city`,
    DROP COLUMN `local`,
    DROP COLUMN `state`,
    ADD COLUMN `city_id` INTEGER NOT NULL,
    ADD COLUMN `district_id` INTEGER NOT NULL,
    ADD COLUMN `landmark` VARCHAR(191) NOT NULL,
    ADD COLUMN `state_id` INTEGER NOT NULL,
    MODIFY `country` ENUM('INDIA') NULL DEFAULT 'INDIA';

-- AddForeignKey
ALTER TABLE `Address` ADD CONSTRAINT `Address_state_id_fkey` FOREIGN KEY (`state_id`) REFERENCES `State`(`state_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Address` ADD CONSTRAINT `Address_city_id_fkey` FOREIGN KEY (`city_id`) REFERENCES `City`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Address` ADD CONSTRAINT `Address_district_id_fkey` FOREIGN KEY (`district_id`) REFERENCES `District`(`districtid`) ON DELETE RESTRICT ON UPDATE CASCADE;
