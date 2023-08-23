Shader "Lesson04/Shader04"
{
    Properties
    {
        _ColorA("Color A", Color) = (1,0,0,0)
       _ColorB("Color B", Color) = (0,0,1,0)
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

            float4 _ColorA;
            float4 _ColorB;

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD0;
                float4 pos : TEXCOORD1;
            };


            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.pos = v.vertex;
                o.uv = v.uv;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                /*float delta = i.uv.x;
                float3 color = lerp(_ColorA,_ColorB, delta);*/
                float3 color = saturate(i.pos * 2);
                return float4(color, 1.0);
            }
            ENDCG
        }
    }
}
