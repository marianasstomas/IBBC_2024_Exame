📊 Workflow de Análise com FastQC, MultiQC e FastP  
Este projeto consiste num pipeline de pré-processamento e análise de dados genómicos, utilizando as ferramentas FastQC, MultiQC e FastP. O pipeline foi estruturado em três etapas principais, ou seja, 3 scripts:  
- O script 1 cria as diretorias necessárias.
- O script 2 realiza as análises de FastQC, MultiQC e FastP:
  1. Pré-processamento com FastQC e MultiQC
  2. Análise com FastP
  3. Análise pós-processamento com FastQC e MultiQC
- O script 3 permite a verificação da existência dos comandos necessários ao script 2, permitindo escolher o ambiente conda onde estes poderão estar e apresenta também a opção de executar o script 2.  

Os scripts estão associados uns aos outros, isto é executando o script 2, o script 1 é executado automaticamente e executando o script 3, existe uma opção que permite executar o script 2.

🚀 Objetivo do pipeline  
O objetivo principal deste pipeline é realizar análises rápidas em dados genómicos, avaliar a qualidade dos dados com FastQC e MultiQc, realizar a análise com FastP e, por fim, consolidar os resultados utilizando, novamente, o FastQC e MultiQC.

🏆 Ferramentas Utilizadas  
- FastQC: Avaliação de qualidade dos ficheiros "gz";
- MultiQC: Avaliação comparativa dos ficheiros "fastqc";
- FastP: Processamento dos ficheiros "gz";
- Conda: Gerenciamento do ambiente Python com dependências específicas.

📂 Estrutura do Código  
🖥️ script1.sh  
Configuração do ambiente inicial e definição das variáveis essenciais.
Preparação das diretórias necessários.
Configuração da estrutura de logs.  
🖥️ script2.sh  
Realiza o processamento principal:
- Execução do FastQC nos dados de entrada.
- Execução do MultiQC antes da execução do FastP.
- Execução do FastP para limpeza dos dados.
- Execução do FastQC após a execução do FastP.
- Execução do MultiQC após a execução do FastP.
Armazenamento em logs com o andamento das análises.  
🖥️ script3.sh  
Interface interativa para verificar a existência dos comandos num determinado ambiente conda.
Possibilidade para escolher executar o script 2.

❗️ Atenção  
Caso enfrente problemas ao executar os scripts, tenha em atenção os seguintes esquecimentos:
- Alterar os paths para os paths da sua área
- Instalar ambiente conda, contendo os comandos necessários à sua execução
- Ter atenção ao nome do samples e à estrutura da "tabela" que esta representa
