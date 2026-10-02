# Поэтапное воспроизведение лабораторной работы №3

Все команды ниже вводятся в обычном терминале Bash, если явно не указано,
что команда предназначена для Julia REPL. Строки, начинающиеся с `$`, `julia>`
или `pkg>`, вводятся без этих приглашений.

## 1. Переход в каталог лабораторной

```bash
cd /home/asvedjmina/university/static_analys/labs/lab03
```

Для снимка экрана можно проверить исходное состояние:

```bash
pwd
ls -la
```

## 2. Создание проекта DrWatson

Сценарий должен запускаться до появления каталога `project`:

```bash
julia setup_project.jl
```

Он вызывает `DrWatson.initialize_project`, создаёт новый проект и печатает
только подтверждение создания. Команда для проверки структуры:

```bash
find project -maxdepth 2 -type d | sort
```

## 3. Установка и фиксация зависимостей

```bash
julia --project=project project/add_packages.jl
```

Проверка окружения:

```bash
julia --project=project -e 'using Pkg; Pkg.status()'
```

## 4. Активация проекта в Julia REPL

Из каталога `lab03` запустить Julia:

```bash
julia --project=project
```

Затем в Julia REPL выполнить:

```julia
using DrWatson
projectdir()
srcdir()
scriptsdir()
datadir()
using Lab03ControlStructures
```

Для выхода из Julia REPL:

```julia
exit()
```

Важно: команды вида `julia --project=...` и `cd project` являются командами
Bash. Их нельзя вводить после приглашения `julia>`.

## 5. Запуск примеров и всех заданий

```bash
julia --project=project project/scripts/run_lab03.jl
```

## 6. Запуск заданий по отдельности

Номер задания передаётся последним аргументом:

```bash
julia --project=project project/scripts/run_task.jl 1
julia --project=project project/scripts/run_task.jl 2
julia --project=project project/scripts/run_task.jl 3
julia --project=project project/scripts/run_task.jl 4
julia --project=project project/scripts/run_task.jl 5
julia --project=project project/scripts/run_task.jl 6
julia --project=project project/scripts/run_task.jl 7
julia --project=project project/scripts/run_task.jl 8
julia --project=project project/scripts/run_task.jl 9
julia --project=project project/scripts/run_task.jl 10
julia --project=project project/scripts/run_task.jl 11
```

## 7. Генерация Julia-, notebook- и Quarto-материалов

```bash
julia --project=project project/scripts/generate_outputs.jl
```

Проверка полученных файлов:

```bash
find project/generated -maxdepth 1 -type f -printf '%f\n' | sort
```

Должны появиться:

- `lab03_code.jl`;
- `lab03_control_structures.ipynb`;
- `lab03_quarto.qmd`;
- `lab03_quarto.html`.

## 8. Запуск выполненного Julia-кода

```bash
julia --project=project project/generated/lab03_code.jl
```

## 9. Автоматические тесты

```bash
julia --project=project project/scripts/test_setup.jl
```

Или стандартной командой менеджера пакетов:

```bash
julia --project=project -e 'using Pkg; Pkg.test()'
```

## 10. Запуск Jupyter Lab

```bash
julia --project=project -e 'using IJulia; IJulia.jupyterlab(dir="project/generated")'
```

В открывшемся Jupyter Lab выбрать
`lab03_control_structures.ipynb`, затем выполнить `Run` → `Run All Cells`.
Сервер останавливается в терминале сочетанием `Ctrl+C`.

## 11. Рендеринг literate-документа напрямую через Quarto

```bash
quarto render project/generated/lab03_quarto.qmd --to html
```

## 12. Сборка отчёта

```bash
quarto render report --to pdf
quarto render report --to docx
```

Результаты:

```bash
ls -lh report/_output/computer-practice-lab03-report.pdf
ls -lh report/_output/computer-practice-lab03-report.docx
```

## 13. Сборка презентации

```bash
quarto render presentation --to beamer
quarto render presentation --to revealjs
```

Результаты:

```bash
ls -lh presentation/_output/computer-practice-lab03-presentation.pdf
ls -lh presentation/_output/computer-practice-lab03-presentation.html
```

## 14. Итоговая проверка

```bash
julia --project=project project/scripts/test_setup.jl
pdfinfo report/_output/computer-practice-lab03-report.pdf | grep '^Pages'
pdfinfo presentation/_output/computer-practice-lab03-presentation.pdf | grep '^Pages'
```

