/// Name:	cook.entity.Employee
/// Desc:	Employee类，继承自Person类 [Cache技术学习Demo]
/// Author:	Skyler Cook
/// Date:	2019-10-09
Class cook.entity.Employee Extends Person [ SqlTableName = T_Employee ]
{

// define indices for this class

/// define a unique index for <property>EECode</property>
Index CodeIndex On EECode [ Unique ];

/// define an index for <property>EETitle</property>
Index TitleIndex On EETitle;

/// define an index for <property>EELos</property>
Index LosIndex On EELos;

/// define an index for <property>EECompany</property>
Index CompanyIndex On EECompanyId;

// define properties for this class

/// employee's code
Property EECode As %String [ Required, SqlFieldName = EE_Code ];

/// employee's title [Tip: 职位这里可以考虑建一个职位表，本Demo暂时不做涉猎]
Property EETitle As %String [ Required, SqlFieldName = EE_Title ];

/// employee's salary
Property EESalary As %Integer [ Required, SqlFieldName = EE_Salary ];

/// employee's length of service
Property EELos As %Integer [ Required, SqlFieldName = EE_Los ];

/// employee's notes 感觉和String没什么区别，存储与String好像不同，zw出来是数字
Property EENotes As %Stream.GlobalCharacter [ SqlFieldName = EE_Notes ];

/// employee's picture [just try]
Property EEPicture As %Stream.GlobalBinary [ SqlFieldName = EE_Picture ];

/// define relationship for this class as property [many to one]
Relationship EECompanyId As cook.entity.Company [ Cardinality = one, Inverse = COEmployees, SqlFieldName = EE_Company_Id ];

// define methods for this class

/// Overwrite cook.entity.Person's method - PrintPerson()
Method PrintPerson()
{
	w "Person Name: "_..Name,?20,"Title: "_..EETitle ,!
}

/// writes a .png file containing the picture, if any, 
/// of this employee the purpose of this method is to prove that Picture really contains an image
/// Desc:	其实就是修改员工照片的名称为"EmployeeName.png"
Method WritePicture()
{
	if (..EEPicture="") {quit}
	set name=$TR(..Name,".") ; strip off trailing period
	set name=$TR(name,", ","__") ; replace commas and spaces
	set filename=name_".png"
	
	set file=##class(%Stream.FileBinary).%New()
	set file.Filename=filename
	do file.CopyFrom(..EEPicture)
	do file.%Save()
	write !, "Generated file: "_filename
}

// define class methods for this class

/// Desc:	get the number of employees at a length of service
/// Debug:	w ##class(cook.entity.Employee).CountEENumberByEELos(1)
ClassMethod CountEENumberByEELos(EELos As %Integer = -1) As %Integer
{
	q:EELos=-1 ""
	s Count = 0
	s EEId = 0
	for {
		s EEId = $o(^cook.entity.PersonI("LosIndex",EELos,EEId))
		q:EEId=""
		s Count = Count + 1
	}
	q Count
}

Storage Default
{
<Data name="EmployeeDefaultData">
<Subscript>"Employee"</Subscript>
<Value name="1">
<Value>EECode</Value>
</Value>
<Value name="2">
<Value>EETitle</Value>
</Value>
<Value name="3">
<Value>EESalary</Value>
</Value>
<Value name="4">
<Value>EELos</Value>
</Value>
<Value name="5">
<Value>EEPicture</Value>
</Value>
<Value name="6">
<Value>EENotes</Value>
</Value>
<Value name="7">
<Value>EECompanyId</Value>
</Value>
</Data>
<DefaultData>EmployeeDefaultData</DefaultData>
<Type>%Library.CacheStorage</Type>
}

}
