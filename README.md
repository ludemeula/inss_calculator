# 📊 INSS Calculator

Projeto Ruby on Rails para cálculo de INSS com autenticação JWT, fila de jobs com Sidekiq e frontend gerenciado via Webpacker.

---

## 🚀 Tecnologias

- **Rails 8**
- **PostgreSQL**
- **Webpacker**
- **JWT (autenticação)**
- **Sidekiq + Sidekiq-Cron**
- **Kaminari (paginação)**
- **Rspec (testes)**
- **Byebug (debug)**

---

## 🧪 Testes

```bash
bundle exec rspec
```

---

## 🛠️ Desenvolvimento

### Instalação

```bash
bundle install
yarn install
```

### Banco de dados

```bash
rails db:create
rails db:migrate
```

---

## ▶️ Execução

```bash
bin/rails server
```

ou com Sidekiq:

```bash
bundle exec sidekiq
```

---

## 💅 Formatação de código

Este projeto utiliza o [Prettier](https://prettier.io/) com suporte opcional a `.erb`.

### Formatar todos os arquivos:

```bash
npm run format
```

> Para incluir arquivos `.erb`, instale também:  
> `npm install --save-dev prettier-plugin-erb @prettier/plugin-ruby`

---

## ♻️ Lint

```bash
bundle exec rubocop
```

---

## 📂 Estrutura do Projeto

- `app/controllers` – Lógica da aplicação
- `app/views` – Templates HTML/ERB
- `app/jobs` – Jobs assíncronos com Sidekiq
- `config/initializers` – Configurações customizadas
- `public/` – Arquivos estáticos
- `spec/` – Testes automatizados com RSpec

---

## 📝 Licença

MIT © [Lude]
