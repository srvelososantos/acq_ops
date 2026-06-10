import { HttpCode, Injectable, UnauthorizedException } from '@nestjs/common';
import { UserService } from '../user.service.js';
import { JwtService } from '@nestjs/jwt';
import * as bcrypt from 'bcrypt';

@Injectable()
export class AuthService {
    constructor( private UserService: UserService, private jwtService: JwtService ){}

    async signIn(email: string, password: string): Promise<{ access_token: string, u_type: number | null, usr_id: string, username: string | null }> {
        const id = await this.UserService.user({ email });
        if(!id){
            throw new UnauthorizedException();
        }
        const isPassValid = await bcrypt.compare(password, id.passwrd)

        if(!isPassValid){
            throw new UnauthorizedException();
        }
        const payload = { sub: id?.usr_id, username: id?.username };
        console.log("autorizado")
        return { access_token: await this.jwtService.signAsync(payload), u_type: id.u_type, usr_id: id.usr_id, username: id.username}
    }

    async signup( data: { email: string, password: string, username: string, u_type: number} ) {
        const id = await this.UserService.user({ email: data.email })
        if(id){
            throw new UnauthorizedException();
        }
        const hashedPassword = await bcrypt.hash(data.password, 10);
        return await this.UserService.createUser({ email: data.email, passwrd: hashedPassword, username: data.username, u_type: data.u_type })
    }
}
