Shader "Learning/Unlit/Shader_Exo6"
{
    Properties
    {   
        _GradientMap("Gradient Map", 2D) = "white" {}
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

sampler2D _GradientMap;
			
struct appdata
{
    float4 vertex : POSITION;
};
			
struct v2f
{
    float4 vertex : SV_POSITION;
    float3 wsPos : TEXCOORD0;
};

v2f vert(appdata v)
{
    v2f o;
    o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
    o.wsPos = mul(unity_ObjectToWorld, v.vertex).xyz;
    return o;
}

float4 frag(v2f i) : SV_Target
{
    return tex2D(_GradientMap, i.wsPos.xy);
}
            
            ENDHLSL
        }
    }
}
