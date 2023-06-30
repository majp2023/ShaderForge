// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:32735,y:31998,varname:node_3138,prsc:2|emission-639-OUT;n:type:ShaderForge.SFN_Vector1,id:4823,x:31347,y:32129,varname:node_4823,prsc:2,v1:-1;n:type:ShaderForge.SFN_LightVector,id:1154,x:31347,y:32281,varname:node_1154,prsc:2;n:type:ShaderForge.SFN_Multiply,id:4102,x:31505,y:32129,varname:node_4102,prsc:2|A-4823-OUT,B-1154-OUT;n:type:ShaderForge.SFN_NormalVector,id:4066,x:31505,y:32271,prsc:2,pt:False;n:type:ShaderForge.SFN_Multiply,id:7727,x:31657,y:32129,varname:node_7727,prsc:2|A-4102-OUT,B-4066-OUT;n:type:ShaderForge.SFN_ViewVector,id:9974,x:31657,y:32281,varname:node_9974,prsc:2;n:type:ShaderForge.SFN_Dot,id:1578,x:31809,y:32129,varname:node_1578,prsc:2,dt:0|A-7727-OUT,B-9974-OUT;n:type:ShaderForge.SFN_Max,id:3777,x:32013,y:32129,varname:node_3777,prsc:2|A-1578-OUT,B-8481-OUT;n:type:ShaderForge.SFN_Vector1,id:8481,x:31809,y:32291,varname:node_8481,prsc:2,v1:0;n:type:ShaderForge.SFN_NormalVector,id:8160,x:31461,y:32687,prsc:2,pt:False;n:type:ShaderForge.SFN_LightVector,id:7601,x:31461,y:32869,varname:node_7601,prsc:2;n:type:ShaderForge.SFN_Dot,id:9994,x:31632,y:32687,varname:node_9994,prsc:2,dt:0|A-8160-OUT,B-7601-OUT;n:type:ShaderForge.SFN_Vector1,id:2371,x:31632,y:32881,varname:node_2371,prsc:2,v1:0;n:type:ShaderForge.SFN_Max,id:3285,x:31799,y:32687,varname:node_3285,prsc:2|A-9994-OUT,B-2371-OUT;n:type:ShaderForge.SFN_Power,id:2079,x:32329,y:32130,varname:node_2079,prsc:2|VAL-3777-OUT,EXP-7291-OUT;n:type:ShaderForge.SFN_TexCoord,id:7620,x:31461,y:33045,varname:node_7620,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Vector1,id:7031,x:31461,y:33214,varname:node_7031,prsc:2,v1:1;n:type:ShaderForge.SFN_Slider,id:8211,x:31425,y:33343,ptovrint:False,ptlb:MaskTex,ptin:_MaskTex,varname:node_8211,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.6920985,max:1;n:type:ShaderForge.SFN_UVTile,id:8803,x:31686,y:33045,varname:node_8803,prsc:2|UVIN-7620-UVOUT,WDT-8211-OUT,HGT-8211-OUT,TILE-7031-OUT;n:type:ShaderForge.SFN_Tex2d,id:9219,x:31906,y:33045,ptovrint:False,ptlb:node_9219,ptin:_node_9219,varname:node_9219,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:f5e9735f222eb8741bf714554d221ebf,ntxv:0,isnm:False|UVIN-8803-UVOUT;n:type:ShaderForge.SFN_Slider,id:7243,x:31795,y:33338,ptovrint:False,ptlb:MaskRange,ptin:_MaskRange,varname:node_7243,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.2308506,max:1;n:type:ShaderForge.SFN_Step,id:3444,x:32151,y:33045,varname:node_3444,prsc:2|A-9219-RGB,B-7243-OUT;n:type:ShaderForge.SFN_Desaturate,id:8426,x:32342,y:33045,varname:node_8426,prsc:2|COL-3444-OUT;n:type:ShaderForge.SFN_Slider,id:6577,x:32152,y:33331,ptovrint:False,ptlb:SpecPow1,ptin:_SpecPow1,varname:node_6577,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:35.74859,max:100;n:type:ShaderForge.SFN_Slider,id:6836,x:32152,y:33439,ptovrint:False,ptlb:SpecPow2,ptin:_SpecPow2,varname:_SpecPow2,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:38.41233,max:100;n:type:ShaderForge.SFN_Lerp,id:7291,x:32562,y:33197,varname:node_7291,prsc:2|A-6577-OUT,B-6836-OUT,T-8426-OUT;n:type:ShaderForge.SFN_Lerp,id:1138,x:32126,y:32862,varname:node_1138,prsc:2|A-2965-RGB,B-5501-RGB,T-8426-OUT;n:type:ShaderForge.SFN_Color,id:5501,x:31799,y:32837,ptovrint:False,ptlb:node_5501,ptin:_node_5501,varname:node_5501,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:0.5,c3:0,c4:1;n:type:ShaderForge.SFN_Color,id:2965,x:31799,y:32517,ptovrint:False,ptlb:node_2965,ptin:_node_2965,varname:node_2965,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0,c2:1,c3:0.5,c4:1;n:type:ShaderForge.SFN_Multiply,id:6553,x:32126,y:32694,varname:node_6553,prsc:2|A-3285-OUT,B-1138-OUT;n:type:ShaderForge.SFN_Add,id:639,x:32389,y:32440,varname:node_639,prsc:2|A-2079-OUT,B-6553-OUT;proporder:8211-9219-7243-6577-6836-5501-2965;pass:END;sub:END;*/

