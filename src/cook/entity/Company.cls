/// Name:	cook.entity.Company
/// Desc:	Company类 [Cache技术学习Demo]
/// Author:	Skyler Cook
/// Date:	2019-10-09
Class cook.entity.Company Extends %Persistent [ SqlRowIdName = CO_Id, SqlTableName = T_Company ]
{

// define indices for this class

/// define a unique index for <property>CoCode</property>
Index CodeIndex On COCode [ Unique ];

/// define an index for <property>CoName</property>
Index NameIndex On COName;

/// define an index for <property>CoAddress</property>
Index AddressIndex On COAddress;

// define properties for this class

/// company's code
Property COCode As %String [ Required, SqlFieldName = CO_Code ];

/// company's Name
Property COName As %String [ Required, SqlFieldName = CO_Name ];

/// company's Address
Property COAddress As User.CTAddress [ Required, SqlFieldName = CO_Address ];

/// count the number of company's Employees
Property CONumberOfEE As %Integer [ Calculated, SqlComputeCode = {s {CO_NumberOfEE} = ##class(cook.entity.Company).CountEmployeesByCOCode({CO_Code})}, SqlComputed, SqlComputeOnChange = COCode, SqlFieldName = CO_NumberOfEE ];

/// define relationship for this class [one to many]
Relationship COEmployees As cook.entity.Employee [ Cardinality = many, Inverse = EECompanyId ];

// define class methods for this class

/// Desc:	get the number of employees in a company by company code 
/// Debug: 	w ##class(cook.entity.Company).CountEmployeesByCOCode("0001")
ClassMethod CountEmployeesByCOCode(COCode As %String = "") As %Integer
{
 	q:COCode="" ""
 	// Tip: [default storage] 在索引中，作为变量的字符串前面会有一个空格
 	s COCode = " "_COCode
 	s Count = 0
 	s COId = 0
 	for {
 		s COId = $o(^cook.entity.CompanyI("CodeIndex",COCode,COId))
 		q:COId=""
 		s EEId = 0
 		for {
	 		// 最好不要使用Index进行数据的统计，因为有时候可能因为某些原因导致统计的结果并不准确
	 		// 继承表使用父表的Global
	 		s EEId = $o(^cook.entity.PersonI("CompanyIndex", COId, EEId))
	 		q:EEId=""
			s Count = Count + 1
 		}
 	}
 	q Count
}

Storage Default
{
<Data name="CompanyDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>COCode</Value>
</Value>
<Value name="3">
<Value>COName</Value>
</Value>
<Value name="4">
<Value>COAddress</Value>
</Value>
</Data>
<DataLocation>^cook.entity.CompanyD</DataLocation>
<DefaultData>CompanyDefaultData</DefaultData>
<IdLocation>^cook.entity.CompanyD</IdLocation>
<IndexLocation>^cook.entity.CompanyI</IndexLocation>
<StreamLocation>^cook.entity.CompanyS</StreamLocation>
<Type>%Library.CacheStorage</Type>
}

}
