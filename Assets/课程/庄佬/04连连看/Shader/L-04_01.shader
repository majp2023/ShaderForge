// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:1,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:0,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:6169,x:32957,y:32744,varname:node_6169,prsc:2|emission-4101-OUT;n:type:ShaderForge.SFN_NormalVector,id:3686,x:32296,y:32770,prsc:2,pt:False;n:type:ShaderForge.SFN_Color,id:9406,x:32136,y:32594,ptovrint:False,ptlb:Directional Light,ptin:_DirectionalLight,varname:node_9406,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0,c2:1,c3:0,c4:1;n:type:ShaderForge.SFN_Normalize,id:9608,x:32296,y:32594,varname:node_9608,prsc:2|IN-9406-RGB;n:type:ShaderForge.SFN_Dot,id:6756,x:32445,y:32683,varname:node_6756,prsc:2,dt:0|A-9608-OUT,B-3686-OUT;n:type:ShaderForge.SFN_RemapRange,id:9431,x:32611,y:32683,varname:node_9431,prsc:2,frmn:-1,frmx:1,tomn:0,tomx:1|IN-6756-OUT;n:type:ShaderForge.SFN_Color,id:7737,x:32147,y:32967,ptovrint:False,ptlb:Add Light,ptin:_AddLight,varname:node_7737,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:0,c3:0,c4:1;n:type:ShaderForge.SFN_Multiply,id:6642,x:32318,y:32967,varname:node_6642,prsc:2|A-9431-OUT,B-7737-RGB;n:type:ShaderForge.SFN_Multiply,id:6978,x:32473,y:32967,varname:node_6978,prsc:2|A-6642-OUT,B-1732-OUT;n:type:ShaderForge.SFN_Slider,id:1732,x:32147,y:33147,ptovrint:False,ptlb:Intensity,ptin:_Intensity,varname:node_1732,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:2;n:type:ShaderForge.SFN_Tex2d,id:4426,x:32582,y:33349,ptovrint:False,ptlb:Texture,ptin:_Texture,varname:node_4426,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:19d321ae72fb633479a91d8e4a3e436a,ntxv:0,isnm:False|UVIN-2293-UVOUT;n:type:ShaderForge.SFN_Multiply,id:2061,x:32670,y:32979,varname:node_2061,prsc:2|A-6978-OUT,B-4426-RGB;n:type:ShaderForge.SFN_TexCoord,id:2293,x:32369,y:33234,varname:node_2293,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_SwitchProperty,id:4101,x:32832,y:33096,ptovrint:False,ptlb:switch,ptin:_switch,varname:node_4101,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False|A-4426-RGB,B-2061-OUT;proporder:9406-7737-1732-4426-4101;pass:END;sub:END;*/

Shader "Unlit/L-04_FlaCol_SF_01" {
    Properties {
        _DirectionalLight ("Directional Light", Color) = (0,1,0,1)
        _AddLight ("Add Light", Color) = (1,0,0,1)
        _Intensity ("Intensity", Range(0, 2)) = 1
        _Texture ("Texture", 2D) = "white" {}
        [MaterialToggle] _switch ("switch", Float ) = 0
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
            #pragma multi_compile_fog
            #pragma target 3.0
            uniform sampler2D _Texture; uniform float4 _Texture_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float4, _DirectionalLight)
                UNITY_DEFINE_INSTANCED_PROP( float4, _AddLight)
                UNITY_DEFINE_INSTANCED_PROP( float, _Intensity)
                UNITY_DEFINE_INSTANCED_PROP( fixed, _switch)
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
                UNITY_FOG_COORDS(2)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                float3 normalDirection = i.normalDir;
////// Lighting:
////// Emissive:
                float4 _Texture_var = tex2D(_Texture,TRANSFORM_TEX(i.uv0, _Texture));
                float4 _DirectionalLight_var = UNITY_ACCESS_INSTANCED_PROP( Props, _DirectionalLight );
                float4 _AddLight_var = UNITY_ACCESS_INSTANCED_PROP( Props, _AddLight );
                float _Intensity_var = UNITY_ACCESS_INSTANCED_PROP( Props, _Intensity );
                float3 _switch_var = lerp( _Texture_var.rgb, ((((dot(normalize(_DirectionalLight_var.rgb),i.normalDir)*0.5+0.5)*_AddLight_var.rgb)*_Intensity_var)*_Texture_var.rgb), UNITY_ACCESS_INSTANCED_PROP( Props, _switch ) );
                float3 emissive = _switch_var;
                float3 finalColor = emissive;
                fixed4 finalRGBA = fixed4(finalColor,1);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
