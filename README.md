# Challenge Stock Nos Backend

Este repositório contém o backend do projeto Challenge Stock Nos. Para facilitar o desenvolvimento e a execução do projeto, utilizamos o `make` para automatizar tarefas comuns, como a instalação de dependências, execução de testes, construção de imagens Docker e gerenciamento de containers.

## Local Development Guide

To get started with local development, follow these steps:

### Prerequisites
Ensure that you have the following installed:
- [Docker](https://www.docker.com/)
- [Make](https://www.gnu.org/software/make/)
- [Python](https://www.python.org/downloads/) (for dependencies installation)

### Setup and Usage
1. **Install dependencies**  
   Run the following command to install all the necessary Python dependencies for the API backend:
   ```bash
   make install
   make test
   make build
   make run
   make stop

# API Documentation

## Overview
Esta API fornece endpoints para acessar informações sobre moedas disponíveis e obter informações de câmbio para moedas específicas. A autenticação é feita através de uma chave de API (`X-API-KEY`), que deve ser incluída nos cabeçalhos de cada requisição.

## Endpoints

### 1. **Health Check**
- **URL**: `/health`
- **Método**: `GET`
- **Descrição**: Verifica o status da API.
- **Resposta de Sucesso**:
  - Código: `200 OK`
  - Corpo:
    ```json
    {
      "status": "ok"
    }
    ```

### 2. **Obter Moedas Disponíveis**
- **URL**: `/price/available`
- **Método**: `GET`
- **Descrição**: Retorna uma lista de moedas disponíveis.
- **Cabeçalhos Requeridos**:
  - `X-API-KEY`: A chave da API para autenticação.
- **Resposta de Sucesso**:
  - Código: `200 OK`
  - Corpo:
    ```json
    {
      "USD": "Dollar",
      "EUR": "Euro"
    }
    ```
- **Resposta de Erro**:
  - Código: `401 Unauthorized`
  - Corpo:
    ```json
    {
      "error": "Unauthorized"
    }
    ```

### 3. **Obter Status de Câmbio de Moeda**
- **URL**: `/price/stats/<currency>`
- **Método**: `GET`
- **Parâmetros**:
  - `<currency>`: O código da moeda para consultar o status de câmbio (por exemplo, `USD` para dólar).
- **Cabeçalhos Requeridos**:
  - `X-API-KEY`: A chave da API para autenticação.
- **Resposta de Sucesso**:
  - Código: `200 OK`
  - Corpo:
    ```json
    {
      "USDBRL": {
        "bid": "5.50"
      }
    }
    ```
- **Resposta de Erro**:
  - Código: `401 Unauthorized`
  - Corpo:
    ```json
    {
      "error": "Unauthorized"
    }
    ```
  - Código: `500 Internal Server Error`
  - Corpo:
    ```json
    {
      "error": "Failed to fetch data"
    }
    ```

---

## Autenticação
A autenticação na API é feita através do cabeçalho `X-API-KEY`, onde o valor deve ser a chave de API que você recebeu ao configurar o ambiente. A chave é necessária para acessar todos os endpoints, exceto o endpoint `/health`.

### Exemplo de Requisição:
```bash
curl -X GET "http://<host>:8080/price/available" -H "X-API-KEY: your_api_key"

## Local annotations
pip install flask
python3 main.py

