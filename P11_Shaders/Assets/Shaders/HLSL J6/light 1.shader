Shader "Learning/Unlit/light1"
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

            float4 _LightColor;
            float3 _WorldSpaceLightDir;

			struct vertexInput
            {
                float4 vertex : POSITION;	
                float3 normal : NORMAL;
            };
			
            struct v2f
            {
                float4 vertex : SV_POSITION;
                float3 worldSpaceNormal : TEXCOORD0;
            };

            v2f vert (vertexInput v)
            {
                v2f o;
	            o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
                o.worldSpaceNormal = normalize(mul(unity_ObjectToWorld, float4(v.normal, 0)).xyz);
                return o;
            }

            float4 frag(v2f i) : SV_Target
            {
                i.worldSpaceNormal = normalize(i.worldSpaceNormal);
                float NdotL = clamp(dot(i.worldSpaceNormal, -_worldSpaceLightDir)0.05,1);
                return NdotL; 
            }
            
            ENDHLSL
        }
    }
}
