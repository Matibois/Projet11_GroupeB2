Shader "Learning/Unlit/PositionColor"
{
    Properties
    {   
        // NOM_VARIABLE("NOM_AFFICHE_DANS_L'INSPECTOR", Shaderlab type) = defaultValue
        _MainColor("Main Color", color) = (1,1,1,1)
        _SecondColor("Second Color", color) = (0,0,0,1)
    }
    
    SubShader
    {
        

		Pass
        {
			HLSLPROGRAM
            #pragma vertex vert  
            #pragma fragment frag

            #include "UnityCG.cginc"
			
            float4 _MainColor;
            float4 _SecondColor;
            float Pos;

			struct vertexInput
            {
                float4 vertex : POSITION;
            };
			
            struct v2f
            {
                float4 vertex : SV_POSITION;
                float worldPos : TEXCOORD0;
            };

            v2f vert (vertexInput v)
            {
                v2f o;
	            o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
                 o.worldPos = mul(unity_ObjectToWorld, v.vertex).x;

                return o;
            }

            float4 frag(v2f i) : SV_Target
            {
                return i.worldPos > 0 ?_MainColor : _SecondColor; 
            }
            
            ENDHLSL
        }
    }
}
