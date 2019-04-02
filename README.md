# NFeALData
Codes for accessing API for Alagoas State (Nota Fiscal Eletronica *Cidadã*). There are the following functions:

- *consulta_descr* -- Funcao para Obter os precos de mercadoria por descricao
- *consulta_min_preco* -- Consulta o menor preco em um determinado estabelecimento por codigo de barras
- *consulta_barcode* -- Consulta o menor preco por codigo de barras
- *consulta_descr_area* -- Funaco para Obter os precos de mercadoria por descricao e por area

Para usar no R, é só usar o pacote `devtools`, e o comando `install_github` da seguinte forma:

- `devtools::install_github("claudiolucinda/NFeALData")`
