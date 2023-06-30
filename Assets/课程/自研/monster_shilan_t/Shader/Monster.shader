Shader "Shader/Monster"
{
     Properties {
        //TODO 材质面板参数
        _MainTex ("主贴图",2d) = "white"{}
        _MaskTex("R:高光强度G:边缘光强度B:高光染色A:高光次幂",2d)="black"{}
        _NormalMap("法线贴图",2D) = "bump" {}
        _Cubemap("Cubmap",Cube)= "_Skybox" {}
        _CubemapMip("环境球Mip",Range(0,7)) = 0 
        _FresnelPow("菲涅尔次幂",Range(0,10)) = 1
        _EnvSpecInt("环境镜面反射强度",Range(0,5)) = 1
        _MainCol("颜色", color) = (1.0,1.0,1.0,1.0)
        [Gamma]_SpecularPow("高光次幂", range(1, 90)) = 30
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
            uniform sampler2D _MainTex;
            uniform sampler2D _MaskTex;
             uniform samplerCUBE _CubeMap;
            uniform sampler2D _NormalMap;
            uniform float _CubemapMip;
            uniform float _FresnelPow;
            uniform float _EnvSpecInt;
            uniform float3 _MainCol;
            uniform float _SpecularPow;
            struct VertexInput {
                //TODO 输入结构
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;//切线信息
            };
            struct VertexOutput {
                //TODO 输出结构
                float4 pos : SV_POSITION;
                float2 uv : TEXCOORD0;
                float3 nDirWS : TEXCOORD1;
                float4 posWS : TEXCOORD2;//世界顶点位置
                float3 tDirWS : TEXCOORD3;//世界切线方向
                float3 bDirWS : TEXCOORD4;//世界副切线方向
            };
            VertexOutput vert (VertexInput v) {
                //TODO 顶点Shader
                VertexOutput o = (VertexOutput)0;
                o.pos = UnityObjectToClipPos( v.vertex );
                o.uv = v.uv;
                o.posWS = mul(unity_ObjectToWorld,v.vertex);//顶点位置OS>WS
                o.nDirWS = UnityObjectToWorldNormal(v.normal);
                o.tDirWS = normalize(mul(unity_ObjectToWorld,float4(v.tangent.xyz,0.0)).xyz);//切线方向OS>WS
                o.bDirWS = normalize(cross(o.nDirWS, o.tDirWS) * v.tangent.w);//根据nDirtDir求bDir
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                //TODO 像素Shader
                //向量准备
                float3 lDirWs = _WorldSpaceLightPos0.xyz;
                float3 nDirTS = UnpackNormal(tex2D(_NormalMap,i.uv)).rgb;
                float3x3 TBN = float3x3(i.tDirWS,i.bDirWS,i.nDirWS);
                float3 nDirWS = normalize(mul(nDirTS, TBN));//计算Fresnel 计算vrDirWS
                float3 vDirWS = normalize(_WorldSpaceCameraPos.xyz - i.posWS.xyz);//计算Fresnel
                float3 vrDirWS = reflect(-vDirWS, nDirWS);//采样Cubema
                float3 vDir = normalize(_WorldSpaceCameraPos.xyz - i.posWS.xyz);
                float3 hDir = normalize(vDir + lDirWs);

                //采样纹理
                half4 var_MainTex = tex2D(_MainTex, i.uv);
                half4 var_MaskTex = tex2D(_MaskTex, i.uv);

                //中间量装备
                float ndotl = dot(i.nDirWS, lDirWs);
                float nDoth = dot(i.nDirWS, hDir);
                float halfLanbort = ndotl * 0.5 + 0.5;
                float vdotn = dot(vDirWS, nDirWS);

                //结果
                float3 var_Cubemap = texCUBElod(_CubeMap, float4(vrDirWS, _CubemapMip)).rgb;
                float fresnel = pow(max(0.0,1.0 - vdotn), _FresnelPow);
                float3 envSpecLighting = var_Cubemap * fresnel * _EnvSpecInt;
                float blinnPhong = pow(max(0.0, nDoth), _SpecularPow) * var_MaskTex.g * _MainCol;
                float3 finalRGB = halfLanbort * var_MainTex * envSpecLighting + blinnPhong;

                return float4(finalRGB,1.0);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}
