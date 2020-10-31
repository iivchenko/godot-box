#if TOOLS
using Godot;
using Godot.Collections;

public class CustomResourcePlugin : EditorImportPlugin
{
    public override string GetImporterName()
    {
        return "demos.sillymaterial";
    }

    public override string GetVisibleName()
    {
        return "Silly Material";
    }

    public override Array GetRecognizedExtensions()
    {
        var array = new Array();
        array.Add("mtxt");
        return array;
    }

    public override string GetSaveExtension()
    {
        return "material";
    }

    public override string GetResourceType()
    {
        return "SpatialMaterial";
    }
}
#endif