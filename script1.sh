#!/bin/bash

# Verificar se o nome está vazio ou contém espaços ou já existe com o mesmo nome
while true; do
# Pedir ao utilizador o nome da diretoria principal
    read -p "Insira o nome que quer dar à diretoria principal: " dir_name
        if [[ "$dir_name" =~ \  ]]; then
         echo "Erro: O nome não pode conter espaços. Tente novamente."
        elif [[ -z "$dir_name" ]]; then
         echo "Erro: O nome não pode estar vazio. Tente novamente."
        elif [[ -d "$dir_name" ]]; then
         echo "Erro: Já existe uma diretoria com esse nome. Tente novamente."
 else
        break
fi
done
echo ""

# Definir o caminho completo da diretoria
dir_principal="$HOME/script_exame/$dir_name"

# Definir nome das subdiretorias necessárias
raw_data="$dir_principal/raw_data"
output_data="$dir_principal/output_data"
log_dir="$dir_principal/logs"
log_file="$log_dir/logs.txt"
pre_fastp="$output_data/pre_fastp"
fastp_output="$output_data/fastp_output"
pos_fastp="$output_data/pos_fastp"

# Criar subdiretorias
echo "A criar subdiretorias em $dir_principal ..."
mkdir -p "$raw_data" "$output_data" "$log_dir"
echo ""

# Criar subdiretorias na diretoria output_data
mkdir -p "$pre_fastp" "$fastp_output" "$pos_fastp"

# Mostra a estrutura das diretorias
echo "Estrutura criada:"
find "$dir_principal"
echo ""

# Copiar ficheiros para a subdiretoria raw_data
echo "A copiar ficheiros..."
cp -r /home/fc60421/script_exame/Exame/* $raw_data
nr_ficheiros=$(ls -1 $raw_data | wc -l)
echo $nr_ficheiros "ficheiros foram copiados"
echo ""

# Mensagem de conclusão
echo "A diretoria principal e as suas subdiretorias foram criadas com sucesso!"
echo ""
