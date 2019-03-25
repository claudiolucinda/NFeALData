#' Title
#'
#' @param apikey - Chave do API, obtida mediante pedido a api [at] sefaz.al.gov.br
#' @param barCode - String com o codigo de barras
#' @param .dias - Numero de dias. Caso não fornecido, e apenas um dia
#' @param .latitude - Latitude do centro do circulo onde a query vai investigar (formato Lat-Lon, nao eh UTM nem outros formatos). Existe um default, mas nao eh relevante.
#' @param .longitude - Lognitude do centro do circulo onde a query vai investigar (formato Lat-Lon, nao eh UTM nem outros formatos). Existe um default, mas nao eh relevante.
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
#' consulta_barcode(apikey=key,barCode="07894900010015")
#'
consulta_barcode <- function(apikey,barCode,.dias=1,.latitude=-9.6432331,.longitude=-35.7190686,.raio=15) {
  content<-rjson::toJSON(list(codigoDeBarras=barCode, dias=.dias, latitude=.latitude, longitude=.longitude, raio=.raio))
  abc<-POST(url="http://api.sefaz.al.gov.br/sfz_nfce_api/api/public/consultarPrecosPorCodigoDeBarras", body=content, add_headers(.headers= c("Content-Type"="application/json","AppToken"=apikey)))
  status<-abc$status_code
  if (status==200) {
    output<-content(abc, as="text")
    if (!(output=="")) {
      out02<-jsonlite::fromJSON(output)
    }
    else {
      out02<-""
    }
  }
  else {
    message_for_status(status, task = "Query Não Bem-Sucedida: Checar Código")
    out02<-status
  }
  return(out02)
}
