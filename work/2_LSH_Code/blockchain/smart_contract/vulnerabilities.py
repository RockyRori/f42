import subprocess
import os

contract = "./VulnerableContract.sol"  # 指定智能合约文件路径
result = "./result.txt"


def check_with_slither(contract_path) -> str:
    """
    使用 Slither 检查合约的漏洞。
    """
    try:
        with open(result, "w", encoding="utf-8") as f:
            # 使用subprocess运行命令，将输出重定向到文件
            subprocess.run(["slither", contract_path], stdout=f, stderr=subprocess.STDOUT)

        with open(result, "r", encoding="utf-8") as f:
            error_content = f.read()
            return error_content
    except Exception as e:
        print(f"An error occurred while running Slither: {e}")
    return ""


if __name__ == "__main__":
    # 检查文件是否存在
    if not os.path.exists(contract):
        print(f"Contract file not found: {contract}")
    # 使用 Slither 检查重入攻击漏洞
    check_with_slither(contract)
