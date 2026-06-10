import { Module } from "@nestjs/common";
import { AppController } from "./app.controller.js";
import { AppService } from "./app.service.js";
import { PrismaService } from "./prisma.service.js";
import { UserService } from "./user.service.js";
import { ChecklistService } from "./checklist.service.js";
import { ConfigModule } from "@nestjs/config";
import { AuthModule } from "./auth/auth.module.js";
import { AuthService } from "./auth/auth.service.js";
import { APP_GUARD } from "@nestjs/core";
import { AuthGuard } from "./auth/auth.guard.js";
import { ServeStaticModule } from "@nestjs/serve-static";
import { join } from "path";
import { QuestionsService } from "./questions.service.js";
import { AnswersService } from "./answers.service.js";
import { ChecklistAnswersService } from "./chkAns.service.js";

@Module({
  imports: [
    ConfigModule.forRoot({ isGlobal: true }),
    AuthModule,
    ServeStaticModule.forRoot({
      rootPath: join(process.cwd(), "src", "pages"),
      serveStaticOptions: {
        fallthrough: false,
      },
    }),
  ],
  controllers: [AppController],
  providers: [
    AppService,
    PrismaService,
    UserService,
    ChecklistService,
    AuthService,
    { provide: APP_GUARD, useClass: AuthGuard },
    QuestionsService,
    AnswersService,
    ChecklistAnswersService,
  ],
})
export class AppModule {}
