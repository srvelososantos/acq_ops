import { Injectable } from "@nestjs/common";
import { PrismaService } from "./prisma.service.js";
import { Prisma, question } from "./generated/prisma/client.js";

@Injectable()
export class QuestionsService{
    constructor(private prisma: PrismaService){}

    async getQuestions(attraction: number): Promise<question[]> {
        return await this.prisma.question.findMany({
            where: {
                attraction,
                isdeleted: false
            }
        });
    }

    async createQuestion(data: Prisma.questionCreateInput): Promise<question>{
        return await this.prisma.question.create({ data })
    }

    async deleteQuestion(data: string[]){
        return await this.prisma.question.updateMany({
            where: {
                question_id: {
                    in: data,
                }
            },
            data:{
                isdeleted: true
            }
        })
    }
    
}