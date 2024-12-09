📊 Workflow de Análise com FastQC, MultiQC e FastP
Este projeto consiste num pipeline de pré-processamento e análise de dados genómicos, utilizando as ferramentas FastQC, MultiQC e FastP. O pipeline foi estruturado em três etapas principais, ou seja, 3 scripts:
- O script 1 cria as diretorias necessárias.
- O script 2 realiza as análises de FastQC, MultiQC e FastP:
  1. Pré-processamento com FastQC e MultiQC
  2. Análise com FastP
  3. Análise pós-processamento com FastQC e MultiQC
- O script 3 permite a visualização dos outputs gerados pelos processos, como ficheiros html em firefox e ficheiros txt.
Os scripts estão associados uns aos outros, isto é correndo o script 2, o script 1 corre automaticamente e correndo o script 3 o script 2 e 1 correm também automaticamente, pelo que para visualizar de uma vez todos apenas é necessário correr o script 3!

🚀 Objetivo do pipeline  
O objetivo principal deste pipeline é realizar análises rápidas em dados genómicos, avaliar a qualidade dos dados com FastQC e MultiQc, realizar a análise com FastP e, por fim, consolidar os resultados utilizando, novamente, o FastQC e MultiQC.

🏆 Ferramentas Utilizadas  
FastQC: Avaliação de qualidade de dados sequenciais.
FastP: Pré-processamento dos dados FASTQ.
MultiQC: Consolidação dos relatórios gerados pelo FastQC e FastP.
Conda: Gerenciamento do ambiente Python com dependências específicas.

📂 Estrutura do Código  
🖥️ script1.sh  
Configuração do ambiente inicial e definição das variáveis essenciais.
Preparação dos diretórios necessários.
Configuração da estrutura de logs.  
🖥️ script2.sh  
Realiza o processamento principal:
Execução do FastQC nos dados de entrada.
Execução do MultiQC antes da execução do FastP.
Execução do FastP para limpeza de dados FASTQ.
Execução do FastQC após a execução do FastP.
Execução do MultiQC para consolidar relatórios finais.
Armazenamento em logs com o andamento das análises.  
🖥️ script3.sh  
Interface interativa para visualizar relatórios:
1. Relatórios pré-fastP.
2. Relatórios após execução do FastP.
3. Relatórios finais pós-análise.
4. Relatório de log.

🛠️ Pré-requisitos  
Antes de executar os scripts, certifique-se de que as ferramentas necessárias estão instaladas:
- Conda instalado com o ambiente necessário que permita correr FastQC, FastP e MultiQC
- Firefox instalado

