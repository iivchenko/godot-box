using Godot;

[Tool]
public class MyButton : Button
{
	public override void _EnterTree()
	{
		Connect("pressed", this, "clicked");
	}

	public void clicked()
	{
		GD.Print("You clicked me!");
	}
}
