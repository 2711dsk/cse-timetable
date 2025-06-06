import express from "express";
import cors from "cors";
import jwt from "jsonwebtoken";
import db from './connection.js';
import getDataAndSchedule from './algorithm/algo.js';
import dotenv from "dotenv";

dotenv.config();

const SECRET_KEY = process.env.SECRET_KEY;

const app = express();

app.use(cors());
app.use(express.json()); 


app.get('/', (req, res) => {
    return res.json('Hello');
});

app.get('/faculty', (req, res) => {
    const sql = "SELECT * FROM faculty";
    db.query(sql, (err, data) => {
        if (err) return res.json({ err: err.message });
        res.json(data);
        
    });
});

app.get('/subjects', (req, res) => {
    const { semester } = req.query;
    let sql = "SELECT * FROM subject";
    
    if (semester && semester !== 'all') {
        sql += " WHERE semester_id = ?";
    }

    db.query(sql, semester !== 'all' ? [semester] : [], (err, data) => {
        if (err) return res.json({ err: err.message });
        res.json(data);
    });
});

app.post('/addFaculty', (req, res) => {
    const sql = "INSERT INTO faculty(`id`,`name`,`department`) VALUES(?)";
    const values = [
        req.body.id,
        req.body.name,
        req.body.department
    ];
    
    db.query(sql, [values], (err, data) => {
        if (err) return res.json({ err: err.message });
        console.log("Faculty added successfully");
        res.json({ message: "Faculty added successfully" });
    });
});

app.post('/addLab', (req, res) => {
    const sql = "INSERT INTO labs(`lab_name`) VALUES(?)";
    const values = [
        req.body.lab_name
    ];
    
    db.query(sql, [values], (err, data) => {
        if (err) return res.json({ err: err.message });
        console.log("Lab added successfully");
        res.json({ message: "Lab added successfully" });
    });
});

// ... existing imports ...

// Get all labs
app.get('/getLab', (req, res) => {
    const sql = "SELECT * FROM labs";
    db.query(sql, (err, data) => {
        if (err) return res.json({ err: err.message });
        res.json(data);
    });
});

// ... existing code ...

app.post('/getLabTimetable', (req, res) => {
    const { selectedLab } = req.body;

    if (!selectedLab) {
        return res.status(400).json({ error: "Lab name is required" });
    }

    const sql = `
        SELECT 
            t.*,
            subject.name AS subject_name
        FROM lab_timetable AS t
        INNER JOIN subject ON t.subject_id = subject.id
        WHERE t.lab_name = ?
        ORDER BY t.day, t.time;
    `;

    db.query(sql, [selectedLab], (err, results) => {
        if (err) {
            console.error("Database error:", err);
            return res.status(500).json({ error: err.message });
        }
        
        res.json(results);
    });
});

// ... rest of the existing code ...
// Delete lab by ID
// ... existing code ...

// Delete lab by lab_name
app.delete('/deleteLab', (req, res) => {
    const lab_name = req.query.lab_name;
    if (!lab_name) {
        return res.status(400).json({ error: "Lab name is required" });
    }
    
    const sql = "DELETE FROM labs WHERE lab_name = ?";
    
    db.query(sql, [lab_name], (err, data) => {
        if (err) return res.json({ err: err.message });
        console.log("Lab deleted successfully");
        res.json({ message: "Lab deleted successfully" });
    });
});

app.put('/updateLab', (req, res) => {
    const { old_lab_name,new_lab_name } = req.body;
    
    if (!old_lab_name || !new_lab_name) {
        return res.status(400).json({ error: "Both old and new lab names are required" });
    }

    const sql = "UPDATE labs SET lab_name = ? WHERE lab_name = ?";
    const values = [new_lab_name, old_lab_name];
    
    db.query(sql, values, (err, data) => {
        if (err) return res.json({ err: err.message });
        console.log("Lab updated successfully");
        res.json({ message: "Lab updated successfully" });
    });
});

// ... rest of your existing code ...


app.post('/addSubjects', (req, res) => {
    const sql = "INSERT INTO subject(`id`,`name`,`type`,`hours_per_week`,`semester_id`) VALUES(?)";
    const values = [
        req.body.id,
        req.body.name,
        req.body.type,
        req.body.hours_per_week,
        req.body.semester
    ];
    
    db.query(sql, [values], (err, data) => {
        if (err) return res.json({ err: err.message });
        console.log("Faculty added successfully");
        res.json({ message: "Faculty added successfully" });
    });
});

app.delete('/deleteFaculty/:id',(req,res)=>{
    const id = req.params.id;
    const sql = "DELETE FROM faculty WHERE id = ?"
    db.query(sql, id, (err, data) => {
        if (err) return res.json({ err: err.message });
        console.log("Faculty added successfully");
        res.json({ message: "Faculty deleted successfully" });
    })
})

