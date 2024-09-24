# Marvel Characters App

Este é um aplicativo desenvolvido em Flutter que consome a API da Marvel para listar e exibir detalhes dos personagens. O aplicativo foi criado como parte de um desafio técnico, seguindo boas práticas de desenvolvimento como Clean Architecture, gerenciamento de estado, testes automatizados e controle de versionamento.

# Funcionalidades

	•	Listagem de personagens da Marvel.
	•	Filtro por nome de personagem.
	•	Exibição de detalhes completos de cada personagem.
	•	Histórico de personagens clicados recentemente.
	•	Testes unitários e de widget para garantir a qualidade do código.

# Tecnologias Utilizadas

	•	Flutter: Framework para desenvolvimento do aplicativo mobile.
	•	Dart: Linguagem de programação utilizada no Flutter.
	•	Provider: Utilizado para gerenciamento de estado.
	•	Dio: Cliente HTTP para realizar requisições à API da Marvel.
	•	Shared Preferences: Para persistência de dados locais (histórico de cliques).
	•	Flutter Secure Storage: Armazenamento seguro para esconder chaves sensíveis.
	•	Dotenv: Para gerenciamento de variáveis de ambiente, como chaves de API.
	•	Mocktail: Biblioteca de mock para testes.
	•	Flutter Test: Framework para testes unitários e de widget.

# Estrutura do Projeto
![Captura de Tela 2024-09-24 às 16 06 55](https://github.com/user-attachments/assets/3919763b-64ec-4f44-b2da-7a3747fcce72)


# Organização por Módulos

	•	Data: Requisições à API, armazenamento de dados.
	•	Domain: Casos de uso e entidades.
	•	Presentation: Páginas e widgets exibidos na interface do usuário.

# Boas Práticas Utilizadas

	•	Clean Architecture: Organização do código em camadas independentes (Data, Domain e Presentation).
	•	Baixo Acoplamento: As dependências são injetadas via construtores, facilitando a testabilidade.
	•	Componentização: Componentes reutilizáveis como CustomAppBar e CharacterCardWidget garantem uma interface consistente.
	•	Versionamento: Git utilizado para versionamento de código e histórico de alterações.
	•	Testes Automatizados: Testes unitários e de widgets foram criados para validar o funcionamento correto do aplicativo.

# Gerenciamento de Chaves

As chaves da API Marvel utilizadas no projeto são apenas para fins de teste e já foram revogadas. Para rodar o projeto, gere novas chaves e insira-as no arquivo .env.

# Como Gerar Novas Chaves na Marvel

	1.	Acesse o Marvel Developer Portal.
	2.	Crie uma conta e gere suas chaves pública e privada.
	3.	Calcule o hash necessário para autenticação seguindo as instruções da documentação oficial.



Esse README.md oferece uma visão clara sobre o projeto, suas funcionalidades, as tecnologias utilizadas, como rodar o aplicativo, e boas práticas de segurança, como a proteção das chaves de API.


## Screenshots

### Tela Inicial
![1](https://github.com/user-attachments/assets/4fabb57f-27a8-437f-9625-636d474d56c8)


### Detalhes do Personagem
![2](https://github.com/user-attachments/assets/a73c654c-960f-4194-858a-04dd3ab57a4d)