Shader "Shader Forge/Rust" {
    Properties {
        _MaskTex ("MaskTex", Range(0, 1)) = 0.6920985
        _node_9219 ("node_9219", 2D) = "white" {}
        _MaskRange ("MaskRange", Range(0, 1)) = 0.2308506
        _SpecPow1 ("SpecPow1", Range(0, 100)) = 35.74859
        _SpecPow2 ("SpecPow2", Range(0, 100)) = 38.41233
        _node_5501 ("node_5501", Color) = (1,0.5,0,1)
        _node_2965 ("node_2965", Color) = (0,1,0.5,1)
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
            uniform sampler2D _node_9219; uniform float4 _node_9219_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _MaskTex)
                UNITY_DEFINE_INSTANCED_PROP( float, _MaskRange)
                UNITY_DEFINE_INSTANCED_PROP( float, _SpecPow1)
                UNITY_DEFINE_INSTANCED_PROP( float, _SpecPow2)
                UNITY_DEFINE_INSTANCED_PROP( float4, _node_5501)
                UNITY_DEFINE_INSTANCED_PROP( float4, _node_2965)
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
////// Emissive:
                float _SpecPow1_var = UNITY_ACCESS_INSTANCED_PROP( Props, _SpecPow1 );
                float _SpecPow2_var = UNITY_ACCESS_INSTANCED_PROP( Props, _SpecPow2 );
                float _MaskTex_var = UNITY_ACCESS_INSTANCED_PROP( Props, _MaskTex );
                float node_7031 = 1.0;
                float2 node_8803_tc_rcp = float2(1.0,1.0)/float2( _MaskTex_var, _MaskTex_var );
                float node_8803_ty = floor(node_7031 * node_8803_tc_rcp.x);
                float node_8803_tx = node_7031 - _MaskTex_var * node_8803_ty;
                float2 node_8803 = (i.uv0 + float2(node_8803_tx, node_8803_ty)) * node_8803_tc_rcp;
                float4 _node_9219_var = tex2D(_node_9219,TRANSFORM_TEX(node_8803, _node_9219));
                float _MaskRange_var = UNITY_ACCESS_INSTANCED_PROP( Props, _MaskRange );
                float node_8426 = dot(step(_node_9219_var.rgb,_MaskRange_var),float3(0.3,0.59,0.11));
                float4 _node_2965_var = UNITY_ACCESS_INSTANCED_PROP( Props, _node_2965 );
                float4 _node_5501_var = UNITY_ACCESS_INSTANCED_PROP( Props, _node_5501 );
                float3 emissive = (pow(max(dot((((-1.0)*lightDirection)*i.normalDir),viewDirection),0.0),lerp(_SpecPow1_var,_SpecPow2_var,node_8426))+(max(dot(i.normalDir,lightDirection),0.0)*lerp(_node_2965_var.rgb,_node_5501_var.rgb,node_8426)));
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
            uniform sampler2D _node_9219; uniform float4 _node_9219_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _MaskTex)
                UNITY_DEFINE_INSTANCED_PROP( float, _MaskRange)
                UNITY_DEFINE_INSTANCED_PROP( float, _SpecPow1)
                UNITY_DEFINE_INSTANCED_PROP( float, _SpecPow2)
                UNITY_DEFINE_INSTANCED_PROP( float4, _node_5501)
                UNITY_DEFINE_INSTANCED_PROP( float4, _node_2965)
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
                float3 finalColor = 0;
                return fixed4(finalColor * 1,0);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
