Shader "Shader/OldShool02"
{
     Properties {
        //TODO 材质面板参数
         _MainCol("颜色", color) = (1.0,1.0,1.0,1.0)
        _SpecularPow("高光次幂", range(1, 90)) = 30
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
            uniform float3 _MainCol;
            uniform float _SpecularPow;
            struct VertexInput {
                //TODO 输入结构
                float4 vertex : POSITION;
                float3 normal : NORMAL;
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
                float lambort = dot(nDir, lDir);
                return float4(lambort,lambort,lambort,1.0);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}
