import os

from work.code.smart_contract.vulnerabilities import check_with_slither, contract, result


def check_gas_limit_with_slither(result_path) -> str:
    print(f"Checking for gas limit vulnerabilities in {result_path} with Slither...")
    try:
        with open(result_path, "r", encoding="utf-8") as f:
            content = f.read()
        start_string = "GasLimitVulnerability"
        end_string = "INFO"
        start = content.find(start_string)
        end = -1
        if start != -1:
            detection = content[start:]
            end = detection.find(end_string)
            print("Potential gas limit vulnerability found!")
            print(detection[:end])
            return detection[:end]
        else:
            print("No gas limit vulnerability found.")
            return "No gas limit vulnerability found."
    except Exception as e:
        print(f"An error occurred while running Slither: {e}")


if __name__ == "__main__":
    if not os.path.exists(result):
        check_with_slither(contract)
    check_gas_limit_with_slither(result)
