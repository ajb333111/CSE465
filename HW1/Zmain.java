import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

/**
 * 465 Program 1: Z+- Interpreter 
 * @author Alec Bird
 *
 */
public class Zmain {
	
	/**
	 * Checks if a string can be converted into an integer
	 * @param str the string
	 * @return true if so, false otherwise 
	 */
	private static boolean checkIfNum(String str) {
		try {
			int num = Integer.parseInt(str);
			// if string is a number
			return true;
			}
		catch (Exception NumberFormatExcpetion) {
			// if string is not a number (is a variable)
			return false;
		}
	}
	
	/**
	 * Performs number operations - add, subtract, and multiply 
	 * @param var the variable on the left side of the statement
	 * @param value the number on right side of the statement
	 * @param op the operator
	 * @param map the map of variables 
	 * @return true if no error, false otherwise
	 */
	public static boolean performNumOp(String var, String value, String op, Map<String, String> map) {
		
			int num = 0;
			int total = Integer.parseInt(map.get(var));
			
			// if right side in map, it's a variable, then check if it's set to a number
			if (checkIfNum(value)) {
				num = Integer.parseInt(value);
				if (op.equals("-=")) {
					total -= num; 
				} else if (op.equals("*=")) {
					total *= num; 
				} else {
					total += num; 
					}
				map.put(var, Integer.toString(total));
				// System.out.println(map.get(var));
				return true;

			} else if (map.containsKey(value) && checkIfNum(map.get(value))) {
				num = Integer.parseInt(map.get(value));
				if (op.equals("-=")) {
					total -= num; 
				} else if (op.equals("*=")) {
					total *= num; 
				} else {
					total += num; 
					}
				map.put(var, Integer.toString(total));
				// System.out.println(map.get(var));
				return true;
			} else {
				// System.out.println("Runtime error: ");
				return false;
				}
	}
	
	/**
	 * Performs string computations for string variables and string literals
	 * @param var the variable on the left side of the statement
	 * @param value the left side of the statement
	 * @param op the operation
	 * @param map the map of variables
	 * @return true if no error, false otherwise
	 */
	public static boolean performStrOp(String var, String value, String op, Map<String, String> map) {
		
		String str = map.get(var);
		// check if right var is a string variable 
		if (map.containsKey(value)){
			
			// check if varaible value is a string
			if (!checkIfNum(map.get(value))) {
				
				str += map.get(value);
				map.put(var, str);
				// System.out.println(map.get(var));
				return true;
			} else {					
				// System.out.println("Runtime error: ");
				return false;
			}
			
			// if right var not in the map, check if string
		} else if (!checkIfNum(value)){
			
			str += value;
			map.put(var, str);
			// System.out.println(map.get(var));
			return true;
			
			// if neither, runtime error
		} else {
			// System.out.println("Runtime error: ");
			return false;
		}
		
	}
	
	/**
	 * Checks if a string is a compound operator 
	 * @param op the compound operator 
	 * @return true if the string is, false otherwise
	 */
	public static boolean checkOp(String op) {
		if (op.equals("+=") || op.equals("-=") || op.equals("*=")) {
			return true;
		} else {
			return false;
		}
	}
	
