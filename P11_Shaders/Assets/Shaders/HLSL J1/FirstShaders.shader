Shader "Learning/Unlit/FirstShaders"
{
    Properties
    {
        // NOM_VARIABLE("NOM_AFFICHE_DANS_L'INSPECTOR", Shaderlab type) = defaultValue
        _MainColor("Main Color", color) = (1,1,1,1)
    }

        SubShader
    {
        Tags { "RenderType" = "Opaque" }

        Pass
        {
            HLSLPROGRAM
            #pragma vertex vert  
            #pragma fragment frag

            #include "UnityCG.cginc"

            float4 _MainColor;
            
            //Data pour chaque vertex
			struct vertexInput
            {
                float4 vertex : POSITION; //dans l'espace �cran
                float4 vertexColors : COLOR;
            };
			
            // Vertex to Fragment = V2F
            struct v2f
            {
                float4 vertex : SV_POSITION; //dans l'espace objet
                float4 vertexColors : COLOR;

            };

            //Vertex Shaders, exucut� pour chaque vertex
            v2f vert (vertexInput v)
            {
                v2f o;
	            o.vertex = mul(UNITY_MATRIX_MVP, v.vertex); // Calcul de la position du Vertex dans l'espace �cran
                o.vertexColors = v.vertexColors;
                return o;
            }

            //Rasterizer

            // Fragment / pixel Shaders : exucut� pour chaque fragment/pixel
            float4 frag(v2f i) : SV_Target
            {
                return _MainColor;
            }
            
            ENDHLSL
        }
    }
}
