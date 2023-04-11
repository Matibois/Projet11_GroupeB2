Shader"Learning/Unlit/BlendTextureDistance"
{
    Properties
    {   
        // NOM_VARIABLE("NOM_AFFICHE_DANS_L'INSPECTOR", Shaderlab type) = defaultValue
        
        _Distance ("Distance factor", Range(0,10)) = 0.5  // slider
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
float _Distance;
struct vertexInput
{
    float4 vertex : POSITION;
    float4 texcoord : TEXCOORD0;
    float3 worldPos : TEXCOORD1;
};

struct v2f
{
    float4 vertex : SV_POSITION;
    float4 texcoord : TEXCOORD0;
    float3 worldPos : TEXCOORD1;
};

v2f vert(vertexInput v)
{
    v2f o;
    o.vertex = UnityObjectToClipPos(v.vertex);
    o.texcoord = v.texcoord;
    o.worldPos = mul(unity_ObjectToWorld, v.vertex);
    return o;
}

float4 frag(v2f i) : SV_Target
{
    float d = distance(_WorldSpaceCameraPos, i.worldPos) ;
    float t = clamp(d / _Distance, 0, 1);
    return lerp(tex2D(_Texture0, i.texcoord.xy), tex2D(_Texture1, i.texcoord.xy), t);;
}
            
            ENDHLSL
        }
    }
}