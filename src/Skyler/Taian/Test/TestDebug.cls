Class Skyler.Taian.Test.TestDebug Extends %RegisteredObject [ ProcedureBlock ]
{

/// Author: Skyler Cook
/// Date:   20200425
/// Desc:   使用VSCode进行M语言的DEBUG测试
/// Table:  
/// Input:  InputParameter
/// Output: 
/// Debug:
/// Others:
ClassMethod DebugDemo(InputParameter As %String = "") As %Status
{
    If (InputParameter = "") {
        s InputParameter = "Hello world!"
    }
    s Version = $ZVersion
    s CurrentSpace = $ZNspace
    s CurrentJob = $Job
    w Version,!,CurrentSpace,!,CurrentJob
    w InputParameter
}

}
