Class Skyler.Taian.Test.TestDebug Extends %RegisteredObject [ ProcedureBlock ]
{

/// Author: Skyler Cook
/// Date:   20200425
/// Desc:   使用VSCode进行M语言的DEBUG测试
/// Table:  
/// Input:  InputParameter
/// Output: 
/// Debug:  w ##class(Skyler.Taian.Test.TestDebug).DebugDemo()
/// Others:
ClassMethod DebugDemo(InputParameter As %String = "") As %String
{
    If (InputParameter = "") {
        s InputParameter = "Hello world!"
    }
    s Version = $ZVersion
    s CurrentSpace = $ZNspace
    s CurrentJob = $Job
    // s CurrentIP = $ZUTIL(67,15,$JOB)
    w Version,!,CurrentSpace,!,CurrentJob
    w InputParameter
    q InputParameter
}

/// w ##class(Skyler.Taian.Test.TestDebug).GetJosnObject()
ClassMethod GetJosnObject()
{
    s myquery = 2
    s myquery(1) = "SELECT JSON_OBJECT('id':DHC_RowId,'name':DHC_Name,'sex':DHC_Sex_DR,'birthDate':DHC_Dob) "
    s myquery(2) = "FROM SQLUSER.DHC_Student1"
    SET tStatement = ##class(%SQL.Statement).%New()
    SET qStatus = tStatement.%Prepare(.myquery)
    IF qStatus'=1 {
        WRITE "%Prepare failed",$System.Status.DisplayError(qStatus)
        QUIT
    }
    SET rset = tStatement.%Execute()
    while (rset.%Next()) {
        w rset.%GetData(1),!
    }
    // d rset.%Display()
    WRITE !,"Total row count=",rset.%ROWCOUNT,!
    QUIT
}

}
