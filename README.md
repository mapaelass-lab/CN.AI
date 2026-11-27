# CN.AI Beta — Cloudflare

Projeto-base adaptado para uma publicação mais simples no Cloudflare Workers: React + Vite, Worker API e Cloudflare D1.

## O que está incluído
- Home responsiva com a identidade CN.AI e mascote em CSS.
- Formulário de relato (anônimo por padrão, categorias de infraestrutura, bairro opcional).
- Código de acompanhamento aleatório e consulta de status.
- Painel público que só conta relatos publicados (sem números fictícios).
- Assistente de perguntas básicas; integração opcional com OpenAI API.
- Página administrativa com chave secreta para listar, mudar status e publicar/retirar relatos.
- Script SQL para criar a tabela D1.

## Ainda não está incluído
- Fotos (a interface explica que ainda não são aceitas).
- Mapa/geolocalização.
- Autenticação individual para administradores. A beta usa chave compartilhada; restrinja a rota `/admin` com Cloudflare Access antes de abrir o site publicamente.
- Limitação de requisições/antispam robusta, auditoria, processo formal de retenção/exclusão.

## Caminho de publicação recomendado
Este projeto usa Cloudflare Workers com o plugin Vite oficial. A publicação pela integração Git exige um repositório GitHub como origem do código; o site e API ficam hospedados na Cloudflare.

### A. Criar o banco D1
1. Faça login no Cloudflare.
2. Abra **Workers & Pages** e procure **D1 SQL database** (ou D1 no menu).
3. Crie um banco com nome `cn-ai-reports`.
4. Abra o banco e a aba **Console/SQL**.
5. Copie todo o conteúdo de `database/schema.sql`, cole e execute.
6. Copie o Database ID do banco recém-criado.
7. Abra `wrangler.jsonc` no projeto e substitua `REPLACE_WITH_D1_DATABASE_ID` pelo Database ID real.

### B. Enviar o código ao GitHub pelo navegador
1. Crie/login no GitHub e crie um repositório `cn-ai-beta`.
2. Use **Add file > Upload files** para enviar o conteúdo da pasta do projeto (arquivos e pastas). Não envie `node_modules`, `.dev.vars`, `.env` ou segredos.
3. Confirme o upload/commit.

### C. Conectar GitHub à Cloudflare Workers Builds
1. Cloudflare Dashboard > **Workers & Pages** > **Create application** > **Connect to Git** (o texto pode variar na interface).
2. Conecte GitHub e escolha o repositório.
3. Build command: `npm run build`.
4. Deploy command: `npx wrangler deploy`.
5. Confira se o projeto detecta Vite/Workers; finalize e aguarde a build.
6. O painel mostrará o endereço `.workers.dev`.

### D. Configurar a chave administrativa
1. No Worker publicado, abra **Settings > Variables and Secrets**.
2. Adicione um Secret chamado `ADMIN_KEY`.
3. Crie uma senha longa e aleatória, não reutilize sua senha pessoal.
4. Salve e redeploy, se a plataforma pedir.
5. Abra `/admin` no endereço do projeto e use essa chave. Não compartilhe a chave.
6. Para site público, coloque Cloudflare Access na rota `/admin` como camada adicional. Esta beta não tem usuários admin individuais.

### E. (Opcional) Conectar IA generativa
1. Adicione `OPENAI_API_KEY` como Worker Secret, sem inserir no código ou Git.
2. Adicione `OPENAI_MODEL` como variável (por padrão, código usa `gpt-5.5`; confirme disponibilidade e preço da API antes).
3. Teste o chat. Sem a chave, o chat responde com modo básico.

## Verificação antes de compartilhar
- Criar relato e receber código.
- Consultar o código e confirmar status.
- Confirmar que o painel público começa vazio e só inclui relatos publicados.
- Entrar na administração e mudar status/publicação.
- Testar que a chave admin incorreta não autoriza ações.
- Proteger `/admin` com Cloudflare Access.
- Não coletar nem publicar dados pessoais. Esta é uma beta escolar independente, não serviço oficial municipal.

## Desenvolvimento local (opcional)
- `npm install`
- `npm run dev`
- `npm run build`

## D1 SQL
O script está em `database/schema.sql`.
