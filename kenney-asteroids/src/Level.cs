using Godot;

public sealed class Level : Node2D
{
	private Vector2 _screenSize;
	private int _buffer = 10;

	public override void _Ready()
	{
		base._Ready();

		var viewport = GetViewport();

		_screenSize = viewport.Size;

		viewport.Connect("size_changed", this, nameof(OnSizeChanged));
	}

	public override void _Process(float delta)
	{
		base._Process(delta);

		foreach(Node2D child in GetChildren())
		{
			var x = Mathf.Wrap(child.Position.x, -_buffer, _screenSize.x + _buffer);
			var y = Mathf.Wrap(child.Position.y, -_buffer, _screenSize.y + _buffer);
			
			child.Position = new Vector2(x, y);
		}
	}

	private void OnSizeChanged()
	{
		_screenSize = GetViewport().Size;
	}
}
