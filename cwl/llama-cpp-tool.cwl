#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool
label: "Llama.cpp inference tool"
doc: "Run LLM inference using llama.cpp"

requirements:
  DockerRequirement:
    dockerPull: owl-llm/llama-cpp:latest
  InlineJavascriptRequirement: {}

baseCommand: ["/opt/llama.cpp/main"]

inputs:
  model:
    type: File
    doc: "GGUF model file"
    inputBinding:
      prefix: "-m"
      position: 1

  prompt:
    type: string
    doc: "Input prompt for the model"
    inputBinding:
      prefix: "-p"
      position: 2

  n_predict:
    type: int?
    default: 128
    doc: "Number of tokens to predict"
    inputBinding:
      prefix: "-n"
      position: 3

  temperature:
    type: float?
    default: 0.8
    doc: "Temperature for sampling"
    inputBinding:
      prefix: "--temp"
      position: 4

  top_k:
    type: int?
    default: 40
    doc: "Top-k sampling"
    inputBinding:
      prefix: "--top-k"
      position: 5

  top_p:
    type: float?
    default: 0.95
    doc: "Top-p sampling"
    inputBinding:
      prefix: "--top-p"
      position: 6

  threads:
    type: int?
    default: 4
    doc: "Number of threads to use"
    inputBinding:
      prefix: "-t"
      position: 7

  seed:
    type: int?
    doc: "Random seed for reproducibility"
    inputBinding:
      prefix: "-s"
      position: 8

outputs:
  response:
    type: stdout
    doc: "Model response output"

stdout: llama_output.txt