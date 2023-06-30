Shader "Shader/13/AC"
{
      Properties {
        //TODO 材质面板参数
        _MainTex("RGB：颜色A：透贴",2d) = "gray"{}
        _Cutoff("透切阈值",range(0.0,1.0)) = 0.5
    }
    SubShader {
        Tags {
            //"RenderType"="Opaque"
                "RenderType" = "TransparentCutout"//对应改为Cutout
                "ForceNoShadowCasting" = "True"//关闭阴影投射
                "IgnoreProjector" = "True"//不响应投射器
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
            uniform float4 _MainTex_ST;
            uniform half _Cutoff;
            struct VertexInput {
                //TODO 输入结构
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;//UV信息采样贴图用
            };
            struct VertexOutput {
                //TODO 输出结构
                float4 pos : SV_POSITION;
                float2 uv : TEXCOORD0;//UV信息采样贴图用
            };
            VertexOutput vert (VertexInput v) {
                //TODO 顶点Shader
                VertexOutput o = (VertexOutput)0;
                o.pos = UnityObjectToClipPos( v.vertex );
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);//UV信息支持TilingOffset
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                //TODO 像素Shader
                half4 var_MainTex = tex2D(_MainTex,i.uv);//采样贴图RGB颜色A透贴
                clip(var_MainTex.a-_Cutoff);//透明剪切
                return var_MainTex;//float4(0,0.4,0,1.0);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}
