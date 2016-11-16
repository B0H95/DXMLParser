module b0h.xml.node;

import b0h.xml.attributelist;

class XMLNode
{
public:
	this(string name, XMLAttributeList attrlist, XMLNode prev, bool isterminating)
	{
		this.name = name;
		this.attrlist = attrlist;
		innernodes = new XMLNode[0];
		this.prev = prev;
		terminating = isterminating;
		textcontent = "";
	}

	string ToString(string indent)
	{
		string returnstr;
		returnstr ~= indent ~ "<" ~ name ~ " ";
		if (attrlist !is null)
		{
			returnstr ~= attrlist.ToString();
		}
		if (terminating)
		{
			returnstr ~= "/";
		}
		returnstr ~= ">\n";

		for (ulong i = 0; i < innernodes.length; ++i)
		{
			returnstr ~= innernodes[i].ToString(indent ~ "  "); 
		}

		if (!terminating)
		{
			returnstr ~= indent ~ "</" ~ name ~ ">\n";
		}

		return returnstr;
	}

	bool AddNode(XMLNode node)
	{
		innernodes[innernodes.length++] = node;
		return true;
	}

	XMLNode GetPrevious()
	{
		return prev;
	}

	void AddText(string textc)
	{
		textcontent ~= textc;
	}

private:
	string name;
	XMLAttributeList attrlist;
	XMLNode[] innernodes;
	XMLNode prev;
	bool terminating;
	string textcontent;
}