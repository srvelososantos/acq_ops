CREATE TABLE Users (
    usr_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    username VARCHAR(128),
    email VARCHAR(128), 
    passwrd VARCHAR(255), 
    u_type INTEGER    -- 1 = SUPERVISOR, 0 = OPERATOR
);

CREATE TABLE Img (
    img_id SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    foto BYTEA
);

CREATE TABLE Question(
    question_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    attraction INTEGER,         
    question VARCHAR(255),
    header_about_question VARCHAR(64),
    icon_key VARCHAR(32),
    isDeleted BOOLEAN DEFAULT false
);

CREATE TABLE Answer (
    ans_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    question_id UUID REFERENCES Question(question_id),
    bool_answ BOOLEAN,
    obs VARCHAR(255),
    img_id INTEGER REFERENCES Img(img_id) 
);

CREATE TABLE Checklist (
    checklist_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    operator_id UUID REFERENCES Users(usr_id),
    dttime TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    obs VARCHAR(255),
    is_archived BOOLEAN
);

CREATE TABLE Checklist_Answer(
    checklist_id UUID REFERENCES Checklist(checklist_id),
    ans_id UUID REFERENCES Answer(ans_id),
    PRIMARY KEY(checklist_id, ans_id)
);

INSERT INTO Users (usr_id, username, email, passwrd, u_type) VALUES
('744e17d6-8090-428a-a1b8-3f1266e92fcb', 'Floriosvaldo', 'gv@gmail.com', '$2a$12$B1FQg9mFdOs/ikw3JSv0n.f4yXWvJOhL0IQRRLMdr75rLcZEC6I16', 0), -- hashed password = 123456
('89824014-8d5a-469f-bfb6-78d5e351401a', 'Admin', 'admin@gmail.com', '$2a$12$KeQBFqb.nE3R4KNB4Xnok.BahkO5dJOJr15xeOL.0hSUlVwdsj1FC', 1);   -- hashed password = 123456

INSERT INTO Question (question_id, attraction, question, header_about_question) VALUES
('a1b2c3d4-e5f6-7890-abcd-ef1234567801', 1, 'Boias: Todas as boias estão calibradas, sem furos e limpas?', 'ENTRADA DA ATRAÇÃO'),
('a1b2c3d4-e5f6-7890-abcd-ef1234567802', 1, 'Placas: Regras e altura encontram-se instaladas e com informações visíveis?', 'ENTRADA DA ATRAÇÃO'),
('a1b2c3d4-e5f6-7890-abcd-ef1234567803', 1, 'Balança ligada?', 'ENTRADA DA ATRAÇÃO'),

('a1b2c3d4-e5f6-7890-abcd-ef1234567804', 1, 'Degraus e guardas corpos da escadas e plataforma: Encontram-se fixos e firmes?', 'ESCADAS E PLATAFORMA'),
('a1b2c3d4-e5f6-7890-abcd-ef1234567805', 1, 'Sistema de içamento de boia: eixo de rotação segue sem travamento e está bem lubrificado?', 'ESCADAS E PLATAFORMA'),
('a1b2c3d4-e5f6-7890-abcd-ef1234567806', 1, 'Sistema de içamento de boia: os botões encontram-se pronto para uso e sem irregularidade?', 'ESCADAS E PLATAFORMA'),
('a1b2c3d4-e5f6-7890-abcd-ef1234567807', 1, 'Sistema de içamento de boia: cabos encontra-se sem ferrugens e funciona corretamente?', 'ESCADAS E PLATAFORMA'),
('a1b2c3d4-e5f6-7890-abcd-ef1234567808', 1, 'Placas: Régua de altura, regras e proibido acessórios: Encontra-se instaladas e com informações visíveis? (Torre)', 'ESCADAS E PLATAFORMA'),

('a1b2c3d4-e5f6-7890-abcd-ef1234567809', 1, 'Entrada do escorregador PENDULO: Sem avarias, trincados, rachados ou pontas que possam machucar?', 'ESCORREGADORES, ENTRADAS, PERCURSO E CHEGADA'),
('a1b2c3d4-e5f6-7890-abcd-ef1234567810', 1, 'Cinto de segurança encontra-se em boas condições para o uso?', 'ESCORREGADORES, ENTRADAS, PERCURSO E CHEGADA'),
('a1b2c3d4-e5f6-7890-abcd-ef1234567811', 1, 'Realizado checagem a seco do desembarque e percurso do escorregador PENDULO?', 'ESCORREGADORES, ENTRADAS, PERCURSO E CHEGADA'),
('a1b2c3d4-e5f6-7890-abcd-ef1234567812', 1, 'Kit de primeiros socorros encontra-se pronto para uso de urgência e emergência? (PENDULO)', 'ESCORREGADORES, ENTRADAS, PERCURSO E CHEGADA'),
('a1b2c3d4-e5f6-7890-abcd-ef1234567813', 1, 'Entrada do escorregador ESFERA: Sem avarias, trincados, rachados ou pontas que possam machucar?', 'ESCORREGADORES, ENTRADAS, PERCURSO E CHEGADA'),
('a1b2c3d4-e5f6-7890-abcd-ef1234567814', 1, 'Realizado checagem a seco do desembarque e percurso do escorregador ESFERA?', 'ESCORREGADORES, ENTRADAS, PERCURSO E CHEGADA'),
('a1b2c3d4-e5f6-7890-abcd-ef1234567815', 1, 'Entrada do escorregador CORREDEIRA: Sem avarias, trincados, rachados ou pontas que possam machucar?', 'ESCORREGADORES, ENTRADAS, PERCURSO E CHEGADA'),
('a1b2c3d4-e5f6-7890-abcd-ef1234567816', 1, 'Realizado checagem a seco do desembarque e percurso do escorregador CORREDEIRA?', 'ESCORREGADORES, ENTRADAS, PERCURSO E CHEGADA'),
('a1b2c3d4-e5f6-7890-abcd-ef1234567817', 1, 'Entrada do escorregador CANOA: Sem avarias, trincados, rachados ou pontas que possam machucar?', 'ESCORREGADORES, ENTRADAS, PERCURSO E CHEGADA'),
('a1b2c3d4-e5f6-7890-abcd-ef1234567818', 1, 'Realizado checagem a seco do desembarque e percurso do escorregador CANOA?', 'ESCORREGADORES, ENTRADAS, PERCURSO E CHEGADA'),

