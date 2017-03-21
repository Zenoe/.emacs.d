
(setenv "Framework35Version" "v3.5")
(setenv "CommonProgramFiles" "C:\\Program Files\\Common Files")
(setenv "INCLUDE"
        (concat
         "C:\\Program Files (x86)\\Microsoft Visual Studio 10.0\\VC\\INCLUDE;"
         "C:\\Program Files (x86)\\Microsoft Visual Studio 10.0\\VC\\ATLMFC\\INCLUDE;"
         "C:\\Program Files (x86)\\Microsoft SDKs\\Windows\\v7.0A\\include;"))

(setenv "Path"
        (concat
         "C:\\Program Files (x86)\\Microsoft Visual Studio 10.0\\VSTSDB\\Deploy;"
         "C:\\Program Files (x86)\\Microsoft Visual Studio 10.0\\Common7\\IDE\\;"
         "C:\\Program Files (x86)\\Microsoft Visual Studio 10.0\\VC\\BIN\\\x86_amd64;"
         "C:\\Program Files (x86)\\Microsoft Visual Studio 10.0\\Common7\\Tools;"
         "C:\\Program Files (x86)\\Microsoft Visual Studio 10.0\\VC\\VCPackages;"
         "C:\\Program Files (x86)\\HTML Help Workshop;"
         (getenv "Path")))

(setenv "PROCESSOR_ARCHITECTURE" "AMD64")
(setenv "ProgramFiles" "C:\\Program Files")

(setenv "VCINSTALLDIR"
        "C:\\Program Files (x86)\\Microsoft Visual Studio 10.0\\VC\\")

(setenv "VSINSTALLDIR"
        "C:\\Program Files (x86)\\Microsoft Visual Studio 10.0\\")

(setenv "WindowsSdkDir"
        "C:\\Program Files (x86)\\Microsoft SDKs\\Windows\\v7.0A\\")