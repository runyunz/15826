import java.util.*;

public class test {
	
	public static void main(String[] args) {
		// String[] result = "this is a test".split("\\s");
		// for (int x=0; x<result.length; x++)
		// {
		// 	System.out.println(result[x]);
		// }

		List<String> a = new ArrayList<String>();
		StringBuffer sb = new StringBuffer();
		for(int i=0;i<5;i++){
			a.add(Integer.toString(i));
			sb.append(a.get(i));
			sb.append('+');
		}
		System.out.println(sb.substring(0,sb.length()-1));

		sb.delete(0, sb.length());

		for(int i=0;i<5-1;i++){
			a.set(i, a.get(i+1));
			sb.append(a.get(i));
			sb.append('+');
		}

		a.set(a.size()-1, Integer.toString(a.size()));
		sb.append(a.get(a.size()-1));

		System.out.println(sb.toString());
	}

}