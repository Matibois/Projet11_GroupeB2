Shader"Learning/Unlit/AnimVertice2"
{
    Properties
    {   
        // NOM_VARIABLE("NOM_AFFICHE_DANS_L'INSPECTOR", Shaderlab type) = defaultValue
        _Scaling("Normal Scaling Factor",Float) = 0.05
        _ScrollingSpeed("Amplitude",Float) = 0.05
        _Albedo("Albedo", 2D) = "white" {} // textures 
        
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
float _Scaling;
float _ScrollingSpeed;
sampler2D _Albedo;

			struct vertexInput
            {
                float4 vertex : POSITION;	
                float3 normal : NORMAL;
                 float4 uv : TEXCOORD0;
    
};
			
            struct v2f
            {
                float4 vertex : SV_POSITION;    
                 float2 uv : TEXCOORD0;
};

            v2f vert (vertexInput v)
            {
                v2f o;
                v.uv.xy += float2(_Time.y * _ScrollingSpeed,0);
                v.vertex.xyz += v.normal *_Scaling * tex2Dlod(_Albedo, v.uv).r;
                o.vertex = mul(UNITY_MATRIX_MVP, v.vertex );
                 o.uv = v.uv.xy;
                return o;
            }

            float4 frag(v2f i) : SV_Target
            {
                return tex2D(_Albedo, i.uv);
            }
            
            ENDHLSL
        }
    }
}
