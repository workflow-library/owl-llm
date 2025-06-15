# owl-llm
LLM tools for container based workflows and prompt engineering

## Command line usage

After installing the package you can run the bundled Docker setup using the
`owl-llm` command:

```bash
owl-llm run models/your-model.gguf -p "What is the capital of France?"
```

This command executes the `llama.cpp` container with your model and prints the
generated response.
