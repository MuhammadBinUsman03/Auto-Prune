#!/bin/bash

pip install "huggingface_hub[cli]"
huggingface-cli login --token $HF_TOKEN

git clone https://github.com/MuhammadBinUsman03/PruneMe.git
cd PruneMe
pip install -r requirements.txt

cd ./compute_block_similarity/
output=$(python layer_similarity.py --model_path $MODEL_ID \
                      --dataset $DATASET \
                      --dataset_column $TEXT_COLUMN \
                      --batch_size $BATCH \
                      --max_length $MAX_LENGTH \
                      --layers_to_skip $LAYERS_TO_SKIP \
                      --dataset_size $DATASET_SIZE \
                      --dataset_subset $DATASET_SUBSET)
last=$(echo "$output" | tail -n 1)
final=$(echo "$last" | awk '{print $1}')
dtype=$(echo "$last" | awk '{print $2}')
l_0=$(echo "$last" | awk '{print $3}')
l_n=$(echo "$last" | awk '{print $4}')

cd ./../slice_with_mergekit
git clone https://github.com/cg123/mergekit.git
cd mergekit
pip install -e .
cd ..
python MergeConfig.py $MODEL_ID $final $dtype $l_0 $l_n
python merge_me.py

if [ "$PUSH" == "True" ]; then   
  cd merged
  huggingface-cli upload $NEW_MODEL . .
fi

if [ "$DEBUG" == "False" ]; then
   runpodctl remove pod $RUNPOD_POD_ID
fi
