#' Consulta o menor preco em um determinado estabelecimento por codigo de barras
#'
#' @param apikey - Chave do API, obtida mediante pedido a api [at] sefaz.al.gov.br
#' @param .cnpj - String	-- Numero Cadastro Nacional da pessoa juridica.
#' @param .codigoBarras - String com o codigo de barras
#' @param .quantidadeDeDias - Numero de dias. Default (caso missing)=3
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
#'
#' @export
#'
#' @examples
#' consulta_min_preco(apikey=key,.cnpj="08618647000355",.codigoBarras =  "7898286201968",.quantidadeDeDias = 1)

consulta_min_preco <- function(apikey,.cnpj,.codigoBarras,.quantidadeDeDias=3) {
  content<-rjson::toJSON(list(cnpj=.cnpj, codigoBarras=.codigoBarras, quantidadeDeDias=.quantidadeDeDias))
  abc<-POST(url="http://api.sefaz.al.gov.br/sfz_nfce_api/api/public/consultarPrecoProdutoEmEstabelecimento", body=content, add_headers(.headers= c("Content-Type"="application/json","AppToken"=apikey)))
  output<-content(abc, as="text",encoding = "latin1")
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
    message_for_status(status, task = "Query Nao Bem-Sucedida: Checar Inputs")
    out02<-status
  }
  return(out02)
}
