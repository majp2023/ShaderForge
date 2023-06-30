Shader "Shader/NormalMap"
{
     Properties {
        //TODO 材质面板参数
        _NormalMap("法线贴图", 2D) = "bump"{}
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
            uniform sampler2D _NormalMap;
            struct VertexInput {
                //TODO 输入结构
                float4 vertex : POSITION;//顶点信息
                float2 uv0 : TEXCOORD0;//需要UV坐标采样法线贴图
                float4 normal : NORMAL; //法线信息
                float4 tangent : TANGENT;//构建切线空间需要模型切线信息
            };
            struct VertexOutput {
                //TODO 输出结构
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float3 nDirWS : TEXCOORD1; //世界空间法线信息
                float3 tDirWS : TEXCOORD2; //世界空间切线信息
                float3 bDirWS : TEXCOORD3; //世界空间切线信息
            };
            VertexOutput vert (VertexInput v) {
                //TODO 顶点Shader
                VertexOutput o = (VertexOutput)0;
                o.pos = UnityObjectToClipPos( v.vertex );//变换顶点信息并将其塞给输出结构
                o.uv0 = v.uv0;//传递UV信息
                o.nDirWS = UnityObjectToWorldNormal(v.normal);//世界空间法线信息
                o.tDirWS = normalize(mul(unity_ObjectToWorld, float4(v.tangent.xyz, 0.0)).xyz);//世界空间切线信息
                o.bDirWS = normalize(cross(o.nDirWS, o.tDirWS) * v.tangent.w);//世界空间切线信息
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                //TODO 像素Shader
                //获取nDirWS
                float3 var_NormalMap = UnpackNormal(tex2D(_NormalMap, i.uv0)).rgb;
                float3x3 TBN = float3x3(i.tDirWS, i.bDirWS, i.nDirWS);
                float3 nDir = normalize(mul(var_NormalMap, TBN));
                //获取lDir
                float3 lDir = _WorldSpaceLightPos0.xyz;
                //一般lambert
                float nDotl = dot(nDir, lDir);
                float lambert = max(0.0, nDotl);

                return float4(lambert,lambert,lambert,1.0);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}
