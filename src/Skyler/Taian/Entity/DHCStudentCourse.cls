/// Name:	Skyler.Taian.Entity.DHCStudentCourse
/// Desc:	使用 [Default Storage] 建学生表的子表
/// Author:	Skyler Cook
/// Date:	2019-09-26
Class Skyler.Taian.Entity.DHCStudentCourse Extends %Persistent [ SqlTableName = DHC_StudentCourse ]
{

/// define a parent relationship for this class
Relationship ParentStudent As Skyler.Taian.Entity.DHCStudent [ Cardinality = parent, Inverse = ChildStudentCourse ];

// define properties for this class

/// 课程 (This is a reference to another persistent object.)
Property DHCCourseDR As Skyler.Taian.Entity.DHCCourse [ Required, SqlFieldName = DHC_Course_DR ];

/// 分数
Property DHCScore As %Integer [ SqlFieldName = DHC_Score ];

Storage Default
{
<Data name="DHCStudentCourseDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>DHCCourseDR</Value>
</Value>
<Value name="3">
<Value>DHCScore</Value>
</Value>
</Data>
<DataLocation>{%%PARENT}("ChildStudentCourse")</DataLocation>
<DefaultData>DHCStudentCourseDefaultData</DefaultData>
<IdLocation>^Skyler.Taian.En66A7.DHCStudentC("ChildStudentCourse")</IdLocation>
<IndexLocation>^Skyler.Tai66A7.DHCStudentCC414I</IndexLocation>
<StreamLocation>^Skyler.Tai66A7.DHCStudentCC414S</StreamLocation>
<Type>%Library.CacheStorage</Type>
}

}