app.post('/addElective',(req,res)=>{
    const sql = "INSERT INTO `elective`(`semester_id`, `elective_id`, `elective_subject_id`, `elective_name`, `elective_section`, `faculty_id`, `hours_per_week`) VALUES (?)";
    const values = [
        req.body.semester_id,
        req.body.elective_id,
        req.body.elective_subject_id,
        req.body.elective_name,
        req.body.elective_section,
        req.body.faculty_id,
        req.body.hours_per_week
    ]
    db.query(sql, [values], (err, data) => {
        if (err) return res.json({ err: err.message });
        console.log("Elective added successfully");
        res.json({ message: "Elective added successfully" });
    })
})

app.get('/getElectiveSections', (req, res) => {
    const { semester } = req.query;
    const sql = 'SELECT * FROM elective_semester WHERE semester_id = ?';
    
    db.query(sql, [semester], (err, data) => {
        if (err) return res.json({ err: err.message });
        res.json(data);
        
    });
});

app.get('/getElectiveId',(req,res)=>{
    const { semester } = req.query;
    const sql = 'SELECT * FROM subject WHERE semester_id = ? and type = "Elective" ';
    
    db.query(sql, [semester], (err, data) => {
        if (err) return res.json({ err: err.message });
        res.json(data);
        
    });
})

app.get('/getElectives',(req,res)=>{
    const sql = 'SELECT * FROM elective';
    db.query(sql, (err, data) => {
        if (err) return res.json({ err: err.message });
        res.json(data);
        
    })
})

app.delete('/deleteElective/:compositeKey', (req, res) => {
    const compositeKey = req.params.compositeKey;
    const [semester_id, elective_section, elective_id] = compositeKey.split('|');
    console.log(semester_id, elective_section, elective_id);

    const deleteSql = `DELETE FROM elective WHERE semester_id = ? AND elective_section = ? AND elective_id = ?;`;

    db.query(deleteSql, [semester_id, elective_section, elective_id], (err, data) => {
        if (err) {
            console.error('Error deleting elective:', err);
            return res.status(500).json({ error: err.message, completed: false });
        }
        res.json({ message: "Elective deleted successfully", completed: true });
    });
});

app.get('/viewFaculty/:id',(req,res)=>{
    const id = req.params.id;
    const sql = "SELECT * FROM faculty WHERE id = ?";
    db.query(sql,id, (err, data) => {
        if (err) return res.json({ err: err.message });
        res.json(data);
        
    });
})

app.post('/updateFaculty/:id', (req, res) => {
    const id = req.params.id;
    const sql = "UPDATE faculty SET name = ?, department = ? WHERE id = ?";
    const values = [req.body.name, req.body.department, id];
    
    db.query(sql, values, (err, data) => {
        if (err) {
            console.error('Error updating faculty:', err);
            return res.json({ error: err.message });
        }
        console.log("Faculty updated successfully");
        res.json({ message: "Faculty updated successfully" });
    });
});

app.get('/viewSubject/:id', (req, res) => {
    const id = req.params.id;
    const sql = "SELECT * FROM subject WHERE id = ?";
    db.query(sql, id, (err, data) => {
        if (err) return res.json({ err: err.message });
        res.json(data);
        
    });
});

// Update subject
app.post('/updateSubject/:id', (req, res) => {
    const id = req.params.id;
    const sql = "UPDATE subject SET name = ?, type = ?, hours_per_week = ?, semester_id = ? WHERE id = ?";
    const values = [
        req.body.name,
        req.body.type,
        req.body.hours_per_week,
        req.body.semester_id, 
        id
    ];
    
    db.query(sql, values, (err, data) => {
        if (err) {
            console.error('Error updating subject:', err);
            return res.json({ error: err.message });
        }
        console.log("Subject updated successfully");
        res.json({ message: "Subject updated successfully" });
    });
});

// Delete subject
app.delete('/deleteSubject/:id', (req, res) => {
    const id = req.params.id;
    const sql = "DELETE FROM subject WHERE id = ?";
    db.query(sql, id, (err, data) => {
        if (err) return res.json({ err: err.message });
        console.log("Subject deleted successfully");
        res.json({ message: "Subject deleted successfully" });
    });
});

app.post('/mapSubFac', (req, res) => {

    const sql = "INSERT INTO fac_sec_map(`semester_id`,`section_id`,`subject_id`,`faculty_id`) VALUES(?)";
    const values = [
        req.body.semester,
        req.body.class,
        req.body.subject,
        req.body.faculty
    ];

    db.query(sql, [values], (err, data) => {
        if (err) {
            console.error('Error inserting mapping:', err);
            return res.status(500).json({ error: err.message });
        }
        console.log("Mapping added successfully");
        res.json({ message: "Mapping added successfully" });
    });
});

