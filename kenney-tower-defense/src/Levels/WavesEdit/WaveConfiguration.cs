using System.Collections.Generic;

public sealed class WaveConfiguration
{
	public string Name { get; set; }

	public IEnumerable<SubWaveConfiguration> SubWaves { get; set; }
}
