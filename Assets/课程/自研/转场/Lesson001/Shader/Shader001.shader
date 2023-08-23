Shader "Lesson001/Shader001"
{
    Properties
    {
       _MainTex("主帖图", 2d) = "white" {}
       _SecondaryTex("副贴图", 2d) = "white" {}
       _Mix("混合", Range(0, 1)) = 0
       [Enum(Single, 0, Multiple, 1)] _Float0("Float 0", float) = 0
       _MulNum("数量", float) = 1
       _Angle("角度", float) = 0
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

            sampler2D _MainTex;
            sampler2D _SecondaryTex;
            float _Mix;
            float _Float0;
            float _MulNum;
            float _Angle;

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
            };

            struct v2f
            {
                float2 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
                float4 vertex : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv0 = v.uv0;
                o.uv1 = v.uv1;
                return o;
            }

            // 直角坐标转极坐标方法
            float2 Polar(float2 UV)
            {
                float2 uv = UV - 0.5;
                float distance = length(uv);
                distance *= 2;
                float angle = atan2(uv.x, uv.y);
                float angle01 = angle / 3.1415926;
                return float2(angle01, distance);
            }
            
            float4x4 RotationAxle(float angle)
            {
                float s;
                float c;
                sincos(radians(angle), s, c);

                float4x4 XRotation = {c, -s, 0, 0,
                                      s, c , 0, 0,
                                      0, 0, 1, 0,
                                      0, 0, 0, 1};

                float4x4 YRotation = {c, s, 0, 0,
                                      0, 1, 0, 0,
                                      -s, 0, c, 0,
                                      0, 0, 0, 1};

                float4x4 ZRotation = {1, 0, 0, 0,
                                      0, c, -s, 0,
                                      0, s, c, 0,
                                      0, 0, 0, 1};

                return ZRotation;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float4 _mainTex = tex2D(_MainTex, i.uv0);
                float4 _secondaryTex = tex2D(_SecondaryTex, i.uv1);

                float2 _polarCoord ;
                float _step;
                float3 mix;

                i.uv1 = mul(i.uv1.xy, RotationAxle(_Angle));

                switch(_Float0)
                {
                     case 0:
                     _polarCoord = Polar(i.uv1);
                     _step = step(_Mix , abs(_polarCoord));
                     mix = lerp(_mainTex, _secondaryTex, _step);
                     break;

                     case 1:
                     _polarCoord = frac(Polar(i.uv1) * _MulNum);
                     _step = step(_Mix, _polarCoord);
                     mix = lerp(_mainTex, _secondaryTex, _step);
                     break;
                }

                return float4(mix, 1.0);
            }
            ENDCG
        }
    }
}
