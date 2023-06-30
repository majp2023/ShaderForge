Shader "Shader/01/01"
{
     Properties {
        //TODO 材质面板参数
        _RampTex("RampTex", 2D) = "white" {}

    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0
            uniform sampler2D _RampTex;
            struct VertexInput {
                //TODO 输入结构
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 uv : TEXCOORD0;
            };
            struct VertexOutput {
                //TODO 输出结构
                float4 pos : SV_POSITION;
                float4 uv : TEXCOORD0;
                float3 nDirWS : TEXCOORD1;
            };
            VertexOutput vert (VertexInput v) {
                //TODO 顶点Shader
                VertexOutput o = (VertexOutput)0;
                o.pos = UnityObjectToClipPos( v.vertex );
                o.uv = v.uv;
                o.nDirWS = UnityObjectToWorldNormal(v.normal);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                //TODO 像素Shader
                float nDir = i.nDirWS;
                float lDir = normalize(_WorldSpaceLightPos0.xyz);

                float halfLambort = dot(nDir, lDir) * 0.5 + 0.5;

                float append = halfLambort + 0.3;

                //贴图采样
                float3 rampTex = tex2D(_RampTex, i.uv);

                //结果
                float finalRGB = append * rampTex;

                return float4(finalRGB,finalRGB,finalRGB,1.0);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}
