Shader "Lesson07/Shader07"
{
    Properties
    {
       _Size("大小", float) = 0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            float _Size;
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
                o.uv = v.uv;
                return o;
            }
            
            fixed4 frag (v2f i) : SV_Target
            {
                i.uv.x = abs(i.uv.x - 0.5);
                i.uv.y = abs(i.uv.y - 0.5);
                i.uv = float2(i.uv.x + _Size, i.uv.y + _Size);
                float step_x = step(i.uv.x, 0.25);
                float step_y = step(i.uv.y, 0.25);
                float3 color = float3(1, 1, 0) * step_x * step_y;
                return float4(color, 1);
            }
            ENDCG
        }
    }
}
