Shader "Shader/CubeMapScript"
{
    Properties {
        //TODO 材质面板参数
        _NormalMap("法线贴图",2D) = "bump" {}
        _Cubemap("环境球",Cube)= "_Skybox" {}
        _CubemapMip("环境球Mip",Range(0,7)) = 0 
        _FresnelPow("菲涅尔次幂",Range(0,10)) = 1
        _EnvSpecInt("环境镜面反射强度",Range(0,5)) = 1
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
            uniform samplerCUBE _CubeMap;
            uniform sampler2D _NormalMap;
            uniform float _CubemapMip;
            uniform float _FresnelPow;
            uniform float _EnvSpecInt;
            struct VertexInput {
                //TODO 输入结构
                float4 vertex : POSITION;//顶点信息
                float2 uv0 : TEXCOORD0;//uv信息
                float3 normal : NORMAL;//法线信息
                float4 tangent : TANGENT;//切线信息
            };
            struct VertexOutput {
                //TODO 输出结构
                float4 pos : SV_POSITION;//屏幕顶点位置
                float2 uv0 : TEXCOORD0;//uv信息
                float4 posWS : TEXCOORD1;//世界顶点位置
                float3 nDirWS : TEXCOORD2;//世界法线方向
                float3 tDirWS : TEXCOORD3;//世界切线方向
                float3 bDirWS : TEXCOORD4;//世界副切线方向
            };
            VertexOutput vert (VertexInput v) {
                //TODO 顶点Shader
                VertexOutput o = (VertexOutput)0;
                o.pos = UnityObjectToClipPos( v.vertex );
                o.uv0 = v.uv0;//传递uv信息
                o.posWS = mul(unity_ObjectToWorld,v.vertex);//顶点位置OS>WS
                o.nDirWS = UnityObjectToWorldNormal(v.normal);//法线方向OS>WS
                o.tDirWS = normalize(mul(unity_ObjectToWorld,float4(v.tangent.xyz,0.0)).xyz);//切线方向OS>WS
                o.bDirWS = normalize(cross(o.nDirWS, o.tDirWS) * v.tangent.w);//根据nDirtDir求bDir
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                //TODO 像素Shader
                //准备向量
                float3 nDirTS = UnpackNormal(tex2D(_NormalMap,i.uv0)).rgb;
                float3x3 TBN = float3x3(i.tDirWS,i.bDirWS,i.nDirWS);
                float3 nDirWS = normalize(mul(nDirTS, TBN));//计算Fresnel 计算vrDirWS
                float3 vDirWS = normalize(_WorldSpaceCameraPos.xyz - i.posWS.xyz);//计算Fresnel
                float3 vrDirWS = reflect(-vDirWS, nDirWS);//采样Cubema

                 //准备中间变量
                float vdotn = dot(vDirWS, nDirWS);

                //光照模型
                float3 var_Cubemap = texCUBElod(_CubeMap, float4(vrDirWS,_CubemapMip)).rgb;
                float fresnel = pow(max(0.0,1.0 - vdotn),_FresnelPow);
                float3 envSpecLighting = var_Cubemap * fresnel * _EnvSpecInt;

                 //返回值
                return float4(envSpecLighting,1.0);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}
