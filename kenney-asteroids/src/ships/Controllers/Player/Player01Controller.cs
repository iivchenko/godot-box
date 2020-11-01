using Godot;
using System;

public class Player01Controller : Node
{
    private Ship _ship;

    public override void _Ready()
    {
        base._Ready();

        _ship = GetParent<Ship>();
    }
    public override void _Process(float delta)
    {
        base._Process(delta);

        if (Input.IsActionPressed("player_01_thrust"))
        {
            _ship.Thrust(delta);
        }

        if (Input.IsActionPressed("player_01_turn_left"))
        {
            _ship.TurnLeft(delta);
        }

        if (Input.IsActionPressed("player_01_turn_right"))
        {
            _ship.TurnRight(delta);
        }
    }
}
