# Guia de Testes - FMS com Autenticação

## Preparação do Ambiente

### 1. Instalar Dependências
```bash
npm install
```

### 2. Configurar Banco de Dados
- Copiar `.env.example` para `.env`
- Preencher credenciais do MySQL
- Executar script SQL:
```bash
mysql -u root -p FMS < src/database/SQLFMS.sql
```

### 3. Iniciar Servidor
```bash
npm run dev
```

O servidor deve estar rodando em `http://localhost:3000`

---

## Testes de Cadastro

### Teste 1: Cadastro Válido
**Objetivo**: Verificar se um novo usuário e restaurante são criados com sucesso

**Passos**:
1. Acessar `http://localhost:3000/cadastro.html`
2. Preencher formulário:
   - Nome: "João Silva"
   - Email: "joao@example.com"
   - Senha: "Senha123"
   - Confirmar Senha: "Senha123"
   - Razão Social: "Restaurante João Ltda"
   - Nome Fantasia: "João's Pizza"
   - Quantidade de Mesas: 20
   - CNPJ: "12345678901234"
3. Clicar em "Cadastrar"

**Resultado Esperado**:
- ✅ Mensagem de sucesso
- ✅ Redirecionamento para login após 3 segundos
- ✅ Dados salvos no banco de dados

**Verificação no Banco**:
```sql
SELECT * FROM Restaurante WHERE cnpj = '12345678901234';
SELECT * FROM Usuario WHERE email = 'joao@example.com';
```

---

### Teste 2: Email Duplicado
**Objetivo**: Rejeitar cadastro com email já existente

**Passos**:
1. Acessar `http://localhost:3000/cadastro.html`
2. Preencher com email de um usuário já cadastrado
3. Clicar em "Cadastrar"

**Resultado Esperado**:
- ✅ Mensagem de erro: "Email já cadastrado no sistema!"
- ✅ Usuário não é redirecionado

---

### Teste 3: CNPJ Duplicado
**Objetivo**: Rejeitar cadastro com CNPJ já existente

**Passos**:
1. Acessar `http://localhost:3000/cadastro.html`
2. Preencher com CNPJ de um restaurante já cadastrado (ex: "11222333000111")
3. Clicar em "Cadastrar"

**Resultado Esperado**:
- ✅ Mensagem de erro: "CNPJ já cadastrado no sistema!"
- ✅ Usuário não é redirecionado

---

### Teste 4: Validação de Senha Fraca
**Objetivo**: Rejeitar senha que não atende aos requisitos

**Passos**:
1. Acessar `http://localhost:3000/cadastro.html`
2. Tentar preencher com senhas fracas:
   - "123" (muito curta)
   - "abcdef" (sem número)
   - "123456" (sem maiúscula/minúscula)
3. Observar feedback em tempo real

**Resultado Esperado**:
- ✅ Validações aparecem em vermelho
- ✅ Botão "Cadastrar" não funciona com senha fraca

---

### Teste 5: Validação de Email Inválido
**Objetivo**: Rejeitar email com formato inválido

**Passos**:
1. Acessar `http://localhost:3000/cadastro.html`
2. Tentar preencher com emails inválidos:
   - "email_sem_arroba.com"
   - "email@sem.extensao"
   - "email@.com"
3. Observar feedback em tempo real

**Resultado Esperado**:
- ✅ Validação aparece em vermelho
- ✅ Mensagem: "E-mail inválido"

---

### Teste 6: Validação de CNPJ
**Objetivo**: Rejeitar CNPJ com menos de 14 dígitos

**Passos**:
1. Acessar `http://localhost:3000/cadastro.html`
2. Preencher CNPJ com menos de 14 dígitos
3. Clicar em "Cadastrar"

**Resultado Esperado**:
- ✅ Mensagem de erro: "CNPJ deve ter 14 dígitos"

---

## Testes de Login

### Teste 7: Login Válido
**Objetivo**: Verificar se login com credenciais corretas funciona

**Passos**:
1. Acessar `http://localhost:3000/login.html`
2. Preencher:
   - Email: "joao@example.com"
   - Senha: "Senha123"
3. Clicar em "Entrar"

**Resultado Esperado**:
- ✅ Mensagem de sucesso
- ✅ Redirecionamento para dashboard após 2 segundos
- ✅ Dados armazenados em `sessionStorage`

**Verificação no Navegador**:
```javascript
// Abrir Console (F12) e executar:
console.log(sessionStorage.getItem('EMAIL_USUARIO'));
console.log(sessionStorage.getItem('NOME_USUARIO'));
console.log(sessionStorage.getItem('RESTAURANTE_NOME'));
```

---

### Teste 8: Login com Email Inválido
**Objetivo**: Rejeitar login com email não cadastrado

**Passos**:
1. Acessar `http://localhost:3000/login.html`
2. Preencher:
   - Email: "nao_existe@example.com"
   - Senha: "qualquer_senha"
3. Clicar em "Entrar"

