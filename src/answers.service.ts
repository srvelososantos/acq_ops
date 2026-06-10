import { Injectable } from "@nestjs/common";
import { PrismaService } from "./prisma.service.js";
import { answer, Prisma } from "./generated/prisma/client.js";

@Injectable()
export class AnswersService {
    constructor(private prisma: PrismaService){}


    async createAnswer(/*question_id: string, bool_answ: boolean, obs: string*/ data: Prisma.answerCreateInput): Promise<answer>{
        return await this.prisma.answer.create({
            data,
        });
    }
}