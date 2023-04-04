Shader "Learning/Unlit/LerpTex"
{
    Properties
    {   
        // NOM_VARIABLE("NOM_AFFICHE_DANS_L'INSPECTOR", Shaderlab type) = defaultValue
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

            sampler2D _Tex1;
            sampler2D _Tex2;
			
			struct vertexInput
            {
                float4 vertex : POSITION;	
                float2 uv : TEXCOORD0;
            };
			
            struct v2f
            {
                float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD0;
                float4 pixelWorldPose : TEXCOORD1;
            };

            v2f vert (vertexInput v)
            {
                v2f o;
	            o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
                o.uv = v.uv;
                o.pixelWorldPose = mul(unity_ObjectToWorld, v.vertex);
                return o;
            }

            //float4 frag(v2f i) : SV_Target
            {
                //float dist = lengh(_WorldSpaceCameraPos - input.pixelWorldPos.xyz);
                //return lerp(text2D(_Tex1, input.uv), tex2D(_Tex2, input.uv), clamp(dist / 10, 0, 1));
            }
            
            ENDHLSL
        }
    }
}
