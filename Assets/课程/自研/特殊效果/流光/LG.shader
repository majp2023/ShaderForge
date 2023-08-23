Shader "Unlit/LG"
{
    Properties
    {
        _Zoom("推进或拉远", Float) = 6
        _Scale("缩放", Float) = .5
        _Exposure("曝光", Float) = 2
        _Speed("速度", Float) = .75
        _Iterations("迭代次数", Int) = 6
        _Saturation("饱和度", Float) = 0.5
        _Power("高光", Float) = 1.75
        _ColorInterval("颜色间隔", Float) = .4
        _Shift("变换", Float) = 1.5
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
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            v2f vert(appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                UNITY_TRANSFER_FOG(o, o.vertex);
                return o;
            }

            float _Zoom;
            float _Scale;
            float _Exposure;
            float _Speed;
            int _Iterations;
            float _Saturation;
            float _Power;
            float _ColorInterval;
            float _Shift;

            fixed4 frag(v2f i) : SV_Target
            {
                half PI = 3.14159;
                half4 c;
                float2 u = (i.uv * 2 - 1) * _Scale;
                float l = length(u);
                float t = _Time.y * _Speed;
                for (int i = 0; i <= _Iterations; i++)
                {
                    u = frac(u * _Shift) - 0.5;
                    c += pow(
                        abs(
                            _Exposure * .01 / sin(
                                length(u) * exp(-l) * _Zoom + t
                            )
                        ), _Power
                    ) * (
                        .5 + .5 * cos(
                            _Saturation * PI * 4 * (
                                l + (i + t) * _ColorInterval + half4(.26, .42, .56, 0)
                            )
                        )
                    );
                }
                return c;
            }
            ENDCG
        }
    }
}
