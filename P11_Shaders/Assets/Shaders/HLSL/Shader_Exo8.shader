Shader"Learning/Unlit/Shader_Exo8"
{
    Properties
    {   
        _Aldebo0("Albedo Map", 2D) = "White" {}
} 
    

    SubShader
    {
		Pass
        {
            Cull Off

			HLSLPROGRAM
            #pragma vertex vert  
            #pragma fragment frag

#include "UnityCG.cginc"

sampler2D _Aldebo0;
			
struct appdata
{
    float4 vertex : POSITION;
    float2 uv : TEXCOORD0;
};
			
struct v2f
{
    float4 vertex : SV_POSITION;
    float2 uv : TEXCOORD0;
};

v2f vert(appdata v)
{
    v2f o;
    o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
    o.uv = v.uv;
    return o;
}

float4 frag(v2f i) : SV_Target
{
    float4 texelColor = tex2D(_Aldebo0, i.uv);
    
    if (texelColor.a < 0.85)
        discard;
    return texelColor;
}
            
            ENDHLSL

}
    }
}
