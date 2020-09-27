using Godot;
using System.Collections.Generic;

public enum EnemyType
{
	RegularSoldier
}

public class Level : Node2D
{
	private static IDictionary<EnemyType, PackedScene> _enemyFactory;

	private Timer _timer;
	private Position2D _spawner;
	private Position2D _targer;
	private Node _enemies;
	private Navigation2D _navigagtion;

	static Level()
	{
		_enemyFactory = new Dictionary<EnemyType, PackedScene> 
		{
			{ EnemyType.RegularSoldier, (PackedScene)ResourceLoader.Load("res://src/Enemies/RegularSoldier.tscn") }
		};
	}

	[Export]
	public string LevelName { get; set; } = "Dummy Level";

	public override void _Ready()
	{
		base._Ready();

		_timer = GetNode<Timer>("Game/Timer");
		_spawner = GetNode<Position2D>("Game/Spawner");
		_targer = GetNode<Position2D>("Game/Target");
		_enemies = GetNode<Node>("Game/Map");
		_navigagtion = GetNode<Navigation2D>("Game/Map/Navigation2D");

		_timer.Connect("timeout", this, nameof(OnSpawn));
	}

	private void OnSpawn()
	{
		var path = _navigagtion.GetSimplePath(_spawner.GlobalPosition, _targer.GlobalPosition, false);

		var enemy = (Enemy)_enemyFactory[EnemyType.RegularSoldier].Instance();

		enemy.GlobalPosition = _spawner.GlobalPosition;
		enemy._Init(path);

		_enemies.AddChild(enemy);
	}
}