app.post('/labEntry', (req, res) => {
    const sql = "INSERT INTO faculty_lab_mapping(`semester_id`, `section_id`, `subject_id`, `faculty_id_A`, `faculty_id_B`,`faculty_id_C`, `lab_name`) VALUES (?)";

    const values = [
        req.body.semester,
        req.body.class,
        req.body.subject,
        req.body.faculty1 || null,
        req.body.faculty2 || null,
        req.body.faculty3 && req.body.faculty3 !== 'null' ? req.body.faculty3 : null,
        req.body.lab_name || null
    ];

    db.query(sql, [values], (err, data) => {
        if (err) {
            console.error('Error inserting lab mapping:', err);
            return res.status(500).json({ error: err.message });
        }
        console.log("Lab mapping added successfully");
        res.json({ message: "Lab mapping added successfully" });
    });
});

app.post('/getTimetable', (req, res) => {
    const { semester, section } = req.body;

    if (!semester || !section) {
        return res.status(400).json({ error: "Semester and section are required" });
    }

    const sql = `SELECT * from timetable as t inner join subject on t.subject_id = subject.id where t.semester_id = ? and section_id = ? order by day,time; `;

    db.query(sql, [semester, section], (err, results) => {
        if (err) {
            console.error("Database error:", err); // Log error
            return res.status(500).json({ error: err.message });
        }
        
        res.json(results);
    });
});

app.post('/getFacultyTimetable', (req, res) => {
    const { selectedFaculty } = req.body;

    const sql = `SELECT 
                        subject.name AS subject_name, 
                        faculty.name AS faculty_name, 
                        CASE 
                            WHEN subject.type = 'Elective' THEN elective.elective_name 
                            ELSE NULL 
                        END AS elective_name,
                        t.*,
                        subject.type
                    FROM faculty_timetable AS t
                    INNER JOIN subject ON t.subject_id = subject.id
                    INNER JOIN faculty ON t.faculty_id = faculty.id
                    LEFT JOIN elective ON t.subject_id = elective.elective_id 
                                    AND elective.faculty_id = t.faculty_id
                    WHERE t.faculty_id = ? ; `;

    db.query(sql, [selectedFaculty], (err, results) => {
        if (err) {
            console.error("Database error:", err); // Log error
            return res.status(500).json({ error: err.message });
        }
        
        res.json(results);
    });
});

app.post('/getClassFaculty', (req, res) => {
    const { selectedFaculty } = req.body;

    const query1 = `
        SELECT 
            fac_sec_map.semester_id,
            fac_sec_map.section_id,
            fac_sec_map.subject_id,
            subject.name AS subject_name
        FROM fac_sec_map
        INNER JOIN subject ON fac_sec_map.subject_id = subject.id
        WHERE fac_sec_map.faculty_id = ?;
    `;

    const query2 = `
        SELECT 
            elective.semester_id,
            elective.elective_section AS section_id,
            elective.elective_subject_id AS subject_id,
            elective.elective_name,
            subject.name AS subject_name
        FROM elective
        INNER JOIN subject ON elective.elective_id = subject.id
        WHERE elective.faculty_id = ?;
    `;

    const query3 = `
        SELECT 
            faculty_lab_mapping.semester_id,
            faculty_lab_mapping.section_id,
            faculty_lab_mapping.subject_id,
            subject.name AS subject_name
        FROM faculty_lab_mapping
        INNER JOIN subject ON faculty_lab_mapping.subject_id = subject.id
        WHERE ? IN (faculty_lab_mapping.faculty_id_A, faculty_lab_mapping.faculty_id_B, faculty_lab_mapping.faculty_id_C)
        ORDER BY semester_id;
    `;

    Promise.all([
        new Promise((resolve, reject) => {
            db.query(query1, [selectedFaculty], (err, results) => {
                if (err) reject(err);
                else resolve(results);
            });
        }),
        new Promise((resolve, reject) => {
            db.query(query2, [selectedFaculty], (err, results) => {
                if (err) reject(err);
                else resolve(results);
            });
        }),
        new Promise((resolve, reject) => {
            db.query(query3, [selectedFaculty], (err, results) => {
                if (err) reject(err);
                else resolve(results);
            });
        })
    ])
    .then(([theoryResults, electiveResults, labResults]) => {
        const combinedResults = [
            ...theoryResults,
            ...electiveResults.map(item => ({
                ...item,
                subject_name: item.elective_name || item.subject_name
            })),
            ...labResults
        ];
        console.log("Combined Results:", combinedResults);
        res.json(combinedResults);
    })
    .catch(err => {
        console.error("Database error:", err);
        res.status(500).json({ error: err.message });
    });
});

