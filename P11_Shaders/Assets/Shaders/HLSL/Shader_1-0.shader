Shader"Learning/Unlit/Shader_1-0"
{
    Properties
    {   
        _Color0("First color",Color) = (0.31, 0.85, 0.92, 1)
        _Color1("Second color",Color) = (1, 0, 0, 1)

        _LerpAlpha("Lerp Alpha", Range(0,1)) = 0
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
            float _LerpAlpha;
			
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
                lerp(_Color0, _Color1, _LerpAlpha);
                return float4(1,0,0,0); 
            }
            
            ENDHLSL
        }
    }
}
