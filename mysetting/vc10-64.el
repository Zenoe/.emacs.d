
(load-file "~/.emacs.d/mysetting/vc10env.el")
;; (setenv "FrameworkDir" "C:\\Windows\\Microsoft.NET\\Framework\\")
(setenv "FrameworkDIR64" "C:\\Windows\\Microsoft.NET\\Framework64\\")
;; (setenv "FrameworkVersion" "v4.0.30319")
(setenv "FrameworkVersion64" "v4.0.30319")

(setenv "LIB"
        (concat
         "C:\\Program Files (x86)\\Microsoft Visual Studio 10.0\\VC\\LIB\\amd64;"
         "C:\\Program Files (x86)\\Microsoft Visual Studio 10.0\\VC\\ATLMFC\\LIB\\amd64;"
         "C:\\Program Files (x86)\\Microsoft SDKs\\Windows\\v7.0A\\lib\\x64;"))

(setenv "LIBPATH"
        (concat
         "C:\\Windows\\Microsoft.NET\\Framework64\\v4.0.30319;"
         "C:\\Windows\\Microsoft.NET\\Framework64\\v3.5;"
         "C:\\Program Files (x86)\\Microsoft Visual Studio 10.0\\VC\\LIB\\amd64;"
         "C:\\Program Files (x86)\\Microsoft Visual Studio 10.0\\VC\\ATLMFC\\LIB\\amd64;"))

(setenv "Path"
        (concat
         "C:\\Windows\\Microsoft.NET\\Framework64\\v4.0.30319;"
         "C:\\Windows\\Microsoft.NET\\Framework64\\v3.5;"
         "C:\\Program Files (x86)\\Microsoft SDKs\\Windows\\v7.0A\\bin\\NETFX 4.0 Tools\\x64;"
         "C:\\Program Files (x86)\\Microsoft SDKs\\Windows\\v7.0A\\bin\\x64;"
         (getenv "Path")))