app.post('/getFacOfClass', (req, res) => {
    const { semester, section } = req.body;
    
    if (!semester || !section) {
        return res.status(400).json({ error: "Semester and section are required" });
    }

    const theoryQuery = `SELECT faculty.name AS faculty_name, subject.name AS subject_name 
                         FROM fac_sec_map AS fp 
                         INNER JOIN faculty ON fp.faculty_id = faculty.id 
                         INNER JOIN subject ON fp.subject_id = subject.id 
                         WHERE fp.section_id = ? AND fp.semester_id = ?`;
    
    const labQuery = `SELECT 
                        f1.name AS faculty_name_A, 
                        f2.name AS faculty_name_B, 
                        f3.name AS faculty_name_C, 
                        subject.name AS subject_name,
                        fp.subject_id
                      FROM faculty_lab_mapping AS fp 
                      INNER JOIN faculty f1 ON fp.faculty_id_A = f1.id 
                      LEFT JOIN faculty f2 ON fp.faculty_id_B = f2.id 
                      LEFT JOIN faculty f3 ON fp.faculty_id_C = f3.id 
                      INNER JOIN subject ON fp.subject_id = subject.id 
                      WHERE fp.section_id = ? AND fp.semester_id = ?`;

    Promise.all([
        new Promise((resolve, reject) => {
            db.query(theoryQuery, [section, semester], (err, results) => {
                if (err) reject(err);
                else resolve(results);
            });
        }),
        new Promise((resolve, reject) => {
            db.query(labQuery, [section, semester], (err, results) => {
                if (err) reject(err);
                else resolve(results);
            });
        })
    ])
    .then(([theoryResults, labResults]) => {
        // Process theory results
        const theory = theoryResults.map(item => ({
            faculty_name: item.faculty_name,
            subject_name: item.subject_name
        }));
        
        // Process lab results - combine faculty A, B, and C
        const lab = labResults.map(item => ({
            faculty_name: [item.faculty_name_A, item.faculty_name_B, item.faculty_name_C].filter(Boolean).join(', '),
            subject_name: item.subject_name
        }));
        
        // Combine all results
        const combinedResults = [...theory, ...lab];
        res.json(combinedResults);
    })
    .catch(err => {
        console.error("Database error:", err);
        res.status(500).json({ error: err.message });
    });
});


        app.post('/getElectiveOfClass', (req, res) => {
            const { semester } = req.body;

            if (!semester) {
                return res.status(400).json({ error: "Semester is required" });
            }

            const sql = `
                SELECT 
                    elective.elective_id,           
                    elective.elective_name,         
                    subject.name AS subject_name,   
                    elective.elective_section,      
                    faculty.name AS faculty_name,   
                    faculty.department              
                FROM elective
                JOIN faculty ON elective.faculty_id = faculty.id
                JOIN subject ON elective.elective_id = subject.id
                WHERE elective.semester_id = ?
                ORDER BY elective.elective_id;
            `;

            db.query(sql, [semester], (err, results) => {
                if (err) {
                    console.error('Error fetching elective data:', err);
                    return res.status(500).json({ error: 'Internal Server Error' });
                }
                
                const mappedData = results.reduce((acc, item) => {
                    const subjectKey = item.subject_name;

                    if (!acc[subjectKey]) {
                        acc[subjectKey] = [];
                    }

                    acc[subjectKey].push({
                        elective_name: item.elective_name,
                        elective_section: item.elective_section,
                        faculty_name: item.faculty_name,
                        department: item.department
                    });

                    return acc;
                }, {});

                res.json(mappedData);
            });
        });


// Fetch subjects based on the selected semester
app.get('/getSubjectsBySemester', (req, res) => {
    const semester = req.query.semester;
    if (!semester) {
        return res.status(400).json({ error: 'Semester parameter is required' });
    }

    const sql = `
        SELECT 
            s.id, 
            s.name, 
            s.type, 
            s.semester_id 
        FROM subject s
        WHERE s.semester_id = ? and s.type LIKE 'L%';
    `;

    db.query(sql, [semester], (err, data) => {
        if (err) {
            console.error('Error fetching subjects:', err);
            return res.status(500).json({ error: err.message });
        }
        res.json(data);
    });
});


// Fetch faculty-subject mappings based on semester
app.get('/getFacSubMap', (req, res) => {
    const semester = req.query.semester;
    if (!semester) {
        return res.status(400).json({ error: 'Semester parameter is required' });
    }

    const sql = `
        SELECT 
            fsm.id,
            fsm.semester_id, 
            fsm.section_id, 
            f.name AS faculty_name, 
            s.name AS subject_name 
        FROM fac_sec_map fsm
        JOIN faculty f ON fsm.faculty_id = f.id
        JOIN subject s ON fsm.subject_id = s.id
        WHERE fsm.semester_id = ?;
    `;

    db.query(sql, [semester], (err, data) => {
        if (err) {
            console.error('Error fetching mappings:', err);
            return res.status(500).json({ error: err.message });
        }
        res.json(data);
    });
});

