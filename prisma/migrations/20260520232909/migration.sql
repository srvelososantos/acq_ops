/*
  Warnings:

  - You are about to drop the `Checklist` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `User` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "Checklist" DROP CONSTRAINT "Checklist_authorId_fkey";

-- DropTable
DROP TABLE "Checklist";

-- DropTable
DROP TABLE "User";

-- CreateTable
CREATE TABLE "checklist" (
    "checklist_id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "operator_id" UUID,
    "ans_id" UUID,
    "dttime" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,
    "obs" VARCHAR(255),

    CONSTRAINT "checklist_pkey" PRIMARY KEY ("checklist_id")
);

-- CreateTable
CREATE TABLE "img" (
    "img_id" SERIAL NOT NULL,
    "nome" VARCHAR(100),
    "foto" BYTEA,

    CONSTRAINT "img_pkey" PRIMARY KEY ("img_id")
);

-- CreateTable
CREATE TABLE "question" (
    "question_id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "attraction" INTEGER,
    "question" VARCHAR(255),

    CONSTRAINT "question_pkey" PRIMARY KEY ("question_id")
);

-- CreateTable
CREATE TABLE "users" (
    "usr_id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "username" VARCHAR(128),
    "email" VARCHAR(128),
    "passwrd" VARCHAR(255),
    "u_type" INTEGER,

    CONSTRAINT "users_pkey" PRIMARY KEY ("usr_id")
);

-- CreateTable
CREATE TABLE "answer" (
    "ans_id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "question_id" UUID,
    "bool_answ" BOOLEAN,
    "obs" VARCHAR(255),
    "img_id" INTEGER,

    CONSTRAINT "answer_pkey" PRIMARY KEY ("ans_id")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- AddForeignKey
ALTER TABLE "checklist" ADD CONSTRAINT "checklist_ans_id_fkey" FOREIGN KEY ("ans_id") REFERENCES "answer"("ans_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "checklist" ADD CONSTRAINT "checklist_operator_id_fkey" FOREIGN KEY ("operator_id") REFERENCES "users"("usr_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "answer" ADD CONSTRAINT "answer_img_id_fkey" FOREIGN KEY ("img_id") REFERENCES "img"("img_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "answer" ADD CONSTRAINT "answer_question_id_fkey" FOREIGN KEY ("question_id") REFERENCES "question"("question_id") ON DELETE NO ACTION ON UPDATE NO ACTION;
