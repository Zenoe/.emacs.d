
(load-file "~/.emacs.d/mysetting/vc10env.el")
(setenv "DevEnvDir" "C:\\Program Files (x86)\\Microsoft Visual Studio 10.0\\Common7\\IDE\\")
(setenv "FrameworkDir" "C:\\Windows\\Microsoft.NET\\Framework\\")
(setenv "FrameworkVersion" "v4.0.30319")

(setenv "LIB"
        (concat
         "C:\\Program Files (x86)\\Microsoft Visual Studio 10.0\\VC\\LIB;"
         "C:\\Program Files (x86)\\Microsoft Visual Studio 10.0\\VC\\ATLMFC\\LIB;"
         "C:\\Program Files (x86)\\Microsoft SDKs\\Windows\\v7.0A\\lib;"))

(setenv "LIBPATH"
        (concat
         "C:\\Windows\\Microsoft.NET\\Framework\\v4.0.30319;"
         "C:\\Windows\\Microsoft.NET\\Framework\\v3.5;"
         "C:\\Program Files (x86)\\Microsoft Visual Studio 10.0\\VC\\LIB;"
         "C:\\Program Files (x86)\\Microsoft Visual Studio 10.0\\VC\\ATLMFC\\LIB;"))

(setenv "Path"
        (concat
         "C:\\Windows\\Microsoft.NET\\Framework\\v4.0.30319;"
         "C:\\Windows\\Microsoft.NET\\Framework\\v3.5;"
         "C:\\Program Files (x86)\\Microsoft SDKs\\Windows\\v7.0A\\bin\\NETFX 4.0 Tools;"
         "C:\\Program Files (x86)\\Microsoft SDKs\\Windows\\v7.0A\\bin;"
         (getenv "Path")))