// Delete faculty-subject mapping
app.delete('/deleteFacSubMap/:id', (req, res) => {
    const id = req.params.id;
    const sql = "DELETE FROM fac_sec_map WHERE id = ?";

    db.query(sql, [id], (err, data) => {
        if (err) {
            console.error('Error deleting mapping:', err);
            return res.json({ err: err.message });
        }
        res.json({ message: "Mapping deleted successfully" });
    });
});

// Fetch lab faculty-subject mappings based on semester
app.get('/getLabFacSubMap', (req, res) => {
    const semester = req.query.semester;
    if (!semester) {
        return res.status(400).json({ error: 'Semester parameter is required' });
    }


    const sql = `
        SELECT 
            flm.id,
            flm.semester_id, 
            flm.section_id, 
            f1.name AS faculty1_name, 
            f2.name AS faculty2_name,
            f3.name AS faculty3_name, 
            flm.lab_name,
            s.name AS subject_name 
        FROM faculty_lab_mapping flm
        JOIN faculty f1 ON flm.faculty_id_A = f1.id
        LEFT JOIN faculty f2 ON flm.faculty_id_B = f2.id
        LEFT JOIN faculty f3 ON flm.faculty_id_C = f3.id
        JOIN subject s ON flm.subject_id = s.id
        WHERE flm.semester_id = ?;
    `;

    db.query(sql, [semester], (err, data) => {
        if (err) {
            console.error('Error fetching lab mappings:', err);
            return res.status(500).json({ error: err.message });
        }
        res.json(data);
    });
});

// ... existing code ...

app.post('/getLabFacTime', (req, res) => {
    const { selectedLab } = req.body;
    
    if (!selectedLab) {
        return res.status(400).json({ error: 'Lab name is required' });
    }

    const sql = `
    SELECT 
        flm.semester_id,
        flm.subject_id,
        flm.section_id,
        f1.name AS faculty_name_A, 
        f2.name AS faculty_name_B, 
        f3.name AS faculty_name_C,
        s.name AS subject_name
    FROM faculty_lab_mapping flm
    LEFT JOIN faculty f1 ON flm.faculty_id_A = f1.id
    LEFT JOIN faculty f2 ON flm.faculty_id_B = f2.id
    LEFT JOIN faculty f3 ON flm.faculty_id_C = f3.id
    JOIN subject s ON flm.subject_id = s.id
    WHERE flm.lab_name = ?;
    `;

    db.query(sql, [selectedLab], (err, data) => {
        if (err) {
            console.error('Error fetching lab mappings:', err);
            return res.status(500).json({ error: err.message });
        }
        
        // Map the data to include semester_id, subject_id, section_id, and faculty names
        const results = data.map(item => ({
            semester_id: item.semester_id,
            subject_id: item.subject_id,
            section_id: item.section_id,
            subject_name : item.subject_name,
            faculty_names: [
                item.faculty_name_A,
                item.faculty_name_B,
                item.faculty_name_C
            ].filter(Boolean).join(', ')
        }));

        res.json(results);
    });
});

// ... rest of the existing code ...


// Delete lab faculty-subject mapping
app.delete('/deleteLabFacSubMap/:id', (req, res) => {
    const id = req.params.id;
    const sql = "DELETE FROM faculty_lab_mapping WHERE id = ?";

    db.query(sql, [id], (err, data) => {
        if (err) {
            console.error('Error deleting lab mapping:', err);
            return res.json({ err: err.message });
        }
        res.json({ message: "Lab mapping deleted successfully" });
    });
});


app.post("/login", (req, res) => {
    const { username, password, loginType } = req.body;

    console.log("Received login request:", { username, loginType });

    const sql = "SELECT * FROM users WHERE username = ? AND role = ?";
    
    db.query(sql, [username, loginType], (err, data) => {
        if (err) {
            console.error("Database Error:", err);
            return res.status(500).json({ error: "Internal Server Error" });
        }

        if (data.length === 0) {
            return res.status(401).json({ error: "Invalid credentials" });
        }

        const user = data[0];

        if (password.trim() !== user.password.trim()) {
            return res.status(401).json({ error: "Invalid credentials" });
        }

        // Generate JWT Token
        const token = jwt.sign(
            { id: user.id, username: user.username, role: user.role },
            SECRET_KEY,
            { expiresIn: "1h" } // Token expires in 1 hour
        );

        console.log("Login successful! Token generated.");

        return res.status(200).json({
            message: "Login successful",
            token,
            user: {
                id: user.id,
                username: user.username,
                role: user.role
            }
        });
    });
});

