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
    w Version,!,CurrentSpace,!,CurrentJob,!,CurrentDevice
    w InputParameter
    q InputParameter
}

}
