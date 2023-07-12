Shader "Shader/19/Scaling"
{
    Properties {
        //TODO 材质面板参数
         _MainTex("RGB：颜色A：透贴",2d) = "gray"{}
         _Opacity ("透明度", range(0, 1)) = 0.5
         _ScaleRange     ("缩放范围", range(0.0, 0.5)) = 0.2
         _ScaleSpeed     ("缩放速度", range(0.0, 3.0)) = 1.0
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
            Blend One OneMinusSrcAlpha

            //Zwrite Off  //可以稍微缓解一下排序的问题

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform half _Opacity;
            uniform float _ScaleRange;
            uniform float _ScaleSpeed;
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
            // 声明常量
            #define TWO_PI 6.283185
            // 顶点动画方法
            void Scaling (inout float3 vertex) {
                vertex *= 1.0 + _ScaleRange * sin(frac(_Time.z * _ScaleSpeed) * TWO_PI);
            }
            //TODO 顶点Shader
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                Scaling(v.vertex.xyz);
                o.pos = UnityObjectToClipPos( v.vertex );
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);//UV信息支持TilingOffset
                return o;
            }
            //TODO 像素Shader
            float4 frag(VertexOutput i) : COLOR {
                half4 var_MainTex = tex2D(_MainTex, i.uv);//采样贴图RGB颜色A透贴
                half3 finalRGB = var_MainTex.rgb;
                float opacity = var_MainTex.a * _Opacity;
                return float4(finalRGB * opacity, opacity);//返回值
            }
            ENDCG
        }
    }
}