app.post("/verify-token", (req, res) => {
    const token = req.headers["authorization"]?.split(" ")[1];
  
    if (!token) {
      return res.json({ valid: false });
    }
  
    jwt.verify(token, SECRET_KEY, (err, decoded) => {
      if (err) {
        return res.json({ valid: false });
      }
      res.json({ valid: true, role: decoded.role });
    });
  });


  
  app.get('/generate', async(req, res) => {
    let GetSemester = req.query;
    let semester_id = GetSemester.semester;

    const deleteQuery1 = `
    DELETE FROM timetable 
    WHERE semester_id = ?`;

    const deleteQuery2 = `
        DELETE FROM faculty_timetable 
        WHERE semester_id = ?`;

    const deleteQuery3 = `
        DELETE FROM delete_entries 
        WHERE semester_id = ?`;

    await Promise.all([
        db.query(deleteQuery1, [semester_id]),
        db.query(deleteQuery2, [semester_id]),
        db.query(deleteQuery3, [semester_id])
    ]);

    getDataAndSchedule(semester_id);
    return res.status(200).send('Timetable generated successfully'); 
});

app.post('/editTimetable', async (req, res) => {
    const {semester,section,day,time,subject_id,faculty_id,faculty_name,subject_name,subject_type,lab_name} = req.body;


    try {
        let deleteQuery1 = '';
        let deleteQuery2 = '';
        let deleteQuery3 = '';
        if(subject_type === 'Lecture'){
            deleteQuery1 = `
                DELETE FROM timetable 
                WHERE semester_id = ? AND section_id = ? AND day = ? AND time = ?`;
    
            deleteQuery2 = `
                DELETE FROM faculty_timetable 
                WHERE semester_id = ? AND section_id = ? AND day = ? AND time = ?`;
    
            let  insertDeletedEntryQuery = `
                INSERT INTO delete_entries (semester_id, section_id, day, time, subject_id, faculty_id, faculty_name, subject_name,type)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?,?)`;

            let faculty_alias = faculty_name[0];
            let faculty_identity = faculty_id[0];
            await Promise.all([
                db.query(deleteQuery1, [semester, section, day, time]),
                db.query(deleteQuery2, [semester, section, day, time]),
                db.query(insertDeletedEntryQuery, [semester, section, day, time, subject_id, faculty_identity,faculty_alias, subject_name,subject_type])
            ]);
            
            return res.status(200).json({ message: "Timetable entry deleted and stored in deleted_entries successfully" });
        }
        else if(subject_type === 'Lab'){
            // Create array of delete queries for faculty_timetable
            const facultyDeleteQueries = faculty_id.map(facId => `
                DELETE FROM faculty_timetable
                WHERE semester_id = ? AND section_id = ? AND day = ? AND time = ? AND faculty_id = ?`
            );

            // Base queries
            deleteQuery1 = `
                DELETE FROM timetable 
                WHERE semester_id = ? AND section_id = ? AND day = ? AND time = ?`;

            deleteQuery3 = `
                DELETE FROM lab_timetable
                WHERE semester_id = ? AND section_id = ? AND day = ? AND time = ? AND subject_id = ?`;

            // New query for lab_deleted_entries
            const insertLabDeletedEntryQuery = `
                INSERT INTO lab_deleted_entries 
                (day, time, section_id, semester_id, subject_id, lab_name, type,
                 faculty_id_A, faculty_id_B, faculty_id_C,
                 faculty_name_A, faculty_name_B, faculty_name_C)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?)`;

            // Prepare all queries for execution
            const queryPromises = [
                db.query(deleteQuery1, [semester, section, day, time]),
                db.query(deleteQuery3, [semester, section, day, time, subject_id]),
            ];

            // Add faculty-specific delete queries
            faculty_id.forEach((facId, index) => {
                queryPromises.push(
                    db.query(facultyDeleteQueries[index], [semester, section, day, time, facId])
                );
            });

            // Insert into lab_deleted_entries
            queryPromises.push(
                db.query(insertLabDeletedEntryQuery, [
                    day, time, section, semester, subject_id, lab_name,subject_type,
                    faculty_id[0] || null, faculty_id[1] || null, faculty_id[2] || null,
                    faculty_name[0] || null, faculty_name[1] || null, faculty_name[2] || null
                ])
            );

            // Execute all queries
            await Promise.all(queryPromises);
            
            return res.status(200).json({ message: "Lab timetable entry and faculty data deleted successfully" });
        }
    } catch (error) {
        console.error("Database error:", error);
        return res.status(500).json({ error: "Internal server error" });
    }
});


