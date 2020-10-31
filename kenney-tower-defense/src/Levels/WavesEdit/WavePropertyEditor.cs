#if TOOLS
using Godot;

public sealed class WavePropertyEditor : EditorProperty
{
	private Button _button;
	private WaveConfigurationDialog _dialog;

	public WavePropertyEditor()
	{
		_button = new Button();
		_button.Text = "Configure";
		_button.Connect("pressed", this, nameof(OnClick));

		_dialog = new WaveConfigurationDialog();

		AddChild(_button);
		AddChild(_dialog);
	}

	private void OnClick()
	{
		_dialog.SetLevel(GetParent<Level>());
		_dialog.Popup_();
	}
}
#endif