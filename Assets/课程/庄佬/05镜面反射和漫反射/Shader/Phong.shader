// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:33523,y:32712,varname:node_3138,prsc:2|emission-664-OUT;n:type:ShaderForge.SFN_LightVector,id:7154,x:32311,y:32613,varname:node_7154,prsc:2;n:type:ShaderForge.SFN_Vector1,id:7284,x:32311,y:32783,varname:node_7284,prsc:2,v1:-1;n:type:ShaderForge.SFN_Multiply,id:9167,x:32508,y:32662,varname:node_9167,prsc:2|A-7154-OUT,B-7284-OUT;n:type:ShaderForge.SFN_NormalVector,id:6618,x:32508,y:32836,prsc:2,pt:False;n:type:ShaderForge.SFN_Reflect,id:4650,x:32657,y:32698,varname:node_4650,prsc:2|A-9167-OUT,B-6618-OUT;n:type:ShaderForge.SFN_ViewVector,id:1089,x:32664,y:32871,varname:node_1089,prsc:2;n:type:ShaderForge.SFN_Dot,id:2333,x:32803,y:32753,varname:node_2333,prsc:2,dt:0|A-4650-OUT,B-1089-OUT;n:type:ShaderForge.SFN_Vector1,id:3286,x:32803,y:32930,varname:node_3286,prsc:2,v1:0;n:type:ShaderForge.SFN_Max,id:9924,x:33104,y:32765,varname:node_9924,prsc:2|A-3347-OUT,B-3286-OUT;n:type:ShaderForge.SFN_Slider,id:7460,x:32947,y:33027,ptovrint:False,ptlb:SpecularPower,ptin:_SpecularPower,varname:node_7460,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:10,cur:30,max:90;n:type:ShaderForge.SFN_Power,id:664,x:33253,y:32858,varname:node_664,prsc:2|VAL-9924-OUT,EXP-7460-OUT;n:type:ShaderForge.SFN_ViewReflectionVector,id:2640,x:32663,y:32416,varname:node_2640,prsc:2;n:type:ShaderForge.SFN_LightVector,id:1324,x:32663,y:32557,varname:node_1324,prsc:2;n:type:ShaderForge.SFN_Dot,id:8064,x:32809,y:32483,varname:node_8064,prsc:2,dt:0|A-2640-OUT,B-1324-OUT;n:type:ShaderForge.SFN_SwitchProperty,id:3347,x:33003,y:32555,ptovrint:False,ptlb:简写,ptin:_,varname:node_3347,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False|A-2333-OUT,B-8064-OUT;proporder:7460-3347;pass:END;sub:END;*/

Shader "Shader Forge/Phong" {
    Properties {
        _SpecularPower ("SpecularPower", Range(10, 90)) = 30
        [MaterialToggle] _ ("简写", Float ) = 0
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
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _SpecularPower)
                UNITY_DEFINE_INSTANCED_PROP( fixed, _)
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
                float __var = lerp( dot(reflect((lightDirection*(-1.0)),i.normalDir),viewDirection), dot(viewReflectDirection,lightDirection), UNITY_ACCESS_INSTANCED_PROP( Props, _ ) );
                float _SpecularPower_var = UNITY_ACCESS_INSTANCED_PROP( Props, _SpecularPower );
                float node_664 = pow(max(__var,0.0),_SpecularPower_var);
                float3 emissive = float3(node_664,node_664,node_664);
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
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _SpecularPower)
                UNITY_DEFINE_INSTANCED_PROP( fixed, _)
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
