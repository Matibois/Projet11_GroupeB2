Shader"Learning/Unlit/ShaderHolo"
{
    Properties
    {   
        _Color("Color", Color) = (1,1,1,1)
        _LineTex("Line Texture", 2D) = "white" {}
        _Speed("Scrolling Speed", float) = 1.0
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

sampler2D _LineTex;
float _Speed;
float4 _Color;
			
struct vertexInput
{
    float4 vertex : POSITION;
};
			
struct v2f
{
    float4 vertex : SV_POSITION;
    float wsPosY : TEXCOORD0;
};

v2f vert(vertexInput v)
{
    v2f o;
    o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
    o.wsPosY = mul(unity_ObjectToWorld, v.vertex).y + _Speed * _Time.y;
    return o;
}

float4 frag(v2f i) : SV_Target
{
    float texelColor = tex2D(_LineTex, float2(0, i.wsPosY)).r;
    
    if (texelColor < 0.05)
        discard;
    
    return _Color;
}
            
            ENDHLSL
        }
    }
}
