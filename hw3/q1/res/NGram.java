//package org.myorg;
import java.io.IOException;
import java.util.*;

import org.apache.hadoop.fs.Path;
import org.apache.hadoop.conf.*;
import org.apache.hadoop.io.*;
import org.apache.hadoop.mapred.*;
import org.apache.hadoop.util.*;

public class NGram extends Configured implements Tool{

	public static class Map extends MapReduceBase implements Mapper<LongWritable, Text, Text, IntWritable> {
		private final static IntWritable one = new IntWritable(1);
		private Text word = new Text();
		private int n = 0;

		public void configure(JobConf job) {
			n = Integer.parseInt(job.get("ngram.n"));
			// m = Integer.parseInt(job.get("ngram.m"));
		}

		public void map(LongWritable key, Text value, OutputCollector<Text, IntWritable> output, Reporter reporter) throws IOException {
			String line = value.toString();
			StringTokenizer tokenizer = new StringTokenizer(line);

			List<String> sList = new ArrayList<String>();
			StringBuffer sb = new StringBuffer();	

			if (tokenizer.countTokens() >= n) {
				for (int i = 0; i < n; ++i) {
					sList.add(tokenizer.nextToken());
					sb.append(sList.get(i));
					sb.append("+");
				}
				word.set(sb.substring(0,sb.length()-1));
				output.collect(word, one);
			
				while (tokenizer.hasMoreTokens()) {
					sb.delete(0, sb.length());
					
					for(int i = 0; i < n-1; ++i){
						sList.set(i, sList.get(i+1));
						sb.append(sList.get(i));
						sb.append("+");
					}

					sList.set(sList.size()-1, tokenizer.nextToken());
					sb.append(sList.get(sList.size()-1));
					
					word.set(sb.toString());
					output.collect(word, one);
				}	
			}
		}	
	}

	public static class Reduce extends MapReduceBase implements Reducer<Text, IntWritable, Text, IntWritable> {
		private int m = 0;
		
		public void configure(JobConf job) {
			// n = Integer.parseInt(job.get("ngram.n"));
			m = Integer.parseInt(job.get("ngram.m"));
		}

		public void reduce(Text key, Iterator<IntWritable> values, OutputCollector<Text, IntWritable> output, Reporter reporter) throws IOException {
			int sum = 0;
			while (values.hasNext()) {
				sum += values.next().get();
			}
			if (sum >= m) {
				output.collect(key, new IntWritable(sum));
			}
		}
	}

	public int run(String[] args) throws Exception {
		JobConf conf = new JobConf(getConf(), NGram.class);
		conf.setJobName("ngram");

		conf.setOutputKeyClass(Text.class);
		conf.setOutputValueClass(IntWritable.class);

		conf.setMapperClass(Map.class);
		//conf.setCombinerClass(Reduce.class);
		conf.setReducerClass(Reduce.class);

		conf.setInputFormat(TextInputFormat.class);
		conf.setOutputFormat(TextOutputFormat.class);

		FileInputFormat.setInputPaths(conf, new Path(args[0]));
		FileOutputFormat.setOutputPath(conf, new Path(args[1]));

		//conf.set("ngram.n", "2");
		//conf.set("ngram.m", "100");

		JobClient.runJob(conf);
		return 0;
	}

	public static void main(String[] args) throws Exception {
		int res = ToolRunner.run(new Configuration(), new NGram(), args);
		System.exit(res);
	}
}