**Resultado Esperado**:
- ✅ Mensagem de erro: "Email e/ou senha inválido(s)"
- ✅ Usuário permanece na página de login

---

### Teste 9: Login com Senha Incorreta
**Objetivo**: Rejeitar login com senha errada

**Passos**:
1. Acessar `http://localhost:3000/login.html`
2. Preencher:
   - Email: "joao@example.com"
   - Senha: "SenhaErrada123"
3. Clicar em "Entrar"

**Resultado Esperado**:
- ✅ Mensagem de erro: "Email e/ou senha inválido(s)"
- ✅ Usuário permanece na página de login

---

### Teste 10: Login com Campos Vazios
**Objetivo**: Rejeitar login com campos não preenchidos

**Passos**:
1. Acessar `http://localhost:3000/login.html`
2. Deixar campos vazios
3. Clicar em "Entrar"

**Resultado Esperado**:
- ✅ Mensagem de erro: "Preencha todos os campos"

---

### Teste 11: Login com Enter
**Objetivo**: Permitir login pressionando Enter

**Passos**:
1. Acessar `http://localhost:3000/login.html`
2. Preencher email e senha
3. Pressionar Enter no campo de senha

**Resultado Esperado**:
- ✅ Login é executado (mesmo comportamento que clicar em "Entrar")

---

## Testes de Segurança

### Teste 12: Hash de Senha
**Objetivo**: Verificar se senhas são armazenadas com hash

**Passos**:
1. Executar cadastro com sucesso
2. Verificar banco de dados:
```sql
SELECT email, senha FROM Usuario WHERE email = 'joao@example.com';
```

**Resultado Esperado**:
- ✅ Senha começa com `$2a$` ou `$2b$` (hash bcrypt)
- ✅ Senha não é texto plano

---

### Teste 13: SessionStorage vs LocalStorage
**Objetivo**: Verificar que dados sensíveis não ficam em localStorage

**Passos**:
1. Fazer login com sucesso
2. Abrir Console (F12)
3. Executar:
```javascript
console.log(localStorage);
console.log(sessionStorage);
```

**Resultado Esperado**:
- ✅ Dados de usuário estão em `sessionStorage`
- ✅ Dados não estão em `localStorage`
- ✅ Dados são limpos ao fechar a aba

---

## Testes de Integração com Banco

### Teste 14: Verificar Relacionamento Usuario-Restaurante
**Objetivo**: Confirmar que usuário está corretamente vinculado ao restaurante

**Passos**:
1. Executar query:
```sql
SELECT u.idUsuario, u.nome, u.email, u.fkRestaurante, r.nome_fantasia
FROM Usuario u
JOIN Restaurante r ON u.fkRestaurante = r.idRestaurante
WHERE u.email = 'joao@example.com';
```

**Resultado Esperado**:
- ✅ Uma linha retornada
- ✅ `fkRestaurante` aponta para o restaurante correto
- ✅ `nome_fantasia` é "João's Pizza"

---

### Teste 15: Verificar Status do Restaurante
**Objetivo**: Confirmar que novo restaurante tem status 'Pendente'

**Passos**:
1. Executar query:
```sql
SELECT idRestaurante, nome_fantasia, status FROM Restaurante WHERE cnpj = '12345678901234';
```

**Resultado Esperado**:
- ✅ Status é 'Pendente'

---

## Testes de Performance

### Teste 16: Múltiplos Cadastros Simultâneos
**Objetivo**: Verificar se o sistema aguenta múltiplas requisições

**Passos**:
1. Abrir múltiplas abas do navegador
2. Tentar cadastrar usuários diferentes simultaneamente
3. Monitorar console para erros

**Resultado Esperado**:
- ✅ Todos os cadastros são bem-sucedidos
- ✅ Sem erros de conexão
- ✅ Sem duplicações

---

## Checklist Final

- [ ] Todos os testes de cadastro passaram
- [ ] Todos os testes de login passaram
- [ ] Todos os testes de segurança passaram
- [ ] Todos os testes de integração passaram
- [ ] Dados estão corretos no banco de dados
- [ ] SessionStorage funciona corretamente
- [ ] Não há erros no console
- [ ] Redirecionamentos funcionam
- [ ] Mensagens de erro são claras
- [ ] Validações funcionam em tempo real

---

## Troubleshooting

### Erro: "Cannot find module 'bcryptjs'"
```bash
npm install bcryptjs
```

### Erro: "Error: connect ECONNREFUSED"
- Verificar se MySQL está rodando
- Verificar credenciais em `.env`
- Verificar se banco de dados FMS foi criado

### Erro: "Email já cadastrado" mas email não existe
- Limpar cache do navegador
- Verificar se há dados duplicados no banco:
```sql
SELECT * FROM Usuario WHERE email = 'seu_email@example.com';
```

### Login não funciona com senha antiga
- Senhas antigas em texto plano ainda funcionam
- Ao fazer login, a senha é comparada com hash
- Se a senha for texto plano, ela será aceita

---

**Data**: 25 de maio de 2026  
**Versão**: 1.0
