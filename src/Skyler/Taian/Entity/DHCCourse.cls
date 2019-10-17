/// Name:	Skyler.Taian.Entity.DHCCourse
/// Desc:	使用 [default storage] 建课程表
/// Author:	Skyler Cook
/// Date:	2019-09-26
Class Skyler.Taian.Entity.DHCCourse Extends %Persistent [ SqlTableName = DHC_Course ]
{

// define indices for this class

/// define a unique index for <property>DHCCrsNo</property>
Index IndexDHCCrsNo On DHCCrsNo [ Unique ];

/// define an index for <property>DHCCrsName</property>
Index IndexDHCCrsName On DHCCrsName;

// define properties for this class

/// 课程编号
Property DHCCrsNo As %String [ Required, SqlColumnNumber = 2, SqlFieldName = DHC_CrsNo ];

/// 课程名称
Property DHCCrsName As %String [ Required, SqlColumnNumber = 3, SqlFieldName = DHC_CrsName ];

/// 课时
Property DHCCrsHours As %Integer [ SqlColumnNumber = 4, SqlFieldName = DHC_CrsHours ];

Storage Default
{
<Data name="DHCCourseDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>DHCCrsNo</Value>
</Value>
<Value name="3">
<Value>DHCCrsName</Value>
</Value>
<Value name="4">
<Value>DHCCrsHours</Value>
</Value>
</Data>
<DataLocation>^Skyler.Taian.Entity.DHCCourseD</DataLocation>
<DefaultData>DHCCourseDefaultData</DefaultData>
<IdLocation>^Skyler.Taian.Entity.DHCCourseD</IdLocation>
<IndexLocation>^Skyler.Taian.Entity.DHCCourseI</IndexLocation>
<StreamLocation>^Skyler.Taian.Entity.DHCCourseS</StreamLocation>
<Type>%Library.CacheStorage</Type>
}

}
