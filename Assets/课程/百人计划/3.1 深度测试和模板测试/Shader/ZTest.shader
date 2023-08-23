Shader "Shader/ZTest"
{
    Properties {
        //TODO 材质面板参数
        _ID("Mask ID", int) = 1
    }
    SubShader {
        Tags {
            "RenderType"="Opaque" 
            "Queue" = "Geometry+1"
        }

         ColorMask 0
         ZWrite off

         Stencil
         {
             Ref [_ID]    
             Comp always
             Pass replace
             //Comp comparisonFunction
             //Pass stencilOperation
             //Fail stencilOperation
             //XFail stencilOperation
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
            //TODO 输入结构
            struct VertexInput {
                float4 vertex : POSITION;
            };
            //TODO 输出结构
            struct VertexOutput {
                float4 pos : SV_POSITION;
            };
            //TODO 顶点Shader
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            //TODO 像素Shader
            float4 frag(VertexOutput i) : COLOR {
                return float4(0,0.4,0,1.0);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}
