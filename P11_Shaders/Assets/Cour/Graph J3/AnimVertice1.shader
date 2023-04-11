Shader"Learning/Unlit/AnimVertice1"
{
    Properties
    {   
        // NOM_VARIABLE("NOM_AFFICHE_DANS_L'INSPECTOR", Shaderlab type) = defaultValue
        _TintColor("Tint", Color) = (0.34, 0.85, 0.92, 1) // color
        _Amplitude("Amplitude",Float) = 0.05
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
            float _Amplitude;
            float4 _TintColor;

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
                o.vertex = mul(UNITY_MATRIX_MVP, v.vertex + float4(_Amplitude * cos(_Time.y), _Amplitude * sin(_Time.y), 0, 0));
                o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
                
                return o;
            }

            float4 frag(v2f i) : SV_Target
            {
                float value = saturate(i.worldPos.y);
                return float4(value, value, value, 1);
            }
            
            ENDHLSL
        }
    }
}