app.post('/addToTimetable',async(req,res)=>{
    try {
    const { semester, section, day, time,subject_id, faculty_id,subject_type,lab_name} = req.body;
    if(subject_type === "Lecture"){
            const insertQuery1 = `
            INSERT INTO timetable(semester_id,section_id,time,day,subject_id) 
            VALUES(?,?,?,?,?)`;

            const insertQuery2 = `
                INSERT INTO faculty_timetable(semester_id,section_id,time,day,faculty_id,subject_id) 
            VALUES(?,?,?,?,?,?)`;

            await Promise.all([
                db.query(insertQuery1, [semester, section, time,day,subject_id]),
                db.query(insertQuery2, [semester, section,time, day,faculty_id,subject_id])
            ]);

        return res.status(200).json({ message: "Timetable entry inserted successfully" });
    }
    else if(subject_type === "Lab"){
        
        const insertQuery1 = `
            INSERT INTO timetable(semester_id,section_id,time,day,subject_id) 
            VALUES(?,?,?,?,?)`;

        const insertLabQuery = `
            INSERT INTO lab_timetable(semester_id,section_id,time,day,subject_id,lab_name) 
            VALUES(?,?,?,?,?,?)`;

        // Insert into faculty_timetable for each faculty
        const facultyInsertQueries = faculty_id.map(facId => `
            INSERT INTO faculty_timetable(semester_id,section_id,time,day,faculty_id,subject_id) 
            VALUES(?,?,?,?,?,?)`);

        // Execute all queries
        await Promise.all([
            db.query(insertQuery1, [semester, section, time, day, subject_id]),
            db.query(insertLabQuery, [semester, section, time, day, subject_id, lab_name]),
            ...faculty_id.map((facId, index) => 
                db.query(facultyInsertQueries[index], [semester, section, time, day, facId, subject_id])
            )
        ]);

        return res.status(200).json({ message: "Lab timetable entry inserted successfully" });
    }
    } catch (error) {
    console.error("Database error:", error);
    return res.status(500).json({ error: "Internal server error" });
    }

})

app.post('/getDeletedEntries', async (req, res) => {
    const { semester, section } = req.body;

    try {
        const fetchQuery = `SELECT * FROM delete_entries WHERE semester_id = ? AND section_id = ?`;
        const fetchQueryLab = `SELECT subject.name as subject_name, l.* 
                                                FROM lab_deleted_entries AS l 
                                                JOIN subject ON subject.id = l.subject_id 
                                                WHERE l.semester_id = ? AND l.section_id = ?`;
        
        const [lectureResults, labResults] = await Promise.all([
            new Promise((resolve, reject) => {
                db.query(fetchQuery, [semester, section], (err, results) => {
                    if (err) reject(err);
                    else resolve(results);
                });
            }),
            new Promise((resolve, reject) => {
                db.query(fetchQueryLab, [semester, section], (err, results) => {
                    if (err) reject(err);
                    else resolve(results);
                });
            })
        ]);

        // Format lecture results
        const formattedLecture = lectureResults.map(entry => ({
            ...entry,
            faculty_id: [entry.faculty_id],
            faculty_name: [entry.faculty_name]
        }));

        // Format lab results
        const formattedLab = labResults.map(entry => ({
            ...entry,
            faculty_id: [
                entry.faculty_id_A,
                entry.faculty_id_B,
                entry.faculty_id_C
            ].filter(Boolean),
            faculty_name: [
                entry.faculty_name_A,
                entry.faculty_name_B,
                entry.faculty_name_C
            ].filter(Boolean)
        }));

        const combinedResults = [...formattedLecture, ...formattedLab];
        
        return res.status(200).json(combinedResults);

    } catch (error) {
        console.error("Database error:", error);
        return res.status(500).json({ error: "Internal server error" });
    }
});


app.post('/removeDeletedEntry', async (req, res) => {
    const { semester, section, day, time, subject_type, subject_id } = req.body;

    try {
        let deleteQuery = '';

        if (subject_type === 'Lecture') {
            deleteQuery = `
                DELETE FROM delete_entries 
                WHERE semester_id = ? AND section_id = ? AND day = ? AND time = ? AND subject_id = ?`;
        } else if (subject_type === 'Lab') {
            deleteQuery = `
                DELETE FROM lab_deleted_entries 
                WHERE semester_id = ? AND section_id = ? AND day = ? AND time = ? AND subject_id = ?`;
        }

        await db.query(deleteQuery, [semester, section, day, time, subject_id]);

        return res.status(200).json({ message: "Deleted entry removed from records" });
    } catch (error) {
        console.error("Database error:", error);
        return res.status(500).json({ error: "Internal server error" });
    }
});


