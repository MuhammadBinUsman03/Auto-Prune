#!/bin/bash
#Setting Up dependencies and authenticating(for gated access)
pip install "huggingface_hub[cli]"
huggingface-cli login --token $HF_TOKEN
git clone https://github.com/MuhammadBinUsman03/PruneMe.git
cd PruneMe
pip install -r requirements.txt
# Drop the layers between [l_0, l_n] and merge the rest of layers
cd ./slice_with_mergekit
git clone https://github.com/cg123/mergekit.git
cd mergekit
pip install -e .
cd ./../..


#Calculate Layer Similarities
cd ./compute_block_similarity/
python layer_similarity.py --model_path $MODEL_ID \
                      --dataset $DATASET \
                      --dataset_column $TEXT_COLUMN \
                      --batch_size $BATCH \
                      --max_length $MAX_LENGTH \
                      --layers_to_skip $LAYERS_TO_SKIP \
                      --dataset_size $DATASET_SIZE \
                      --dataset_subset $DATASET_SUBSET

# Upload to Hub
if [ "$PUSH" == "True" ]; then   
  cd ./merged
  huggingface-cli upload $NEW_MODEL . .
fi

# Kill Pod
if [ "$DEBUG" == "False" ]; then
   runpodctl remove pod $RUNPOD_POD_ID
fi
