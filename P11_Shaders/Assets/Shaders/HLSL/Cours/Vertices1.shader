Shader"Learning/Unlit/Vertices1"
{
    Properties
    {   
        _Amplitude("Aplitude", float) = 1.0
    }
    
    SubShader
    {
        Tags { "RenderType"="Opaque" "Queue"="Geometry"}
		Pass
        {
			HLSLPROGRAM
            #pragma vertex vert  
            #pragma fragment frag
float _Amplitude;

#include "UnityCG.cginc"
			
struct vertexInput
{
    float4 vertex : POSITION;
    float2 uv : TEXCOORD0;
};
			
struct v2f
{
    float4 vertex : SV_POSITION;
    float3 worldSpacePos : TEXCOORD0;
};

v2f vert(vertexInput v)
{
    v2f o;
    //o.vertex = mul(UNITY_MATRIX_MVP, v.vertex + float4(_Amplitude * cos(_Time.y), _Amplitude * sin(_Time.y), 0, 0));
    v.vertex.y += sin(_Time.y) * _Amplitude;
    o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
    o.worldSpacePos = mul(unity_ObjectToWorld, v.vertex).xyz;
    return o;
}

float4 frag(v2f i) : SV_Target
{
    float value = saturate(i.worldSpacePos.y);
    return float4(value, value, value, 1);
}
            
            ENDHLSL
        }
    }
}
