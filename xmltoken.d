module b0h.xml.token;

import std.stdio;

class XMLToken
{
public:
	this(string str)
	{
		token = str;
	}

	string ToString()
	{
		return token;
	}

	bool IsValid()
	{
		return token != "";
	}

private:
	string token;
}