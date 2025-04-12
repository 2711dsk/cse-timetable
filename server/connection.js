import mysql from "mysql";

const db = mysql.createConnection({
    host: "host.docker.internal",
    user: "root",
    password: "",
    database: "timetable_cse"
});

export default db;