('a1b2c3d4-e5f6-7890-abcd-ef1234567819', 1, 'Piso: Área de circulação sem partes e pontas que possam machucar?', 'AREA DE CIRCULAÇÃO'),
('a1b2c3d4-e5f6-7890-abcd-ef1234567820', 1, 'As 3 calhas de chegada e grelhas encontran-se fixas e firmes?', 'AREA DE CIRCULAÇÃO'),
('a1b2c3d4-e5f6-7890-abcd-ef1234567821', 1, 'Kit de primeiros socorros encontra-se pronto para uso de urgência e emergência? (BÓIA DUPLA)', 'AREA DE CIRCULAÇÃO');

INSERT INTO Question (question_id, attraction, question, header_about_question) VALUES
('e5f6a7b8-c9d0-1234-efab-345678900001', 2, 'Placa: Informações e regras encontram-se instaladas e com informações visíveis?', 'ENTRADA 01 - RIO 01 LADO RACK DE BOIAS'),
('e5f6a7b8-c9d0-1234-efab-345678900002', 2, 'Degraus, corrimão e bordas estão fixos e sem pontas que possam machucar?', 'ENTRADA 01 - RIO 01 LADO RACK DE BOIAS'),
('e5f6a7b8-c9d0-1234-efab-345678900003', 2, 'Racks de boias estão fixos e sem pontas que possam machucar? Estado da pintura sem pontos de ferrugem?', 'ENTRADA 01 - RIO 01 LADO RACK DE BOIAS'),
('e5f6a7b8-c9d0-1234-efab-345678900004', 2, 'Cordinhas das entradas encontram-se em boas condições de uso?', 'ENTRADA 01 - RIO 01 LADO RACK DE BOIAS'),
('e5f6a7b8-c9d0-1234-efab-345678900005', 2, 'Bordas e ralos das piscinas encontram-se sem pontas que possam machucar?', 'ENTRADA 01 - RIO 01 LADO RACK DE BOIAS'),

('e5f6a7b8-c9d0-1234-efab-345678900006', 2, 'Placa: Informações e regras encontram-se instaladas e com informações visíveis?', 'ENTRADA 02 - RIO 01 LADO PRAIA'),
('e5f6a7b8-c9d0-1234-efab-345678900007', 2, 'Degraus, corrimão e bordas estão fixos e sem pontas que possam machucar?', 'ENTRADA 02 - RIO 01 LADO PRAIA'),
('e5f6a7b8-c9d0-1234-efab-345678900008', 2, 'Cordinhas das entradas encontram-se em boas condições de uso?', 'ENTRADA 02 - RIO 01 LADO PRAIA'),
('e5f6a7b8-c9d0-1234-efab-345678900009', 2, 'Bordas e ralos das piscinas encontram-se sem pontas que possam machucar?', 'ENTRADA 02 - RIO 01 LADO PRAIA'),

('e5f6a7b8-c9d0-1234-efab-345678900010', 2, 'Placa: Informações e regras encontram-se instaladas e com informações visíveis?', 'ENTRADA 03 - PRÓXIMO À HAMBURGUERIA'),
('e5f6a7b8-c9d0-1234-efab-345678900011', 2, 'Degraus, corrimão e bordas estão fixos e sem pontas que possam machucar?', 'ENTRADA 03 - PRÓXIMO À HAMBURGUERIA'),
('e5f6a7b8-c9d0-1234-efab-345678900012', 2, 'Racks de boias estão fixos e sem pontas que possam machucar? Estado da pintura sem pontos de ferrugem?', 'ENTRADA 03 - PRÓXIMO À HAMBURGUERIA'),
('e5f6a7b8-c9d0-1234-efab-345678900013', 2, 'Cordinhas das entradas encontram-se em boas condições de uso?', 'ENTRADA 03 - PRÓXIMO À HAMBURGUERIA'),
('e5f6a7b8-c9d0-1234-efab-345678900014', 2, 'Bordas e ralos das piscinas encontram-se sem pontas que possam machucar?', 'ENTRADA 03 - PRÓXIMO À HAMBURGUERIA'),
('e5f6a7b8-c9d0-1234-efab-345678900015', 2, 'Verificar ponte: cascatas com a vazão adequada de água?', 'ENTRADA 03 - PRÓXIMO À HAMBURGUERIA'),

('e5f6a7b8-c9d0-1234-efab-345678900016', 2, 'Degraus, corrimão e bordas estão fixos e sem pontas que possam machucar?', 'ENTRADA 04 - ACESSO AO DAYBED'),
('e5f6a7b8-c9d0-1234-efab-345678900017', 2, 'Cordinhas das entradas encontram-se em boas condições de uso?', 'ENTRADA 04 - ACESSO AO DAYBED'),
('e5f6a7b8-c9d0-1234-efab-345678900018', 2, 'Bordas e ralos das piscinas encontram-se sem pontas que possam machucar?', 'ENTRADA 04 - ACESSO AO DAYBED'),

('e5f6a7b8-c9d0-1234-efab-345678900019', 2, 'Degraus, corrimão e bordas estão fixos e sem pontas que possam machucar?', 'ENTRADA 05 - RESTAURANTE YAMAMA'),
('e5f6a7b8-c9d0-1234-efab-345678900020', 2, 'Racks de boias estão fixos e sem pontas que possam machucar? Estado da pintura sem pontos de ferrugem?', 'ENTRADA 05 - RESTAURANTE YAMAMA'),
('e5f6a7b8-c9d0-1234-efab-345678900021', 2, 'Cordinhas das entradas encontram-se em boas condições de uso?', 'ENTRADA 05 - RESTAURANTE YAMAMA'),
('e5f6a7b8-c9d0-1234-efab-345678900022', 2, 'Bordas e ralos das piscinas encontram-se sem pontas que possam machucar?', 'ENTRADA 05 - RESTAURANTE YAMAMA'),

