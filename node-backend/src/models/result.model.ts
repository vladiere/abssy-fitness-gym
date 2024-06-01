// Object returned on insert and update database
export interface IMySQLResult {
  insertId: number;
  message: string;
  status: number;
  affectedRows: number;
  changedRows: number;
  fieldCount: number;
  info: string;
  serverStatus: number;
  warningStatus: number;
}

export interface IUser {
  0: {
    user_id: number;
    role: string;
    password: string;
    user_type: string;
  };
}
