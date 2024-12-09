
#!/bin/bash

echo "Bem-vindo ao verificador de comandos!"
echo ""

# Solicitar comandos a verificar
echo "Por favor, insira os comandos que deseja verificar, separados por espaços (exemplo: fastqc multiqc fastp):"
read -r -a comandos
echo ""

# Solicitar e ativar o ambiente conda
source /home/fc60421/miniconda3/etc/profile.d/conda.sh
while true; do
    echo "Por favor, insira o nome do ambiente conda que deseja ativar para a verificação:"
    read -r ambiente

    if conda activate "$ambiente"; then
        echo ""
        echo "Ambiente conda '$ambiente' ativado com sucesso."
        break
    else
        echo "Erro ao ativar o ambiente conda '$ambiente'. Verifique se o nome está correto e tente novamente."
    fi
done
echo ""

# Verificar cada comando
echo "A verificar a existência dos comandos..."
echo ""

for tool in "${comandos[@]}"; do
    if ! command -v "$tool" &>/dev/null; then
        echo "$tool não instalado!"
    else
        version=$("$tool" --version 2>&1 | head -n 1)
        echo "$tool instalado: $version"
    fi
done
echo ""

# Finalizar o script
echo "Verificação concluída!"
echo ""

# Perguntar se deseja correr o script 2
while true; do
    echo "Deseja executar o script 2? (S/s para sim, N/n para não)"
    read -r escolha
    case $escolha in
        [sS])
            bash script2.sh
            break
            ;;
        [nN])
            echo "A sair..."
            exit 0
            ;;
        *)
            echo "Escolha inválida, por favor insira S/s (sim) ou N/n (não)!"
            echo ""
            ;;
    esac
done
