# Teste Técnico Mobile BeTalent

Este projeto é uma solução para o [Teste Prático Mobile BeTalent](https://github.com/BeMobile/desafio-mobile), que consiste em construir uma visualização de dados provenientes de uma API simulada. A aplicação foi desenvolvida utilizando Flutter, seguindo o mockup disponibilizado no Figma para garantir fidelidade ao design e aos requisitos fornecidos.

## API simulada

Para acessar os dados que alimentarão o projeto, siga os passos abaixo para iniciar a API simulada. Após clonar este repositório em sua máquina, execute os seguintes comandos para configurar e rodar a API:

```bash
cd ~/my_rest_server/
```

Instale o pacote `json_rest_server`:

```bash
dart pub global activate json_rest_server
```

Inicie o servidor da API simulada:

```bash
json_rest_server run
```

Deixe o servidor rodando em segundo plano enquanto prossegue com a execução do aplicativo.

## Executando o aplicativo

Com a API rodando em segundo plano, abra um novo terminal e siga os passos abaixo para rodar o aplicativo Flutter:

Navegue até o diretório do projeto:

```bash
cd ~/betalent_challenge/
```

Como o aplicativo foi desenvolvido para funcionar tanto no Android quanto no iOS, utilize o comando abaixo para listar os emuladores disponíveis:

```bash
flutter emulators
```

Após identificar o emulador desejado, inicie o dispositivo virtual com o comando:

```bash
flutter emulators --launch 'Nome do emulador'
```

Com o emulador iniciado, compile e execute o aplicativo com:

```bash
flutter run
```

## Aplicativo em funcionamento

<div style="text-align: center">
   <table>
      <tr>
         <td style="text-align: center">
            <img src="https://github.com/geanjrii/betalent_challenge/blob/main/images/test1.gif" width="200"/>
         </td>
         <td style="text-align: center">
            <img src="https://github.com/geanjrii/betalent_challenge/blob/main/images/test2.gif" width="200"/>
         </td>
      </tr>
   </table>
</div>
