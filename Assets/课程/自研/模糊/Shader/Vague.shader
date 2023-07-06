Shader "Shader/Vague"
{
    Properties {
        //TODO 材质面板参数
        _MainTexture ("主帖图", 2D) = "white" {}
        _DDXInt ("横向模糊", Range(0, 1)) = 0.015
        _DDYInt ("纵向模糊", Range(0, 1)) = 0.015
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
            uniform sampler2D _MainTexture;
            uniform float _DDXInt;
            uniform float _DDYInt;
            struct VertexInput {
                //TODO 输入结构
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };
            struct VertexOutput {
                //TODO 输出结构
                float4 pos : SV_POSITION;
                float2 uv : TEXCOORD0;//UV0
            };
            VertexOutput vert (VertexInput v) {
                //TODO 顶点Shader
                VertexOutput o = (VertexOutput)0;
                o.pos = UnityObjectToClipPos( v.vertex );
                o.uv = v.uv;
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                //TODO 像素Shader
                float4 mainTexture = tex2D(_MainTexture, i.uv, _DDXInt, _DDYInt);

                return mainTexture;//float4(0,0.4,0,1.0);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}
