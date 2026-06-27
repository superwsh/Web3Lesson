import prompts from "prompts";

/**
 * 安全地输入私钥（隐藏输入内容）
 */
export async function inputPrivateKey(
  message: string = "请输入私钥:",
): Promise<string> {
  const response = await prompts({
    type: "password",
    name: "value",
    message,
  });

  let privateKey = response.value;
  if (privateKey && !privateKey.startsWith("0x")) {
    privateKey = "0x" + privateKey;
  }

  return privateKey;
}
