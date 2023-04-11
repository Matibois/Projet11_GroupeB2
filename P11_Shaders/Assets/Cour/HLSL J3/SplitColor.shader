Shader "Learning/Unlit/SplitColor"
{
    Properties
    {   
        _Color0("Positive x Color 1", Color) = (0.34, 0.85, 0.92, 1)
        _Color1("Positive x Color 2", Color) = (0.34, 0.85, 0.92, 1)
        // NOM_VARIABLE("NOM_AFFICHE_DANS_L'INSPECTOR", Shaderlab type) = defaultValue
    }
    
    SubShader
    {
        Tags { "RenderType"="Opaque" }

		Pass
        {
			HLSLPROGRAM
            #pragma vertex vert  
            #pragma fragment frag

            #include "UnityCG.cginc"

            float4 _Color0, _Color1;

			struct vertexInput
            {
                float4 vertex : POSITION;	

            };
			
            struct v2f
            {
                float4 vertex : SV_POSITION;    
                float3 worldPos : TEXCOORD0;

            };

            v2f vert (vertexInput v)
            {
                v2f o;
	            o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
                o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;

                return o;
            }

            float4 frag(v2f i) : SV_Target
            {
                return i.worldPos.x > 0 ?_Color0 : _Color1; 
            }
            
            ENDHLSL
        }
    }
}
