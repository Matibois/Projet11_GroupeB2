Shader"Learning/Unlit/Shader_Exo7"
{
    Properties
    {
        _MainTex("Albedo", 2D) = "black" {}
        _Speed("Scrolling Speed", Vector) = (0, 0, 0, 0)
    }
    SubShader
    {
		Pass
        {
			HLSLPROGRAM
            #pragma vertex vert  
            #pragma fragment frag

#include "UnityCG.cginc"

sampler2D _MainTex;
float2 _Speed;
			
struct vertexInput
{
    float4 vertex : POSITION;
    float2 uv : TEXCOORD0;
};
			
struct v2f
{
    float4 vertex : SV_POSITION;
    float2 uv : TEXCOORD0;
};

v2f vert(vertexInput v)
{
    v2f o;
    o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
    o.uv = v.uv + float2(_Speed.x * _Time.x, _Speed.y * _Time.x);
    return o;
}

float4 frag(v2f i) : SV_Target
{
    return tex2D(_MainTex, i.uv);
}
            
            ENDHLSL
        }
    }
}
