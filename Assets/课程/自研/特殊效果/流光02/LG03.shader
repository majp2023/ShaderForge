Shader "Unlit/LG03"
{
    Properties
    {
        _m("Scale", Float) = 1
        _iTime("iTime", Float) = 1
        _MainCol("流光色",Color) = (1.0, 0.0, 0.0, 1.0)
        _BackgroundColor("底色",Color) = (1.0, 0.0, 0.0, 1.0)
        _Opacity ("透明度", range(0, 1)) = 1
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

            float _m;
            float _iTime;
            float4 _MainCol;
            float4 _BackgroundColor;
            float _Opacity;

            fixed4 frag(v2f i) : SV_Target
            {
                float var_time = _Time.y * _iTime;
                float2 uv = i.uv - float2(0.5, 0.5);
                uv *= _m;
                uv += float2(0.5, 0.5);
                float2 pos = 10 * uv;
                float2 rep = frac(pos);
                float dist = max(max(rep.x, 1.0 - rep.x), max(rep.y, 1.0 - rep.y));
                float squareDist = length((floor(pos) + float2(0.5,0.5)) - float2(5.0, 5.0) );
                float edge = sin(var_time - squareDist);
                edge = (var_time - squareDist * 0.3) * 0.4;
                edge = 1 * frac(edge * 0.5);
                float value = 1 * abs(dist - 0.0);
                value = frac(dist * 2);
                //value = lerp(value, 1.0 - value, step(1.0, edge));
                edge = pow(abs(1.0 - edge), 2.0);
                value =  smoothstep(edge , edge, value);
                //value += squareDist * 0.1;
                float opacity = _MainCol.a * _Opacity;
                float4 var_mainCol = float4(_MainCol.rgb, opacity);
                float4 var_backgroundColor = float4(_BackgroundColor.rgb, opacity);

                float4 fragColor = lerp(var_mainCol, var_backgroundColor, value * opacity);
                return fragColor;

               /* float aspect = 1;
                float value;
            	float2 uv = (i.uv);
                float var_time = _Time.y * _iTime;
                uv -= float2(0.5, 0.5 * aspect);
                float rot = radians(45.0); // radians(45.0*sin(iTime));
                float2x2 mat2 = float2x2(cos(rot), -sin(rot), sin(rot), cos(rot));
               	uv  = _m * uv;
                uv += float2(0.5, 0.5 * aspect);
                uv.y += 0.5 * (1.0 - aspect);
                float2 pos = 10.0*uv;
                float2 rep = frac(pos);
                float dist = 2.0 * min(min(rep.x, 1.0 - rep.x), min(rep.y, 1.0 - rep.y));
                float squareDist = length((floor(pos) + float2(0.5,0.5)) - float2(5.0, 5.0) );
                float edge = sin(var_time - squareDist * 0.5) * 0.5 + 0.5;
                edge = (var_time -squareDist * 0.5) * 0.5;
                edge = 2.0 * frac( edge * 0.5);
                value = 2.0*abs(dist-0.5);
                //value = pow(dist, 2.0);
                value = frac( dist * 2.0);
                value = lerp(value, 1.0 - value, step(1.0, edge));
                //value *= 1.0-0.5*edge;
                edge = pow(abs(1.0-edge), 2.0);
                //edge = abs(1.0-edge);
                value = smoothstep( edge - 0.05, edge, 0.95 * value);
                value += squareDist * 0.1;
                //float4 fragColor = float4(value, value,value,1.0);
                float4 fragColor = lerp(float4(1.0,1.0,1.0,1.0), float4(0.5,0.75,1.0,1.0), value);
                fragColor.a = 0.25 * clamp(value, 0.0, 1.0);
                
                return fragColor;*/
            }
            ENDCG
        }
    }
}
