// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:33433,y:32743,varname:node_3138,prsc:2|emission-4777-OUT;n:type:ShaderForge.SFN_ViewVector,id:8126,x:32083,y:32654,varname:node_8126,prsc:2;n:type:ShaderForge.SFN_Vector1,id:4157,x:32083,y:32806,varname:node_4157,prsc:2,v1:-1;n:type:ShaderForge.SFN_Multiply,id:3779,x:32290,y:32695,varname:node_3779,prsc:2|A-8126-OUT,B-4157-OUT;n:type:ShaderForge.SFN_Tex2d,id:5537,x:32083,y:32901,ptovrint:False,ptlb:NormalMap,ptin:_NormalMap,varname:node_5537,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:a8cff2c87bbe7a44ebd7f4d6fcf215fe,ntxv:2,isnm:False;n:type:ShaderForge.SFN_Transform,id:8502,x:32290,y:32901,varname:node_8502,prsc:2,tffrom:2,tfto:0|IN-5537-RGB;n:type:ShaderForge.SFN_Reflect,id:6162,x:32485,y:32737,varname:node_6162,prsc:2|A-3779-OUT,B-8502-XYZ;n:type:ShaderForge.SFN_Cubemap,id:6011,x:32757,y:32730,ptovrint:False,ptlb:Cubemap,ptin:_Cubemap,varname:node_6011,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,pvfc:0|DIR-6162-OUT,MIP-7952-OUT;n:type:ShaderForge.SFN_Slider,id:7952,x:32445,y:32945,ptovrint:False,ptlb:CubemapMip,ptin:_CubemapMip,varname:node_7952,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:7;n:type:ShaderForge.SFN_Multiply,id:2893,x:32991,y:32751,varname:node_2893,prsc:2|A-6011-RGB,B-9643-OUT;n:type:ShaderForge.SFN_Slider,id:3177,x:32445,y:33063,ptovrint:False,ptlb:FresnelPow,ptin:_FresnelPow,varname:node_3177,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:10;n:type:ShaderForge.SFN_Fresnel,id:9643,x:32757,y:32986,varname:node_9643,prsc:2|NRM-8502-XYZ,EXP-3177-OUT;n:type:ShaderForge.SFN_Multiply,id:4777,x:33179,y:32820,varname:node_4777,prsc:2|A-2893-OUT,B-2763-OUT;n:type:ShaderForge.SFN_Slider,id:2763,x:32926,y:33032,ptovrint:False,ptlb:EnvSpecInt2,ptin:_EnvSpecInt2,varname:node_2763,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.2,max:5;proporder:5537-6011-7952-3177-2763;pass:END;sub:END;*/

Shader "Shader Forge/Cubemap" {
    Properties {
        _NormalMap ("NormalMap", 2D) = "black" {}
        _Cubemap ("Cubemap", Cube) = "_Skybox" {}
        _CubemapMip ("CubemapMip", Range(0, 7)) = 0
        _FresnelPow ("FresnelPow", Range(0, 10)) = 1
        _EnvSpecInt2 ("EnvSpecInt2", Range(0, 5)) = 0.2
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
            uniform samplerCUBE _Cubemap;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _CubemapMip)
                UNITY_DEFINE_INSTANCED_PROP( float, _FresnelPow)
                UNITY_DEFINE_INSTANCED_PROP( float, _EnvSpecInt2)
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
                float4 _NormalMap_var = tex2D(_NormalMap,TRANSFORM_TEX(i.uv0, _NormalMap));
                float3 node_8502 = mul( _NormalMap_var.rgb, tangentTransform ).xyz;
                float _CubemapMip_var = UNITY_ACCESS_INSTANCED_PROP( Props, _CubemapMip );
                float _FresnelPow_var = UNITY_ACCESS_INSTANCED_PROP( Props, _FresnelPow );
                float _EnvSpecInt2_var = UNITY_ACCESS_INSTANCED_PROP( Props, _EnvSpecInt2 );
                float3 emissive = ((texCUBElod(_Cubemap,float4(reflect((viewDirection*(-1.0)),node_8502.rgb),_CubemapMip_var)).rgb*pow(1.0-max(0,dot(node_8502.rgb, viewDirection)),_FresnelPow_var))*_EnvSpecInt2_var);
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
