Shader "Learning/Unlit/waterLike"
{
    Properties
    {
        _Texture0("snad", 2D) = "white" {} // textures 
        _Texture1("bruit", 2D) = "white" {} // textures 
        _Slider ("noise slider", Range(0,1)) = 0  // slider
        _Speed ("Speed slider", Range(0,10)) = 0  // slider
        // NOM_VARIABLE("NOM_AFFICHE_DANS_L'INSPECTOR", Shaderlab type) = defaultValue
    }

        SubShader
    {
        Tags { "RenderType" = "Opaque" }
        Tags { "RenderType"="Opaque" "Queue"="Geometry"}
        Pass
        {
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            sampler2D _Texture0;
            sampler2D _Texture1;
            float _Speed;
            float _Slider;

            struct vertexInput
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float2 uv: TEXCOORD0;
            };

            v2f vert (vertexInput v)
            {
                v2f o;
                o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
                o.uv = v.uv;
                return o;
            }

            float4 frag(v2f i) : SV_Target
            {
                float2 offset =_Speed * _Time.x;

                float2 disturbOffSet = tex2D(_Texture1,i.uv + offset).rg;
                disturbOffSet += _Slider;

                return tex2D(_Texture0, i.uv + disturbOffSet); 
            }

            ENDHLSL
        }
    }
}