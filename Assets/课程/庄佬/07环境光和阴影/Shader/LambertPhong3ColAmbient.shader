// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:34969,y:32861,varname:node_3138,prsc:2|emission-6812-OUT;n:type:ShaderForge.SFN_NormalVector,id:7076,x:32189,y:32647,prsc:2,pt:False;n:type:ShaderForge.SFN_LightVector,id:9030,x:32189,y:32822,varname:node_9030,prsc:2;n:type:ShaderForge.SFN_Dot,id:230,x:32351,y:32718,varname:node_230,prsc:2,dt:0|A-7076-OUT,B-9030-OUT;n:type:ShaderForge.SFN_Max,id:2283,x:32523,y:32718,varname:node_2283,prsc:2|A-230-OUT,B-9281-OUT;n:type:ShaderForge.SFN_Vector1,id:9281,x:32365,y:32878,varname:node_9281,prsc:2,v1:0;n:type:ShaderForge.SFN_Color,id:4835,x:32523,y:32507,ptovrint:False,ptlb:BassCol,ptin:_BassCol,varname:node_4835,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Multiply,id:8598,x:32684,y:32571,varname:node_8598,prsc:2|A-4835-RGB,B-2283-OUT;n:type:ShaderForge.SFN_LightVector,id:9796,x:31743,y:33048,varname:node_9796,prsc:2;n:type:ShaderForge.SFN_Vector1,id:5758,x:31743,y:33220,varname:node_5758,prsc:2,v1:-1;n:type:ShaderForge.SFN_Multiply,id:7087,x:31904,y:33093,varname:node_7087,prsc:2|A-9796-OUT,B-5758-OUT;n:type:ShaderForge.SFN_NormalVector,id:4911,x:31904,y:33253,prsc:2,pt:False;n:type:ShaderForge.SFN_Reflect,id:6611,x:32065,y:33145,varname:node_6611,prsc:2|A-7087-OUT,B-4911-OUT;n:type:ShaderForge.SFN_ViewVector,id:3643,x:32078,y:33305,varname:node_3643,prsc:2;n:type:ShaderForge.SFN_Dot,id:2565,x:32278,y:33155,varname:node_2565,prsc:2,dt:0|A-6611-OUT,B-3643-OUT;n:type:ShaderForge.SFN_Max,id:1747,x:32460,y:33165,varname:node_1747,prsc:2|A-2565-OUT,B-1303-OUT;n:type:ShaderForge.SFN_Vector1,id:1303,x:32307,y:33349,varname:node_1303,prsc:2,v1:0;n:type:ShaderForge.SFN_Power,id:8605,x:32626,y:33192,varname:node_8605,prsc:2|VAL-1747-OUT,EXP-1650-OUT;n:type:ShaderForge.SFN_Slider,id:1650,x:32307,y:33468,ptovrint:False,ptlb:SpecPow,ptin:_SpecPow,varname:node_1650,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:30,max:90;n:type:ShaderForge.SFN_Add,id:2056,x:32842,y:32833,varname:node_2056,prsc:2|A-8598-OUT,B-8605-OUT;n:type:ShaderForge.SFN_NormalVector,id:9277,x:31589,y:33565,prsc:2,pt:False;n:type:ShaderForge.SFN_ComponentMask,id:5615,x:31803,y:33545,varname:node_5615,prsc:2,cc1:1,cc2:-1,cc3:-1,cc4:-1|IN-9277-OUT;n:type:ShaderForge.SFN_Max,id:830,x:31988,y:33545,varname:node_830,prsc:2|A-5615-OUT,B-3367-OUT;n:type:ShaderForge.SFN_Vector1,id:3367,x:31803,y:33715,varname:node_3367,prsc:2,v1:0;n:type:ShaderForge.SFN_Subtract,id:998,x:32194,y:33593,varname:node_998,prsc:2|A-4227-OUT,B-830-OUT;n:type:ShaderForge.SFN_Vector1,id:4227,x:31988,y:33701,varname:node_4227,prsc:2,v1:1;n:type:ShaderForge.SFN_Subtract,id:7285,x:32373,y:33593,varname:node_7285,prsc:2|A-998-OUT,B-1706-OUT;n:type:ShaderForge.SFN_Multiply,id:4153,x:31988,y:33796,varname:node_4153,prsc:2|A-5615-OUT,B-4733-OUT;n:type:ShaderForge.SFN_Vector1,id:4733,x:31803,y:33818,varname:node_4733,prsc:2,v1:-1;n:type:ShaderForge.SFN_Max,id:1706,x:32194,y:33796,varname:node_1706,prsc:2|A-4153-OUT,B-3367-OUT;n:type:ShaderForge.SFN_Color,id:561,x:32539,y:33616,ptovrint:False,ptlb:EnvUpCol,ptin:_EnvUpCol,varname:node_561,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Color,id:8369,x:32684,y:33616,ptovrint:False,ptlb:EnvSideCol,ptin:_EnvSideCol,varname:_EnvUpCol_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Color,id:9249,x:32822,y:33616,ptovrint:False,ptlb:EnvDownCol,ptin:_EnvDownCol,varname:_EnvSideCol_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0,c2:0,c3:0,c4:1;n:type:ShaderForge.SFN_Multiply,id:6914,x:33002,y:33539,varname:node_6914,prsc:2|A-561-RGB,B-830-OUT;n:type:ShaderForge.SFN_Multiply,id:3640,x:33002,y:33707,varname:node_3640,prsc:2|A-8369-RGB,B-7285-OUT;n:type:ShaderForge.SFN_Multiply,id:4808,x:33002,y:33859,varname:node_4808,prsc:2|A-9249-RGB,B-1706-OUT;n:type:ShaderForge.SFN_Add,id:2792,x:33224,y:33598,varname:node_2792,prsc:2|A-6914-OUT,B-4808-OUT;n:type:ShaderForge.SFN_Add,id:9745,x:33404,y:33727,varname:node_9745,prsc:2|A-2792-OUT,B-3640-OUT;n:type:ShaderForge.SFN_Multiply,id:3263,x:33665,y:33633,varname:node_3263,prsc:2|A-9745-OUT,B-4190-OUT;n:type:ShaderForge.SFN_Slider,id:4190,x:33289,y:33906,ptovrint:False,ptlb:EvnInt,ptin:_EvnInt,varname:node_4190,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Multiply,id:7365,x:33885,y:33633,varname:node_7365,prsc:2|A-4835-RGB,B-3263-OUT;n:type:ShaderForge.SFN_Tex2d,id:136,x:34028,y:33370,ptovrint:False,ptlb:Occlusion,ptin:_Occlusion,varname:node_136,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:7501,x:34242,y:33562,varname:node_7501,prsc:2|A-136-RGB,B-7365-OUT;n:type:ShaderForge.SFN_Color,id:2453,x:33148,y:32666,ptovrint:False,ptlb:LightCol,ptin:_LightCol,varname:node_2453,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Multiply,id:9553,x:33359,y:32777,varname:node_9553,prsc:2|A-2453-RGB,B-2056-OUT;n:type:ShaderForge.SFN_Multiply,id:5953,x:33630,y:32785,varname:node_5953,prsc:2|A-7915-OUT,B-9553-OUT;n:type:ShaderForge.SFN_LightAttenuation,id:7915,x:33463,y:32584,varname:node_7915,prsc:2;n:type:ShaderForge.SFN_Add,id:6812,x:34492,y:33024,varname:node_6812,prsc:2|A-5953-OUT,B-7501-OUT;proporder:4835-1650-561-8369-9249-4190-136-2453;pass:END;sub:END;*/

