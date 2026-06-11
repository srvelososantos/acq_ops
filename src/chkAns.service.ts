import { Injectable } from "@nestjs/common";
import { PrismaService } from "./prisma.service.js";

@Injectable()
export class ChecklistAnswersService{
    constructor(private prisma: PrismaService) {}

    async addAnswersToChecklist(checklistId: string, answerIds: string[]) {
        // 1. Transformamos o array de strings ['id1', 'id2'] em um array de objetos
        const recordsToInsert = answerIds.map((id) => ({
            checklist_id: checklistId, // O ID do checklist é o mesmo para todos
            ans_id: id,                // Cada linha recebe um ID de resposta diferente
        }));

        // O resultado de 'recordsToInsert' será:
        // [
        //   { checklist_id: '...', ans_id: 'id1' },
        //   { checklist_id: '...', ans_id: 'id2' }
        // ]

        // 2. Passamos esse array para o createMany
        return await this.prisma.checklist_answer.createMany({
            data: recordsToInsert,
            skipDuplicates: true, // Altamente recomendado! Ignora o erro se a combinação já existir no banco
        });
    }
//ans_id, question_id, bool_answ, obs,
//question, header_about_question
    async getAnswersbyChecklistId(checklistId: string){
        return await this.prisma.checklist_answer.findMany({
            where: {
                checklist_id: checklistId,
            },
            include: {
                answer: {
                    include: {
                        question: true,
                    }
                },
                checklist:{
                    include:{
                        users: {
                            select:{
                                username: true
                            }
                        }
                    }
                }
            }
        })
    }
}