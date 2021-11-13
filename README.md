# Sonoff Quarto tecla morta

Este projeto permite com que eu acenda e apague a luz do quarto a parti da tecla morta do  teclado.

## Instalando

instala o ambiente virtual

```bash
python -m pip install --user virtualenv
```

```bash
python -m venv env
```

```bash
.\env\Scripts\activate
```

instalar pyinstaller

```bash
pip install PyInstaller
```

compilar o programa

```bash
pyinstaller -i ./light.ico -F -w  main.py
```

## Autor

[Felipe Mateus](https://felipemateus.com)
