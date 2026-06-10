import { Injectable } from '@nestjs/common';
import { PrismaService } from './prisma.service.js';
import { Prisma, users } from './generated/prisma/client.js';

@Injectable()
export class UserService {
  constructor(private prisma: PrismaService) {}

  async user(
    userWhereUniqueInput: Prisma.usersWhereInput,
  ): Promise<users | null> {
    return this.prisma.users.findFirst({
      where: userWhereUniqueInput, 
    });
  }

  async retrieveUserByEmailPassword(
    userWhereUniqueInput: Prisma.usersWhereUniqueInput
  ): Promise<string>{
    const query = this.prisma.users.findUnique({
      where: userWhereUniqueInput
    });
    if(!query){
      return "Not Found"
    } 

    return JSON.stringify(userWhereUniqueInput);
  }

  async users(params: {
    skip?: number;
    take?: number;
    cursor?: Prisma.usersWhereUniqueInput;
    where?: Prisma.usersWhereInput;
    orderBy?: Prisma.usersOrderByWithRelationInput;
  }): Promise<users[]> {
    const { skip, take, cursor, where, orderBy } = params;
    return this.prisma.users.findMany({
      skip,
      take,
      cursor,
      where,
      orderBy,
    });
  }

  async createUser(data: Prisma.usersCreateInput): Promise<users> {
    return this.prisma.users.create({
      data,
    });
  }

  async updateUser(params: {
    where: Prisma.usersWhereUniqueInput;
    data: Prisma.usersUpdateInput;
  }): Promise<users> {
    const { where, data } = params;
    return this.prisma.users.update({
      data,
      where,
    });
  }

  async deleteUser(where: Prisma.usersWhereUniqueInput): Promise<users> {
    return this.prisma.users.delete({
      where,
    });
  }
}
