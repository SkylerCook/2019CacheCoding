/// Name:	Skyler.Taian.Model.DHCStudentCourse
/// Desc:	选课表 (学生表的子表) [SqlStorage]
/// Author:	Skyler Cook
/// Date:	2019-09-26
Class Skyler.Taian.Model.DHCStudentCourse Extends %Persistent [ SqlTableName = DHC_StudentCourse, StorageStrategy = SCStorage ]
{

/// define a parent relationship for this class
Relationship ParentStudent As Skyler.Taian.Model.DHCStudent [ Cardinality = parent, Inverse = ChildStudentCourse, SqlFieldName = Sc_ParRef ];

Index RowIDBasedIDKeyIndex On ScChildsub [ IdKey, PrimaryKey, Unique ];

// define properties for this class

Property ScChildsub As %Numeric(SCALE = 0) [ InitialExpression = {$i(^DHCSTUDENT($p($s($d(initvalue):initvalue,1:%d(0)),$c(1),1),"SC",0))}, SqlColumnNumber = 2, SqlFieldName = Sc_Childsub ];

/// 课程
Property ScCourseDR As Skyler.Taian.Model.DHCCourse [ Required, SqlColumnNumber = 3, SqlFieldName = Sc_Couese_DR ];

/// 分数
Property ScScore As %Integer [ SqlColumnNumber = 4, SqlFieldName = Sc_Score ];

Storage SCStorage
{
<SQLMap name="DataMap">
<Data name="Sc_Couese_DR">
<Delimiter>"^"</Delimiter>
<Piece>1</Piece>
</Data>
<Data name="Sc_Score">
<Delimiter>"^"</Delimiter>
<Piece>2</Piece>
</Data>
<Global>^DHCSTUDENT</Global>
<PopulationType>nonnull</PopulationType>
<RowIdSpec name="1">
<Expression>{L1}</Expression>
<Field>DHC_Student.St_RowID</Field>
</RowIdSpec>
<RowIdSpec name="2">
<Expression>{L3}</Expression>
<Field>Sc_Childsub</Field>
</RowIdSpec>
<Subscript name="1">
<Expression>{DHC_Student.St_RowID}</Expression>
<StartValue>1</StartValue>
</Subscript>
<Subscript name="2">
<Expression>"SC"</Expression>
</Subscript>
<Subscript name="3">
<Expression>{Sc_Childsub}</Expression>
<StartValue>1</StartValue>
</Subscript>
<Type>data</Type>
</SQLMap>
<SqlRowIdName>Sc_RowID</SqlRowIdName>
<StreamLocation>^Skyler.Tai5515.DHCStudentCC414S</StreamLocation>
<Type>%CacheSQLStorage</Type>
}

}
