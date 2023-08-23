Shader "Lesson02/Shader02"
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
                //sin函数 将参数限制在[-1,1]的区间 
                //cos函数 将参数限制在[-1,1]的区间 
                //它们的区别为 PI(Π)的周期性不同
                //即为 当sin参数为0时  cos参数为1
                //     当sin参数为1时  cos参数为0
                float3 color = float3((sin(_Time.y) + 1) / 2, 0.0, ((cos(_Time.y) + 1) / 2));
                return float4(color, 1.0);
            }
            ENDCG
        }
    }
}
