CPATH='.:../lib/hamcrest-core-1.3.jar:../lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'
 
file=`ls student-submission/ListExamples.java`
echo $file
if [[ -f $file ]]
then
    echo "File found."
else 
    echo "Incorrect file submitted."
    exit 1
fi

cp student-submission/* grading-area 
cp TestListExamples.java grading-area

cd grading-area

javac -cp $CPATH ListExamples.java TestListExamples.java

if [[ $? -eq 0 ]]
then 
    echo "Compiled correctly."
    java -cp $CPATH org.junit.runner.JUnitCore TestListExamples >JUnitOutput.txt 2>&1
else 
    echo "Failed to compile."
    exit 1
fi 

if [ grep "OK" JUnitOutput.txt ]
then 
    echo "All tests passed: 100%"
else 
    echo "Tests failed: Incomplete"
    exit 1
fi

# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests
