# SQL & Relational Database Design — Student Assignment Pack

- **Student:** İsmayıl İsmayılzadə
- **Group:** 844i
- **DBMS Used:** SQLite (DB Browser for SQLite 3.13.1)
- **Execution Screenshots Report:** [`SalesDB_SQLite_Screenshots_Report.docx`](./SalesDB_SQLite_Screenshots_Report.docx) *(All query execution screenshots for Scenarios 1.1 – 6.10)*

---

## Part I: Basic SQL — Task B10 Explanation

**Why is a `WHERE` clause needed to target the intended rows?**
Without a `WHERE` clause, an `UPDATE` statement modifies every single row in the `Products` table (changing all product prices to `95.00`), and a `DELETE` statement removes all records from the table. Filtering by the primary key (`WHERE ProductID = 901`) ensures that only the intended single test record is updated or deleted while all reference products remain untouched.

---

## Part II: Business Scenarios (Scenarios 1 – 3)

### Scenario 1: Customer Campaign Segmentation

**1.1 Customers Sorted by Score DESC**
| CustomerID | FirstName | LastName | Country | Score |
|---|---|---|---|---|
| 3 | Emma | Schmidt | Germany | 860 |
| 1 | Ayla | Karimova | Azerbaijan | 720 |
| 8 | Sofia | Rossi | Italy | 700 |
| 7 | Lea | Fischer | Germany | 680 |
| 6 | Noah | Adams | USA | 610 |
| 5 | Lukas | Weber | Germany | 550 |
| 2 | John | Miller | USA | 450 |
| 9 | Ali | Hasanov | Azerbaijan | 330 |
| 4 | Sara | Martin | France | 280 |

**1.2 Germany or France with Score >= 500**
| CustomerID | FirstName | LastName | Country | Score |
|---|---|---|---|---|
| 3 | Emma | Schmidt | Germany | 860 |
| 5 | Lukas | Weber | Germany | 550 |
| 7 | Lea | Fischer | Germany | 680 |

**1.3 Score Between 400 and 750**
| CustomerID | FirstName | LastName | Country | Score |
|---|---|---|---|---|
| 1 | Ayla | Karimova | Azerbaijan | 720 |
| 2 | John | Miller | USA | 450 |
| 5 | Lukas | Weber | Germany | 550 |
| 6 | Noah | Adams | USA | 610 |
| 7 | Lea | Fischer | Germany | 680 |
| 8 | Sofia | Rossi | Italy | 700 |

**1.4 FirstName Starts with 'A' or LastName Ends with 'i'**
| CustomerID | FirstName | LastName | Country | Score |
|---|---|---|---|---|
| 1 | Ayla | Karimova | Azerbaijan | 720 |
| 8 | Sofia | Rossi | Italy | 700 |
| 9 | Ali | Hasanov | Azerbaijan | 330 |

**1.5 Distinct Countries**
| Country |
|---|
| Azerbaijan |
| France |
| Germany |
| Italy |
| USA |

**1.6 Countries with >= 2 Customers**
| Country | CustomerCount |
|---|---|
| Azerbaijan | 2 |
| Germany | 3 |
| USA | 2 |

**1.7 All Customers with Orders (LEFT JOIN)** — *25 rows total (all 24 orders plus CustomerID 9 with `NULL` OrderID and Sales).*

**1.8 Customers with Zero Orders**
| CustomerID | FirstName | LastName | Country | Score |
|---|---|---|---|---|
| 9 | Ali | Hasanov | Azerbaijan | 330 |

**Written Explanation (Scenario 1):**
A customer with no orders (`Ali Hasanov`, `CustomerID = 9`) appears in `Customers` but has no matching row in `Orders` (`o.OrderID IS NULL`), so an `INNER JOIN` excludes him whereas a `LEFT JOIN` preserves him with `NULL` order fields. By contrast, a customer who fails a campaign filter (such as `Sara Martin`, `Score = 280`, or `John Miller`, `Country = 'USA'`) may still have existing orders in `Orders`, but is excluded directly by the `WHERE` predicate because their attribute values do not satisfy the campaign criteria.

---

### Scenario 2: Product Catalog & Inventory Maintenance

**2.1 Sorted by Category ASC, Price DESC**
| ProductID | Product | Category | Price |
|---|---|---|---|
| 103 | Laptop | Electronics | 850.00 |
| 105 | Smart Phone | Electronics | 420.00 |
| 101 | Wireless Mouse | Electronics | 55.00 |
| 107 | USB Hub | Electronics | 45.00 |
| 106 | Standing Desk | Furniture | 380.00 |
| 102 | Office Chair | Furniture | 230.00 |
| 108 | Desk Lamp | Furniture | 65.00 |
| 104 | Notebook | Stationery | 12.00 |

