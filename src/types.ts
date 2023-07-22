
export interface ICustomer {
    first_name: string;
    middle_name: string;
    last_name: string;
    phone: string;
    email: string;
    password: string;
    repeat_password: string;
    date_of_birth: string;
    gender: 'MALE' | 'FEMALE' | 'OTHER';
    documents: IDocument[];
    account: IAccount;
    address: IAddress;
}

export interface IAccount {
    account_type: 'CURRENT' | 'SAVING' | 'SALARY' | 'FIXED' | 'JOINT';
    account_balance: number;
    document: IDocument;
}

export interface IAddress {
    type: 'REGULAR' | 'DEFAULT';
    country: string
    state: string
    city: string
    district: string
    landmark: string
    Customer: string
    customer_id: string
}

enum AccountType {
    CURRENT,
    SAVING,
    SALARY,
    FIXED,
    JOINT
}

export interface IDocument {
    document_type: 'PANCARD' | 'UID' | 'LICENSE';
    document_number: string;
}



enum address_type {
    REGULAR,
    DEFAULT
}

enum DocumentType {
    PANCARD,
    UID,
    LICENCE
}

enum GenderType {
    MALE,
    FEMALE,
    OTHER
}

enum IFSC {
    BANK0007
}

enum Country {
    INDIA
}

enum UserRole {
    ADMIN,
    CUSTOMER
}
