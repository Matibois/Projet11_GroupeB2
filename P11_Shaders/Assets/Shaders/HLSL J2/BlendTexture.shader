Shader"Learning/Unlit/BlendTexture"
{
    Properties
    {   
        // NOM_VARIABLE("NOM_AFFICHE_DANS_L'INSPECTOR", Shaderlab type) = defaultValue
        
        _BlendFactor ("Blend factor", Range(0,1)) = 0.5  // slider
        _Texture0("Texture0", 2D) = "white" {} // textures 
        _Texture1("Texture1", 2D) = "white" {} // textures 

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
sampler2D _Texture0, _Texture1;
float _BlendFactor;

struct vertexInput
{
    float4 vertex : POSITION;
    float4 texcoord : TEXCOORD0;
    float4 texcoord1 : TEXCOORD1;
};
			
struct v2f
{
    float4 vertex : SV_POSITION;
    float4 texcoord : TEXCOORD0;
    float4 texcoord1 : TEXCOORD1;
};

v2f vert(vertexInput v)
{
    v2f o;
    o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
    o.texcoord = v.texcoord;
    o.texcoord1 = v.texcoord1;
    return o;
}

float4 frag(v2f i) : SV_Target
{
            
    return lerp(tex2D(_Texture0, i.texcoord), tex2D(_Texture1, i.texcoord1), _BlendFactor);;
}
            
            ENDHLSL
        }
    }
}