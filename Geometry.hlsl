struct GS_IN
{
	float4 Pos : POSITION;
	float2 Tex: TEXCOORD;
};

struct GSOutput
{
	float4 pos : SV_POSITION;
	float2 Tex : TEXCOORD;
	float3 normal : NORMAL;
};

cbuffer VS_CONSTANT_BUFFER : register(b0)
{
	matrix world;
	matrix view;
	matrix projection;
};

[maxvertexcount(32)]
void main(triangle GS_IN input[3] : SV_POSITION, inout TriangleStream< GSOutput > output)
{
	//float3 a = input[0].Pos - input[1].Pos;
	//float3 b = input[0].Pos - input[2].Pos;
	float3 a = input[1].Pos - input[0].Pos;
	float3 b = input[2].Pos - input[0].Pos;
	float3 normal = normalize(cross(a, b));

	for (uint i = 0; i < 3; i++)
	{
		GSOutput element;
		element.pos = mul(projection, mul(view, mul(world, input[i].Pos)));
		element.Tex = input[i].Tex;
		element.normal = normal;
		output.Append(element);
	}

	output.RestartStrip();

	float4 normal4 = float4(normal, 0.0);
	for (uint i = 0; i < 3; i++)
	{
		GSOutput element;
		element.pos = mul(projection, mul(view, mul(world,input[i].Pos + normal4)));
		element.Tex = input[i].Tex;
		element.normal = normal;
		output.Append(element);
	}
}