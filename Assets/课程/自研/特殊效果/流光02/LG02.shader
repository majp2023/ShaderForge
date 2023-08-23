Shader "Unlit/LG02"
{
    Properties
    {
        _iResolution("Resolution", vector) = (1, 1, 0 , 0)
        _m("m", Float) = 1
        _iTime("iTime", Float) = 1
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

            float4 _iResolution;
            float _m;
            float _iTime;

            fixed4 frag(v2f i) : SV_Target
            {
                float aspect = 1;//_iResolution.y/_iResolution.x;
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
                //value = 2.0*abs(dist-0.5);
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
                
                return fragColor;
            }
            ENDCG
        }
    }
}
