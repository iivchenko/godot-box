using Godot;
using System;
using System.Collections.Generic;
using System.Linq;

public sealed class Enemy : KinematicBody2D, IDamagable
{
	private int _maxLife;
	private int _life;

	private Stack<Vector2> _path = new Stack<Vector2>();
	private Vector2 _next;

	public Enemy()
	{
		_maxLife = 100;
		_life = _maxLife;
	}

	[Export]
	public int Speed { get; set; } = 100;

	[Export]
	public int MaxLife
	{
		get => _maxLife;

		set
		{
			if (value < 1)
			{
				throw new InvalidOperationException("Life can't be less then 1 hit point!");
			}

			_life = (_life / _maxLife) * value;
			_maxLife = value;
		}
	}

	public int Life { get => _life; }

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

	public void ApplyDamage(int damage)
	{
		_life = Math.Max(0, _life - damage);

		if (_life == 0 && !IsQueuedForDeletion())
		{
			QueueFree();
		}
	}
}