**2.2 Electronics or Furniture Priced 50–450**
| ProductID | Product | Category | Price |
|---|---|---|---|
| 101 | Wireless Mouse | Electronics | 55.00 |
| 102 | Office Chair | Furniture | 230.00 |
| 105 | Smart Phone | Electronics | 420.00 |
| 106 | Standing Desk | Furniture | 380.00 |
| 108 | Desk Lamp | Furniture | 65.00 |

**2.3 Contains 'Desk' or 'Mouse'**
| ProductID | Product | Category | Price |
|---|---|---|---|
| 101 | Wireless Mouse | Electronics | 55.00 |
| 106 | Standing Desk | Furniture | 380.00 |
| 108 | Desk Lamp | Furniture | 65.00 |

**2.4 Summary per Category**
| Category | ProductCount | TotalPrice | AveragePrice |
|---|---|---|---|
| Electronics | 4 | 1370.00 | 342.50 |
| Furniture | 3 | 675.00 | 225.00 |
| Stationery | 1 | 12.00 | 12.00 |

**2.5–2.7 Practice Copy Operations (`SalesDB_Practice`):** Added nullable `StockQuantity` column, inserted `ProductID = 109` (`Wireless Keyboard`, Price `75.00`, Stock `30`), and updated `ProductID = 101` (Price `60.00`, Stock `50`) and `ProductID = 102` (Stock `15`).

---

### Scenario 3: Order Fulfillment & Data Cleanup

**3.2 Pending or Cancelled Orders**
| OrderID | CustomerID | ProductID | OrderStatus | OrderDate | Sales |
|---|---|---|---|---|---|
| 203 | 2 | 102 | Pending | 2026-10-12 | 230.00 |
| 208 | 4 | 101 | Pending | 2026-10-23 | 110.00 |
| 210 | 6 | 103 | Cancelled | 2026-10-25 | 1700.00 |
| 212 | 3 | 105 | Pending | 2026-10-27 | 840.00 |
| 215 | 5 | 106 | Pending | 2026-10-30 | 380.00 |
| 218 | 6 | 105 | Pending | 2026-11-04 | 420.00 |
| 224 | 3 | 101 | Pending | 2026-11-02 | 110.00 |

**3.4 NULL ShipDate or ShipAddress**
| OrderID | OrderStatus | OrderDate | ShipDate | ShipAddress |
|---|---|---|---|---|
| 203 | Pending | 2026-10-12 | NULL | NULL |
| 208 | Pending | 2026-10-23 | NULL | NULL |
| 210 | Cancelled | 2026-10-25 | NULL | 31 Oak St, Boston |
| 212 | Pending | 2026-10-27 | NULL | NULL |
| 215 | Pending | 2026-10-30 | NULL | 16 Park Rd, Munich |
| 218 | Pending | 2026-11-04 | NULL | 31 Oak St, Boston |
| 221 | Shipped | 2026-10-28 | NULL | 31 Oak St, Boston |
| 224 | Pending | 2026-11-02 | NULL | 22 Oak St, Berlin |

**3.5 ShipAddress Differs from BillAddress**
| OrderID | ShipAddress | BillAddress |
|---|---|---|
| 203 | NULL | 45 Main St, New York |
| 206 | 45 Main St, New York | 9 Pine St, Boston |
| 208 | NULL | 8 Rue Lyon, Paris |
| 212 | NULL | 22 Oak St, Berlin |
| 218 | 31 Oak St, Boston | NULL |

**3.6 Audit Anomalies**
| OrderID | OrderDate | ShipDate | OrderStatus |
|---|---|---|---|
| 221 | 2026-10-28 | NULL | Shipped |
| 222 | 2026-10-31 | 2026-10-30 | Shipped |

**3.7 Statuses with >= 3 Orders**
| OrderStatus | OrderCount | TotalSales |
|---|---|---|
| Delivered | 11 | 11755.00 |
| Pending | 7 | 2320.00 |
| Shipped | 5 | 2310.00 |

**3.8–3.10 Practice Copy Cleanup (`SalesDB_Practice`):** Inserted test orders `301`, `302`, `303`; updated `302` address to `'45 Main Street, Baku'`; deleted `303`; and deleted remaining `'Old St%'` rows (`301`, `302`), leaving 0 test orders.
---

### Scenario 4: Sales Performance & Employee Analytics

