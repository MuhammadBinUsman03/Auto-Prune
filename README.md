<div align="center">
  <h1>🔧AutoPrune</h1>
  <p>
     <a href="www.linkedin.com/in/muhammad-bin-usman">LinkedIn</a> • 
     <a href="https://huggingface.co/Muhammad2003/">Hugging Face</a> • 
     <a href="https://medium.com/@muhammadbinusman03">Medium</a> • 
  </p>
   <p><em>Simplify LLM evaluation using a convenient Colab notebook.</em></p>
   <a href="https://colab.research.google.com/drive/1-stRWrVsrglkjtE8dRorjQZL00wANR58?usp=sharing"><img src="img/colab.svg" alt="Open In Colab"></a></center>
</div>
<br/>





![image](https://github.com/MuhammadBinUsman03/Auto-Prune/assets/58441901/eca306e6-f0f5-475e-8051-4c3c916ab32b)

## 🔍 Overview

AutoPrune **simplifies the process of pruning LLMs** through [Colab notebook](https://colab.research.google.com/drive/1Igs3WZuXAIv9X0vwqiE90QlEPys8e8Oa?usp=sharing). You need to specify pruning parameters as described
in the [pruning paper](https://arxiv.org/abs/2403.17887).

### Key Features

* Automated setup and execution using [RunPod](https://runpod.io?ref=9nvk2srl).
* Identifies the most ideal block of layers to prune
* Removes the pruning block and merges the rest of model
* Pushed to 🤗 Huggingface the pruned model.
* Doesn't perform the QLoRA-SFT (Healing) of the pruned model as it can be performed normally.