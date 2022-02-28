import os
dir_list = os.listdir("/media/genesis/Personal/EthereumBlockchainPy/solidity_project/remix-backup-at-22h54min-2022-2-28")
n = len(dir_list)
print(dir_list)
for i in range(n-1,-1,-1):
    if dir_list[i][-5:] == ".json":
        if os.path.exists("/media/genesis/Personal/EthereumBlockchainPy/solidity_project/remix-backup-at-22h54min-2022-2-28/"+dir_list[i]):
            os.remove("/media/genesis/Personal/EthereumBlockchainPy/solidity_project/remix-backup-at-22h54min-2022-2-28/"+dir_list[i])
        else:
            print("Not exists")

# print(dir_list)