import std.stdio;
import b0h.xml.lexer;
import b0h.xml.parser;

void main(string[] args)
{
	XMLLexer lexer = new XMLLexer();
	if (!lexer.LoadAndParseFile("testxml.xml"))
	{
		writeln("Could not find testxml.xml");
	}

	auto tokenqueue = lexer.GetTokenQueue();

	XMLParser parser = new XMLParser();
	parser.ParseTokenQueue(tokenqueue);

	auto elementqueue = parser.GetElementQueue();

	typeof(elementqueue.Pull()) element;
	while ((element = elementqueue.Pull()).IsValid())
	{
		write("#" ~ element.ToString() ~ "#");
	}
	writeln("");
}