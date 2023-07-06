Shader "Shader/Data2"
{
     Properties {
        //TODO 材质面板参数
        [Header(Texture)]
        _MainTex        ("RGB:颜色 A:透贴", 2d) = "white"{}
        _MaskTex        ("R:高光强度 G:边缘光强度 B:高光染色 A:高光次幂", 2d) = "black"{}
        _NormTex        ("RGB:法线贴图", 2d) = "bump"{}
        _MatelnessMask  ("金属度遮罩", 2d) = "black"{}
        _EmissionMask   ("自发光遮罩", 2d) = "black"{}
        _DiffWarpTex    ("颜色Warp图", 2d) = "gray"{}
        _FresWarpTex    ("菲涅尔Warp图", 2d) = "gray"{}
        _Cubemap        ("环境球", cube) = "_Skybox"{}
        [Header(DirDiff)]
        _LightCol       ("光颜色", color) = (1.0, 1.0, 1.0, 1.0)
        [Header(DirSpec)]
        _SpecPow        ("高光次幂", range(0.0, 99.0)) = 5
        _SpecInt        ("高光强度", range(0.0, 10.0)) = 5
        [Header(EnvDiff)]
        _EnvCol         ("环境光颜色", color) = (1.0, 1.0, 1.0, 1.0)
        [Header(EnvSpec)]
        _EnvSpecInt     ("环境镜面反射强度", range(0.0, 30.0)) = 0.5
        [Header(RimLight)]
        [HDR]_RimCol    ("轮廓光颜色", color) = (1.0, 1.0, 1.0, 1.0)
        [Header(Emission)]
        _EmitInt        ("自发光强度", range(0.0, 10.0)) = 1.0
        [HideInInspector]
        _Cutoff         ("Alpha cutoff", Range(0,1)) = 0.5
        [HideInInspector]
        _Color          ("Main Color", Color) = (1.0, 1.0, 1.0, 1.0)
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
            // 输入参数
            uniform sampler2D _MainTex;
            uniform sampler2D _MaskTex;
            uniform sampler2D _NormTex;
            uniform sampler2D _MatelnessMask;
            uniform sampler2D _EmissionMask;
            uniform sampler2D _DiffWarpTex;
            uniform sampler2D _FresWarpTex;
            uniform samplerCUBE _Cubemap;
            // DirDiff
            uniform half3 _LightCol;
            // DirSpec
            uniform half _SpecPow;
            uniform half _SpecInt;
            // EnvDiff
            uniform half3 _EnvCol;
            // EnvSpec
            uniform half _EnvSpecInt;
            // RimLight
            uniform half3 _RimCol;
            // Emission
            uniform half _EmitInt;
            // Other
            uniform half _Cutoff;
            struct VertexInput {
                //TODO 输入结构
                float4 vertex : POSITION;
                float2 uv0      : TEXCOORD0;  // UV信息 Get✔
                float4 normal   : NORMAL;     // 法线信息 Get✔
                float4 tangent  : TANGENT;    // 切线信息 Get✔
            };
            struct VertexOutput {
                //TODO 输出结构
                float4 pos : SV_POSITION;
                float2 uv0      : TEXCOORD0;  // UV0
                float4 posWS    : TEXCOORD1;  // 世界空间顶点位置
                float3 nDirWS   : TEXCOORD2;  // 世界空间法线方向
                float3 tDirWS   : TEXCOORD3;  // 世界空间切线方向
                float3 bDirWS   : TEXCOORD4;  // 世界空间副切线方向
                LIGHTING_COORDS(5,6)          // 投影相关
            };
            VertexOutput vert (VertexInput v) {
                //TODO 顶点Shader
                VertexOutput o = (VertexOutput)0;
                o.pos = UnityObjectToClipPos( v.vertex );
                o.uv0 = v.uv0;                                  // 传递UV
                o.posWS = mul(unity_ObjectToWorld, v.vertex);   // 顶点位置 OS>WS
                o.nDirWS = UnityObjectToWorldNormal(v.normal);  // 法线方向 OS>WS
                o.tDirWS = normalize(mul(unity_ObjectToWorld, float4(v.tangent.xyz, 0.0)).xyz); // 切线方向 OS>WS
                o.bDirWS = normalize(cross(o.nDirWS, o.tDirWS) * v.tangent.w);  // 副切线方向
                TRANSFER_VERTEX_TO_FRAGMENT(o)                  // 投影相关
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                //TODO 像素Shader
                 // 向量准备
                half3 nDirTS = UnpackNormal(tex2D(_NormTex, i.uv0));
                half3x3 TBN = half3x3(i.tDirWS, i.bDirWS, i.nDirWS);
                half3 nDirWS = normalize(mul(nDirTS, TBN));
                half3 vDirWS = normalize(_WorldSpaceCameraPos.xyz - i.posWS);
                half3 vrDirWS = reflect(-vDirWS, nDirWS);
                half3 lDirWS = _WorldSpaceLightPos0.xyz;
                half3 lrDirWS = reflect(-lDirWS, nDirWS);
                // 中间量准备
                half ndotl = dot(nDirWS, lDirWS);
                half ndotv = dot(nDirWS, vDirWS);
                half vdotr = dot(vDirWS, lrDirWS);
                // 采样纹理
                half4 var_MainTex = tex2D(_MainTex, i.uv0);
                half4 var_MaskTex = tex2D(_MaskTex, i.uv0);
                half var_MatelnessMask = tex2D(_MatelnessMask, i.uv0).r;
                half var_EmissionMask = tex2D(_EmissionMask, i.uv0).r;
                half3 var_FresWarpTex = tex2D(_FresWarpTex, ndotv);
                half3 var_Cubemap = texCUBElod(_Cubemap, float4(vrDirWS, lerp(8.0, 0.0, var_MaskTex.a))).rgb;
                half shadow = LIGHT_ATTENUATION(i);
                // 光照模型
                    // 漫反射颜色 镜面反射颜色
                    half3 diffCol = lerp(var_MainTex.rgb, half3(0.0, 0.0, 0.0), var_MatelnessMask);
                    half3 specCol = lerp(var_MainTex.rgb, half3(0.3, 0.3, 0.3), var_MaskTex.b) * var_MaskTex.r;
                    // 菲涅尔
                    half3 fresnel = lerp(var_FresWarpTex, 0.0, var_MatelnessMask);
                    half fresnelCol = fresnel.r;    // 无实际用途
                    half fresnelRim = fresnel.g;
                    half fresnelSpec = fresnel.b;
                    // 光源漫反射
                    half halfLambert = ndotl * 0.5 + 0.5;
                    half3 var_DiffWarpTex = tex2D(_DiffWarpTex, half2(halfLambert, 0.2));
                    half3 dirDiff = diffCol * var_DiffWarpTex * _LightCol;
                    // 光源镜面反射
                    half phong = pow(max(0.0, vdotr), var_MaskTex.a * _SpecPow);
                    half spec = phong * max(0.0, ndotl);
                    spec = max(spec, fresnelSpec);
                    spec = spec * _SpecInt;
                    half3 dirSpec = specCol * spec * _LightCol;
                    // 环境漫反射
                    half3 envDiff = diffCol * _EnvCol;
                    // 环境镜面反射
                    half reflectInt = max(fresnelSpec, var_MatelnessMask) * var_MaskTex.r;
                    half3 envSpec = specCol * reflectInt * var_Cubemap * _EnvSpecInt;
                    // 轮廓光
                    half3 rimLight = _RimCol * fresnelRim * var_MaskTex.g * max(0.0, nDirWS.g);
                    // 自发光
                    half3 emission = diffCol * var_EmissionMask * _EmitInt;
                    // 混合
                    half3 finalRGB = (dirDiff + dirSpec) * shadow + envDiff + envSpec + rimLight + emission;
                // 透明剪切
                clip(var_MainTex.a - _Cutoff);
                // 返回值
                return float4(finalRGB, 1.0);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}
