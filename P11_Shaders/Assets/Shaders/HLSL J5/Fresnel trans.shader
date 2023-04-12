Shader "Learning/Unlit/Fresneltra"
{
	Properties
	{
		// Fresnel Exponent : float entre 0.1 & 20
		_FresnelExpo("Fresnel Exponent", Range(0.1,20)) = 0.5

		// 2 couleurs : une BaseColor (celle du mesh) et une pour l'effet outline du fresnel 
		_BaseColor("Base Color", Color) = (0.34, 0.85, 0.92, 0) // color
		_OutlineColor("Outline Color", Color) = (0.34, 0.85, 0.92, 0) // color

	}
		SubShader
	{
		Tags { "RenderType" = "Transparent" "Queue" = "Transparent" }

		Blend SrcAlpha OneMinusSrcAlpha
		ZWrite Off

		Pass
		{
			HLSLPROGRAM
			#pragma vertex vert  
			#pragma fragment frag

			#include "UnityCG.cginc"
			float _FresnelExpo;
			float4 _BaseColor, _OutlineColor;
			// Variables du bloc Properties

			struct vertexInput
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;

				// + 
				// Transf�rer la position & la normale en WORLD SPACE
				float3 worldPos : TEXCOORD0;
				float3 worldNormal : TEXCOORD1; // world normal output
			};

			v2f vert(vertexInput v)
			{
				v2f o;

				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);

				// TO DO 
				// position en float4 => w = 1
				// direction en float4 => w = 0
				// matrice: unity_ObjectToWorld
				o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				// la normale en worldspace de la struct v2f doit �tre normalis�e
				o.worldNormal = normalize(mul(unity_ObjectToWorld, float4(v.normal, 0.0)).xyz);

				return o;
			}

			 float4 frag(v2f i) : SV_Target
			 {
				 // TO DO: Une ligne � coder apr�s chaque commentaire
				 // Calculer le vecteur FragmentToCamera puis le normaliser
				 float3 FragToCam = normalize(_WorldSpaceCameraPos.xyz - i.worldPos);

				 // Normaliser de nouveau la normale de la struct v2f
				 float3 normal = normalize(i.worldNormal);
				 // Calcul du produit scalaire entre le vecteur PixelToCamera (View vector) & la normale
				 float NdotV = dot(normal, FragToCam);
				 // Visualiser le r�sultat de NdotV  => ligne temporaire, juste pour comprendre l'effet � cette �tape
				 float4 temp = float4(1.0 - NdotV, NdotV, 0.0, 1.0);
				 // "Ajuster" le r�sultat obtenu
				 //????
				 // Utiliser la fonction pow(valueToRaise, FresnelExponent)
				 float rim = pow(NdotV, _FresnelExpo);
				 // lerp entre BaseColor, FresnelColor et le rim calcul� ci-dessus.
				 return lerp(_OutlineColor, _BaseColor, rim);


			 }
			 ENDHLSL
		 }
	}
}