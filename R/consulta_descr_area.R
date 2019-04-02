#' Funcao para obter os precos por descricao em uma area
#'
#' @param apikey - Chave do API, obtida mediante pedido a api [at] sefaz.al.gov.br
#' @param query - String com a query
#' @param .lattice - Matrix (2 X N) com a coordenada de N pontos cujos circulos cubram a area interessada. Longitude na coluna 1 e latitude na coluna 2
#' @param .dias - Numero de dias. Caso não fornecido, e apenas um dia
#' @param .raio - Raio do circulo. Default eh 15 kms
#'
#' @return - Retorna um dataframe com os seguintes objetos:
#' codGetin	String -- Codigo do produto.
#' dscProduto	String	-- Descricao do produto.
#' dthEmissaoUltimaVenda	String -- Data de Ultima venda do produto.
#' valUnitarioUltimaVenda	Double -- Valor unitário da Ultima venda.
#' valUltimaVenda	Double	-- Valor da Ultima venda.
#' valMinimoVendido	Double	-- Valor minimo vendido no periodo pesquisado.
#' valMaximoVendido	Double	-- Valor maximo vendido no periodo pesquisado.
#' txtDataUltimaEmissao	String	-- Calculo do tempo da Data da ultima emissao do produto.
#' numCNPJ	String	-- Numero Cadastro Nacional da pessoa juridica.
#' nomRazaoSocial	String	-- Nome da razao social do contribuinte.
#' nomFantasia	String	-- Nome fantasia do contribuinte.
#' numTelefone	String	-- Numero de telefone do contribuinte.
#' nomLogradouro	String	-- Nome do logradouro do estabelecimento.
#' numImovel	String	-- Numero do estabelecimento.
#' nomBairro	String	-- Nome do bairro do estabelecimento.
#' numCep	String	-- CEP.
#' nomMunicipio	String -- Municipio.
#' numLatitude	Double	-- Latitude do estabelecimento.
#' numLongitude	Double	-- Longitude do estabelecimento.
#' codNcm	Long	-- Codigo NCM do produto.
#' @export
#'
#' @examples
consulta_descr_area <- function(apikey,query,.lattice,.dias=1,.raio=15) {
  datalist<-list()

  for (i in 1:nrow(.lattice)) {
    lat<-.lattice[i,2]
    lon<-.lattice[i,1]
    teste<-consulta_descr(apikey=apikey,query=query,.dias=.dias,.latitude = lat,.longitude = lon, .raio=.raio)
    if ((teste=="") || (length(teste)==0)) {
      next
    }
    else {
      # Checar se tem a coluna ncm -- se tiver, apaga
      if ("ncm" %in% colnames(teste$results)) {
        teste$ncm<-NULL
      }
      # Caso contrário, append no resto, usando data.table
      else {
        datalist[[i]]<-teste
      }
    }

  }

  big_data = do.call(rbind, datalist)
  big_data_final<-dplyr::distinct(big_data)

  return(big_data_final)
  }

