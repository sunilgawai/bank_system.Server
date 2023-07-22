/*
  Warnings:

  - You are about to drop the column `citiesId` on the `address` table. All the data in the column will be lost.
  - You are about to drop the column `countryId` on the `address` table. All the data in the column will be lost.
  - You are about to drop the column `default` on the `address` table. All the data in the column will be lost.
  - You are about to drop the column `lattitude` on the `address` table. All the data in the column will be lost.
  - You are about to drop the column `longitude` on the `address` table. All the data in the column will be lost.
  - You are about to drop the column `stateId` on the `address` table. All the data in the column will be lost.
  - You are about to drop the column `userId` on the `address` table. All the data in the column will be lost.
  - You are about to drop the column `cityId` on the `customer` table. All the data in the column will be lost.
  - You are about to drop the column `countryId` on the `customer` table. All the data in the column will be lost.
  - You are about to drop the column `email` on the `customer` table. All the data in the column will be lost.
  - You are about to drop the column `kycId` on the `customer` table. All the data in the column will be lost.
  - You are about to drop the column `phone` on the `customer` table. All the data in the column will be lost.
  - You are about to drop the column `shopId` on the `customer` table. All the data in the column will be lost.
  - You are about to drop the column `stateId` on the `customer` table. All the data in the column will be lost.
  - You are about to drop the column `submitted_by_userId` on the `customer` table. All the data in the column will be lost.
  - You are about to drop the `cities` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `countries` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `department` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `kyc` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `refreshtoken` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `shop` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `shopimages` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `states` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `user` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `city` to the `Address` table without a default value. This is not possible if the table is not empty.
  - Added the required column `country` to the `Address` table without a default value. This is not possible if the table is not empty.
  - Added the required column `documentId` to the `Address` table without a default value. This is not possible if the table is not empty.
  - Added the required column `local` to the `Address` table without a default value. This is not possible if the table is not empty.
  - Added the required column `state` to the `Address` table without a default value. This is not possible if the table is not empty.
  - Added the required column `date_of_birth` to the `Customer` table without a default value. This is not possible if the table is not empty.
  - Added the required column `email_address` to the `Customer` table without a default value. This is not possible if the table is not empty.
  - Added the required column `gender` to the `Customer` table without a default value. This is not possible if the table is not empty.
  - Added the required column `middle_name` to the `Customer` table without a default value. This is not possible if the table is not empty.
  - Added the required column `phone_number` to the `Customer` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `address` DROP FOREIGN KEY `Address_citiesId_fkey`;

-- DropForeignKey
ALTER TABLE `address` DROP FOREIGN KEY `Address_countryId_fkey`;

-- DropForeignKey
ALTER TABLE `address` DROP FOREIGN KEY `Address_stateId_fkey`;

-- DropForeignKey
ALTER TABLE `address` DROP FOREIGN KEY `Address_userId_fkey`;

-- DropForeignKey
ALTER TABLE `cities` DROP FOREIGN KEY `cities_ibfk_1`;

-- DropForeignKey
ALTER TABLE `cities` DROP FOREIGN KEY `cities_ibfk_2`;

-- DropForeignKey
ALTER TABLE `customer` DROP FOREIGN KEY `Customer_cityId_fkey`;

-- DropForeignKey
ALTER TABLE `customer` DROP FOREIGN KEY `Customer_countryId_fkey`;

-- DropForeignKey
ALTER TABLE `customer` DROP FOREIGN KEY `Customer_kycId_fkey`;

-- DropForeignKey
ALTER TABLE `customer` DROP FOREIGN KEY `Customer_shopId_fkey`;

-- DropForeignKey
ALTER TABLE `customer` DROP FOREIGN KEY `Customer_stateId_fkey`;

-- DropForeignKey
ALTER TABLE `customer` DROP FOREIGN KEY `Customer_submitted_by_userId_fkey`;

-- DropForeignKey
ALTER TABLE `shop` DROP FOREIGN KEY `Shop_shopImagesId_fkey`;

-- DropForeignKey
ALTER TABLE `states` DROP FOREIGN KEY `country_region_final`;

-- DropForeignKey
ALTER TABLE `user` DROP FOREIGN KEY `User_departmentId_fkey`;

-- DropIndex
DROP INDEX `Address_id_key` ON `address`;

-- DropIndex
DROP INDEX `Customer_email_key` ON `customer`;

-- DropIndex
DROP INDEX `Customer_id_key` ON `customer`;

-- AlterTable
ALTER TABLE `address` DROP COLUMN `citiesId`,
    DROP COLUMN `countryId`,
    DROP COLUMN `default`,
    DROP COLUMN `lattitude`,
    DROP COLUMN `longitude`,
    DROP COLUMN `stateId`,
    DROP COLUMN `userId`,
    ADD COLUMN `city` VARCHAR(191) NOT NULL,
    ADD COLUMN `country` VARCHAR(191) NOT NULL,
    ADD COLUMN `documentId` VARCHAR(191) NOT NULL,
    ADD COLUMN `local` VARCHAR(191) NOT NULL,
    ADD COLUMN `state` VARCHAR(191) NOT NULL,
    ADD COLUMN `type` ENUM('REGULAR', 'DEFAULT') NOT NULL DEFAULT 'REGULAR';

-- AlterTable
ALTER TABLE `customer` DROP COLUMN `cityId`,
    DROP COLUMN `countryId`,
    DROP COLUMN `email`,
    DROP COLUMN `kycId`,
    DROP COLUMN `phone`,
    DROP COLUMN `shopId`,
    DROP COLUMN `stateId`,
    DROP COLUMN `submitted_by_userId`,
    ADD COLUMN `date_of_birth` VARCHAR(191) NOT NULL,
    ADD COLUMN `email_address` VARCHAR(191) NOT NULL,
    ADD COLUMN `gender` ENUM('MALE', 'FEMALE', 'OTHER') NOT NULL,
    ADD COLUMN `middle_name` VARCHAR(191) NOT NULL,
    ADD COLUMN `phone_number` VARCHAR(191) NOT NULL;

-- DropTable
DROP TABLE `cities`;

-- DropTable
DROP TABLE `countries`;

-- DropTable
DROP TABLE `department`;

-- DropTable
DROP TABLE `kyc`;

-- DropTable
DROP TABLE `refreshtoken`;

-- DropTable
DROP TABLE `shop`;

-- DropTable
DROP TABLE `shopimages`;

-- DropTable
DROP TABLE `states`;

-- DropTable
DROP TABLE `user`;

-- CreateTable
CREATE TABLE `Document` (
    `id` VARCHAR(191) NOT NULL,
    `type` ENUM('PANCARD', 'UID', 'LICENCE') NOT NULL DEFAULT 'UID',
    `number` VARCHAR(191) NOT NULL,
    `customerId` VARCHAR(191) NULL,

    INDEX `Document_customerId_fkey`(`customerId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Account` (
    `id` VARCHAR(191) NOT NULL,
    `account_type` ENUM('CURRENT', 'SAVING', 'SALARY', 'FIXED', 'JOINT') NOT NULL DEFAULT 'CURRENT',
    `account_number` VARCHAR(15) NOT NULL,
    `ifsc_code` VARCHAR(8) NOT NULL,
    `account_balance` VARCHAR(999) NOT NULL,

    UNIQUE INDEX `Account_account_number_key`(`account_number`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Transaction` (
    `id` VARCHAR(191) NOT NULL,
    `sender_id` VARCHAR(191) NOT NULL,
    `receiver_id` VARCHAR(191) NOT NULL,
    `time` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `City` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,
    `districtid` INTEGER NULL,
    `state_id` INTEGER NULL,
    `description` TEXT NOT NULL,
    `status` VARCHAR(10) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `District` (
    `districtid` INTEGER NOT NULL AUTO_INCREMENT,
    `district_title` VARCHAR(100) NOT NULL,
    `state_id` INTEGER NULL,
    `district_description` TEXT NOT NULL,
    `district_status` VARCHAR(10) NOT NULL,

    PRIMARY KEY (`districtid`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `State` (
    `state_id` INTEGER NOT NULL AUTO_INCREMENT,
    `state_title` VARCHAR(100) NOT NULL,
    `state_description` TEXT NOT NULL,
    `status` VARCHAR(10) NOT NULL,

    PRIMARY KEY (`state_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateIndex
CREATE INDEX `Address_documentId_fkey` ON `Address`(`documentId`);

-- AddForeignKey
ALTER TABLE `Document` ADD CONSTRAINT `Document_customerId_fkey` FOREIGN KEY (`customerId`) REFERENCES `Customer`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Transaction` ADD CONSTRAINT `Transaction_sender_id_fkey` FOREIGN KEY (`sender_id`) REFERENCES `Account`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Transaction` ADD CONSTRAINT `Transaction_receiver_id_fkey` FOREIGN KEY (`receiver_id`) REFERENCES `Account`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Address` ADD CONSTRAINT `Address_documentId_fkey` FOREIGN KEY (`documentId`) REFERENCES `Document`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
