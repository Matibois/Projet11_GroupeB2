Shader"Learning/Unlit/BlendTextureNoise"
{
    Properties
    {   
        _BlendFactor ("Blend factor", Range(0,1)) = 0.5
        _Texture0("Texture0", 2D) = "white" {}
        _Texture1("Texture1", 2D) = "white" {}
        _NoiseTexture("Noise Texture", 2D) = "white" {}
        _NoiseFactor("Noise Factor", Range(0, 1)) = 0.5
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
sampler2D _Texture0, _Texture1, _NoiseTexture;
float _BlendFactor;
float _NoiseFactor;

struct vertexInput
{
    float4 vertex : POSITION;
    float2 texcoord : TEXCOORD0;
};
            
struct v2f
{
    float4 vertex : SV_POSITION;
    float2 texcoord : TEXCOORD0;
};

v2f vert(vertexInput v)
{
    v2f o;
    o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
    o.texcoord = v.texcoord;
    return o;
}

float4 frag(v2f i) : SV_Target
{
                // Calculate the noise value
    float4 noise = tex2D(_NoiseTexture, i.texcoord);

                // Calculate the blend factor based on the noise value
    float blend = lerp(_BlendFactor, 1.0 - _BlendFactor, noise.r * _NoiseFactor);

                // Lerp between the two textures using the calculated blend factor
    return lerp(tex2D(_Texture0, i.texcoord), tex2D(_Texture1, i.texcoord), blend);
}
            
            ENDHLSL
        }
    }
}