**4.3 Salary Summary per Department**
| Department | MinSalary | MaxSalary | AvgSalary | TotalSalary |
|---|---|---|---|---|
| Sales | 2000.00 | 2400.00 | 2175.00 | 8700.00 |
| Support | 1900.00 | 1900.00 | 1900.00 | 1900.00 |

**4.4 Employee – Manager Hierarchy (Self-Join)**
| EmployeeID | EmployeeFirstName | EmployeeLastName | ManagerFirstName | ManagerLastName |
|---|---|---|---|---|
| 12 | Maya | Brown | NULL | NULL |
| 11 | David | Lee | Maya | Brown |
| 13 | Alex | Green | Maya | Brown |
| 14 | Omar | Ali | Maya | Brown |
| 15 | Nina | Stone | Maya | Brown |

**4.6 Employees with Zero Orders**
| EmployeeID | FirstName | LastName | Department |
|---|---|---|---|
| 13 | Alex | Green | Support |
| 15 | Nina | Stone | Sales |

**4.7 Salesperson Performance Summary**
| EmployeeID | FirstName | LastName | OrderCount | TotalSales |
|---|---|---|---|---|
| 12 | Maya | Brown | 7 | 10240.00 |
| 14 | Omar | Ali | 6 | 4125.00 |
| 11 | David | Lee | 11 | 2720.00 |
| 13 | Alex | Green | 0 | 0.00 |
| 15 | Nina | Stone | 0 | 0.00 |

**4.10 Revenue & Quantity by Category**
| Category | TotalQuantity | TotalRevenue |
|---|---|---|
| Electronics | 27 | 14635.00 |
| Furniture | 10 | 2270.00 |
| Stationery | 15 | 180.00 |

**4.11 Revenue by Country (> 1000)**
| Country | TotalRevenue |
|---|---|
| Germany | 8980.00 |
| USA | 5060.00 |
| France | 1190.00 |

---

### Scenario 5: Executive Reporting & Cross-Entity KPIs

**5.1 Overall Order KPIs**
| TotalOrders | TotalQuantity | TotalSales | AverageSales | MinSales | MaxSales |
|---|---|---|---|---|---|
| 24 | 52 | 17085.00 | 711.88 | 45.00 | 6800.00 |

**5.5 Top 5 Highest-Value Orders**
| OrderID | OrderDate | CustomerName | Product | SalesPersonName | Sales |
|---|---|---|---|---|---|
| 205 | 2026-10-20 | Emma Schmidt | Laptop | Maya Brown | 6800.00 |
| 210 | 2026-10-25 | Noah Adams | Laptop | Omar Ali | 1700.00 |
| 206 | 2026-10-21 | John Miller | Smart Phone | David Lee | 1260.00 |
| 207 | 2026-10-22 | Noah Adams | Office Chair | Omar Ali | 920.00 |
| 202 | 2026-10-08 | Emma Schmidt | Laptop | Maya Brown | 850.00 |

**5.7 Never-Ordered Products**
| ProductID | Product | Category | Price |
|---|---|---|---|
| 108 | Desk Lamp | Furniture | 65.00 |

**5.8 Pricing Discrepancies (`Sales <> Price * Quantity`)**
*0 rows returned — all 24 orders match `Price * Quantity` accurately.*

**5.12 Customers with Delivered Revenue >= 1000**
| CustomerID | FirstName | LastName | Country | DeliveredRevenue |
|---|---|---|---|---|
| 3 | Emma | Schmidt | Germany | 6800.00 |
| 2 | John | Miller | USA | 1550.00 |
---

### Scenario 6: Multi-Table Audit & Exception Reporting

**6.3 Active Orders Missing ShipDate (`ShipDate IS NULL AND OrderStatus <> 'Cancelled'`)**
| OrderID | OrderDate | ShipDate | OrderStatus | CustomerName | Sales |
|---|---|---|---|---|---|
| 203 | 2026-10-12 | NULL | Pending | John Miller | 230.00 |
| 208 | 2026-10-23 | NULL | Pending | Sara Martin | 110.00 |
| 212 | 2026-10-27 | NULL | Pending | Emma Schmidt | 840.00 |
| 215 | 2026-10-30 | NULL | Pending | Lukas Weber | 380.00 |
| 218 | 2026-11-04 | NULL | Pending | Noah Adams | 420.00 |
| 221 | 2026-10-28 | NULL | Shipped | Noah Adams | 45.00 |
| 224 | 2026-11-02 | NULL | Pending | Emma Schmidt | 110.00 |

**6.4 Chronological Date Anomaly (`ShipDate < OrderDate`)**
| OrderID | OrderDate | ShipDate | OrderStatus | CustomerName | SalesPersonName |
|---|---|---|---|---|---|
| 222 | 2026-10-31 | 2026-10-30 | Shipped | Sara Martin | David Lee |

