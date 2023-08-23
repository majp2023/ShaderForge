Shader "Lesson09/Shader09"
{ 
    Properties
    {
       _Color("Color", Color) = (1,1,1,1)
       _Radius("Radius", float) = 0.5
       _Size("Size", float) = 0.5
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
            float _Radius;
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
                float2 center = float2(sin(_Time.y), cos(_Time.y)) * _Radius;
                float inRect = rect(i.pos, _Size, center); 

                float3 color = _Color * inRect;
                return float4(color, 1);
            }
            ENDCG
        }
    }
}