app.post('/getFaculty', (req, res) => {
    const { section_id, semester_id, subject_id,subject_type } = req.body;

    if (!section_id || !semester_id || !subject_id) {
        return res.status(400).json({ error: "Missing required parameters" });
    }

    let query = "";
    if(subject_type === "Lecture"){
        query = `
            SELECT faculty.id AS faculty_id,faculty.name AS faculty_name,subject.name AS subject_name 
                            FROM fac_sec_map AS fp 
                            INNER JOIN faculty ON fp.faculty_id = faculty.id 
                            INNER JOIN subject ON fp.subject_id = subject.id 
                            WHERE fp.section_id = ? AND fp.semester_id = ? and subject_id = ?;
        `;
    }

    else if(subject_type==="Lab"){
        query = `
            SELECT 
                f1.name AS faculty_name_A, 
                f2.name AS faculty_name_B, 
                f3.name AS faculty_name_C,
                flm.*
            FROM faculty_lab_mapping flm
            LEFT JOIN faculty f1 ON flm.faculty_id_A = f1.id
            LEFT JOIN faculty f2 ON flm.faculty_id_B = f2.id
            LEFT JOIN faculty f3 ON flm.faculty_id_C = f3.id
            WHERE flm.section_id = ? AND flm.semester_id = ? and subject_id = ?;`;
    }

    db.query(query, [section_id, semester_id, subject_id], (err, results) => {
        if (err) {
            console.error("Error fetching faculty data:", err,semester_id,section_id,subject_id);
            return res.status(500).json({ error: "Database query failed" });
        }

        if (results.length === 0) {
            return res.status(404).json({ message: "No faculty found for the given criteria" });
        }

        res.json(results);
    });
});

app.post('/checkCellAvailability', (req, res) => {
    const { faculty_id, semester_id, section_id, subject_type, lab_name } = req.body;

    if (subject_type === 'Lecture') {
        const query1 = `
            SELECT day, time FROM timetable 
            WHERE semester_id = ? AND section_id = ?;
        `;

        const query2 = `
            SELECT day, time FROM faculty_timetable 
            WHERE faculty_id = ?;
        `;

        Promise.all([
            new Promise((resolve, reject) => {
                db.query(query1, [semester_id, section_id], (err, results) => {
                    if (err) reject(err);
                    else resolve(results);
                });
            }),
            new Promise((resolve, reject) => {
                db.query(query2, [faculty_id], (err, results) => {
                    if (err) reject(err);
                    else resolve(results);
                });
            })
        ])
        .then(([timetableResults, facultyResults]) => {

            const combinedResults = [
                ...(timetableResults || []),
                ...(facultyResults || [])
            ];

            const uniqueResults = Array.from(
                new Set(combinedResults.map(JSON.stringify))
            ).map(JSON.parse);

            res.status(200).json(uniqueResults);
        })
        .catch(err => {
            console.error("Error checking lecture availability:", err);
            res.status(500).json({ error: "Database query failed" });
        });

    } else if (subject_type === 'Lab') {
        const query1 = `
            SELECT day, time FROM lab_timetable WHERE lab_name = ?;
        `;

        const query2 = `
            SELECT day, time FROM faculty_timetable 
            WHERE faculty_id IN (${faculty_id.filter(id => id !== null).map(() => '?').join(',')});
        `;

        const query3 = `
            SELECT day, time FROM timetable 
            WHERE semester_id = ? AND section_id = ?;
        `;

        const validFacultyIds = faculty_id.filter(id => id !== null);

        Promise.all([
            new Promise((resolve, reject) => {
                db.query(query1, [lab_name], (err, results) => {
                    if (err) reject(err);
                    else resolve(results);
                });
            }),
            new Promise((resolve, reject) => {
                db.query(query2, validFacultyIds, (err, results) => {
                    if (err) reject(err);
                    else resolve(results);
                });
            }),
            new Promise((resolve, reject) => {
                db.query(query3, [semester_id, section_id], (err, results) => {
                    if (err) reject(err);
                    else resolve(results);
                });
            })
        ])
        .then(([labResults, facultyResults, timetableResults]) => {

            const combinedResults = [
                ...(labResults || []),
                ...(facultyResults || []),
                ...(timetableResults || [])
            ];

            const uniqueResults = Array.from(
                new Set(combinedResults.map(JSON.stringify))
            ).map(JSON.parse);

            res.status(200).json(uniqueResults);
        })
        .catch(err => {
            console.error("Error checking lab availability:", err);
            res.status(500).json({ error: "Database query failed" });
        });
    }
});


app.get('/deleteData', async (req, res) => {
    try {
        let GetSemester = req.query;
        let sem_id = GetSemester.semester;
        console.log(`Deleting records for semester: ${sem_id}`);

        const deleteQueries = [
            `DELETE FROM timetable WHERE semester_id = ?`,
            `DELETE FROM faculty_timetable WHERE semester_id = ?`,
            `DELETE FROM lab_timetable WHERE semester_id = ?`,

        ];

        for (let query of deleteQueries) {
            await db.query(query, [sem_id]);
        }

        return res.status(200).json({ message: "Deleted Successfully" });

    } catch (error) {
        console.error("Database error:", error);
        return res.status(500).json({ error: "Internal server error" });
    }
});



app.listen(3000, () => {
    console.log("Server running on port 3000");
});
