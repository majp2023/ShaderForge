Shader "Lesson03/Shader03"
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
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                //lerp 混合
                //当分量(delta)值为0时，返回_ColorA
                //当分量(delta)值为1时，返回_ColorB
                //当分量(delta)值为0.5时, 返回_ColorA和_ColorB各一半
                float delta = (sin(_Time.y) + 1) / 2;
                float3 color = lerp(_ColorA, _ColorB, delta);
                return float4(color, 1);
            }
            ENDCG
        }
    }
}
