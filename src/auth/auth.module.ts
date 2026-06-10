import { Module } from '@nestjs/common';
import { AuthService } from './auth.service.js';
import { AuthController } from './auth.controller.js';
import { UserService } from './../user.service.js';
import { PrismaService } from './../prisma.service.js';
import { JwtModule } from '@nestjs/jwt';
import { jwtConstants } from './constants.js';
import { APP_GUARD } from '@nestjs/core';
import { AuthGuard } from './auth.guard.js';

@Module({
  imports:[JwtModule.register({
    global: true,
    secret: jwtConstants.secret,
    signOptions: { expiresIn: '1h' },
  })],
  providers: [{
    provide: APP_GUARD,
    useClass: AuthGuard
  }, AuthService, UserService, PrismaService],
  controllers: [AuthController],
})
export class AuthModule {}
