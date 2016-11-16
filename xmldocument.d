module b0h.xml.document;

import b0h.xml.attributelist;
import b0h.xml.node;

class XMLDocument
{
public:
    this()
    {
	root = new XMLNode("root", null, null, false);
	currentnode = root;
    }

    void OnStartTag(string name, XMLAttributeList params, bool isterminating)
    {
	XMLNode newnode = new XMLNode(name, params, currentnode, isterminating);
	currentnode.AddNode(newnode);
	if (!isterminating)
	{
	    currentnode = newnode;
	}
		
    }

    void OnEndTag(string name)
    {
	if (currentnode.GetPrevious() !is null)
	{
	    currentnode = currentnode.GetPrevious();
	}
    }

    void OnText(string text)
    {
	currentnode.AddText(text);
    }

    string ToString()
    {
	return root.ToString("");
    }

private:
    XMLNode root;
    XMLNode currentnode;
}
