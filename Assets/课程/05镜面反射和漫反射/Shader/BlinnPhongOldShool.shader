Shader "Shader/BlinnPhongOldShool"
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
                float4 normal : NORMAL;
            };
            struct VertexOutput {
                //TODO 输出结构
                float4 posCS : SV_POSITION;
                float4 posWS : TEXCOORD0;
                float3 nDirWS : TEXCOORD1;
            };
            VertexOutput vert (VertexInput v) {
                //TODO 顶点Shader
                VertexOutput o = (VertexOutput)0;
                o.posCS = UnityObjectToClipPos( v.vertex );
                o.posWS = mul(unity_ObjectToWorld, v.vertex);
                o.nDirWS = UnityObjectToWorldNormal(v.normal);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                //TODO 像素Shader
                //准备向量
                float3 nDir = i.nDirWS;
                float3 lDir = _WorldSpaceLightPos0.xyz;
                float3 vDir = normalize(_WorldSpaceCameraPos.xyz - i.posWS.xyz);
                float3 hDir = normalize(vDir + lDir);
                //准备点积结果
                float nDotl = dot(nDir, lDir);
                float nDoth = dot(nDir, hDir);
                //光照模型
                float lambert = max(0.0, nDotl);
                float blinnPhong = pow(max(0.0, nDoth), _SpecularPow);
                float3 finalRGB = _MainCol * lambert + blinnPhong;
                return float4(finalRGB,1.0);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}
