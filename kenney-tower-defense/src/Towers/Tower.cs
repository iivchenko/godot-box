using Godot;
using System.Collections.Generic;
using System.Linq;

public class Tower : Node2D
{
	private Node2D _base;
	private Node2D _tower;
	private Area2D _trigger;
	private Node2D _firePoint;

	private PackedScene _bullet;

	private IList<Enemy> _enemies = new List<Enemy>();
	private float _reloadElapsed; 

	[Export]
	public int Radius { get; set; } = 100;

	[Export]
	public float ReloadTime { get; set; } = 5;
	
	public override void _Ready()
	{
		base._Ready();

		_base = GetNode<Sprite>("Base");
		_tower = GetNode<Node2D>("Tower");
		_trigger = GetNode<Area2D>("Trigger");
		_firePoint = GetNode<Node2D>("Tower/FirePoint");

		_bullet = ResourceLoader.Load<PackedScene>("res://src/Projectiles/Bullet.tscn");

		_reloadElapsed = 0;
		_trigger.AddChild(CreateReadiusArea(_trigger.Position, Radius));

		_trigger.Connect("body_entered", this, nameof(OnTriggerAdd));
		_trigger.Connect("body_exited", this, nameof(OnTriggerRemove));
	}

	public override void _Process(float delta)
	{
		base._Process(delta);

		switch (_enemies.FirstOrDefault())
		{
			case var enemy when enemy is null:
				break;

			case var enemy:
				_tower.LookAt(enemy.GlobalPosition);
				if (_reloadElapsed <= 0)
				{
					_reloadElapsed = ReloadTime;
					
					var bullet = (Projectile)_bullet.Instance();
					bullet._Init(enemy);
					bullet.GlobalPosition = _firePoint.GlobalPosition;

					GetParent().AddChild(bullet);
				}
				break;
		}

		if (_reloadElapsed > 0)
		{
			_reloadElapsed -= delta;
		}
	}

	public override void _Draw()
	{
		base._Draw();

		DrawCircle(Vector2.Zero, Radius, new Color(1.0f, 1.0f, 0.0f, 0.15f));
	}

	private CollisionShape2D CreateReadiusArea(Vector2 position, int radius)
	{
		var area = new CollisionShape2D();
		area.Position = position;
		var circle = new CircleShape2D();
		circle.Radius = radius;
		area.Shape = circle;

		return area;
	}

	private void OnTriggerAdd(Enemy enemy)
	{
		_enemies.Add(enemy);
	}

	private void OnTriggerRemove(Enemy enemy)
	{
		_enemies.Remove(enemy);
	}
}
