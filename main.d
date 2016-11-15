import std.stdio;
import b0h.xml.lexer;

void main(string[] args)
{
	XMLLexer lexer = new XMLLexer();
	if (!lexer.LoadAndParseFile("testxml.xml"))
	{
		writeln("Could not find testxml.xml");
	}

	auto tokenqueue = lexer.GetTokenQueue();

	while (tokenqueue.Length > 0)
	{
		write(tokenqueue.Pull().ToString() ~ "|");
	}
	writeln("");
}