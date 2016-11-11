@echo off
REM Please adjust the paths JFLEX_HOME and JAVA_HOME to suit your needs
REM (please do not add a trailing backslash)

set JFLEX_HOME=/home/procedure2012/Documents/sjtu/Complier/lab/javatools/jflex-1.4.1

REM only needed for JDK 1.1.x:
set JAVA_HOME=/usr/lib/jdk1.8.0_111


REM ------------------------------------------------------------------- 

set CLPATH=%JAVA_HOME%\lib\classes.zip;%JFLEX_HOME%\lib\JFlex.jar

REM for JDK 1.1.x
%JAVA_HOME%\bin\java -classpath %CLPATH% JFlex.Main %1 %2 %3 %4 %5 %6 %7 %8 %9

REM for JDK 1.2
rem java -Xmx128m -jar %JFLEX_HOME%\lib\JFlex.jar %1 %2 %3 %4 %5 %6 %7 %8 %9