('e5f6a7b8-c9d0-1234-efab-345678900023', 2, 'Degraus, corrimão e bordas estão fixos e sem pontas que possam machucar?', 'ENTRADA 06 - RIO 11 LOUNGE BAR'),
('e5f6a7b8-c9d0-1234-efab-345678900024', 2, 'Cordinhas das entradas encontram-se em boas condições de uso?', 'ENTRADA 06 - RIO 11 LOUNGE BAR'),
('e5f6a7b8-c9d0-1234-efab-345678900025', 2, 'Bordas e ralos das piscinas encontram-se sem pontas que possam machucar?', 'ENTRADA 06 - RIO 11 LOUNGE BAR'),
('e5f6a7b8-c9d0-1234-efab-345678900026', 2, 'Verificar ponte: cascatas com a vazão adequada de água?', 'ENTRADA 06 - RIO 11 LOUNGE BAR'),

('e5f6a7b8-c9d0-1234-efab-345678900027', 2, 'Placa: Informações e regras encontram-se instaladas e com informações visíveis?', 'ENTRADA 07 - DAYBED PRÓXIMO AO RIO 11'),
('e5f6a7b8-c9d0-1234-efab-345678900028', 2, 'Degraus, corrimão e bordas estão fixos e sem pontas que possam machucar?', 'ENTRADA 07 - DAYBED PRÓXIMO AO RIO 11'),
('e5f6a7b8-c9d0-1234-efab-345678900029', 2, 'Cordinhas das entradas encontram-se em boas condições de uso?', 'ENTRADA 07 - DAYBED PRÓXIMO AO RIO 11'),
('e5f6a7b8-c9d0-1234-efab-345678900030', 2, 'Bordas e ralos das piscinas encontram-se sem pontas que possam machucar?', 'ENTRADA 07 - DAYBED PRÓXIMO AO RIO 11');

INSERT INTO Question (question_id, attraction, question, header_about_question) VALUES
('c9d0e1f2-a3b4-5678-cdef-789000000001', 3, 'Placas: Regras e altura encontram-se instaladas e com informações visíveis?', 'ENTRADA DA ATRAÇÃO'),
('c9d0e1f2-a3b4-5678-cdef-789000000002', 3, 'Piscina: a entrada está limpa, a água está sem cor e sem cheiro?', 'ENTRADA DA ATRAÇÃO'),

('c9d0e1f2-a3b4-5678-cdef-789000000003', 3, 'Degraus e guarda-corpos das escadas e plataforma encontram-se fixos e firmes?', 'ESCADAS E PLATAFORMA'),
('c9d0e1f2-a3b4-5678-cdef-789000000004', 3, 'Régua de altura, regras e proibição de acessórios encontram-se instaladas e com informações visíveis?', 'ESCADAS E PLATAFORMA'),

('c9d0e1f2-a3b4-5678-cdef-789000000005', 3, 'Escorregador duplo Roxo sem avarias, trincados, rachados ou pontas que possam machucar?', 'ESCORREGADORES PLATAFORMA'),
('c9d0e1f2-a3b4-5678-cdef-789000000006', 3, 'Escorregador duplo Rosa sem avarias, trincados, rachados ou pontas que possam machucar?', 'ESCORREGADORES PLATAFORMA'),
('c9d0e1f2-a3b4-5678-cdef-789000000007', 3, 'Escorregador duplo Azul sem avarias, trincados, rachados ou pontas que possam machucar?', 'ESCORREGADORES PLATAFORMA'),

('c9d0e1f2-a3b4-5678-cdef-789000000008', 3, 'Escorregador triplo sem avarias, trincados, rachados ou pontas que possam machucar?', 'ESCORREGADORES KIDS 1'),
('c9d0e1f2-a3b4-5678-cdef-789000000009', 3, 'Escorregador roxo sem avarias, trincados, rachados ou pontas que possam machucar?', 'ESCORREGADORES KIDS 1'),
('c9d0e1f2-a3b4-5678-cdef-789000000010', 3, 'Escorregador rosa sem avarias, trincados, rachados ou pontas que possam machucar?', 'ESCORREGADORES KIDS 1'),

('c9d0e1f2-a3b4-5678-cdef-789000000011', 3, 'Escorregador Azul sem avarias, trincados, rachados ou pontas que possam machucar?', 'ESCORREGADORES KIDS 2'),
('c9d0e1f2-a3b4-5678-cdef-789000000012', 3, 'Escorregador roxo com rosa sem avarias, trincados, rachados ou pontas que possam machucar?', 'ESCORREGADORES KIDS 2'),

('c9d0e1f2-a3b4-5678-cdef-789000000013', 3, 'Escorregador triplo Azul sem avarias, trincados, rachados ou pontas que possam machucar?', 'ESCORREGADORES KIDS 3'),
('c9d0e1f2-a3b4-5678-cdef-789000000014', 3, 'Escorregador azul sem avarias, trincados, rachados ou pontas que possam machucar?', 'ESCORREGADORES KIDS 3'),
('c9d0e1f2-a3b4-5678-cdef-789000000015', 3, 'Escorregador Rosa sem avarias, trincados, rachados ou pontas que possam machucar?', 'ESCORREGADORES KIDS 3'),

('c9d0e1f2-a3b4-5678-cdef-789000000016', 3, 'Escorregador triplo rosa sem avarias, trincados, rachados ou pontas que possam machucar?', 'ESCORREGADORES KIDS 4'),
('c9d0e1f2-a3b4-5678-cdef-789000000017', 3, 'Escorregador azul sem avarias, trincados, rachados ou pontas que possam machucar?', 'ESCORREGADORES KIDS 4'),

