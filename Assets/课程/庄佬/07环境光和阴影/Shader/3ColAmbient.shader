// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:33415,y:32496,varname:node_3138,prsc:2|emission-6025-OUT;n:type:ShaderForge.SFN_NormalVector,id:2030,x:31715,y:32595,prsc:2,pt:False;n:type:ShaderForge.SFN_ComponentMask,id:9923,x:31897,y:32595,varname:node_9923,prsc:2,cc1:1,cc2:-1,cc3:-1,cc4:-1|IN-2030-OUT;n:type:ShaderForge.SFN_Max,id:1701,x:32055,y:32595,varname:node_1701,prsc:2|A-9923-OUT,B-6478-OUT;n:type:ShaderForge.SFN_Vector1,id:6478,x:31897,y:32769,varname:node_6478,prsc:2,v1:0;n:type:ShaderForge.SFN_Vector1,id:6688,x:31897,y:32860,varname:node_6688,prsc:2,v1:-1;n:type:ShaderForge.SFN_Vector1,id:335,x:32055,y:32781,varname:node_335,prsc:2,v1:1;n:type:ShaderForge.SFN_Subtract,id:4313,x:32252,y:32656,varname:node_4313,prsc:2|A-335-OUT,B-1701-OUT;n:type:ShaderForge.SFN_Multiply,id:9261,x:32066,y:32860,varname:node_9261,prsc:2|A-9923-OUT,B-6688-OUT;n:type:ShaderForge.SFN_Max,id:6793,x:32252,y:32860,varname:node_6793,prsc:2|A-9261-OUT,B-6478-OUT;n:type:ShaderForge.SFN_Subtract,id:7115,x:32405,y:32656,varname:node_7115,prsc:2|A-4313-OUT,B-6793-OUT;n:type:ShaderForge.SFN_Color,id:3958,x:32405,y:32115,ptovrint:False,ptlb:EnvUpCol,ptin:_EnvUpCol,varname:node_3958,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Vector1,id:3218,x:32025,y:33169,varname:node_3218,prsc:2,v1:11;n:type:ShaderForge.SFN_Color,id:870,x:32405,y:32295,ptovrint:False,ptlb:EnvSideCol,ptin:_EnvSideCol,varname:_EnvUpCol_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Vector1,id:464,x:31961,y:33224,varname:node_464,prsc:2,v1:11;n:type:ShaderForge.SFN_Vector1,id:1916,x:32025,y:33288,varname:node_1916,prsc:2,v1:11;n:type:ShaderForge.SFN_Color,id:208,x:32405,y:32475,ptovrint:False,ptlb:EnvDownCo,ptin:_EnvDownCo,varname:_EnvUpCol_copy_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0,c2:0,c3:0,c4:1;n:type:ShaderForge.SFN_Multiply,id:375,x:32625,y:32656,varname:node_375,prsc:2|A-870-RGB,B-7115-OUT;n:type:ShaderForge.SFN_Multiply,id:8262,x:32625,y:32826,varname:node_8262,prsc:2|A-208-RGB,B-6793-OUT;n:type:ShaderForge.SFN_Multiply,id:1686,x:32625,y:32503,varname:node_1686,prsc:2|A-3958-RGB,B-1701-OUT;n:type:ShaderForge.SFN_Add,id:5087,x:32837,y:32518,varname:node_5087,prsc:2|A-1686-OUT,B-8262-OUT;n:type:ShaderForge.SFN_Add,id:4481,x:33002,y:32697,varname:node_4481,prsc:2|A-5087-OUT,B-375-OUT;n:type:ShaderForge.SFN_Tex2d,id:222,x:33021,y:32501,ptovrint:False,ptlb:Occlusion,ptin:_Occlusion,varname:node_222,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:6025,x:33196,y:32601,varname:node_6025,prsc:2|A-222-RGB,B-4481-OUT;proporder:3958-870-208-222;pass:END;sub:END;*/

Shader "Shader Forge/3ColAmbient" {
    Properties {
        _EnvUpCol ("EnvUpCol", Color) = (1,1,1,1)
        _EnvSideCol ("EnvSideCol", Color) = (0.5,0.5,0.5,1)
        _EnvDownCo ("EnvDownCo", Color) = (0,0,0,1)
        _Occlusion ("Occlusion", 2D) = "white" {}
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
            uniform sampler2D _Occlusion; uniform float4 _Occlusion_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float4, _EnvUpCol)
                UNITY_DEFINE_INSTANCED_PROP( float4, _EnvSideCol)
                UNITY_DEFINE_INSTANCED_PROP( float4, _EnvDownCo)
            UNITY_INSTANCING_BUFFER_END( Props )
            struct VertexInput {
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float2 uv0 : TEXCOORD0;
                float3 normalDir : TEXCOORD1;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                i.normalDir = normalize(i.normalDir);
                float3 normalDirection = i.normalDir;
////// Lighting:
////// Emissive:
                float4 _Occlusion_var = tex2D(_Occlusion,TRANSFORM_TEX(i.uv0, _Occlusion));
                float4 _EnvUpCol_var = UNITY_ACCESS_INSTANCED_PROP( Props, _EnvUpCol );
                float node_9923 = i.normalDir.g;
                float node_6478 = 0.0;
                float node_1701 = max(node_9923,node_6478);
                float4 _EnvDownCo_var = UNITY_ACCESS_INSTANCED_PROP( Props, _EnvDownCo );
                float node_6793 = max((node_9923*(-1.0)),node_6478);
                float4 _EnvSideCol_var = UNITY_ACCESS_INSTANCED_PROP( Props, _EnvSideCol );
                float3 emissive = (_Occlusion_var.rgb*(((_EnvUpCol_var.rgb*node_1701)+(_EnvDownCo_var.rgb*node_6793))+(_EnvSideCol_var.rgb*((1.0-node_1701)-node_6793))));
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
