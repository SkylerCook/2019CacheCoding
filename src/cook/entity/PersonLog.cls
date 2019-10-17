/// Name:	cook.entity.PersonLog
/// Desc:	Person类的日志表 [Cache技术学习Demo]
/// Author:	Skyler Cook
/// Date:	2019-10-11
Class cook.entity.PersonLog Extends %Persistent [ SqlTableName = T_PersonLog ]
{

// desfine indices for this class

/// define a unique index for <property>PLCode</property>
Index CodeIndex On PLCode [ Unique ];

/// define an index for <property>PLType</property>
Index TypeIndex On PLType;

/// define an index for <property>PLDate</property>
Index DateIndex On PLDate;

// define properties for this class

/// log's code
Property PLCode As %String [ InitialExpression = {..GeneratePLCode()}, Required, SqlColumnNumber = 2, SqlFieldName = PL_Code ];

/// log's person id. This is a reference to another persistent object.
Property PLPersonDR As cook.entity.Person [ Required, SqlColumnNumber = 3, SqlFieldName = PL_Person_DR ];

/// log's type {,C,R,U,D}
Property PLType As %String(DISPLAYLIST = ",Create,Read,Update,Delete", VALUELIST = ",C,R,U,D") [ Required, SqlColumnNumber = 4, SqlFieldName = PL_Type ];

/// log's date
Property PLDate As %Date [ InitialExpression = {+$h}, SqlColumnNumber = 5, SqlFieldName = PL_Date ];

/// log's time
Property PLTime As %Time [ InitialExpression = {$p($h, ",", 2)}, SqlColumnNumber = 6, SqlFieldName = PL_Time ];

// define methods for this class

/// get person log code
Method GetPLCode()
{
	q $this.PLCode
}

// define class methods for this class

/// define generate the length of person's log code
Parameter LengthOfCode = 10;

/// Desc:	generate code of person's log
/// Debug:	w ##class(cook.entity.PersonLog).GeneratePLCode()
ClassMethod GeneratePLCode()
{
	s PLCode = ""
	s Ind = $i(^PersonLogInd)
	s LengthOfInd = $l(Ind)
	if (LengthOfInd < ..#LengthOfCode) {
		s LengthOfZero = ..#LengthOfCode - LengthOfInd
		for i=1:1:LengthOfZero {
			if (PLCode = "") {
				s PLCode = "0"_Ind
			} else {
				s PLCode = "0"_PLCode
			}
		}
	}
	q PLCode
}

Storage Default
{
<Data name="PersonLogDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>PLCode</Value>
</Value>
<Value name="3">
<Value>PLPersonDR</Value>
</Value>
<Value name="4">
<Value>PLType</Value>
</Value>
<Value name="5">
<Value>PLDate</Value>
</Value>
<Value name="6">
<Value>PLTime</Value>
</Value>
</Data>
<DataLocation>^cook.entity.PersonLogD</DataLocation>
<DefaultData>PersonLogDefaultData</DefaultData>
<IdLocation>^cook.entity.PersonLogD</IdLocation>
<IndexLocation>^cook.entity.PersonLogI</IndexLocation>
<StreamLocation>^cook.entity.PersonLogS</StreamLocation>
<Type>%Library.CacheStorage</Type>
}

}
