# Mini Cadastro de Tarefas (Flutter)

## 1. Descrição do Projeto

Este projeto consiste em um **mini sistema de cadastro de tarefas** desenvolvido em **Flutter** utilizando **SQLite** como banco de dados local. Para os campos personalizados e customizações, utilizamos o do Guilherme Fabretti, ou seja:

* Campo personalizado: `indiceRelevancia`
* Banco de dados com o RA: `tarefas_202310286.db`
* Tema personalizado: `lightGreen e greenAccent`

---

## 2. Dados dos Alunos

* **Nome:** Guilherme Defavori Fabretti
* **RA:** 202310286

* **Nome:** Leonardo Martins
* **RA:** 202310239

---

## 3. Dificuldades encontradas

* Inicialmente o banco não era encontrado no Flutter Web e tive que utilizar emulador do Android Studio
* Acesso ao `.db` no emulador Android exigiu comandos `adb root` e `adb pull`.

---

## 4. Como acessar o banco de dados SQLite do app

### Passo a passo usando ADB (Android Emulator)

1. **Listar dispositivos/emuladores disponíveis**

```bash
adb devices
```

2. **Dar root no emulador**

```bash
adb -s <nome_dispositivo> root
```

3. **Acessar o shell do emulador**

```bash
adb -s <nome_dispositivo> shell
```

4. **Navegar até a pasta do app**

```bash
cd /data/data/<package_name>/app_flutter
```

Exemplo:

```bash
cd /data/data/com.example.p2_flutter_app/app_flutter
```

5. **Listar arquivos na pasta**

```bash
ls
```

* Procure pelo arquivo `.db`, ex.: `tarefas_202310286.db`.

6. **Sair do shell**

```bash
exit
```

7. **Exportar (pull) o banco para o PC**

```bash
adb -s <nome_dispositivo> pull /data/data/<package_name>/app_flutter/<nome_arquivo>.db .
```

Exemplo:

```bash
adb -s emulator-5554 pull /data/data/com.example.p2_flutter_app/app_flutter/tarefas_202310286.db .
```

8. **Abrir no DB Browser**

* Usar o **DB Browser for SQLite** ou plugin VS Code para visualizar os dados.

---

## 5. Vídeo do App

video aqui

---

## 6. Prints obrigatórios

prints aqui

