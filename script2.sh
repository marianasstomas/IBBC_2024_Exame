#!/bin/bash

# Diretorias definidas
source /home/fc60421/script_exame/script1.sh

# Explicação do workflow
echo "O workflow vai ser o seguinte: "
echo ""
echo "1º FastQC e MultiQC pré-processamento"
echo ""
echo "2º FastP"
echo ""
echo "3º FastQC e MultiQC prós-processamento"
echo ""

# Ativação do ambiente conda necessário
source /home/fc60421/miniconda3/etc/profile.d/conda.sh
conda activate tools_qc

# Iniciar e colocar data no log_file
echo "Processo iniciado a: $(date +'%d/%m/%Y %H:%M:%S')" &>> "$log_file"

# Pré FastQC e MultiQC
samples="/home/fc60421/script_exame/$dir_name/raw_data/samples.txt"
sed -i 's/\r//g' "$samples"

while IFS=$'\t' read -r amostra tratamento ficheiro; do

   # Caminho para os diferentes ficheiros
   ficheiro_path="$raw_data/${ficheiro}"

   # Executar FastQC
   if [[ -f "$ficheiro_path" ]]; then
        echo "A executar FastQC no seguinte ficheiro: $ficheiro_path" | tee -a "$log_file"
        fastqc "$ficheiro_path" -o /home/fc60421/script_exame/$dir_name/output_data/pre_fastp | tee -a "$log_file"
        echo "" | tee -a "$log_file"
   else
        echo "O seguinte ficheiro não foi encontrado: $ficheiro_path" | tee -a "$log_file"
        echo "" | tee -a "$log_file"
   fi
done < "$samples"

# Executar multiqc
if compgen -G "$pre_fastp/*.zip" > /dev/null; then
   echo "A executar o MultiQC em todos os ficheiros FastQC" | tee -a "$log_file"
   multiqc /home/fc60421/script_exame/$dir_name/output_data/pre_fastp/*.zip \
           -o /home/fc60421/script_exame/$dir_name/output_data/pre_fastp | tee -a "$log_file"
   echo "" | tee -a "$log_file"
else
   echo "Não existem ficheiros fastqc para analisar!" | tee -a "$log_file"
fi

echo "Análise de ficheiros pré-processamento completa!" | tee -a "$log_file"
echo "" | tee -a "$log_file"

# Executar FastP
echo "A executar análise com FastP..."
while IFS=$'\t' read -r amostra tratamento ficheiro; do
   ficheiro_path="$raw_data/${ficheiro}"

   if [[ -f "$ficheiro_path" ]]; then
        # Verificar se é single-end ou paired-end
        paired_file="${ficheiro/_1/_2}"
        if [[ "$ficheiro" =~ _1 ]]; then
            echo "Amostra $ficheiro: Detetado modo paired-end" | tee -a "$log_file"
            fastp -i "$ficheiro_path" \
                  -I "$raw_data/$paired_file" \
                  -o "$fastp_output/${ficheiro/.fastq.gz/_cleaned_1.fastq.gz}" \
                  -O "$fastp_output/${paired_file/.fastq.gz/_cleaned_2.fastq.gz}" \
                  --cut_front --cut_tail -g -p -q 20 \
                  -j "$fastp_output/${ficheiro/.fastq.gz/_report.json}" &>> "$log_file" \
                  -h "$fastp_output/${ficheiro/.fastq.gz/_report.html}"
           echo "" &>> "$log_file"
        elif [[ "$ficheiro" =~ _2 ]]; then
            # Ignorar ficheiros que contêm '_2' no nome
            echo "Amostra $ficheiro ignorada porque já será processada em paired-end com o ficheiro par." | tee -a "$log_file"
            echo "" | tee -a "$log_file"
        else
            echo "Amostra $ficheiro: Detetado modo single-end" | tee -a "$log_file"
            fastp -i "$ficheiro_path" \
                  -o "$fastp_output/${ficheiro/.fastq.gz/_cleaned.fastq.gz}" \
                  --cut_front --cut_tail -g -p -q 20 \
                  -j "$fastp_output/${ficheiro/.fastq.gz/_report.json}" &>> "$log_file" \
                  -h "$fastp_output/${ficheiro/.fastq.gz/_report.html}"
            echo "" | tee -a "$log_file"
        fi
   else
        echo "Ficheiro $ficheiro_path não encontrado para análise com FastP!" | tee -a "$log_file"
        echo "" | tee -a "$log_file"
   fi
done < "$samples"

echo "Análise de FastP concluída!" | tee -a "$log_file"
echo "" | tee -a "$log_file"

# Executar FastQC após FastP
   if compgen -G "$fastp_output/*.gz" > /dev/null; then
        echo "A executar FastQC em todos os ficheiros gz..." | tee -a "$log_file"
        fastqc "$fastp_output"/*.gz -o /home/fc60421/script_exame/$dir_name/output_data/pos_fastp | tee -a "$log_file"
        echo "" | tee -a "$log_file"
   else
        echo "O seguinte ficheiro não foi encontrado: $ficheiro_path" | tee -a "$log_file"
        echo "" | tee -a "$log_file"
   fi

# Executar MultiQC após FastP
   if compgen -G "$pos_fastp/*.zip" > /dev/null; then
        echo "A executar o MultiQC pós-FastP em todos os ficheiros FastQC" | tee -a "$log_file"
        multiqc /home/fc60421/script_exame/$dir_name/output_data/pos_fastp/*.zip \
                -o /home/fc60421/script_exame/$dir_name/output_data/pos_fastp | tee -a "$log_file"
       echo "" | tee -a "$log_file"
   else
        echo "Não existem ficheiros fastqc para analisar!" | tee -a "$log_file"
        echo "" | tee -a "$log_file"
   fi

echo "Análise de ficheiros completa!" | tee -a "$log_file"
echo "" | tee -a "$log_file"
