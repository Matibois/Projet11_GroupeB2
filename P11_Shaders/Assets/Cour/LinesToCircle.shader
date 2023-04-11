Shader "Learning/Unlit/LinesToCircle"
{
    Properties
    {   
        // NOM_VARIABLE("NOM_AFFICHE_DANS_L'INSPECTOR", Shaderlab type) = defaultValue
        _Albedo("Texture", 2D) = "white" {} // textures 
        _ScrollingSpeed("Scrolling Speed", Range(0.1,5)) = 1

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
            float _ScrollingSpeed;
			
            sampler2D _Albedo;

			struct vertexInput
            {
                float4 vertex : POSITION;						
                float2 uv : TEXCOORD0;
            };
			
            struct v2f
            {
                float4 vertex : SV_POSITION;    
                float2 uv : TEXCOORD0;
                float3 worldPos : TEXCOORD1;
                
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
                 float2 uv = i.uv;

                float2 center = float2(0.5, 0.5); // Définir le point central (0.5, 0.5)

                float dist = distance(uv, center) - _ScrollingSpeed * _Time.x;
    
             return tex2D(_Albedo, dist );
}
            
            ENDHLSL
        }
    }
}