('c9d0e1f2-a3b4-5678-cdef-789000000018', 3, 'Escorregador mini roxo sem avarias, trincados, rachados ou pontas que possam machucar?', 'ESCORREGADORES KIDS 5'),

('c9d0e1f2-a3b4-5678-cdef-789000000019', 3, 'Grelhas plásticas estão completas e firmes?', 'AREA DE CIRCULAÇÃO'),
('c9d0e1f2-a3b4-5678-cdef-789000000020', 3, 'Piso: área de circulação sem partes e pontas que possam machucar?', 'AREA DE CIRCULAÇÃO');

INSERT INTO Question (question_id, attraction, question, header_about_question) VALUES
('d4e5f6a7-b8c9-0123-defa-234567890001', 4, 'Placa de informações encontra-se instalada e com as informações visíveis?', 'PRAIA DO VULCÃO'),
('d4e5f6a7-b8c9-0123-defa-234567890002', 4, 'Lava-pés encontra-se limpo e com anti-derrapante?', 'PRAIA DO VULCÃO'),
('d4e5f6a7-b8c9-0123-defa-234567890003', 4, 'Bordas da piscina estão fixas e firmes?', 'PRAIA DO VULCÃO'),
('d4e5f6a7-b8c9-0123-defa-234567890004', 4, 'Entrada da piscina: o chão encontra-se sem pontas ou desnível que possam provocar quedas?', 'PRAIA DO VULCÃO'),
('d4e5f6a7-b8c9-0123-defa-234567890005', 4, 'Meio e fundo da piscina apresentam pontas ou desnível que possam provocar quedas?', 'PRAIA DO VULCÃO'),
('d4e5f6a7-b8c9-0123-defa-234567890006', 4, 'Grades do fundo da piscina de ondas estão todas fixas e com todos os parafusos rosqueados? Lado direito', 'PRAIA DO VULCÃO'),
('d4e5f6a7-b8c9-0123-defa-234567890007', 4, 'Cadeirões estão posicionados no local correto, firmes e em bom estado?', 'PRAIA DO VULCÃO'),
('d4e5f6a7-b8c9-0123-defa-234567890008', 4, 'Cadeiras e guarda-sol dos postos de guarda-vidas estão em boas condições de uso?', 'PRAIA DO VULCÃO'),
('d4e5f6a7-b8c9-0123-defa-234567890009', 4, 'Grades do fundo da piscina de ondas estão todas fixas e com todos os parafusos rosqueados? Lado esquerdo', 'PRAIA DO VULCÃO'),
('d4e5f6a7-b8c9-0123-defa-234567890010', 4, 'Raias do fundo das piscinas estão fixas e em boas condições de uso?', 'PRAIA DO VULCÃO'),

('d4e5f6a7-b8c9-0123-defa-234567890011', 4, 'Cadeiras e guarda-sol dos postos de guarda-vidas estão em boas condições de uso?', 'BAR MOLHADO'),
('d4e5f6a7-b8c9-0123-defa-234567890012', 4, 'Degraus e corrimão estão fixos, firmes e sem pontas que possam machucar?', 'BAR MOLHADO'),
('d4e5f6a7-b8c9-0123-defa-234567890013', 4, 'Piso da piscina está sem pontas e com pintura em boas condições de uso?', 'BAR MOLHADO'),
('d4e5f6a7-b8c9-0123-defa-234567890014', 4, 'Bancos estão fixos e sem pontas que possam machucar?', 'BAR MOLHADO'),
('d4e5f6a7-b8c9-0123-defa-234567890015', 4, 'Rochas estão sem pontas ou desníveis que possam machucar?', 'BAR MOLHADO'),
('d4e5f6a7-b8c9-0123-defa-234567890016', 4, 'Ralos estão fixos e sem pontas que possam machucar?', 'BAR MOLHADO'),
('d4e5f6a7-b8c9-0123-defa-234567890017', 4, 'Espreguiçadeiras estão em boas condições de uso e no layout?', 'BAR MOLHADO');

INSERT INTO Question (question_id, attraction, question, header_about_question) VALUES
('b8c9d0e1-f2a3-4567-bcde-678900000001', 5, 'Placas: Regras e altura encontram-se instaladas e com informações visíveis? (Escada)', 'ENTRADA DA ATRAÇÃO'),
('b8c9d0e1-f2a3-4567-bcde-678900000002', 5, 'Placa: Atração fechada encontra-se com as informações visíveis e em condições de uso?', 'ENTRADA DA ATRAÇÃO'),
('b8c9d0e1-f2a3-4567-bcde-678900000003', 5, 'Balança ligada e calibrada?', 'ENTRADA DA ATRAÇÃO'),
('b8c9d0e1-f2a3-4567-bcde-678900000004', 5, 'Compressor funcionando?', 'ENTRADA DA ATRAÇÃO'),

('b8c9d0e1-f2a3-4567-bcde-678900000005', 5, 'Degraus e guarda-corpos das escadas e plataforma encontram-se fixos e firmes?', 'ESCADAS E PLATAFORMA'),
('b8c9d0e1-f2a3-4567-bcde-678900000006', 5, 'Degraus e guarda-corpos das escadas e plataforma encontram-se livres de ferrugem e com pintura em bom estado?', 'ESCADAS E PLATAFORMA'),
('b8c9d0e1-f2a3-4567-bcde-678900000007', 5, 'Postinhos, cordas e cadeira estão organizados e em boas condições de uso?', 'ESCADAS E PLATAFORMA'),
('b8c9d0e1-f2a3-4567-bcde-678900000008', 5, 'Placas: Régua de altura encontra-se instalada e com informações visíveis?', 'ESCADAS E PLATAFORMA'),

