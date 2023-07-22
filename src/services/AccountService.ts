
class AccountService {
    static async generateAccountNumber(length: number = 12): Promise<string> {
        return new Promise((res, rej) => {
            const digits = "0123456789";
            let accountNumber = '';

            for (let i = 0; i < length; i++) {
                const randomIndex = Math.floor(Math.random() * digits.length);
                accountNumber += digits.charAt(randomIndex);
            }
            return res(accountNumber);
        })
    }

    static async generateRandomPassword(password: string): Promise<string> {
        return new Promise((res, rej) => {
            const digits = "abcdefghijjklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            let accountNumber = '';

            for (let i = 0; i < length; i++) {
                const randomIndex = Math.floor(Math.random() * digits.length);
                password += digits.charAt(randomIndex);
            }
            return password;
        })
    }
}

export default AccountService;