using Godot;
using System;

public class Ship : KinematicBody2D
{
	private Vector2 _direction = Vector2.Up;
	private Vector2 _velocity;

	[Export]
	public int MaxSpeed { get; set; } = 400;

	[Export]
	public int Acceleration { get; set; } = 20;
	
	[Export]
	public int RotationSpeed { get; set; } = 5;

	public void Thrust(float delta)
	{
		var accelration = _direction * Acceleration;
		
		_velocity.x = Mathf.Clamp(_velocity.x + accelration.x, Vector2.One.x * -MaxSpeed, Vector2.One.x * MaxSpeed);
		_velocity.y = Mathf.Clamp(_velocity.y + accelration.y, Vector2.One.y * -MaxSpeed, Vector2.One.y * MaxSpeed);
	}

	public void TurnLeft(float delta)
	{
		Rotation -= RotationSpeed * delta;

		_direction = new Vector2(Mathf.Sin(Rotation), Mathf.Cos(Rotation));
	}

	public void TurnRight(float delta)
	{
		Rotation += RotationSpeed * delta;

		_direction = new Vector2(Mathf.Sin(Rotation), -Mathf.Cos(Rotation));
	}

	public override void _PhysicsProcess(float delta)
	{
		base._PhysicsProcess(delta);

		MoveAndSlide(_velocity);
	}
}