('b8c9d0e1-f2a3-4567-bcde-678900000009', 5, 'ARREPIO: Botões de abertura e fechamento de porta estão funcionando normalmente?', 'ESCORREGADORES, ENTRADAS, PERCURSO E CHEGADA'),
('b8c9d0e1-f2a3-4567-bcde-678900000010', 5, 'ARREPIO: Botões de abertura e fechamento de alçapão estão funcionando normalmente?', 'ESCORREGADORES, ENTRADAS, PERCURSO E CHEGADA'),
('b8c9d0e1-f2a3-4567-bcde-678900000011', 5, 'ARREPIO: Limpeza do acrílico: está limpo e transparente?', 'ESCORREGADORES, ENTRADAS, PERCURSO E CHEGADA'),
('b8c9d0e1-f2a3-4567-bcde-678900000012', 5, 'ARREPIO: Limpeza da cápsula: está limpa e em condições de uso?', 'ESCORREGADORES, ENTRADAS, PERCURSO E CHEGADA'),
('b8c9d0e1-f2a3-4567-bcde-678900000013', 5, 'ARREPIO: Percurso do escorregador está livre de desníveis e pontas que possam machucar?', 'ESCORREGADORES, ENTRADAS, PERCURSO E CHEGADA'),
('b8c9d0e1-f2a3-4567-bcde-678900000014', 5, 'ARREPIO: Calha de frenagem está livre de desníveis e pontas que possam machucar?', 'ESCORREGADORES, ENTRADAS, PERCURSO E CHEGADA'),
('b8c9d0e1-f2a3-4567-bcde-678900000015', 5, 'ARREPIO: Calha de frenagem está limpa e em condições de uso?', 'ESCORREGADORES, ENTRADAS, PERCURSO E CHEGADA'),
('b8c9d0e1-f2a3-4567-bcde-678900000016', 5, 'KAMIKAZE: Entrada do escorregador apresenta avarias, trincados, rachados ou pontas que possam machucar?', 'ESCORREGADORES, ENTRADAS, PERCURSO E CHEGADA'),
('b8c9d0e1-f2a3-4567-bcde-678900000017', 5, 'KAMIKAZE: Vazão de água está no nível adequado?', 'ESCORREGADORES, ENTRADAS, PERCURSO E CHEGADA'),
('b8c9d0e1-f2a3-4567-bcde-678900000018', 5, 'KAMIKAZE: Percurso do escorregador está livre de desníveis e pontas que possam machucar?', 'ESCORREGADORES, ENTRADAS, PERCURSO E CHEGADA'),
('b8c9d0e1-f2a3-4567-bcde-678900000019', 5, 'KAMIKAZE: Calha de frenagem está livre de desníveis e pontas que possam machucar?', 'ESCORREGADORES, ENTRADAS, PERCURSO E CHEGADA'),
('b8c9d0e1-f2a3-4567-bcde-678900000020', 5, 'KAMIKAZE: Calha de frenagem está limpa e em condições de uso?', 'ESCORREGADORES, ENTRADAS, PERCURSO E CHEGADA'),
('b8c9d0e1-f2a3-4567-bcde-678900000021', 5, 'CALAFRIO: Botões de abertura e fechamento de porta estão funcionando normalmente?', 'ESCORREGADORES, ENTRADAS, PERCURSO E CHEGADA'),
('b8c9d0e1-f2a3-4567-bcde-678900000022', 5, 'CALAFRIO: Botões de abertura e fechamento de alçapão estão funcionando normalmente?', 'ESCORREGADORES, ENTRADAS, PERCURSO E CHEGADA'),
('b8c9d0e1-f2a3-4567-bcde-678900000023', 5, 'CALAFRIO: Limpeza do acrílico: está limpo e transparente?', 'ESCORREGADORES, ENTRADAS, PERCURSO E CHEGADA'),
('b8c9d0e1-f2a3-4567-bcde-678900000024', 5, 'CALAFRIO: Limpeza da cápsula: está limpa e em condições de uso?', 'ESCORREGADORES, ENTRADAS, PERCURSO E CHEGADA'),
('b8c9d0e1-f2a3-4567-bcde-678900000025', 5, 'CALAFRIO: Percurso do escorregador está livre de desníveis e pontas que possam machucar?', 'ESCORREGADORES, ENTRADAS, PERCURSO E CHEGADA'),
('b8c9d0e1-f2a3-4567-bcde-678900000026', 5, 'CALAFRIO: Calha de frenagem está livre de desníveis e pontas que possam machucar?', 'ESCORREGADORES, ENTRADAS, PERCURSO E CHEGADA'),
('b8c9d0e1-f2a3-4567-bcde-678900000027', 5, 'CALAFRIO: Calha de frenagem está limpa e em condições de uso?', 'ESCORREGADORES, ENTRADAS, PERCURSO E CHEGADA'),
('b8c9d0e1-f2a3-4567-bcde-678900000028', 5, 'Capa da televisão e aparelho estão em boas condições e funcionam corretamente?', 'ESCORREGADORES, ENTRADAS, PERCURSO E CHEGADA'),

('b8c9d0e1-f2a3-4567-bcde-678900000029', 5, 'Piso: área de circulação sem partes e pontas que possam machucar?', 'AREA DE CIRCULAÇÃO E CISTERNA'),
('b8c9d0e1-f2a3-4567-bcde-678900000030', 5, 'Posto de guarda-vidas: cadeira e ombrelone estão em boas condições de uso?', 'AREA DE CIRCULAÇÃO E CISTERNA'),
('b8c9d0e1-f2a3-4567-bcde-678900000031', 5, 'CISTERNA: Nível de água está dentro do esperado?', 'AREA DE CIRCULAÇÃO E CISTERNA'),
('b8c9d0e1-f2a3-4567-bcde-678900000032', 5, 'CISTERNA: Água está limpa e quente?', 'AREA DE CIRCULAÇÃO E CISTERNA'),

('b8c9d0e1-f2a3-4567-bcde-678900000033', 5, 'Piso: área de circulação sem partes e pontas que possam machucar?', 'SAIDA DE EMERGENCIA ARREPIO'),
('b8c9d0e1-f2a3-4567-bcde-678900000034', 5, 'Porta de emergência está em boas condições e abre e fecha normalmente?', 'SAIDA DE EMERGENCIA ARREPIO'),
('b8c9d0e1-f2a3-4567-bcde-678900000035', 5, 'RAPEL: Material montado e em boas condições de uso?', 'SAIDA DE EMERGENCIA ARREPIO'),
('b8c9d0e1-f2a3-4567-bcde-678900000036', 5, 'RAPEL: Material está completo: 1 talabarte, 2 cintos, 2 polias, 1 freio?', 'SAIDA DE EMERGENCIA ARREPIO');

