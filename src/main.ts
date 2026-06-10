import { NestFactory, Reflector } from '@nestjs/core';
import { AppModule } from './app.module.js';
import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger';


async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  
  const config = new DocumentBuilder()
  .setTitle('Acqualinda Operations')
  .setDescription('Acqualinda API description')
  .setVersion('0.5')
  .addTag('waterpark')
  .build();

  const documentFactory = () => SwaggerModule.createDocument(app, config);
  SwaggerModule.setup('api', app, documentFactory);

  app.enableCors()
  
  await app.listen(process.env.PORT ?? 3000);
}
bootstrap();
