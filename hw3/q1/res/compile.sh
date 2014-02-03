#!/bin/bash

function buildJar {
        rm -rf $1_classes/
        mkdir $1_classes
        javac -classpath ../hadoop-core-1.2.1.jar -d $1_classes/ $1.java
        jar -cf $1.jar -C $1_classes/ .
        rm -rf $1_classes/
}

buildJar $1
# buildJar WordCount
# buildJar NGram