	/**
	 * Checks assignment and compound assignment statements
	 * @param list list of parts of a statement
	 * @param first first part of a statement
	 * @param map map containing variables and their values 
	 * @return true if no runtime error, false otherwise
	 */
	public static boolean executeSimple(String [] list, String first, Map<String, String> map) {
		
		boolean print = true;
		if (list.length == 4 && list[3].equals(";")) {
			String op = list[1];
			String value = list[2];
			// check operator
			if (op.equals("=")) {
				// check if right string is a variable (in the map)
				if (map.containsKey(value)) {
					map.put(first, map.get(value));
					
					// if not a variable, check if number or string 
				} else if (checkIfNum(value) || (value.substring(0, 1).equals("\"") && value.substring(value.length()-1).equals("\""))) {
					map.put(first, value);
					
					// if none of the above, error
				} else {
					print = false;
				}
				
			} else if (map.containsKey(first) && checkOp(op)){
				// check if left var is number, string, or variable
				// if number	
				if (checkIfNum(map.get(first))) {
					
					print = performNumOp(first, value, op, map);
					
				
				} else if (op.equals("+=") && !checkIfNum(map.get(first))) {
					
					print = performStrOp(first, value, op, map);
					
				
				} else {
					// System.out.println("Runtime error: ");
					print = false;
				}
			} else {
				// System.out.println("Runtime error: ");

				print = false;
				}
		} else {
			// System.out.println("Runtime error: ");
			print = false;
		}
		return print;
	
	}
	// METHOD NOT IMPLEMENTED
	/**
	 * Excutes nested for loops (method is not called, does not work)
	 * @param map
	 * @param list
	 * @param numLoops
	 * @return
	 */
	public static boolean executeFor(Map<String, String> map, String [] list, int numLoops) {
		ArrayList<String> holder = new ArrayList<String>();

		int numElements = 0;
		int forCount = 0;
		// only in this method if last word in line is ENDFOR
		int endForCount = 1;
		boolean check = false, print = true;
		// check for more FOR loops
		for (int k = 0; k < list.length; k++) {
			
			if (list[k].equals("FOR")) {
				forCount++;
				holder.add(list[k]);
				k++;
				
			} else if (list[k].equals("ENDFOR")) {
				endForCount++;
				
			} else if (forCount == endForCount){
				holder.add(list[k]);
				numElements++;
			}
			
		}
		
		
			int subLength = list.length - (numElements+2);
			String [] sublist = new String[subLength];
			for (int a = 0; a < subLength; a++) {
				sublist[a] = list[numElements+2];
			}
		
		
		String [] calclist = new String [4];
		// execute current FOR loop 
		for (int i = 0; i < numLoops; i++) {

			for (int a = 0; a < holder.size(); a += 4) {
				if (holder.get(i).equals("FOR")) {
					// call method
					
				} else {
					// create array to be executed 
					for (int j = 0; j < calclist.length; j++) {
						calclist[j] = holder.get(a);
					}
					print = executeSimple(calclist, calclist[0], map);
					if (!print) {
						return print;
					}
				}
			}
		
		}
		return print;
	}

	/**
	 * Reads lines of a Z+/- program
	 * @param args the file to be read
	 * @throws FileNotFoundException
	 */
	public static void main(String[] args) throws FileNotFoundException {
		
		File file = new File(args[0]);
		Scanner scan = new Scanner(file);
		Map<String, String> map = new HashMap<String, String>();
		int counter = 0;
		boolean print = true;
		while(scan.hasNextLine()) {
			// read each line
			String line = scan.nextLine();
			String [] list = line.split(" ");
			counter++;
	
			String first = list[0];
			String last = list[list.length-1];
			// only works for non-nested for loop
			if (first.equals("FOR") && last.equals("ENDFOR")) {
				// check if string after FOR is a number
				if (checkIfNum(list[1])) {
					boolean check = true;
					int numTimes = Integer.parseInt(list[1]);
					// all elements between FOR and ENDFOR except numTimes
					int numElements = list.length - 3 ;

					// create sublist of 4 elements 
					String [] sublist = new String [4];
			
					// execute the loop the given amount of times unless there's a runtime time
					while (numTimes > 0 && print) {
						int start = 2;
						// assignment statements in loop should be length 4
						int numStatements = numElements / 4;
						while (numStatements > 0) {
							for (int i = 0; i < sublist.length; i++) {
								sublist[i] = list[start];
								start++;
							}
							print = executeSimple(sublist, sublist[0], map);
							numStatements--;
						}
						numTimes--;
					}
					
				} else {
					System.out.println("Runtime Error: ");
				}
				// if line is length 3, must be print statement
			} else if (list.length == 3 && first.equals("PRINT")) {
				String var = list[1];
				if (map.containsKey(var)) {
					if (checkIfNum(map.get(var))) {
						System.out.println(var + "=" + map.get(var));

					} else {
						System.out.println(var + "=" + map.get(var).replace("\"", ""));
					}
					
				} else {
					// System.out.println("Runtime error: ");
					print = false;
				}
				
				// if not for or print statement, assignment statement
			} else {
				print = executeSimple(list, first, map);
			}
			
			// if print = false, runtime error occurred 
			if (!print) {
				System.out.println("RUNTIME ERROR: line " + counter);
				break;
			}
			
			}
		}
	}
