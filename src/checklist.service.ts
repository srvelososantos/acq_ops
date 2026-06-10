import { Injectable } from '@nestjs/common';
import { PrismaService } from './prisma.service.js';
import { checklist, Prisma } from './generated/prisma/client.js';

@Injectable()
export class ChecklistService {
  constructor(private prisma: PrismaService) {}

  async checklist(
    checklistWhereUniqueInput: Prisma.checklistWhereUniqueInput,
  ): Promise<checklist | null> {
    return this.prisma.checklist.findUnique({
      where: checklistWhereUniqueInput,
    });
  }

  async checklists(params: {
    skip?: number;
    take?: number;
    cursor?: Prisma.checklistWhereUniqueInput;
    where?: Prisma.checklistWhereInput;
    orderBy?: Prisma.checklistOrderByWithRelationInput;
    include?: Prisma.checklistInclude;
  }): Promise<checklist[]> {
    const { skip, take, cursor, where, orderBy, include } = params;
    return this.prisma.checklist.findMany({
      skip,
      take,
      cursor,
      where,
      orderBy,
      include:{
        users:{
          select:{
            username:true
          }
        },
        checklist_answer:{
          include:{
            answer:{
              include:{
                question:{
                  select:{
                    attraction:true
                  }
                }
              }
            }
          }
        }
      },
    });
  }



  async createChecklist(data: Prisma.checklistCreateInput): Promise<checklist> {
    return this.prisma.checklist.create({
      data,
    });
  }

  async updateChecklist(params: {
    where: Prisma.checklistWhereUniqueInput;
    data: Prisma.checklistUpdateInput
  }): Promise<checklist> {
    const { where, data } = params;
    return this.prisma.checklist.update({
      data,
      where,
    });
  }

  async deleteChecklist(
    where: Prisma.checklistWhereUniqueInput,
  ): Promise<checklist> {
    return this.prisma.checklist.delete({
      where,
    });
  }

  
}
