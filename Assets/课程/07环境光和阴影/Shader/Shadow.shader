//阴影
Shader "Shader/Shadow"
{
   Properties {
        //TODO 材质面板参数
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
            #include"AutoLight.cginc"
            #include"Lighting.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0
            struct VertexInput {
                //TODO 输入结构
                float4 vertex : POSITION;
            };
            struct VertexOutput {
                //TODO 输出结构
                float4 pos : SV_POSITION;
                LIGHTING_COORDS(0,1)
            };
            VertexOutput vert (VertexInput v) {
                //TODO 顶点Shader
                VertexOutput o = (VertexOutput)0;
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                //TODO 像素Shader
                float shadow = LIGHT_ATTENUATION(i);
                return float4(shadow,shadow,shadow,1.0);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}
