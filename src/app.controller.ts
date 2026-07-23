import { Body, Controller, Delete, Get, Param, ParseIntPipe, Post, Query, Request, Res } from '@nestjs/common';
import { UserService } from './user.service.js';
import { ChecklistService } from './checklist.service.js';
import { users as UserModel } from './generated/prisma/client.js';
import { checklist as ChecklistModel } from './generated/prisma/client.js'
import { ApiOperation, ApiResponse } from '@nestjs/swagger';
import { Public } from './auth/publicDecorator.js';
import { join } from 'path';
import { QuestionsService } from './questions.service.js';
import { AnswersService } from './answers.service.js';
import { ChecklistAnswersService } from './chkAns.service.js';

@Controller()
export class AppController {
  constructor(
    private readonly UserService: UserService,
    private readonly ChecklistService: ChecklistService,
    private readonly QuestionsService: QuestionsService,
    private readonly AnswersService: AnswersService,
    private readonly ChecklistAnswerService: ChecklistAnswersService
  ) {}

  // @Public()
  // @Get() getIndex(@Res() res: Response){return  }

  @ApiOperation({ summary: 'Retrieve Checklist by id' })
  @ApiResponse({ status: 201, description: 'Checklist retrieved successfully' })
  @ApiResponse({ status: 401, description: 'Unauthorized, user not logged in' })
  @Get('checklist/:id')
  async getChecklistById(
    @Param('id') id: string,
  ): Promise<ChecklistModel | null> {
    const res = await this.ChecklistService.checklist({ checklist_id: String(id) });
    return res;
  }

  @ApiOperation({ summary: 'Create a new Checklist' })
  @ApiResponse({ status: 201, description: 'Checklist created successfully' })
  @ApiResponse({ status: 401, description: 'Unauthorized, user not logged in' })
  @Post('createChecklist')
  async createChecklist(
    @Body()
    checklistData: {
      operator_id: string;
      obs: string;
    }, @Request() data
  ): Promise<ChecklistModel> {
    const { operator_id, obs} = checklistData;
    console.log(operator_id)
    console.log(obs)
    return this.ChecklistService.createChecklist({
      obs,
      users: {
        connect: { usr_id: checklistData.operator_id }
      },
    });
  }

  //this endpoint returns the count of inserts were made
  @Post('checklist-answers')
  async createChecklistAnswer(@Body() data:{ checklist_id: string, ans_ids: string[] }){
    console.log(data.checklist_id, data.ans_ids)
    return await this.ChecklistAnswerService.addAnswersToChecklist(data.checklist_id, data.ans_ids)
  }

  @Get('checklist-answers/:id')
  async getChecklistAnswers(@Param('id') id: string){
    return await this.ChecklistAnswerService.getAnswersbyChecklistId(id)
  }
  
  @ApiOperation({ summary: 'Create a new User' })
  @ApiResponse({ status: 201, description: 'User created successfully' })
  @Post('user')
  async createUser(
    @Body() userData: { u_type: number, username: string, email: string, password: string },
  ): Promise<UserModel> {
    console.log("teste-----------")
    return this.UserService.createUser(userData);
  }

  @ApiOperation({ summary: 'Retrieve a user by id' })
  @ApiResponse({ status: 201, description: 'User retrieved successfully' })
  @ApiResponse({ status: 401, description: 'Unauthorized, user not logged in' })
  @Get('user/:id')
  // param : https://acqops-production.up.railway.app/user/744e17d6-8090-428a-a1b8-3f1266e92fcb
  async getUserById(@Param('id') id: string): Promise<UserModel | null> {
    return this.UserService.user({ usr_id: id });
  }

  @ApiOperation({ summary: 'Retrieve all users created checklists' })
  @ApiResponse({ status: 201, description: 'User checklists retrieved successfully' })
  @ApiResponse({ status: 401, description: 'Unauthorized, user not logged in' })
  //                soon
  @Get('myfeed')
  async myFeed(@Request() data){
    const res = await this.ChecklistService.checklists({ 
      where: {
        users: data.user.sub
      }
     });
    return res;
  }

  @Get('getchecklists')
  async getChecklists(){
    return this.ChecklistService.checklists({
      include: {
        users: {
          select: {
            username: true
          }
        }
      }
    })
  }

  @Get('getquestions')
  //query : https://acqops-production.up.railway.app/getquestions?attraction=1
  async getQuestions(@Query('attraction', ParseIntPipe) attraction: number){
    return await this.QuestionsService.getQuestions(attraction)
  }

//  { 
//   "question_ids": [
//       "112a49ef-3963-4729-bd33-e7c75aec7e5e",
//       "1a3b76b0-d920-4c7d-b1fa-b23d0091c6a7"
//     ]
//  }
  @Delete('deleteQuestions')
  async deleteQuestion(@Body() data: {
    question_ids: string[]
  }){
    this.QuestionsService.deleteQuestion(data.question_ids)
  }

  @Post('answers')
  async createAnswer(@Body() data: { question_id: string, bool_answ: boolean, obs: string }){
    return await this.AnswersService.createAnswer(data)
  }

  @Post('createQuestion')
  async createQuestion(@Body() questionData: {
    attraction: number,
    question: string,
    header_about_question: string
  }){
    const {attraction, question, header_about_question} = questionData
    return await this.QuestionsService.createQuestion({
      attraction,
      question,
      header_about_question
    })
  }

}
