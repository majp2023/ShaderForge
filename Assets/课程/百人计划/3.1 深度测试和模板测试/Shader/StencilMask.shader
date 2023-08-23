Shader "Shader/StencilMask"
{
    Properties {
        //TODO 材质面板参数
        _Color("颜色", color) = (1,1,1,1)
        _ID("Mask ID", int) = 1
        _NameTex("名字贴图", 2d) = "gray"{}
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
            "Queue" = "Geometry+2"
        }

        Stencil{
            Ref[_ID]
            Comp equal
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
            #pragma multi_compile_fwdbase_fullshadows
            float3 _Color;
            sampler2D _NameTex;

            #pragma target 3.0
            //TODO 输入结构
            struct VertexInput {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };
            //TODO 输出结构
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv : TEXCOORD0;
            };
            //TODO 顶点Shader
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.pos = UnityObjectToClipPos( v.vertex );
                o.uv = v.uv;
                return o;
            }
            //TODO 像素Shader
            float4 frag(VertexOutput i) : COLOR {
                float4 var_NameTex = tex2D(_NameTex, i.uv);
                return float4(var_NameTex.rgb, 0);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}
