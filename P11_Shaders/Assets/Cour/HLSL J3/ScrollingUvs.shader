Shader "Learning/Unlit/ScrollingsUvs"
{
    Properties
    {   
        
        _Texture0("Mat", 2D) = "white" {} // textures 
        _ScrollingSpeed("Scrolling Speed", Vector) = (1,0,0,1)
        // NOM_VARIABLE("NOM_AFFICHE_DANS_L'INSPECTOR", Shaderlab type) = defaultValue
    }
    
    SubShader
    {
        Tags { "RenderType" = "Opaque" "Queue" = "Geometry"}

		Pass
        {
			HLSLPROGRAM
            #pragma vertex vert  
            #pragma fragment frag

            #include "UnityCG.cginc"
			
            sampler2D _Texture0;
            float2 _ScrollingSpeed;
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

            v2f vert (vertexInput v)
            {
                v2f o;
	            o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
                o.uv = v.uv + float2(_ScrollingSpeed.x * _Time.x, _ScrollingSpeed.y * _Time.x);
                return o;
            }

            float4 frag(v2f i) : SV_Target
            {
                return tex2D(_Texture0, i.uv);
            }
            
            ENDHLSL
        }
    }
}