Shader "Shader Forge/LambertPhong3ColAmbient" {
    Properties {
        _BassCol ("BassCol", Color) = (0.5,0.5,0.5,1)
        _SpecPow ("SpecPow", Range(0, 90)) = 30
        _EnvUpCol ("EnvUpCol", Color) = (1,1,1,1)
        _EnvSideCol ("EnvSideCol", Color) = (0.5,0.5,0.5,1)
        _EnvDownCol ("EnvDownCol", Color) = (0,0,0,1)
        _EvnInt ("EvnInt", Range(0, 1)) = 0
        _Occlusion ("Occlusion", 2D) = "white" {}
        _LightCol ("LightCol", Color) = (0.5,0.5,0.5,1)
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
            #include "Lighting.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0
            uniform sampler2D _Occlusion; uniform float4 _Occlusion_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float4, _BassCol)
                UNITY_DEFINE_INSTANCED_PROP( float, _SpecPow)
                UNITY_DEFINE_INSTANCED_PROP( float4, _EnvUpCol)
                UNITY_DEFINE_INSTANCED_PROP( float4, _EnvSideCol)
                UNITY_DEFINE_INSTANCED_PROP( float4, _EnvDownCol)
                UNITY_DEFINE_INSTANCED_PROP( float, _EvnInt)
                UNITY_DEFINE_INSTANCED_PROP( float4, _LightCol)
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
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                LIGHTING_COORDS(3,4)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.uv0 = v.texcoord0;
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
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
////// Emissive:
                float4 _LightCol_var = UNITY_ACCESS_INSTANCED_PROP( Props, _LightCol );
                float4 _BassCol_var = UNITY_ACCESS_INSTANCED_PROP( Props, _BassCol );
                float _SpecPow_var = UNITY_ACCESS_INSTANCED_PROP( Props, _SpecPow );
                float4 _Occlusion_var = tex2D(_Occlusion,TRANSFORM_TEX(i.uv0, _Occlusion));
                float4 _EnvUpCol_var = UNITY_ACCESS_INSTANCED_PROP( Props, _EnvUpCol );
                float node_5615 = i.normalDir.g;
                float node_3367 = 0.0;
                float node_830 = max(node_5615,node_3367);
                float4 _EnvDownCol_var = UNITY_ACCESS_INSTANCED_PROP( Props, _EnvDownCol );
                float node_1706 = max((node_5615*(-1.0)),node_3367);
                float4 _EnvSideCol_var = UNITY_ACCESS_INSTANCED_PROP( Props, _EnvSideCol );
                float _EvnInt_var = UNITY_ACCESS_INSTANCED_PROP( Props, _EvnInt );
                float3 emissive = ((attenuation*(_LightCol_var.rgb*((_BassCol_var.rgb*max(dot(i.normalDir,lightDirection),0.0))+pow(max(dot(reflect((lightDirection*(-1.0)),i.normalDir),viewDirection),0.0),_SpecPow_var))))+(_Occlusion_var.rgb*(_BassCol_var.rgb*((((_EnvUpCol_var.rgb*node_830)+(_EnvDownCol_var.rgb*node_1706))+(_EnvSideCol_var.rgb*((1.0-node_830)-node_1706)))*_EvnInt_var))));
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
            #include "Lighting.cginc"
            #pragma multi_compile_fwdadd_fullshadows
            #pragma target 3.0
            uniform sampler2D _Occlusion; uniform float4 _Occlusion_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float4, _BassCol)
                UNITY_DEFINE_INSTANCED_PROP( float, _SpecPow)
                UNITY_DEFINE_INSTANCED_PROP( float4, _EnvUpCol)
                UNITY_DEFINE_INSTANCED_PROP( float4, _EnvSideCol)
                UNITY_DEFINE_INSTANCED_PROP( float4, _EnvDownCol)
                UNITY_DEFINE_INSTANCED_PROP( float, _EvnInt)
                UNITY_DEFINE_INSTANCED_PROP( float4, _LightCol)
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
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                LIGHTING_COORDS(3,4)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.uv0 = v.texcoord0;
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
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 finalColor = 0;
                return fixed4(finalColor * 1,0);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
