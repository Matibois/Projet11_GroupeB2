Shader "Learning/Unlit/Hologramme"
{
    Properties
    {   
        // NOM_VARIABLE("NOM_AFFICHE_DANS_L'INSPECTOR", Shaderlab type) = defaultValue
        _Albedo("Texture", 2D) = "white" {} // textures 
        _ScrollingSpeed("Scrolling Speed", Vector) = (0,1,0,1)
        _Color0("Texture1", Color) = (0.34, 0.85, 0.92, 1) // color


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
            float4 _Color0;
            float2 _ScrollingSpeed;
            sampler2D _Albedo;
			
			struct vertexInput
            {
                float4 vertex : POSITION;	
    
};
			
            struct v2f
            {
                float4 vertex : SV_POSITION;  
                float3 worldPos : TEXCOORD0;
    
            };

            v2f vert (vertexInput v)
            {
                v2f o;
	            o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
                 float WPos = mul(unity_ObjectToWorld, v.vertex).y;
                o.worldPos = WPos -  _ScrollingSpeed.y * _Time.x;
                return o;
            }

            float4 frag(v2f i) : SV_Target
            {
                 float4 tex = tex2D(_Albedo, i.worldPos);
                 if (tex.r < 0.05)
                   discard;
                 return tex;
            }
            
            ENDHLSL
        }
    }
}
