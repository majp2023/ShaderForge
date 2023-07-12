Shader "Shader/13/AD"
{
      Properties {
        //TODO 材质面板参数
        _MainTex("RGB：颜色A：透贴",2d) = "gray"{}
        _Opacity("透明值", Range(0, 1)) = 1
    }
    SubShader {
        Tags {
                "Queue"="Transparent"//调整渲染顺序
                "RenderType"="Transparent"//对应改为Cutout
                "ForceNoShadowCasting"="True"//关闭阴影投射
                "IgnoreProjector"="True"//不响应投射器
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Blend One One

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0
            uniform sampler2D _MainTex;
            uniform float4 _MainTex_ST;
            uniform float _Opacity;
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
                half4 var_MainTex = tex2D(_MainTex, i.uv);
                float3 finalRGB = var_MainTex.rgb;
                float opacity = var_MainTex.a * _Opacity;
                return half4(finalRGB * opacity, opacity);//返回值
            }
            ENDCG
        }
    }
}
