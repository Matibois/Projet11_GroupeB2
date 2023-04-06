Shader "Learning/Unlit/VertexColor"
{
	Properties
	{
		// NOM_VARIABLE("NOM_AFFICHE_DANS_L'INSPECTOR", Shaderlab type) = defaultValue
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

			//Data pour chaque vertex
			struct vertexInput
			{
				float4 vertex : POSITION; //dans l'espace écran
				float4 vertexColors : COLOR;
			};

			// Vertex to Fragment = V2F
			struct v2f
			{
				float4 vertex : SV_POSITION; //dans l'espace objet
				float4 vertexColors : COLOR;

			};

			//Vertex Shaders, exucuté pour chaque vertex
			//tous les elem doivent être calculer dans le vertex shaders
			//toiutes ces variables seront interpolé par le rasterizer et reçu en entré du fragment shader
			v2f vert(vertexInput v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex); // Calcul de la position du Vertex dans l'espace écran
				o.vertexColors = v.vertexColors;
				return o;
			}

			float4 frag(v2f i) : SV_Target
			{
				return i.vertexColors;
			}

			ENDHLSL
		}
	}
}
