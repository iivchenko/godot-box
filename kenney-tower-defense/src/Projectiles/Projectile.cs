using Godot;

public class Projectile : Area2D
{
	private Node2D _target;

	private bool _done = false;

	[Export]
	public int Damage { get; set; } = 10;

	[Export]
	public int Speed { get; set; } = 300;

	public void _Init(Node2D target)
	{
		_target = target;
	}

	public override void _Ready()
	{
		base._Ready();

		Connect("body_entered", this, nameof(OnTarget));
	}

	public override void _Process(float delta)
	{
		if (IsInstanceValid(_target))
		{
			var distance = _target.GlobalPosition - GlobalPosition;
			var direction = distance.Normalized();

			GlobalPosition += direction * Speed * delta;
		}
		else
		{
			QueueFree();
		}
	}

	private void OnTarget(Node2D body)
	{
		if (!_done)
		{
			_done = true;

			QueueFree();
		}
	}
}
