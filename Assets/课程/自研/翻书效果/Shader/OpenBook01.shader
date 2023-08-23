Shader "Shader/OpenBook01"
{
    Properties {
        //TODO 材质面板参数
        _MainTex("MainTex", 2D) = "white" {}
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
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0
            uniform sampler2D _MainTex;
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
                half3 mainTex = tex2D(_MainTex, i.uv).rgb;
                return  float4(mainTex, 0.0);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}
