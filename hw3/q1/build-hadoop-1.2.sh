# This script sets up your system as follows:
# Hadoop is running with HDFS being hosted at a local directory
# .cshrc now contains the appropriate JAVA_HOME and HADOOP_PREFIX
# Bash scripts start-hadoop.sh and stop-hadoop.sh are created
# csh script setenv.csh is made
# hadoop-1.2.1/reddit_titles/ contains the data file (but still needs to be put on HDFS)
# hadoop-1.2.1/ngram/ contains example WordCount.java and bash script compile.sh to compile it

export HW_HADOOP_DIR=`pwd`

# THIS IS ONLY CORRECT FOR THE ANDREW MACHINES
export JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk-1.7.0.45.x86_64/jre
export HADOOP_VERSION=1.2.1

if [ ! -e ~/.cshrc ]
then
	touch ~/.cshrc
fi
echo "setenv JAVA_HOME $JAVA_HOME" >> ~/.cshrc

export MY_HADOOP_PORT=9000
export MY_HADOOP_PORT_JT=9001

# Check if ports available
portOpen=$(netstat -ano|grep 9000 |grep LISTEN | wc -l)
if [ $portOpen -ne 0 ]
then
	echo "Ports necessary to start Hadoop are not available on this machine."
	echo "Please try a different machine"
	exit
fi


echo "Downloading Hadoop"
wget http://supergsego.com/apache/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION-bin.tar.gz
tar -xzf hadoop-$HADOOP_VERSION-bin.tar.gz  

export HADOOP_HOME=$HW_HADOOP_DIR/hadoop-$HADOOP_VERSION
echo "setenv HADOOP_PREFIX $HADOOP_HOME" >> ~/.cshrc

touch setenv.csh
echo "setenv JAVA_HOME $JAVA_HOME" >> setenv.csh
echo "setenv HADOOP_PREFIX $HADOOP_HOME" >> setenv.csh

echo "cd $HADOOP_HOME

portOpen=\$(netstat -ano|grep 9000 |grep LISTEN | wc -l)
if [ \$portOpen -ne 0 ]
then
	echo \"Ports necessary to start Hadoop are not available on this machine.\"
	echo \"Please try a different machine\"
	exit
fi

sed -i '/^localhost/d' ~/.ssh/known_hosts
sed -i '/^0.0.0.0/d' ~/.ssh/known_hosts
bash bin/start-all.sh
" > start-hadoop.sh

echo "cd $HADOOP_HOME
sed -i '/^localhost/d' ~/.ssh/known_hosts
sed -i '/^0.0.0.0/d' ~/.ssh/known_hosts
bash bin/stop-all.sh
" > stop-hadoop.sh

cd $HADOOP_HOME

mkdir $HADOOP_HOME/tmp
mkdir $HADOOP_HOME/hdfs

# Make core-site.xml
echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<?xml-stylesheet type=\"text/xsl\" href=\"configuration.xsl\"?>

<configuration>
  <property>
    <name>hadoop.tmp.dir</name>
    <value>$HADOOP_HOME/tmp</value>
  </property>

  <property>
    <name>fs.default.name</name>
    <value>hdfs://localhost:$MY_HADOOP_PORT</value>
  </property>
</configuration>
" > $HADOOP_HOME/conf/core-site.xml


# Make mapred-site.xml
echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<?xml-stylesheet type=\"text/xsl\" href=\"configuration.xsl\"?>

<configuration>
  <property>
    <name>mapred.job.tracker</name>
    <value>localhost:$MY_HADOOP_PORT_JT</value>
  </property>
</configuration>
" > $HADOOP_HOME/conf/mapred-site.xml

# Make hdfs-site.xml
echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<?xml-stylesheet type=\"text/xsl\" href=\"configuration.xsl\"?>

<configuration>
    <property>
      <name>dfs.replication</name>
      <value>1</value>
    </property>
</configuration>
" > $HADOOP_HOME/conf/hdfs-site.xml

cd $HADOOP_HOME
bin/hadoop namenode -format

cd $HW_HADOOP_DIR
bash start-hadoop.sh


cd $HADOOP_HOME
mkdir -p reddit_titles/
cd reddit_titles/
wget http://cs.cmu.edu/~abeutel/reddit_titles.csv

cd $HADOOP_HOME
mkdir ngram
cd ngram
wget http://cs.cmu.edu/~abeutel/WordCount.java
wget http://cs.cmu.edu/~abeutel/compile.sh


echo ""
echo ""
echo "Make sure you run:"
echo "source setenv.csh"
echo "NOW!"
