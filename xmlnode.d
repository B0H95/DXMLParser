module b0h.xml.node;

import b0h.xml.attributelist;

import std.stdio;

class XMLNode
{
public:
    this()
    {
	this.name = "";
	this.attrlist = null;
	innernodes = new XMLNode[0];
	this.prev = null;
	terminating = false;
	textcontent = "";
	roottype = true;
    }

    this(string name, XMLAttributeList attrlist, XMLNode prev, bool isterminating)
    {
	this.name = name;
	this.attrlist = attrlist;
	innernodes = new XMLNode[0];
	this.prev = prev;
	terminating = isterminating;
	textcontent = "";
	roottype = false;
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

    void AddText(string textc)
    {
	textcontent ~= textc;
    }

    XMLNode GetParent()
    {
	if (prev.roottype)
	{
	    return null;
	}
	return prev;
    }

    XMLNode[] GetChilds()
    {
	return innernodes;
    }
    
    XMLNode GetRoot()
    {
	XMLNode node = this;
	while (node.GetParent() !is null)
	{
	    node = node.GetParent();
	}
	return node;
    }

    string GetName()
    {
	return name;
    }

    XMLNode SearchFirstChild(string childname)
    {
	XMLNode foundnode = null;
	for (ulong i = 0; i < innernodes.length; ++i)
	{
	    if (innernodes[i].GetName() == childname)
	    {
		return innernodes[i];
	    }
	    foundnode = innernodes[i].SearchFirstChild(childname);
	    if (foundnode !is null)
	    {
		return foundnode;
	    }
	}
	return null;
    }

    XMLNode[] SearchChilds(string childname)
    {
	XMLNode[] foundnodes = new XMLNode[0];
	for (ulong i = 0; i < innernodes.length; ++i)
	{
	    if (innernodes[i].GetName() == childname)
	    {
		foundnodes[foundnodes.length++] = innernodes[i];
	    }
	    foundnodes ~= innernodes[i].SearchChilds(childname);
	}
	return foundnodes;
    }

    string GetAttribute(string attrname)
    {
	return attrlist.GetAttribute(attrname);
    }

private:
    string name;
    XMLAttributeList attrlist;
    XMLNode[] innernodes;
    XMLNode prev;
    bool terminating;
    string textcontent;
    bool roottype;
}
