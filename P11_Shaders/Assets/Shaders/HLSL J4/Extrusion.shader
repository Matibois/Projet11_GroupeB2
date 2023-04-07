Shader "Learning/Unlit/extru"
{
	Properties
	{
		_Amplitude ("Amplitude", float) = 1 
		_speed("speed", float) = 1 
		_noise("noise", 2D) = "white" {}

			// NOM_VARIABLE("NOM_AFFICHE_DANS_L'INSPECTOR", Shaderlab type) = defaultValue
	}

		SubShader
		{
			Tags { "RenderType" = "Opaque" }
			Tags { "RenderType" = "Opaque" "Queue" = "Geometry"}
			Pass
			{
				HLSLPROGRAM
				#pragma vertex vert
				#pragma fragment frag

				#include "UnityCG.cginc"
				
				float _speed;
				float _Amplitude;
				sampler2D _noise;

				struct vertexInput
				{
					float4 vertex : POSITION;
					float3 normal : NORMAL;
					float4 uv : TEXCOORD0;

				};

				struct v2f
				{
					float4 vertex : SV_POSITION;
					float2 uv : TEXCOORD0;
				};

				v2f vert(vertexInput v)
				{
					v2f o;
					v.uv.xy += float2(_Time.y * _speed, 0);
					v.vertex.xyz += v.normal * _Amplitude * tex2Dlod(_noise, v.uv).r;
					o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
					o.uv = v.uv.xy;
					return o;
				}

				float4 frag(v2f i) : SV_Target
				{
					return tex2D(_noise, i.uv);
				}

				ENDHLSL
			}
		}
}