INSERT INTO Question (question_id, attraction, question, header_about_question) VALUES
('c3d4e5f6-a7b8-9012-cdef-123456789001', 6, 'Placa de informações encontra-se instalada e com as informações visíveis?', 'PRAIA DOS MOAIS'),
('c3d4e5f6-a7b8-9012-cdef-123456789002', 6, 'Entrada da piscina: o chão está escorregadio?', 'PRAIA DOS MOAIS'),
('c3d4e5f6-a7b8-9012-cdef-123456789003', 6, 'Entrada da piscina: o chão está limpo?', 'PRAIA DOS MOAIS'),
('c3d4e5f6-a7b8-9012-cdef-123456789004', 6, 'Entrada da piscina: o chão encontra-se sem pontas ou desnível que possam provocar quedas?', 'PRAIA DOS MOAIS'),
('c3d4e5f6-a7b8-9012-cdef-123456789005', 6, 'Meio e fundo da piscina apresentam materiais estranhos ou sujeira?', 'PRAIA DOS MOAIS'),
('c3d4e5f6-a7b8-9012-cdef-123456789006', 6, 'Há animais na água?', 'PRAIA DOS MOAIS'),
('c3d4e5f6-a7b8-9012-cdef-123456789007', 6, 'Cadeiras e guarda-sol dos postos de guarda-vidas estão em boas condições de uso?', 'PRAIA DOS MOAIS'),
('c3d4e5f6-a7b8-9012-cdef-123456789008', 6, 'Ralos estão fixos e sem pontas que possam machucar?', 'PRAIA DOS MOAIS'),
('c3d4e5f6-a7b8-9012-cdef-123456789009', 6, 'Cascata encontra-se íntegra e em boas condições de uso?', 'PRAIA DOS MOAIS'),
('c3d4e5f6-a7b8-9012-cdef-123456789010', 6, 'Moais estão funcionando e em boas condições de uso?', 'PRAIA DOS MOAIS'),
('c3d4e5f6-a7b8-9012-cdef-123456789011', 6, 'Passarela de acessibilidade: há alguma obstrução, material no caminho, material cortante ou perfurante?', 'PRAIA DOS MOAIS'),

('c3d4e5f6-a7b8-9012-cdef-123456789012', 6, 'Cadeiras e guarda-sol dos postos de guarda-vidas estão em boas condições de uso?', 'OFURÔ'),
('c3d4e5f6-a7b8-9012-cdef-123456789013', 6, 'Piso da piscina: a pintura está em boas condições?', 'OFURÔ'),
('c3d4e5f6-a7b8-9012-cdef-123456789014', 6, 'Meio e fundo da piscina apresentam materiais estranhos ou sujeira?', 'OFURÔ'),
('c3d4e5f6-a7b8-9012-cdef-123456789015', 6, 'Esguichos estão sem pontas ou farpas?', 'OFURÔ'),
('c3d4e5f6-a7b8-9012-cdef-123456789016', 6, 'Sombrites estão firmes e seguros?', 'OFURÔ'),
('c3d4e5f6-a7b8-9012-cdef-123456789017', 6, 'Ralos estão fixos e sem pontas que possam machucar?', 'OFURÔ'),
('c3d4e5f6-a7b8-9012-cdef-123456789018', 6, 'Espreguiçadeiras estão em boas condições de uso e no layout?', 'OFURÔ'),
('c3d4e5f6-a7b8-9012-cdef-123456789019', 6, 'Mesas e cadeiras estão em boas condições de uso e no layout?', 'OFURÔ');

INSERT INTO Question (question_id, attraction, question, header_about_question) VALUES
('b2c3d4e5-f6a7-8901-bcde-f12345678901', 7, 'Tapetes: Alças firmes e fixas?', 'ENTRADA DA ATRAÇÃO'),
('b2c3d4e5-f6a7-8901-bcde-f12345678902', 7, 'Placa: Regras e altura encontram-se instalados e com informações visíveis?', 'ENTRADA DA ATRAÇÃO'),
('b2c3d4e5-f6a7-8901-bcde-f12345678903', 7, 'Balança ligada e calibrada?', 'ENTRADA DA ATRAÇÃO'),
('b2c3d4e5-f6a7-8901-bcde-f12345678904', 7, 'Placa de atração fechada encontra-se em boas condições de uso?', 'ENTRADA DA ATRAÇÃO'),

('b2c3d4e5-f6a7-8901-bcde-f12345678905', 7, 'Degraus e guarda corpo da escada: Encontram-se fixos e firmes?', 'ESCADAS E PLATAFORMA'),
('b2c3d4e5-f6a7-8901-bcde-f12345678906', 7, 'Placas: Réguas de altura, regras e proibição de acessórios: Encontram-se fixos e firmes?', 'ESCADAS E PLATAFORMA'),
('b2c3d4e5-f6a7-8901-bcde-f12345678907', 7, 'Piso e cobertura encontram-se em boas condições de uso?', 'ESCADAS E PLATAFORMA'),

('b2c3d4e5-f6a7-8901-bcde-f12345678908', 7, 'Entrada dos escorregadores sem avarias, trincados, rachados ou pontas que possam machucar? Pista 1', 'ESCORREGADORES, ENTRADAS'),
('b2c3d4e5-f6a7-8901-bcde-f12345678909', 7, 'Entrada dos escorregadores sem avarias, trincados, rachados ou pontas que possam machucar? Pista 2', 'ESCORREGADORES, ENTRADAS'),
('b2c3d4e5-f6a7-8901-bcde-f12345678910', 7, 'Entrada dos escorregadores sem avarias, trincados, rachados ou pontas que possam machucar? Pista 3', 'ESCORREGADORES, ENTRADAS'),
('b2c3d4e5-f6a7-8901-bcde-f12345678911', 7, 'Entrada dos escorregadores sem avarias, trincados, rachados ou pontas que possam machucar? Pista 4', 'ESCORREGADORES, ENTRADAS'),

