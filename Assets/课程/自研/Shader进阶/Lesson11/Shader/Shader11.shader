Shader "Lesson11/Shader11"
{
     Properties
    {
       _Color("Color", Color) = (1,1,1,1)
       _Size("Size", float) = 0.5
       _Anchor("Anchor", vector) = (0.15, 0.15, 0, 0)
       _TileCount("平铺", float) = 1
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
            float4 _Color;
            float _Size;
            float4 _Anchor;
            float _TileCount;

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

            float rect(float2 pos, float2 anchor, float2 size, float2 center)                                   
            {
                float2 p = pos - center;
                float2 halfsize = size / 2.0;
                float horz = step(-halfsize.x - anchor.x, pos.x) - step(halfsize.x - anchor.x, pos.x);
                float vert = step(-halfsize.y - anchor.y, pos.y) - step(halfsize.y - anchor.y, pos.y);
                return horz * vert;
            }

            float2x2 GetRotationMatrix(float theta)
            {
                float s = sin(theta);
                float c = cos(theta);

                return float2x2(c, -s, s, c);
            }

            float2x2 GetScaleMatrix(float scale)
            {
                return float2x2(scale, 0, 0, scale);
            }
                                  
            fixed4 frag (v2f i) : SV_Target
            {
                float2 center = float2(0.0, 0.0);
                i.pos *= 2.0;
                float2 pos = frac(i.pos * _TileCount);
                pos -= 0.5;

                float2x2 matr = GetRotationMatrix(_Time.y);
                float2x2 mats = GetScaleMatrix((sin(_Time.y) + 1) / 3 + 0.5);
                float2x2 mat = mul(matr, mats);
                float2 pt = mul(mat, pos - center) + center;

                float3 color = _Color * rect(pt, _Anchor.xy, float2(_Size, _Size), center);

                return float4(color, 1);
            }
            ENDCG
        }
    }
}
