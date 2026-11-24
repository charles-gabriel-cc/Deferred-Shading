<div align="center">
  <img src="https://capsule-render.vercel.app/api?type=waving&color=0:111827,50:374151,100:6366f1&height=170&section=header&text=Deferred%20Shading&fontSize=44&fontColor=ffffff&animation=fadeIn&fontAlignY=40&desc=Ilumina%C3%A7%C3%A3o%20Interativa%20com%20Mapas%20Difuso%2C%20Normal%20e%20Especular%20em%20Processing&descAlignY=65&descSize=14" width="100%" alt="Banner" />
</div>

<p align="center">
  <img src="https://img.shields.io/badge/Processing-3-006699?style=for-the-badge&logo=processingfoundation&logoColor=white" alt="Processing 3" />
  <img src="https://img.shields.io/badge/Computa%C3%A7%C3%A3o%20Gr%C3%A1fica-Deferred%20Shading-6366F1?style=for-the-badge" alt="Computação Gráfica" />
</p>

---

## 📖 Sobre o Projeto

Implementação interativa da técnica de **Deferred Shading** em **Processing 3**, combinando mapas de textura **difuso** (`_d`), **normal** (`_n`) e **especular** (`_s`) para calcular iluminação dinâmica em tempo real sobre personagens 2D/2.5D.

---

## 📋 Pré-requisitos

- **Processing 3** instalado
- Biblioteca **UiBooster** na versão **1.2.0** (instalada pelo gerenciador de bibliotecas do Processing):

<p align="center">
  <img src="content/uibooster.jpg" alt="Instalação da biblioteca UiBooster 1.2.0" width="60%" />
</p>

---

## ⌨️ Controles e Instruções de Uso

Abra e execute `sketch/sketch.pde` no Processing 3:

| Tecla | Ação |
| :---: | :--- |
| `i` | Alternar entre os modelos/imagens (`char1` / `char2`) |
| `s` | Alternar visualização do componente **especular** |
| `d` | Alternar visualização do componente **difuso** |
| `a` | Visualizar a **composição completa** (difuso + especular) |
| `c` | Abrir o **Color Picker** (UiBooster) para alterar a cor da luz |

---

## 📂 Estrutura

```text
Deferred-Shading/
├── content/
│   └── uibooster.jpg
└── sketch/
    ├── sketch.pde
    ├── char1_{d,n,s}.png
    └── char2_{d,n,s}.png
```

---

## 👥 Autores

- **Grupo:** `cgcc` (Charles Gabriel), `nbmcd`
