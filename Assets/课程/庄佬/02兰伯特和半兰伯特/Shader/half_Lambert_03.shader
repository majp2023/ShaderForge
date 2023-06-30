// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:33263,y:32467,varname:node_3138,prsc:2|emission-2131-RGB;n:type:ShaderForge.SFN_Dot,id:431,x:32322,y:32634,varname:node_431,prsc:2,dt:0|A-5158-OUT,B-4030-OUT;n:type:ShaderForge.SFN_NormalVector,id:5158,x:32147,y:32537,prsc:2,pt:False;n:type:ShaderForge.SFN_LightVector,id:4030,x:32147,y:32703,varname:node_4030,prsc:2;n:type:ShaderForge.SFN_Multiply,id:4774,x:32522,y:32660,varname:node_4774,prsc:2|A-431-OUT,B-974-OUT;n:type:ShaderForge.SFN_Vector1,id:974,x:32435,y:32853,varname:node_974,prsc:2,v1:0.5;n:type:ShaderForge.SFN_Add,id:6191,x:32731,y:32648,varname:node_6191,prsc:2|A-4774-OUT,B-8817-OUT;n:type:ShaderForge.SFN_Vector1,id:8817,x:32621,y:32870,varname:node_8817,prsc:2,v1:0.5;n:type:ShaderForge.SFN_Vector1,id:4335,x:32795,y:32909,varname:node_4335,prsc:2,v1:0.9;n:type:ShaderForge.SFN_Append,id:3975,x:32905,y:32704,varname:node_3975,prsc:2|A-6191-OUT,B-4335-OUT;n:type:ShaderForge.SFN_Tex2d,id:2131,x:33072,y:32856,ptovrint:False,ptlb:node_2131,ptin:_node_2131,varname:node_2131,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:64762182648488447aa471134ce5cc60,ntxv:0,isnm:False|UVIN-3975-OUT;proporder:2131;pass:END;sub:END;*/

Shader "Shader Forge/01/half_Lambert_03" {
    Properties {
        _node_2131 ("node_2131", 2D) = "white" {}
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
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0
            uniform sampler2D _node_2131; uniform float4 _node_2131_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float4 posWorld : TEXCOORD0;
                float3 normalDir : TEXCOORD1;
                LIGHTING_COORDS(2,3)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 normalDirection = i.normalDir;
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
////// Lighting:
////// Emissive:
                float2 node_3975 = float2(((dot(i.normalDir,lightDirection)*0.5)+0.5),0.9);
                float4 _node_2131_var = tex2D(_node_2131,TRANSFORM_TEX(node_3975, _node_2131));
                float3 emissive = _node_2131_var.rgb;
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
        Pass {
            Name "FORWARD_DELTA"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Blend One One
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdadd_fullshadows
            #pragma target 3.0
            uniform sampler2D _node_2131; uniform float4 _node_2131_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float4 posWorld : TEXCOORD0;
                float3 normalDir : TEXCOORD1;
                LIGHTING_COORDS(2,3)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 normalDirection = i.normalDir;
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
////// Lighting:
                float3 finalColor = 0;
                return fixed4(finalColor * 1,0);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
