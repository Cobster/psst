#
# TEST
#
Task Test ``
    -description "This runs the Pester unit tests." ``
    -requiredVariables TestDir, TestResults, ModuleName, TestFailureMessage ``
{
    Import-Module Pester

    try {
        `$TestResult = Invoke-Pester -Script `$TestDir -OutputFormat NUnitXml -OutputFile `$ReleaseDir\`$TestResults  -PassThru -Verbose:`$VerbosePreference
        Assert (`$TestResult.FailedCount -eq 0) `$TestFailureMessage
    }
    finally {
        Pop-Location
        Remove-Module `$ModuleName 
    }
}