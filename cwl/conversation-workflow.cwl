#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: Workflow
label: "Multi-turn conversation workflow"
doc: "Process multiple prompts through llama.cpp in sequence"

requirements:
  ScatterFeatureRequirement: {}
  InlineJavascriptRequirement: {}
  StepInputExpressionRequirement: {}

inputs:
  model:
    type: File
    doc: "GGUF model file to use for all prompts"
  
  prompts:
    type: string[]
    doc: "Array of prompts to process"
  
  temperature:
    type: float?
    default: 0.8
    doc: "Temperature for sampling"
  
  n_predict:
    type: int?
    default: 128
    doc: "Number of tokens to predict per prompt"

outputs:
  responses:
    type: File[]
    outputSource: inference/response
    doc: "Array of response files"

steps:
  inference:
    run: llama-cpp-tool.cwl
    scatter: prompt
    in:
      model: model
      prompt: prompts
      temperature: temperature
      n_predict: n_predict
    out: [response]