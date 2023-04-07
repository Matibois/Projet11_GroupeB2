Shader"Learning/Unlit/Vertices2"
{
    Properties
    {   
        _NormalScalingFactor("Normal Scaling Factor", float) =1
        _Speed("Scrolling Speed", float) = 1.0
        _NoiseMap("Noise Map", 2D) = "white"{}
    }
    
    SubShader
    {
        Tags { "RenderType"="Opaque" "Queue"="Geometry"}
		Pass
        {
HLSLPROGRAM
            #pragma vertex vert  
            #pragma fragment frag

#include "UnityCG.cginc"

float _NormalScalingFactor, _Speed;
sampler2D _NoiseMap;
			
struct vertexInput
{
    float4 vertex : POSITION;
    float3 normal : NORMAL;
    float4 uv : TEXCOORD0;
};
			
struct v2f
{
    float4 vertex : SV_POSITION;
    float2 uv : TEXCOORD0;
};

v2f vert(vertexInput v)
{
    v2f o;
    v.uv.xy += float2(_Time.x * _Speed, 0);
    v.vertex.xyz += v.normal * _NormalScalingFactor * tex2Dlod(_NoiseMap, v.uv).r;
    o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
    o.uv = v.uv.xy;
    return o;
}

float4 frag(v2f i) : SV_Target
{
    return tex2D(_NoiseMap, i.uv);
}
            
            ENDHLSL
        }
    }
}
