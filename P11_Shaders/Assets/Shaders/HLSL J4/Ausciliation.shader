Shader "Learning/Unlit/ausci"
{
	Properties
	{
		_Amplitude ("Amplitude", float) = 1 
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
				
				float2 _Speed;
				float _Amplitude;

				struct vertexInput
				{
					float4 vertex : POSITION;
					float2 uv : TEXCOORD1;

				};

				struct v2f
				{
					float4 vertex : SV_POSITION;
					float3 WorldPos: TEXCOORD0;
				};

				v2f vert(vertexInput v)
				{
					v2f o;
					//o.vertex += float4(cos(_Time.y) * _Amplitude, sin(_Time.y) * _Amplitude,0,0);
					o.vertex = mul(UNITY_MATRIX_MVP, v.vertex + float4(_Amplitude * cos(_Time.y), _Amplitude * sin(_Time.y), 0, 0));
					//o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
					o.WorldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
					
					return o;
				}

				float4 frag(v2f i) : SV_Target
				{
					float color = saturate(i.WorldPos.y);
					
					return float4(color, color, color, 1);
				}

				ENDHLSL
			}
		}
}
