Shader "Lesson08/Shader08"
{
    Properties
    {
       
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float2 pos : TEXCOORD1;
                float4 vertex : SV_POSITION;
            };

            
            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                o.pos = v.vertex;
                return o;
            }

            float rect(float2 pos, float2 size, float2 center)
            {
                float2 p = pos - center;
                float2 halfsize = size * 0.5;
                float horz = step(-halfsize.x , p.x) - step(halfsize.x, p.x);
                float vert = step(-halfsize.y , p.y) - step(halfsize.y, p.y);
                return horz * vert;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float2 size01 = float2(0.2, 0.2);
                float2 size05 = float2(0.3, 0.3);
                float2 center01 = float2(-0.25, 0);
                float2 center02 = float2(0.25, 0);
                float inRect01 = rect(i.pos, size01, center01); 
                float inRect02 = rect(i.pos, size05, center02); 

                float3 color = float3(1, 1, 0) * inRect01 + float3(0, 1, 0) * inRect02;
                return float4(color, 1);
            }
            ENDCG
        }
    }
}
