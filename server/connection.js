import mysql from "mysql";

const db = mysql.createConnection({
  host: "db",           // use the service name defined in docker-compose.yml
  user: "root",
  password: "",
  database: "timetable_cse",
  port: 3306            
});

export default db;
