import std.stdio;
import b0h.xml.documentbuilder;
import b0h.xml.document;

void main(string[] args)
{
    XMLDocumentBuilder builder = new XMLDocumentBuilder();
    XMLDocument xmldoc = builder.Build("testxml.xml");
    writeln(xmldoc.ToString());

    auto node = xmldoc.GetRoot();
    auto nodelist = node.SearchChilds("DataItem");
    for (ulong i = 0; i < nodelist.length; ++i)
    {
	writeln(nodelist[i].GetName());
	writeln(nodelist[i].GetAttribute("name"));
	writeln(nodelist[i].GetAttribute("type"));
    }
}
