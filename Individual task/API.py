import web3
import json
class API():

    def __init__(self, current_user):
        self.w3 = web3.Web3(web3.HTTPProvider("http://127.0.0.1:8545"))
        print(self.w3.is_connected())
        with open ("ABI.txt", "r") as f:
            abi = json.loads(f.read())
        contract_address = web3.Web3.to_checksum_address("0xBDfe2d748734A52657f400ac02b3aB376FF74c16")
        self.sc = self.w3.eth.contract(address = contract_address, abi = abi)
      # self.current_user = self.w3.eth.accounts[0]
        self.current_user = current_user

    def get_accounts(self):
        return self.w3.eth.accounts

    def get_balance(self, address):
        return web3.Web3.from_wei(self.w3.eth.get_balance(address), "ether")

    def create_account(self, password):
        new_account = self.w3.geth.personal.new_account(password)
        return new_account

    def check_password(self, account, password):
        try:
            unlocked = self.w3.geth.personal.unlock_account(account, password, 0)
            return unlocked
        except:
            return 0
    
    def owner(self):
        return self.sc.functions.owner().call()

    def inflation(self):
        return self.sc.functions.inflation().call()

    def add_service(self, name, price):
        self.w3.geth.personal.unlock_account(self.current_user, "1", 0)
        self.w3.geth.miner.start()
        tx = self.sc.functions.addService(name, price).transact({'from': self.current_user})
        self.w3.eth.wait_for_transaction_receipt(tx)
        self.w3.geth.miner.stop()

    def add_master(self, master):
        self.w3.geth.personal.unlock_account(self.current_user, "1", 0)
        self.w3.geth.miner.start()
        tx = self.sc.functions.addMaster(master).transact({'from': self.current_user})
        self.w3.eth.wait_for_transaction_receipt(tx)
        self.w3.geth.miner.stop()

    def add_clients(self, client):
        self.w3.geth.personal.unlock_account(self.current_user, "1", 0)
        self.w3.geth.miner.start()
        tx = self.sc.functions.addClients(client).transact({'from': self.current_user})
        self.w3.eth.wait_for_transaction_receipt(tx)
        self.w3.geth.miner.stop()

    def change_inflation(self, newInflation):
        self.w3.geth.personal.unlock_account(self.current_user, "1", 0)
        self.w3.geth.miner.start()
        tx = self.sc.functions.changeInflation(newInflation).transact({'from': self.current_user})
        self.w3.eth.wait_for_transaction_receipt(tx)
        self.w3.geth.miner.stop()

    def change_price(self, serviceNumber, newPrice):
        self.w3.geth.personal.unlock_account(self.current_user, "1", 0)
        self.w3.geth.miner.start()
        tx = self.sc.functions.changePrice(serviceNumber, newPrice).transact({'from': self.current_user})
        self.w3.eth.wait_for_transaction_receipt(tx)
        self.w3.geth.miner.stop()

    def register_visit(self, masterAddress, serviceNumber, data):
        self.w3.geth.personal.unlock_account(self.current_user, "1", 0)
        self.w3.geth.miner.start()
        tx = self.sc.functions.registerVisit(masterAddress, serviceNumber, data).transact({'from': self.current_user})
        self.w3.eth.wait_for_transaction_receipt(tx)
        self.w3.geth.miner.stop()

    def cancel_visit(self, visitIndex):
        self.w3.geth.personal.unlock_account(self.current_user, "1", 0)
        self.w3.geth.miner.start()
        tx = self.sc.functions.cancelVisit(visitIndex).transact({'from': self.current_user})
        self.w3.eth.wait_for_transaction_receipt(tx)
        self.w3.geth.miner.stop()

    def pay_for_service(self, visitIndex, value):
        self.w3.geth.personal.unlock_account(self.current_user, "1", 0)
        self.w3.geth.miner.start()
        tx = self.sc.functions.payForService(visitIndex).transact({'from': self.current_user, 'value': value})
        self.w3.eth.wait_for_transaction_receipt(tx)
        self.w3.geth.miner.stop()

    def get_visits(self):
        return self.sc.functions.getVisits().call()

    def get_service(self):
        return self.sc.functions.getService().call()

    def get_masters(self):
        return self.sc.functions.getMasters().call()

    def get_clients(self):
        return self.sc.functions.getClients().call()

    def is_client(self, client):
        return self.sc.functions.isClient(client).call()

    def is_master(self, master):
        return self.sc.functions.isMaster(master).call()

    def check_client(self, i, c):
        return self.sc.functions.checkClient(i, c).call()

    def check_master(self, i, m):
        return self.sc.functions.checkMaster(i, m).call()

    def change_time(self, time):
        self.w3.geth.personal.unlock_account(self.current_user, "1", 0)
        self.w3.geth.miner.start()
        tx = self.sc.functions.changeTime(time).transact({'from': self.current_user})
        self.w3.eth.wait_for_transaction_receipt(tx)
        self.w3.geth.miner.stop()
    def get_time(self):
        return self.sc.functions.getTime().call()


api = API('0x8fb3340c6eFdcb6b078409F77621D47342741677')
#print(api.get_service())
#print(api.inflation())
#api.add_service(1, "nails", 1)
#api.add_master('0x219e66A0A33bc9A071F8204a07DAA867634eE57C')
#api.register_clients('0xD76262DD06051B337C22C6b14D303284641885dA')
#api.register_visit('0x219e66A0A33bc9A071F8204a07DAA867634eE57C',1)
#api.pay_for_service(1,1)
#print(api.get_masters())