# Robot Framework - ServeRest API Tests

## Pré-requisitos

- Python 3.8+
- Node.js 14+
- Robot Framework
- Browser Library

## Instalação

1. Instale as dependências do Robot Framework:
```bash
pip install robotframework
pip install robotframework-browser
rfbrowser init
```

## Executando a API ServeRest

Para rodar a API localmente na porta 3000:
```bash
npx serverest@latest
```

A API estará disponível em: http://localhost:3000

## Executando os Testes

Com a API rodando, execute os testes:
```bash
robot tests/tasks/
```

## Estrutura do Projeto

```
├── resources/
│   ├── base.resource          # Configurações base
│   ├── online.robot           # Testes de conectividade
│   └── env.robot              # Variáveis de ambiente
└── tests/
    └── tasks/
        └── api_tests.robot    # Casos de teste
```