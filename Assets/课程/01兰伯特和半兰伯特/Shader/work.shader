// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:33761,y:32730,varname:node_3138,prsc:2|emission-1084-RGB,olwid-5289-OUT,olcol-2108-OUT;n:type:ShaderForge.SFN_Dot,id:431,x:32325,y:32600,varname:node_431,prsc:2,dt:0|A-5158-OUT,B-4030-OUT;n:type:ShaderForge.SFN_NormalVector,id:5158,x:32147,y:32537,prsc:2,pt:False;n:type:ShaderForge.SFN_LightVector,id:4030,x:32147,y:32703,varname:node_4030,prsc:2;n:type:ShaderForge.SFN_Multiply,id:4872,x:32527,y:32633,varname:node_4872,prsc:2|A-431-OUT,B-3596-OUT;n:type:ShaderForge.SFN_Vector1,id:3596,x:32369,y:32767,varname:node_3596,prsc:2,v1:0.5;n:type:ShaderForge.SFN_Add,id:2570,x:32721,y:32712,varname:node_2570,prsc:2|A-4872-OUT,B-6966-OUT;n:type:ShaderForge.SFN_Vector1,id:6966,x:32545,y:32843,varname:node_6966,prsc:2,v1:0.5;n:type:ShaderForge.SFN_Append,id:4470,x:32885,y:32774,varname:node_4470,prsc:2|A-2570-OUT,B-3694-OUT;n:type:ShaderForge.SFN_Vector1,id:3694,x:32705,y:32964,varname:node_3694,prsc:2,v1:0.5;n:type:ShaderForge.SFN_Tex2d,id:1084,x:32965,y:32939,ptovrint:False,ptlb:node_1084,ptin:_node_1084,varname:node_1084,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:19d321ae72fb633479a91d8e4a3e436a,ntxv:0,isnm:False|UVIN-4470-OUT;n:type:ShaderForge.SFN_Vector3,id:2108,x:33349,y:33141,varname:node_2108,prsc:2,v1:0.4,v2:0.06,v3:0.26;n:type:ShaderForge.SFN_Vector1,id:5289,x:33359,y:33037,varname:node_5289,prsc:2,v1:0.015;proporder:1084;pass:END;sub:END;*/

Shader "Shader Forge/01/work" {
    Properties {
        _node_1084 ("node_1084", 2D) = "white" {}
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        Pass {
            Name "Outline"
            Tags {
            }
            Cull Front
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma target 3.0
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.pos = UnityObjectToClipPos( float4(v.vertex.xyz + v.normal*0.015,1) );
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                return fixed4(float3(0.4,0.06,0.26),0);
            }
            ENDCG
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
            uniform sampler2D _node_1084; uniform float4 _node_1084_ST;
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
                float2 node_4470 = float2(((dot(i.normalDir,lightDirection)*0.5)+0.5),0.5);
                float4 _node_1084_var = tex2D(_node_1084,TRANSFORM_TEX(node_4470, _node_1084));
                float3 emissive = _node_1084_var.rgb;
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
            uniform sampler2D _node_1084; uniform float4 _node_1084_ST;
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