('b2c3d4e5-f6a7-8901-bcde-f12345678912', 7, 'Realizado checagem a seco do desembarque e percurso dos escorregadores, pista 1?', 'ESCORREGADORES, DESEMBARQUE E PERCURSO'),
('b2c3d4e5-f6a7-8901-bcde-f12345678913', 7, 'Realizado checagem a seco do desembarque e percurso dos escorregadores, pista 2?', 'ESCORREGADORES, DESEMBARQUE E PERCURSO'),
('b2c3d4e5-f6a7-8901-bcde-f12345678914', 7, 'Realizado checagem a seco do desembarque e percurso dos escorregadores, pista 3?', 'ESCORREGADORES, DESEMBARQUE E PERCURSO'),
('b2c3d4e5-f6a7-8901-bcde-f12345678915', 7, 'Realizado checagem a seco do desembarque e percurso dos escorregadores, pista 4?', 'ESCORREGADORES, DESEMBARQUE E PERCURSO'),
('b2c3d4e5-f6a7-8901-bcde-f12345678916', 7, 'Piso: Área de circulação sem partes e pontas que possam machucar?', 'ESCORREGADORES, DESEMBARQUE E PERCURSO'),
('b2c3d4e5-f6a7-8901-bcde-f12345678917', 7, 'Placa de identificação de cada pista apresenta informações visíveis e em condições de uso?', 'ESCORREGADORES, DESEMBARQUE E PERCURSO'),
('b2c3d4e5-f6a7-8901-bcde-f12345678918', 7, 'Placa de atração temporariamente fechada apresenta informações visíveis e em condições de uso?', 'ESCORREGADORES, DESEMBARQUE E PERCURSO');

INSERT INTO Question (question_id, attraction, question, header_about_question) VALUES
('f6a7b8c9-d0e1-2345-fabc-456789000001', 8, 'Placas: Regras e altura encontram-se instaladas e com informações visíveis?', 'ENTRADA DA ATRAÇÃO'),
('f6a7b8c9-d0e1-2345-fabc-456789000002', 8, 'Piscina: a entrada está limpa, a água está sem cor e sem cheiro?', 'ENTRADA DA ATRAÇÃO'),

('f6a7b8c9-d0e1-2345-fabc-456789000003', 8, 'Degraus e guarda-corpos das escadas e plataforma encontram-se fixos e firmes?', 'ESCADAS E PLATAFORMA'),
('f6a7b8c9-d0e1-2345-fabc-456789000004', 8, 'Régua de altura, regras e proibição de acessórios encontram-se instaladas e com informações visíveis?', 'ESCADAS E PLATAFORMA'),

('f6a7b8c9-d0e1-2345-fabc-456789000005', 8, 'Escorregador duplo Roxo sem avarias, trincados, rachados ou pontas que possam machucar?', 'ESCORREGADORES PLATAFORMA'),
('f6a7b8c9-d0e1-2345-fabc-456789000006', 8, 'Escorregador duplo Rosa sem avarias, trincados, rachados ou pontas que possam machucar?', 'ESCORREGADORES PLATAFORMA'),
('f6a7b8c9-d0e1-2345-fabc-456789000007', 8, 'Escorregador duplo Azul sem avarias, trincados, rachados ou pontas que possam machucar?', 'ESCORREGADORES PLATAFORMA'),

('f6a7b8c9-d0e1-2345-fabc-456789000008', 8, 'Escorregador Navio sem avarias, trincados, rachados ou pontas que possam machucar?', 'MINI ESCORREGADORES'),
('f6a7b8c9-d0e1-2345-fabc-456789000009', 8, 'Escorregador Lagosta sem avarias, trincados, rachados ou pontas que possam machucar?', 'MINI ESCORREGADORES'),
('f6a7b8c9-d0e1-2345-fabc-456789000010', 8, 'Escorregador Tubarão sem avarias, trincados, rachados ou pontas que possam machucar?', 'MINI ESCORREGADORES'),

('f6a7b8c9-d0e1-2345-fabc-456789000011', 8, 'Caranguejo encontra-se fixo, firme e sem pontas que possam machucar?', 'ACESSÓRIOS'),
('f6a7b8c9-d0e1-2345-fabc-456789000012', 8, 'Cogumelo roxo encontra-se fixo, firme e sem pontas que possam machucar?', 'ACESSÓRIOS'),
('f6a7b8c9-d0e1-2345-fabc-456789000013', 8, 'Sapinho encontra-se fixo, firme e sem pontas que possam machucar?', 'ACESSÓRIOS'),
('f6a7b8c9-d0e1-2345-fabc-456789000014', 8, 'Tubarão encontra-se fixo, firme e sem pontas que possam machucar?', 'ACESSÓRIOS'),
('f6a7b8c9-d0e1-2345-fabc-456789000015', 8, 'Jacaré encontra-se fixo, firme e sem pontas que possam machucar?', 'ACESSÓRIOS'),
('f6a7b8c9-d0e1-2345-fabc-456789000016', 8, 'Estrela encontra-se fixa, firme e sem pontas que possam machucar?', 'ACESSÓRIOS'),
('f6a7b8c9-d0e1-2345-fabc-456789000017', 8, 'Palmeira encontra-se fixa, firme e sem pontas que possam machucar?', 'ACESSÓRIOS'),
('f6a7b8c9-d0e1-2345-fabc-456789000018', 8, 'Minhoca d''água encontra-se fixa, firme e sem pontas que possam machucar?', 'ACESSÓRIOS'),
('f6a7b8c9-d0e1-2345-fabc-456789000019', 8, 'Túnel d''água encontra-se fixo, firme e sem pontas que possam machucar?', 'ACESSÓRIOS'),
('f6a7b8c9-d0e1-2345-fabc-456789000020', 8, 'Postinho com esguichos encontra-se fixo, firme e sem pontas que possam machucar?', 'ACESSÓRIOS'),
('f6a7b8c9-d0e1-2345-fabc-456789000021', 8, 'Esguichos da plataforma encontram-se funcionando normalmente?', 'ACESSÓRIOS'),

