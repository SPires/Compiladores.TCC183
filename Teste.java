import java_cup.runtime.*;
import java.io.*;

public class Teste{
	public static void main (String args[]) throws Exception{
		new Parser(new Yylex(new FileReader(new File("exemplo.lua")))).parse();
	}
}