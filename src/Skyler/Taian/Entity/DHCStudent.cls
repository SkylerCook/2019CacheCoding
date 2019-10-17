/// Name:	Skyler.Taian.Entity.DHCStudent
/// Desc:	学生表 (Default Storage)
/// Author:	Skyler Cook
/// Date:	2019-09-24
Class Skyler.Taian.Entity.DHCStudent Extends %Persistent [ SqlTableName = DHC_Student ]
{

/// define a children relationship for this class
Relationship ChildStudentCourse As Skyler.Taian.Entity.DHCStudentCourse [ Cardinality = children, Inverse = ParentStudent ];

// define indices for this class (在索引中，纯数字的字符串前面会有一个空格)

/// Define a unique index for <property>DHCCode</property>.
Index DHCCodeIndex On DHCCode [ Unique ];

/// Define a unique index for <property>DHCName</property>.
Index DHCNameIndex On DHCName [ Unique ];

/// Define an index for for <property>DHCSexDR</property>.
Index DHCSexCodeIndex On (DHCSexDR, DHCCode);

// define properties for this class

/// 学号
Property DHCCode As %String [ Required, SqlColumnNumber = 2, SqlFieldName = DHC_Code ];

/// 姓名
Property DHCName As %String [ Required, SqlColumnNumber = 3, SqlFieldName = DHC_Name ];

/// 年龄
/// This is a calculated field whose value is derived from <property>DHC_Dob</property>.
Property DHCAge As %Integer [ Calculated, SqlColumnNumber = 4, SqlComputeCode = {s {DHC_Age} = ##class(Skyler.Taian.Entity.DHCStudent).CurrentAge({DHC_Dob})}, SqlComputed, SqlComputeOnChange = DHCDob, SqlFieldName = DHC_Age ];

/// 性别
/// This is a reference to another persistent object.
Property DHCSexDR As User.CTSex [ SqlColumnNumber = 5, SqlFieldName = DHC_Sex_DR ];

/// 生日
Property DHCDob As %Date [ SqlColumnNumber = 6, SqlFieldName = DHC_Dob ];

/// 是否
Property DHCActive As %String(DISPLAYLIST = ",Yes,No", VALUELIST = ",Y,N") [ SqlColumnNumber = 7, SqlFieldName = DHC_Active ];

/// This class method calculates a current age given a date of birth <var>date</var>.
ClassMethod CurrentAge(date As %Date = "") As %Integer [ CodeMode = expression ]
{
$Select(date="":"", 1:($zd($h,8) - $zd(date,8)\10000))
}

Storage Default
{
<Data name="DHCStudentDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>DHCCode</Value>
</Value>
<Value name="3">
<Value>DHCName</Value>
</Value>
<Value name="4">
<Value>DHCSexDR</Value>
</Value>
<Value name="5">
<Value>DHCDob</Value>
</Value>
<Value name="6">
<Value>DHCActive</Value>
</Value>
</Data>
<DataLocation>^Skyler.Taian.En66A7.DHCStudentD</DataLocation>
<DefaultData>DHCStudentDefaultData</DefaultData>
<IdLocation>^Skyler.Taian.En66A7.DHCStudentD</IdLocation>
<IndexLocation>^Skyler.Taian.En66A7.DHCStudentI</IndexLocation>
<StreamLocation>^Skyler.Taian.En66A7.DHCStudentS</StreamLocation>
<Type>%Library.CacheStorage</Type>
}

}
