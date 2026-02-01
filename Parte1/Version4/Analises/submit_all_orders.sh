#!/bin/bash
#
# Lança TODOS os jobs (uma ordem de loop por job)
#

ORDERS=(0 1 2 3 4 5)

echo "======================================"
echo "Submetendo jobs para todas as ordens"
echo "Data: $(date)"
echo "======================================"

for order in "${ORDERS[@]}"; do
    echo "Submetendo LOOP_ORDER = $order"
    sbatch run_one_order.sh $order
done

echo "======================================"
echo "Todos os jobs submetidos"
echo "======================================"
