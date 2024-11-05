from flask import Flask, render_template, request

from smart_contract.access_control.access_control import check_access_control_with_slither
from smart_contract.gas_limit.gas_limit import check_gas_limit_with_slither
from smart_contract.insecure_randomness.insecure_randomness import check_insecure_randomness_with_slither
from smart_contract.reentrancy_attacks.reentrancy_attacks import check_reentrancy_with_slither
from smart_contract.timestamp_dependence.timestamp_dependence import check_timestamp_dependence_with_slither
from smart_contract.vulnerabilities import check_with_slither

app = Flask(__name__)

contract = "./input.sol"  # 指定智能合约文件路径
result = "./result.txt"


@app.route("/", methods=["GET", "POST"])
def home():
    detection = ""
    v_num = 0
    if request.method == "POST":
        user_text = request.form.get("user_text")
        if user_text:
            detection, v_num = detect_vulnerability(user_text)
    return render_template("index.html", detection=detection, v_num=v_num)


def detect_vulnerability(text) -> (str, int):
    with open(contract, "w", encoding="utf-8") as file:
        file.write(text)

    check_with_slither(contract)
    v_num = 0
    reentrancy = check_reentrancy_with_slither(result)
    v_num += count(reentrancy)
    timestamp_dependence = check_timestamp_dependence_with_slither(result)
    v_num += count(timestamp_dependence)
    access_control = check_access_control_with_slither(result)
    v_num += count(access_control)
    insecure_randomness = check_insecure_randomness_with_slither(result)
    v_num += count(insecure_randomness)
    gas_limit = check_gas_limit_with_slither(result)
    v_num += count(gas_limit)
    return (f"reentrancy: {reentrancy}\n\n"
            f"timestamp dependence: {timestamp_dependence}\n\n"
            f"access control: {access_control}\n\n"
            f"insecure randomness: {insecure_randomness}\n\n"
            f"gas limit: {gas_limit}\n\n"), v_num


def count(text: str) -> int:
    return 0 if text.startswith("No") else 1


if __name__ == "__main__":
    app.run(debug=True)
