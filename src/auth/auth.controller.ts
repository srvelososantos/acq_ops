import { Body, Controller, Get, Post, Request, UseGuards } from '@nestjs/common';
import { AuthService } from './auth.service.js';
import { AuthGuard } from './auth.guard.js';
import { Public } from './publicDecorator.js';

@Controller('auth')
export class AuthController {
    constructor( private authService: AuthService ){}

    @Public()
    @Post('signin')
    async signin(@Body() data: { email: string, password: string } ){
        return await this.authService.signIn(data.email, data.password)
    }

    @Public()
    @Post('signup')
    async signup(@Body() data: { email: string, password: string, username: string, u_type: number} ){
        return await this.authService.signup(data)
    }

    @Get('guardtest')
    async profile(@Request() req){
        return { message: "success", user: req.user.sub } //req.user.sub = user id
    }
}
