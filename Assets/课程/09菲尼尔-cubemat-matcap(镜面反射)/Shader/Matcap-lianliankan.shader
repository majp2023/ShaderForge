// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:33968,y:32297,varname:node_3138,prsc:2|emission-9473-OUT;n:type:ShaderForge.SFN_Tex2d,id:3726,x:31825,y:32507,ptovrint:False,ptlb:NormalMap,ptin:_NormalMap,varname:node_3726,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:143fd30d2b942eb468f1a8b3d0ffe6b6,ntxv:3,isnm:True;n:type:ShaderForge.SFN_Transform,id:9728,x:32023,y:32507,varname:node_9728,prsc:2,tffrom:2,tfto:0|IN-3726-RGB;n:type:ShaderForge.SFN_Transform,id:7159,x:32204,y:32290,varname:node_7159,prsc:2,tffrom:0,tfto:3|IN-9728-XYZ;n:type:ShaderForge.SFN_ComponentMask,id:3858,x:32403,y:32290,varname:node_3858,prsc:2,cc1:0,cc2:1,cc3:-1,cc4:-1|IN-7159-XYZ;n:type:ShaderForge.SFN_Multiply,id:4503,x:32591,y:32290,varname:node_4503,prsc:2|A-3858-OUT,B-7466-OUT;n:type:ShaderForge.SFN_Vector1,id:7466,x:32403,y:32459,varname:node_7466,prsc:2,v1:0.5;n:type:ShaderForge.SFN_Add,id:9343,x:32835,y:32290,varname:node_9343,prsc:2|A-4503-OUT,B-7466-OUT;n:type:ShaderForge.SFN_Tex2d,id:8619,x:33073,y:32290,ptovrint:False,ptlb:Matcap,ptin:_Matcap,varname:node_8619,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:de5028d995a7e5840b732eccd7da337f,ntxv:0,isnm:False|UVIN-9343-OUT;n:type:ShaderForge.SFN_Fresnel,id:649,x:33073,y:32487,varname:node_649,prsc:2|NRM-9728-XYZ,EXP-7917-OUT;n:type:ShaderForge.SFN_Slider,id:7917,x:32587,y:32640,ptovrint:False,ptlb:FresnelPow,ptin:_FresnelPow,varname:node_7917,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:10;n:type:ShaderForge.SFN_Multiply,id:3837,x:33325,y:32290,varname:node_3837,prsc:2|A-8619-RGB,B-649-OUT;n:type:ShaderForge.SFN_Multiply,id:9473,x:33622,y:32331,varname:node_9473,prsc:2|A-3837-OUT,B-5835-OUT;n:type:ShaderForge.SFN_Slider,id:5835,x:33276,y:32518,ptovrint:False,ptlb:EnvSpecInt,ptin:_EnvSpecInt,varname:node_5835,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:5;proporder:3726-8619-7917-5835;pass:END;sub:END;*/

Shader "Shader Forge/Matcap-lianliankan" {
    Properties {
        _NormalMap ("NormalMap", 2D) = "bump" {}
        _Matcap ("Matcap", 2D) = "white" {}
        _FresnelPow ("FresnelPow", Range(0, 10)) = 1
        _EnvSpecInt ("EnvSpecInt", Range(0, 5)) = 1
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
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0
            uniform sampler2D _NormalMap; uniform float4 _NormalMap_ST;
            uniform sampler2D _Matcap; uniform float4 _Matcap_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _FresnelPow)
                UNITY_DEFINE_INSTANCED_PROP( float, _EnvSpecInt)
            UNITY_INSTANCING_BUFFER_END( Props )
            struct VertexInput {
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                float3 tangentDir : TEXCOORD3;
                float3 bitangentDir : TEXCOORD4;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                i.normalDir = normalize(i.normalDir);
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
////// Lighting:
////// Emissive:
                float3 _NormalMap_var = UnpackNormal(tex2D(_NormalMap,TRANSFORM_TEX(i.uv0, _NormalMap)));
                float3 node_9728 = mul( _NormalMap_var.rgb, tangentTransform ).xyz;
                float node_7466 = 0.5;
                float2 node_9343 = ((mul( UNITY_MATRIX_V, float4(node_9728.rgb,0) ).xyz.rgb.rg*node_7466)+node_7466);
                float4 _Matcap_var = tex2D(_Matcap,TRANSFORM_TEX(node_9343, _Matcap));
                float _FresnelPow_var = UNITY_ACCESS_INSTANCED_PROP( Props, _FresnelPow );
                float _EnvSpecInt_var = UNITY_ACCESS_INSTANCED_PROP( Props, _EnvSpecInt );
                float3 emissive = ((_Matcap_var.rgb*pow(1.0-max(0,dot(node_9728.rgb, viewDirection)),_FresnelPow_var))*_EnvSpecInt_var);
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
