from smart_contract.vulnerabilities import check_with_slither, contract, result


def check_compile_error_with_slither(result_path) -> str:
    print(f"Checking for compile error vulnerabilities in {result_path} with Slither...")
    try:
        with open(result_path, "r", encoding="utf-8") as f:
            content = f.read()
        start_string = "Error"
        end_string = "Traceback"
        start = content.find(start_string)
        end = -1
        if start != -1:
            detection = content[start:]
            end = detection.rfind(end_string)
            print("Potential compile error vulnerability found!")
            print(detection[:end])
            return detection[:end]
        else:
            print("No compile error vulnerability found.")
            return "No compile error vulnerability found."
    except Exception as e:
        print(f"An error occurred while running Slither: {e}")


if __name__ == "__main__":
    check_with_slither(contract)
    check_compile_error_with_slither(result)
