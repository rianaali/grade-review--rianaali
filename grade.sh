
#DETECTING OS (source: https://gist.github.com/3080525.git):
UNAME=$(uname)

if [[ "$UNAME" == CYGWIN* || "$UNAME" == MINGW* ]] ; then
	CPATH='.;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar'
else
        CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'
fi

rm -rf student-submission
git clone $1 student-submission
echo 'Finished cloning'


cd student-submission

if [[ -f ListExamples.java ]]
then
        echo "ListExamples.java found"
else
        echo "ListExamples.java is missing"
        exit 1
fi

cd ..

cp student-submission/ListExamples.java ./
set +e # set +e turn auto-exit off
javac -cp $CPATH *.java 2>compile.txt

if [[ $? -eq 0 ]]
then
        echo "Files compiled"
else
        echo "Compilation error"
        cat compile.txt
        exit 1
fi

java -cp $CPATH org.junit.runner.JUnitCore TestListExamples 2>results.txt
cat results.txt