('f6a7b8c9-d0e1-2345-fabc-456789000022', 8, 'Grelhas plásticas estão completas e firmes?', 'AREA DE CIRCULAÇÃO'),
('f6a7b8c9-d0e1-2345-fabc-456789000023', 8, 'Piso: área de circulação sem partes e pontas que possam machucar?', 'AREA DE CIRCULAÇÃO');

INSERT INTO Question (question_id, attraction, question, header_about_question) VALUES
('a7b8c9d0-e1f2-3456-abcd-567890000001', 9, 'Piso: área de circulação sem partes soltas e pontas que possam machucar?', 'AREA DE CIRCULAÇÃO'),
('a7b8c9d0-e1f2-3456-abcd-567890000002', 9, 'Bordas da piscina estão fixas e firmes, sem pontas que possam machucar?', 'AREA DE CIRCULAÇÃO'),
('a7b8c9d0-e1f2-3456-abcd-567890000003', 9, 'Escadas de acesso das cabanas: corrimão fixo e degraus firmes e sem pontas que possam machucar?', 'AREA DE CIRCULAÇÃO'),
('a7b8c9d0-e1f2-3456-abcd-567890000004', 9, 'Estruturas das cabanas estão fixas e firmes?', 'AREA DE CIRCULAÇÃO'),
('a7b8c9d0-e1f2-3456-abcd-567890000005', 9, 'Cadeirões estão posicionados no local correto, firmes e em bom estado?', 'AREA DE CIRCULAÇÃO'),
('a7b8c9d0-e1f2-3456-abcd-567890000006', 9, 'Cadeiras e guarda-sol dos postos de guarda-vidas estão em boas condições de uso?', 'AREA DE CIRCULAÇÃO'),
('a7b8c9d0-e1f2-3456-abcd-567890000007', 9, 'Meio e fundo da piscina apresentam pontas ou desnível que possam provocar quedas?', 'AREA DE CIRCULAÇÃO'),
('a7b8c9d0-e1f2-3456-abcd-567890000008', 9, 'Ralos da piscina estão sem pontas que possam machucar?', 'AREA DE CIRCULAÇÃO'),

('a7b8c9d0-e1f2-3456-abcd-567890000009', 9, 'CABANA 01: Corrimão fixo sem pontas que possam machucar?', 'BANGALÔS'),
('a7b8c9d0-e1f2-3456-abcd-567890000010', 9, 'CABANA 02: Corrimão fixo sem pontas que possam machucar?', 'BANGALÔS'),
('a7b8c9d0-e1f2-3456-abcd-567890000011', 9, 'CABANA 03: Corrimão fixo sem pontas que possam machucar?', 'BANGALÔS'),
('a7b8c9d0-e1f2-3456-abcd-567890000012', 9, 'CABANA 04: Corrimão fixo sem pontas que possam machucar?', 'BANGALÔS'),
('a7b8c9d0-e1f2-3456-abcd-567890000013', 9, 'CABANA 05: Corrimão fixo sem pontas que possam machucar?', 'BANGALÔS'),
('a7b8c9d0-e1f2-3456-abcd-567890000014', 9, 'CABANA 06: Corrimão fixo sem pontas que possam machucar?', 'BANGALÔS'),
('a7b8c9d0-e1f2-3456-abcd-567890000015', 9, 'CABANA 07: Corrimão fixo sem pontas que possam machucar?', 'BANGALÔS'),
('a7b8c9d0-e1f2-3456-abcd-567890000016', 9, 'CABANA 08: Corrimão fixo sem pontas que possam machucar?', 'BANGALÔS'),
('a7b8c9d0-e1f2-3456-abcd-567890000017', 9, 'CABANA 09: Corrimão fixo sem pontas que possam machucar?', 'BANGALÔS'),
('a7b8c9d0-e1f2-3456-abcd-567890000018', 9, 'CABANA 10: Corrimão fixo sem pontas que possam machucar?', 'BANGALÔS'),
('a7b8c9d0-e1f2-3456-abcd-567890000019', 9, 'CABANA 11: Corrimão fixo sem pontas que possam machucar?', 'BANGALÔS'),
('a7b8c9d0-e1f2-3456-abcd-567890000020', 9, 'CABANA 12: Corrimão fixo sem pontas que possam machucar?', 'BANGALÔS'),
('a7b8c9d0-e1f2-3456-abcd-567890000021', 9, 'CABANA 13: Corrimão fixo sem pontas que possam machucar?', 'BANGALÔS'),
('a7b8c9d0-e1f2-3456-abcd-567890000022', 9, 'CABANA 14: Corrimão fixo sem pontas que possam machucar?', 'BANGALÔS'),
('a7b8c9d0-e1f2-3456-abcd-567890000023', 9, 'CABANA 15: Corrimão fixo sem pontas que possam machucar?', 'BANGALÔS'),
('a7b8c9d0-e1f2-3456-abcd-567890000024', 9, 'CABANA 16: Corrimão fixo sem pontas que possam machucar?', 'BANGALÔS'),
('a7b8c9d0-e1f2-3456-abcd-567890000025', 9, 'CABANA 17: Corrimão fixo sem pontas que possam machucar?', 'BANGALÔS'),
('a7b8c9d0-e1f2-3456-abcd-567890000026', 9, 'CABANA 18: Corrimão fixo sem pontas que possam machucar?', 'BANGALÔS'),
('a7b8c9d0-e1f2-3456-abcd-567890000027', 9, 'CABANA 19: Corrimão fixo sem pontas que possam machucar?', 'BANGALÔS');
