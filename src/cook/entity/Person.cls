Import cook.entity

/// Name:	cook.entity.Person
/// Desc:	Person类 [Cache技术学习Demo]
/// Author:	Skyler Cook
/// Date:	2019-10-09
Class cook.entity.Person Extends %Persistent [ SqlTableName = T_Person ]
{

// define indices for this class

/// Define a unique index for <property>IdNumber</property>.
Index IdNumberIndex On IdNumber [ Type = index, Unique ];

/// Define an index for <property>Name</property>. Type = index [default]
/// 使用Data，属性的值将会存储在索引中，可以直接获取 [^cook.entity.PersonI("NameIndex"," 吴广义",1)=$lb("","吴广义")]
/// 缺省的话，属性值将不会被存储在索引中 [^cook.entity.PersonI("IdNumberIndex"," 451024198105013804",2)=""]
/// DHC基本不用，了解即可
Index NameIndex On Name [ Data = Name, Type = index ];

// define properties for this class

/// person's id number
Property IdNumber As %String [ Required, SqlColumnNumber = 2, SqlFieldName = Id_Number ];

/// person's name.
Property Name As %String [ Required, SqlColumnNumber = 3 ];

/// person's sex. This is a reference to another persistent object.
/// Others: 根据身份证号获取性别的方法已经写在了下面[GetSexDRByIdNumber()]，在本Demo中的就不在使用Calculated了
Property SexDR As User.CTSex [ Required, SqlColumnNumber = 4, SqlFieldName = Sex_DR ];

/// person's age. This is a calculated field whose value is derived from <property>Dob</property>.
Property Age As %Integer [ Calculated, SqlColumnNumber = 5, SqlComputeCode = {s {Age} = ##class(cook.entity.Person).CurrentAge({Dob})}, SqlComputed, SqlComputeOnChange = Dob ];

/// person's date of birthday.
/// SqlComputeCode大括号里面的大括号里的值指的是表中字段的名称
Property Dob As %Date [ Calculated, SqlColumnNumber = 6, SqlComputeCode = {s {Dob} = ##class(cook.entity.Person).GetDobByIdNumber({Id_Number})}, SqlComputed, SqlComputeOnChange = IdNumber ];

/// person's Married?
/// Others:	关于婚姻可以使用DR指向User.CTMarital表，在本Demo中,已经有了性别的指向，这里就不做展示
Property Married As %String(DISPLAYLIST = ",Yes,No", VALUELIST = ",Y,N") [ SqlColumnNumber = 7 ];

// define methods for this class

/// get person's age
Method GetAge()
{
	q $this.Age
}

/// print person's name
Method PrintPerson()
{
	w "Person Name: "_..Name,!
}

// define class methods for this class

/// This class method calculates a current age given a date of birth <var>date</var>.
/// Debug:	w ##class(cook.entity.Person).CurrentAge("42345")
/// Others:	[ API: $SELECT(expression:value,...) ],有多组时，从左往右依次执行，返回第一个表达式为真的值
/// Others: "/" 除	"\" 整除
ClassMethod CurrentAge(date As %Date = "") As %Integer [ CodeMode = expression ]
{
$Select(date="":"", 1:($zd($h,8) - $zd(date,8)\10000))
}

/// Desc:	get person's current age by id number
/// Debug:	w ##class(cook.entity.Person).CurrentAgeByIdNumber("610115199607252517")
ClassMethod CurrentAgeByIdNumber(IdNumber As %String = "") As %Integer
{
	q:IdNumber="" ""
	s CurrentAge = $zd($h,8) - $e(IdNumber, 7, 14) \ 10000
	q CurrentAge
}

/// Desc:	get person's date of birthday by Id Number
/// Debug:	w ##class(cook.entity.Person).GetDobByIdNumber("610115199607252517")
ClassMethod GetDobByIdNumber(IdNumber As %String = "") As %Date
{
	q:IdNumber="" ""
	; 610115199607252517
	s Date = $zdh($e(IdNumber, 7, 14), 8)
	q Date
}

/// Desc:	get person's sex by Id Number
/// Output:	1 男; 2 女; 3 未知性别 {对应[CT_Sex]表}
/// Debug:	w ##class(cook.entity.Person).GetSexDRByIdNumber("610115199607252517")
ClassMethod GetSexDRByIdNumber(IdNumber As %String = "") As %Date
{
	// [3]: the sex is unknow
	q:IdNumber="" 3
	s Sex = $e(IdNumber, 17)
	if (Sex#2 = 1) {
		q 1
	} else {
		q 2
	}
}

/// Invoke the <method>PrintPerson</method> on all <class>Person</class> objects within the database.
/// Debug:	d ##class(cook.entity.Person).PrintAllPerson()
ClassMethod PrintAllPerson()
{
	// use the extent result set to find all person
	s extent = ##class(%ResultSet).%New("cook.entity.Person:Extent")
	d extent.Execute()
	
	while (extent.Next()) {
		// "."代指cook.entity.Person
		s person = ..%OpenId(extent.GetData(1))
		d person.PrintPerson()
	}
	q
}

/// Prints out data on all persons within the database using SQL to iterate over all the person data.
/// Debug:	d ##class(cook.entity.Person).PrintAllPersonSQL()
ClassMethod PrintAllPersonSQL()
{
	// use dynamic SQL result ser to find person data
	s query = ##class(%ResultSet).%New("%DynamicQuery:SQL")
	d query.Prepare("SELECT Id_Number, Name FROM cook_entity.T_Person ORDER BY Name")
	d query.Execute()
	
	while (query.Next()) {
		// [?12] 右对齐12格，类似于`$Justify(expression, 12)`
		w "Name: ", query.Get("Name"), ?12 ,query.Get("Id_Number") ,!
	}
}

// define triggers for this class

/// this trigger is triggered the PersonLog after every insert
/// inheritance tables insert can not trigger the trigger
/// Others:	其他的触发器和这个雷同，就不再重复写了[^_^:其实就是懒]
Trigger TAfterIns [ Event = INSERT, Order = 1, Time = AFTER ]
{
	n PLPersonDR
	s PLPersonDR = {ID}
	s PLType = "C"
	s PLDate = +$h
	s PLTime = $p($h, ",", 2)
	&sql(
	INSERT INTO T_PersonLog (PL_Person_DR, PL_Type, PL_Date, PL_Time) VALUES (:PLPersonDR, :PLType, :PLDate, :PLTime)
	)
	// 调试代码的话，放开下面这行代码，但是请记得用完，把Global K掉
#;	s ^TEMPXKL("TAfterIns") = $lb(PLPersonDR, PLType, PLDate, PLTime, SQLCODE, %msg)

	// ?xkl 好像在Trigger中不能使用事务
	// the current error trap handler
#;	s $zt = "ErrorHandler"
#;	s $ze = ""
#;	
#;	n PLPersonDR
#;	s PLPersonDR = {ID}
#;	q:PLPersonDR=""
#;	s PLType = "C"
#;	s PLDate = +$h
#;	s PLTime = $p($h, ",", 2)
#;	TS
#;	s PersonLogObj = ##class(cook.entity.PersonLog).%New()
#;	if ($IsObject(PersonLogObj)) {
#;		s PersonLogObj.PLPersonDR = PLPersonDR
#;		s PersonLogObj.PLType = PLType
#;		s PersonLogObj.PLDate = PLDate
#;		s PersonLogObj.PLTime = PLTime
#;		s sc = PersonLogObj.%Save()
#;		if ($$$ISOK(sc)) {
#;			TC
#;		} else {
#;			TRO
#;		}
#;		d PersonLogObj.%Close()
#;	}
#;	
#;ErrorHandler
#;	TRO
#;	if ($ze '= "") {
#;		q $ze
#;	}
}

Storage Default
{
<Data name="PersonDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IdNumber</Value>
</Value>
<Value name="3">
<Value>Name</Value>
</Value>
<Value name="4">
<Value>SexDR</Value>
</Value>
<Value name="5">
<Value>Dob</Value>
</Value>
<Value name="6">
<Value>Married</Value>
</Value>
</Data>
<DataLocation>^cook.entity.PersonD</DataLocation>
<DefaultData>PersonDefaultData</DefaultData>
<IdLocation>^cook.entity.PersonD</IdLocation>
<IndexLocation>^cook.entity.PersonI</IndexLocation>
<StreamLocation>^cook.entity.PersonS</StreamLocation>
<Type>%Library.CacheStorage</Type>
}

}
