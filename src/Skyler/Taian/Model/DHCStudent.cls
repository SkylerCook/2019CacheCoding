/// Name:	Skyler.Taian.Model.DHCStudent
/// Desc:	学生表 [SqlStorage]
/// Author:	Skyler Cook
/// Date:	2019-09-24
Class Skyler.Taian.Model.DHCStudent Extends %Persistent [ SqlTableName = DHC_Student, StorageStrategy = StudentStorage ]
{

/// define a children relationship for this class
Relationship ChildStudentCourse As Skyler.Taian.Model.DHCStudentCourse [ Cardinality = children, Inverse = ParentStudent ];

// define indices for this class

/// Define a unique index for <property>StCode</property>
Index IndexCode On StCode [ Unique ];

// define properties for this class

/// 学号
Property StCode As %String [ Required, SqlColumnNumber = 2, SqlFieldName = St_Code ];

/// 姓名
Property StName As %String [ Required, SqlColumnNumber = 3, SqlFieldName = St_Name ];

/// 性别 
/// This is a reference to another persistent object.
Property StSexDR As User.CTSex [ SqlColumnNumber = 4, SqlFieldName = St_Sex_DR ];

/// 出生年月日
Property StDob As %Date [ SqlColumnNumber = 5, SqlFieldName = St_Dob ];

Storage StudentStorage
{
<SqlIdExpression>$i(^DHCSTUDENT)</SqlIdExpression>
<SQLMap name="DateMap">
<Data name="St_Code">
<Delimiter>"^"</Delimiter>
<Piece>1</Piece>
</Data>
<Data name="St_Dob">
<Delimiter>"^"</Delimiter>
<Piece>4</Piece>
</Data>
<Data name="St_Name">
<Delimiter>"^"</Delimiter>
<Piece>2</Piece>
</Data>
<Data name="St_Sex_DR">
<Delimiter>"^"</Delimiter>
<Piece>3</Piece>
</Data>
<Global>^DHCSTUDENT</Global>
<PopulationType>nonnull</PopulationType>
<RowIdSpec name="1">
<Expression>{L1}</Expression>
<Field>St_RowID</Field>
</RowIdSpec>
<Subscript name="1">
<Expression>{St_RowID}</Expression>
<StartValue>1</StartValue>
</Subscript>
<Type>data</Type>
</SQLMap>
<SQLMap name="IndexDob">
<Global>^DHCSTUDENTi</Global>
<PopulationType>nonnull</PopulationType>
<RowIdSpec name="1">
<Expression>{L4}</Expression>
<Field>St_RowID</Field>
</RowIdSpec>
<Subscript name="1">
<Expression>0</Expression>
</Subscript>
<Subscript name="2">
<Expression>"DOB"</Expression>
</Subscript>
<Subscript name="3">
<Expression>{St_Dob}</Expression>
</Subscript>
<Subscript name="4">
<Expression>{St_RowID}</Expression>
<StartValue>1</StartValue>
</Subscript>
<Type>index</Type>
</SQLMap>
<SQLMap name="IndexSex">
<Global>^DHCSTUDENTi</Global>
<RowIdSpec name="1">
<Expression>{L4}</Expression>
<Field>St_RowID</Field>
</RowIdSpec>
<Subscript name="1">
<Expression>0</Expression>
</Subscript>
<Subscript name="2">
<Expression>"SEX"</Expression>
</Subscript>
<Subscript name="3">
<Expression>{St_Sex_DR}</Expression>
<StartValue>1</StartValue>
</Subscript>
<Subscript name="4">
<Expression>{St_RowID}</Expression>
<StartValue>1</StartValue>
</Subscript>
<Type>index</Type>
</SQLMap>
<SqlRowIdName>St_RowID</SqlRowIdName>
<StreamLocation>^Skyler.Taian.Model.DHCStudentS</StreamLocation>
<Type>%CacheSQLStorage</Type>
}

}
