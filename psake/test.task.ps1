#
# TEST
#
Task 'test' `
    -description "This runs the Pester unit tests." `
    -requiredVariables TestDir, TestResults, ModuleName `
{
    Import-Module Pester
    $TestFailureMessage = "One or more tests failed, build will not continue."

    try {
        $TestResult = Invoke-Pester -Script $TestDir -OutputFormat NUnitXml -OutputFile $ReleaseDir\$TestResults  -PassThru -Verbose:$VerbosePreference
        Assert ($TestResult.FailedCount -eq 0) $TestFailureMessage
    }
    finally {
        Pop-Location
        Remove-Module $ModuleName -ErrorAction SilentlyContinue
    }
}