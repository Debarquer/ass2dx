struct VS_OUT
{
	float4 Pos : POSITION;
	float2 Tex : TEXCOORD;
	float3 normal : NORMAL;
};

Texture2D txDiffuse : register(t0);
SamplerState sampAni;

float4 PS_main(VS_OUT input) : SV_Target
{
	float4 s = txDiffuse.Sample(sampAni, input.Tex);

	float3 norNormal = normalize(input.normal);
	float3 norLightPos = normalize(float3(0.0, 0.0, -3.0) - input.Pos);

	float angle = max(dot(norLightPos, norNormal), 0.0);

	if(s.w < 0.2)
		discard;

	return s * angle + s * 0.1;
	//return float4(1.0, 0.0, 0.0, 1.0);
};