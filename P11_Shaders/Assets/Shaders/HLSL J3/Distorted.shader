Shader"Learning/Unlit/Distorted"
{
	Properties
	{
		_Texture0("Texture0", 2D) = "white" {}
		_NoiseTexture("Noise Texture", 2D) = "white" {}
		_Speed("Speed",Range(0, 5)) = 2
		_DisturbedFactor("Distortion Factor", Range(0, 0.2)) = 0.1
	}

		SubShader
		{
			Tags { "RenderType" = "Opaque" }

			Pass
			{
				HLSLPROGRAM
				#pragma vertex vert  
				#pragma fragment frag

	#include "UnityCG.cginc"
	sampler2D _Texture0, _NoiseTexture;
		float _Speed;
	float _DisturbedFactor;

	struct vertexInput
	{
		float4 vertex : POSITION;
		float2 uv : TEXCOORD0;

	};

	struct v2f
	{
		float4 vertex : SV_POSITION;
		float2 uv : TEXCOORD0;
	};

	v2f vert(vertexInput v)
	{
		v2f o;
		o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
		o.uv = v.uv;
		return o;
	}

		float4 frag(v2f i) : SV_Target
	{
			float2 offset = _Speed * _Time.x;

			float2 disturbedOffset = tex2D(_NoiseTexture, i.uv + offset).rg;

			disturbedOffset *= _DisturbedFactor;
		return tex2D(_Texture0, i.uv + disturbedOffset);
	}

				ENDHLSL
			}
		}
}
