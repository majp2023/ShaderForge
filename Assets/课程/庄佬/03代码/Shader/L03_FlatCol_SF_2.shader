//���ģ��
Shader "Shader/L03_FlatCol_SF_2" {
    Properties {
        //TODO ����������
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
            struct VertexInput {
                //TODO ����ṹ
                float4 vertex : POSITION;
            };
            struct VertexOutput {
                //TODO ����ṹ
                float4 pos : SV_POSITION;
            };
            VertexOutput vert (VertexInput v) {
                //TODO ����Shader
                VertexOutput o = (VertexOutput)0;
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                //TODO ����Shader
                return float4(0,0.4,0,1.0);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}
