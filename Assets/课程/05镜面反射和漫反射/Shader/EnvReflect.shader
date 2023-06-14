// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:33738,y:32885,varname:node_3138,prsc:2|emission-9782-OUT;n:type:ShaderForge.SFN_LightVector,id:6278,x:32307,y:32670,varname:node_6278,prsc:2;n:type:ShaderForge.SFN_ViewReflectionVector,id:394,x:32307,y:32825,varname:node_394,prsc:2;n:type:ShaderForge.SFN_Dot,id:101,x:32452,y:32736,varname:node_101,prsc:2,dt:0|A-6278-OUT,B-394-OUT;n:type:ShaderForge.SFN_RemapRange,id:7411,x:32629,y:32736,varname:node_7411,prsc:2,frmn:-1,frmx:1,tomn:0,tomx:1|IN-101-OUT;n:type:ShaderForge.SFN_Append,id:7012,x:32812,y:32736,varname:node_7012,prsc:2|A-7411-OUT,B-6718-OUT;n:type:ShaderForge.SFN_Slider,id:6718,x:32577,y:32968,ptovrint:False,ptlb:RampType,ptin:_RampType,varname:node_6718,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Tex2d,id:3818,x:33003,y:32736,ptovrint:False,ptlb:RampTex,ptin:_RampTex,varname:node_3818,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-7012-OUT;n:type:ShaderForge.SFN_Slider,id:9754,x:32909,y:32973,ptovrint:False,ptlb:EnvReflect,ptin:_EnvReflect,varname:node_9754,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:1;n:type:ShaderForge.SFN_Multiply,id:3393,x:33221,y:32754,varname:node_3393,prsc:2|A-3818-RGB,B-9754-OUT;n:type:ShaderForge.SFN_Vector1,id:1144,x:32892,y:33111,varname:node_1144,prsc:2,v1:0;n:type:ShaderForge.SFN_Slider,id:630,x:32926,y:33297,ptovrint:False,ptlb:SpecularPow,ptin:_SpecularPow,varname:node_630,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:10,cur:30,max:90;n:type:ShaderForge.SFN_Power,id:9763,x:33277,y:33130,varname:node_9763,prsc:2|VAL-6773-OUT,EXP-630-OUT;n:type:ShaderForge.SFN_Add,id:9782,x:33432,y:32936,varname:node_9782,prsc:2|A-3393-OUT,B-9763-OUT;n:type:ShaderForge.SFN_Max,id:6773,x:33083,y:33098,varname:node_6773,prsc:2|A-101-OUT,B-1144-OUT;proporder:6718-3818-9754-630;pass:END;sub:END;*/

Shader "Shader Forge/EvnShader" {
    Properties {
        _RampType ("RampType", Range(0, 1)) = 0
        _RampTex ("RampTex", 2D) = "white" {}
        _EnvReflect ("EnvReflect", Range(0, 1)) = 1
        _SpecularPow ("SpecularPow", Range(10, 90)) = 30
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
            #pragma multi_compile_instancing
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0
            uniform sampler2D _RampTex; uniform float4 _RampTex_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _RampType)
                UNITY_DEFINE_INSTANCED_PROP( float, _EnvReflect)
                UNITY_DEFINE_INSTANCED_PROP( float, _SpecularPow)
            UNITY_INSTANCING_BUFFER_END( Props )
            struct VertexInput {
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float4 posWorld : TEXCOORD0;
                float3 normalDir : TEXCOORD1;
                LIGHTING_COORDS(2,3)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                i.normalDir = normalize(i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
////// Lighting:
////// Emissive:
                float node_101 = dot(lightDirection,viewReflectDirection);
                float _RampType_var = UNITY_ACCESS_INSTANCED_PROP( Props, _RampType );
                float2 node_7012 = float2((node_101*0.5+0.5),_RampType_var);
                float4 _RampTex_var = tex2D(_RampTex,TRANSFORM_TEX(node_7012, _RampTex));
                float _EnvReflect_var = UNITY_ACCESS_INSTANCED_PROP( Props, _EnvReflect );
                float node_1144 = 0.0;
                float _SpecularPow_var = UNITY_ACCESS_INSTANCED_PROP( Props, _SpecularPow );
                float3 emissive = ((_RampTex_var.rgb*_EnvReflect_var)+pow(max(node_101,node_1144),_SpecularPow_var));
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
            #pragma multi_compile_instancing
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdadd_fullshadows
            #pragma target 3.0
            uniform sampler2D _RampTex; uniform float4 _RampTex_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _RampType)
                UNITY_DEFINE_INSTANCED_PROP( float, _EnvReflect)
                UNITY_DEFINE_INSTANCED_PROP( float, _SpecularPow)
            UNITY_INSTANCING_BUFFER_END( Props )
            struct VertexInput {
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float4 posWorld : TEXCOORD0;
                float3 normalDir : TEXCOORD1;
                LIGHTING_COORDS(2,3)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                i.normalDir = normalize(i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
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
