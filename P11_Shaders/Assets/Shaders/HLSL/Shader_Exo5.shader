Shader "Learning/Unlit/Shader_Exo5"
{
    Properties
    {   
        _Color1 ("Positive X color", Color) = (1,1,1,1)
        _Color2 ("Negative Y color", Color) = (0,0,0,1)
    }
    
    SubShader
    {
Tags { "RenderType"="Opaque" "Queue"="Geometry"}
		Pass
        {
			HLSLPROGRAM
            #pragma vertex vert  
            #pragma fragment frag

            #include "UnityCG.cginc"

            float4 _Color1, _Color2;
			
			struct vertexInput
            {
                float4 vertex : POSITION;						
            };
			
            struct v2f
            {
                float4 vertex : SV_POSITION;
                float3 worldSpacePos : TEXCOORD0;
            };

            v2f vert (vertexInput v)
            {
                v2f o;
	            o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
                o.worldSpacePos = mul(unity_ObjectToWorld, v.vertex).xyz;

                return o;
            }

            float4 frag(v2f i) : SV_Target
            {
                //if (i.worldSpacePos.x > 0)
                //{
                //    return _Color1;
                //}
                //else
                //{
                //    return _Color2;
                //}
    
                return i.worldSpacePos.x > 0 ? _Color1 : _Color2;
            }
            
            ENDHLSL
        }
    }
}