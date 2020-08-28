Class DHCDoc.Common.MapIndex Extends %RegisteredObject
{

Property index As %Integer [ Private ];

Property list As %ListOfDataTypes [ Private ];

Property map [ MultiDimensional ];

Property map2 [ MultiDimensional, Private ];

Method %OnNew() As %Status [ Private ]
{
	s ..list=##Class(%Library.ListOfDataTypes).%New()
	s ..index=0
	Quit $$$OK
}

Method add(key)
{
	q:key=""
	if '$d(..map(key)){
		s ..index=..index+1
		//s $list(..list,..index)=key
		d ..list.InsertAt(key,..index)
		s ..map2(key)=..index
	}
}

Method index(key)
{
	q:key="" 0
	q ..map2(key)
}

Method get(index)
{
	q ..list.GetAt(index)
}

Method count()
{
	q ..index
}

}
