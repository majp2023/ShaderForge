//兰伯特 + Phong + shadow + 环境光
Shader "Shader/OldSchoolPlus"
{
     Properties {
        //TODO 材质面板参数
         _BassCol ("基本色", Color) = (0.5,0.5,0.5,1)
        _LightCol ("光颜色", Color) = (0.5,0.5,0.5,1)
        _SpecPow ("高光次幂", Range(0, 90)) = 30
        _Occlusion ("AO图", 2D) = "white" {}
        _EvnInt ("环境光强度", Range(0, 1)) = 0
        _EnvUpCol ("环境天顶颜色", Color) = (1,1,1,1)
        _EnvSideCol ("环境水平颜色", Color) = (0.5,0.5,0.5,1)
        _EnvDownCol ("环境地表颜色", Color) = (0,0,0,1)
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
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0
            uniform float3 _BassCol;
            uniform float3 _LightCol;
            uniform float _SpecPow;
            uniform sampler2D _Occlusion;
            uniform float _EvnInt;
            uniform float3 _EnvUpCol;
            uniform float3 _EnvSideCol;
            uniform float3 _EnvDownCol;
            struct VertexInput {
                //TODO 输入结构
                float4 vertex : POSITION;
                float4 normal : NORMAL;
                float2 uv0 : TEXCOORD0;
            };
            struct VertexOutput {
                //TODO 输出结构
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;//UV0
                float4 posWS : TEXCOORD1;//世界空间顶点位置
                float3 nDirWS : TEXCOORD2;//世界空间法线方向
                LIGHTING_COORDS(3,4)
            };
            VertexOutput vert (VertexInput v) {
                //TODO 顶点Shader
                VertexOutput o = (VertexOutput)0;
                o.pos = UnityObjectToClipPos( v.vertex );
                o.uv0 = v.uv0;
                o.posWS = mul(unity_ObjectToWorld, v.vertex);
                o.nDirWS = UnityObjectToWorldNormal(v.normal);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                //TODO 像素Shader
                //准备向量
                float3 nDir = normalize(i.nDirWS);
                float3 lDir = _WorldSpaceLightPos0.xyz;
                float3 vDir = normalize(_WorldSpaceCameraPos.xyz - i.posWS.xyz);
                float3 rDir = reflect(-lDir, nDir);

                //准备点积结果
                float nDotl = dot(nDir, lDir);
                float vDotr = dot(vDir, rDir);

                //光照模型(直接光照部分)
                float shadow = LIGHT_ATTENUATION(i);
                float lambert = max(0.0, nDotl);
                float phong = pow(max(0.0, vDotr), _SpecPow);
                float3 dirLighting = (_BassCol * lambert + phong) * _LightCol * shadow;

                //光照模型(环境光部分)
                float upMask = max(0.0, nDir.g);
                float downMask = max(0.0, -nDir.g);
                float sideMask = 1.0 - upMask - downMask;

                //混合环境色
                float3 envCol = _EnvUpCol * upMask + _EnvSideCol * sideMask + _EnvDownCol * downMask;
                float occlusion = tex2D(_Occlusion, i.uv0);
                float3 envLighting = envCol * _EvnInt * occlusion;

                //返回结果
                float3 finalRGB = dirLighting + envLighting;
                return float4(finalRGB,1.0);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}