**6.5 Address Mismatches & NULL Addresses**
| OrderID | CustomerName | ShipAddress | BillAddress |
|---|---|---|---|
| 203 | John Miller | NULL | 45 Main St, New York |
| 206 | John Miller | 45 Main St, New York | 9 Pine St, Boston |
| 208 | Sara Martin | NULL | 8 Rue Lyon, Paris |
| 212 | Emma Schmidt | NULL | 22 Oak St, Berlin |
| 218 | Noah Adams | 31 Oak St, Boston | NULL |

**6.6 – 6.8 Unreferenced Master Entities (`LEFT JOIN ... WHERE NULL`)**
* **Unordered Customer:** `CustomerID = 9` (`Ali Hasanov`, Azerbaijan)
* **Unordered Product:** `ProductID = 108` (`Desk Lamp`, Furniture)
* **Employees with Zero Orders:** `EmployeeID = 13` (`Alex Green`, Support) and `EmployeeID = 15` (`Nina Stone`, Sales)

**6.10 High-Activity Category–Country Combinations (`>= 2 Orders OR TotalSales >= 1500`)**
| Category | Country | OrderCount | TotalSales |
|---|---|---|---|
| Electronics | Germany | 5 | 8600.00 |
| Electronics | USA | 4 | 3140.00 |
| Furniture | Germany | 2 | 610.00 |
| Furniture | USA | 3 | 1380.00 |

**Written Audit Summary (Scenario 6):**
1. **Fulfillment & Date Integrity Issues:** Seven non-cancelled orders lack a `ShipDate`, including `OrderID = 221` which is already marked `Shipped` without a recorded shipping date. Additionally, `OrderID = 222` shows `ShipDate = 2026-10-30` preceding `OrderDate = 2026-10-31`, indicating a data entry error.
2. **Address Completeness Issues:** Five orders (`203`, `206`, `208`, `212`, `218`) have mismatched or incomplete (`NULL`) shipping/billing addresses that require verification before dispatch or invoicing.
3. **Unengaged Entities:** One customer (`Ali Hasanov`), one catalog product (`Desk Lamp`), and two employees (`Alex Green` in Support and `Nina Stone` in Sales) have zero associated order records.
---

## Part III: Relational Database Design & ERD Diagrams

### Project A: Online Course Platform
* **Diagram File:** `erd/Project_A_Online_Course_ERD.png`
* **Key Entities (8 Tables):** `Students`, `Instructors`, `Courses`, `Modules`, `Lessons`, `Enrollments`, `Payments`, `Reviews`
* **Relationships & Cardinality:**
  * `Instructors (1) ──< (N) Courses`: One instructor teaches many courses.
  * `Courses (1) ──< (N) Modules (1) ──< (N) Lessons`: Hierarchical curriculum structure.
  * `Students (M) ──< Enrollments >── (N) Courses`: Associative bridge table resolving the many-to-many enrollment relationship (`StudentID + CourseID`).
  * `Enrollments (1) ──── (1) Payments`: Each enrollment has a corresponding payment record.
  * `Students (1) ──< (N) Reviews >── (1) Courses`: Students submit ratings and reviews for courses.
* **Normalization (3NF):** Instructor details (`Specialty`, `Email`) are separated from `Courses`, and student profile data is separated from `Enrollments`, eliminating partial and transitive dependencies.

### Project B: Hospital Outpatient Appointment System
* **Diagram File:** `erd/Project_B_Hospital_ERD.png`
* **Key Entities (9 Tables):** `Departments`, `Doctors`, `Patients`, `Appointments`, `Consultations`, `Prescriptions`, `Medications`, `Prescription_Items`, `Billing`
* **Relationships & Cardinality:**
  * `Departments (1) ──< (N) Doctors`: Each doctor belongs to one medical department.
  * `Patients (1) ──< (N) Appointments >── (1) Doctors`: Resolves the many-to-many scheduling relationship between patients and doctors.
  * `Appointments (1) ──── (1) Consultations` and `Appointments (1) ──── (1) Billing`: Each completed appointment produces one clinical consultation record and one billing invoice.
  * `Consultations (1) ──< (N) Prescriptions` and `Prescriptions (M) ──< Prescription_Items >── (N) Medications`: Junction table `Prescription_Items` normalizes multi-drug prescriptions with per-item dosage, frequency, and duration.
* **Normalization (3NF):** Medication catalog attributes (`MedicationName`, `DosageForm`) are isolated in `Medications` rather than repeated across prescription lines, ensuring full 3NF compliance.