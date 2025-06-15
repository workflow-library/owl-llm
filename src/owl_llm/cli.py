import argparse
import os
import subprocess
import sys


def run_docker(model_path: str, prompt: str, n_predict: int = 50) -> None:
    """Run the llama.cpp Docker container with the given model and prompt."""
    if not os.path.isfile(model_path):
        print(f"Error: Model file not found: {model_path}")
        sys.exit(1)

    cmd = [
        "docker-compose",
        "run",
        "--rm",
        "llama-cpp",
        "./main",
        "-m",
        f"/models/{os.path.basename(model_path)}",
        "-p",
        prompt,
        "-n",
        str(n_predict),
    ]
    subprocess.run(cmd, check=True)


def main(argv: list[str] | None = None) -> None:
    """Entry point for the owl-llm command line interface."""
    parser = argparse.ArgumentParser(description="Tools for running LLM models")
    subparsers = parser.add_subparsers(dest="command")

    run_parser = subparsers.add_parser(
        "run", help="Run a GGUF model inside the Docker container"
    )
    run_parser.add_argument("model", help="Path to the GGUF model file")
    run_parser.add_argument("-p", "--prompt", required=True, help="Prompt text")
    run_parser.add_argument(
        "-n", "--n-predict", type=int, default=50, help="Number of tokens to predict"
    )

    args = parser.parse_args(argv)

    if args.command == "run":
        run_docker(args.model, args.prompt, args.n_predict)
    else:
        parser.print_help()


if __name__ == "__main__":
    main()
