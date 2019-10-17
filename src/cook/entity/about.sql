-- Calculated，InitialExpression 的属性字段不用插入

-- Select
SELECT * FROM cook_entity.T_Person;

SELECT * FROM cook_entity.T_PersonLog;

SELECT * FROM cook_entity.T_Employee;

SELECT * FROM cook_entity.T_Company;

-- Insert -- Tip: 插入的身份证号码请保持后12位的规范性，因为部分字段是通过身份证字段来计算的
INSERT INTO cook_entity.T_Employee 
(Id_Number, Name, Sex_DR, Married, EE_Code, EE_Company_Id, EE_Los, EE_Notes, EE_Picture, EE_Salary, EE_Title)
VALUES ("450924200103163479", "刘宏伟", "1", "N", "201907", 1, 1, "毕业于陕西职业技术学院", NULL, "3500", "实习生");