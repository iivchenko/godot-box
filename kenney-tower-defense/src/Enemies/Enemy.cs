using Godot;
using System;
using System.Collections.Generic;
using System.Linq;

public class Enemy : KinematicBody2D
{
	private Stack<Vector2> _path;
	private Vector2 _next;

	[Export]
	public int Speed { get; set; } = 100;

	public void _Init(Vector2[] path)
	{
		_path = new Stack<Vector2>(path.Reverse());

		_path.Pop();

		if(_path.Count > 0)
		{
			_next = _path.Pop();
		}
		else
		{
			throw new InvalidOperationException("Path should contain more then 1 element!");
		}
	}

	public override void _Process(float delta)
	{
		var distance = _next - GlobalPosition;

		if (distance.Length() < 5)
		{
			if (_path.Count > 0)
			{
				_next = _path.Pop();
			}
			else
			{
				// FINISH
				MoveAndSlide(Vector2.Zero);
			}
		}
		else
		{
			LookAt(_next);

			var direction = distance.Normalized();
			MoveAndSlide(direction * Speed);
		}

		Update();
	}
}
