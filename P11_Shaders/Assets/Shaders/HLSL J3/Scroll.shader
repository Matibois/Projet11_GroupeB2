Shader "Learning/Unlit/Scroll"
{
    Properties
    {
        _Texture0("Gradiant Map", 2D) = "white" {} // textures 
        _ScrollSpeed("Scroll Speed", vector) = (0,0,0,0) 
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
            float2 _ScrollSpeed;

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
                o.uv = v.uv + float2(_ScrollSpeed.x * _Time.x, _ScrollSpeed.y * _Time.x);
                return o;
            }

            float4 frag(v2f i) : SV_Target
            {
                return tex2D(_Texture0,i.uv); 
            }

            ENDHLSL
        }
    }
}