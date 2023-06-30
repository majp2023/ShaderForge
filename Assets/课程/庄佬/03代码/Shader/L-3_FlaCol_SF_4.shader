//兰伯特
Shader "Shader/L-3_FlaCol_SF_4" {
     Properties {
        //TODO 材质面板参数
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
            struct VertexInput {
                //TODO 输入结构
                float4 vertex : POSITION;
                float4 normal : NORMAL;
            };
            struct VertexOutput {
                //TODO 输出结构
                float4 pos : SV_POSITION;
                float3 nDirWS : TEXCOORD0;
            };
            VertexOutput vert (VertexInput v) {
                //TODO 顶点Shader
                VertexOutput o = (VertexOutput)0;
                o.pos = UnityObjectToClipPos( v.vertex );
                o.nDirWS = UnityObjectToWorldNormal(v.normal);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                //TODO 像素Shader
                float3 nDir = i.nDirWS;
                float3 lDir = normalize(_WorldSpaceLightPos0.xyz);
                float nDot = dot(nDir, lDir);
                float harfLambrt = (nDot * 0.5) + 0.5;
                //float lambrt = max(0.0, nDot + 0.5);
                return float4(harfLambrt,harfLambrt,harfLambrt,1.0);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}
