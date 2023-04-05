Shader "Learning/Unlit/BlendColors"
{
    Properties
    {   
        // NOM_VARIABLE("NOM_AFFICHE_DANS_L'INSPECTOR", Shaderlab type) = defaultValue
        _Color0("Texture1", Color) = (0.34, 0.85, 0.92, 1) // color
        _Color1("Texture2", Color) = (0.34, 0.85, 0.92, 1) // color
        _BlendFactor ("Blend factor", Range(0,1)) = 0.5  // slider


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
            float _BlendFactor;

			struct vertexInput
            {
                float4 vertex : POSITION;	
            };
			
            struct v2f
            {
                float4 vertex : SV_POSITION;    
            };

            v2f vert (vertexInput v)
            {
                v2f o;
	            o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
                return o;
            }

            float4 frag(v2f i) : SV_Target
            {
            
            return lerp(_Color0, _Color1, _BlendFactor);;
            }
            
            ENDHLSL
        }
    }
}
