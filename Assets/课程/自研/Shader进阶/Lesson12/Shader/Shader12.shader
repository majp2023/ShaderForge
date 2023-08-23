Shader "Lesson12/Shader02"
{
    Properties
    {
       _Radius("半径", float) = 1
       _Center("中心点", vector) = (0, 0, 0, 0)
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
            float _Radius;
            float4 _Center;

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

            float circle(float2 pt, float2 center, float radius, bool soften)
            {
                float2 p = pt - center;
                float edge = soften ? radius * 0.005 : 0.0;
                return 1.0 - smoothstep(radius - edge, radius + edge, length(p));
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float2 pos = i.pos * 2;
                float3 color = float3(1, 1, 0) * circle(pos, _Center.xy, _Radius, true);
                
                return float4(color, 1);
            }
            ENDCG
        }
    }
}
