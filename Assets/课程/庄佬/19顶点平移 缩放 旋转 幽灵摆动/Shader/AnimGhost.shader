Shader "Shader/19/AnimGhost"
{
     Properties {
        //TODO 材质面板参数
         _MainTex("RGB：颜色A：透贴",2d) = "gray"{}
         _Opacity ("透明度", range(0, 1)) = 0.5
         _ScaleParams    ("天使圈缩放 X:强度 Y:速度 Z:校正", vector) = (0.2, 1.0, 4.5, 0.0)
         _SwingXParams   ("X轴扭动 X:强度 Y:速度 Z:波长", vector) = (1.0, 3.0, 1.0, 0.0)
         _SwingZParams   ("Z轴扭动 X:强度 Y:速度 Z:波长", vector) = (1.0, 3.0, 1.0, 0.0)
         _SwingYParams   ("Y轴起伏 X:强度 Y:速度 Z:滞后", vector) = (1.0, 3.0, 0.3, 0.0)
         _ShakeYParams   ("Y轴摇头 X:强度 Y:速度 Z:滞后", vector) = (20.0, 3.0, 0.3, 0.0)
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
            uniform float4 _ScaleParams;
            uniform float3 _SwingXParams;
            uniform float3 _SwingZParams;
            uniform float3 _SwingYParams;
            uniform float3 _ShakeYParams;
            //TODO 输入结构
            struct VertexInput {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float4 color : COLOR;           // 顶点色 遮罩用
            };
            //TODO 输出结构
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv : TEXCOORD0;
                float4 color : COLOR;
            };
            // 声明常量
            #define TWO_PI 6.283185
            // 顶点动画方法
            void AnimGhost (inout float3 vertex, inout float3 color) {
                // 缩放天使圈
                float scale = _ScaleParams.x * color.g * sin(frac(_Time.z * _ScaleParams.y) * TWO_PI);
                vertex.xyz *= 1.0 + scale;
                vertex.y -=  _ScaleParams.z * scale;
                // 幽灵摆动
                float swingX = _SwingXParams.x * sin(frac(_Time.z * _SwingXParams.y + vertex.y * _SwingXParams.z) * TWO_PI);
                float swingZ = _SwingZParams.x * sin(frac(_Time.z * _SwingZParams.y + vertex.y * _SwingZParams.z) * TWO_PI);
                vertex.xz += float2(swingX, swingZ) * color.r;
                 // 幽灵摇头
                float radY = radians(_ShakeYParams.x) * (1.0 - color.r) * sin(frac(_Time.z * _ShakeYParams.y - color.g * _ShakeYParams.z) * TWO_PI);
                float sinY, cosY = 0;
                sincos(radY, sinY, cosY);
                vertex.xz = float2(
                    vertex.x * cosY - vertex.z * sinY,
                    vertex.x * sinY + vertex.z * cosY
                );
                 // 幽灵起伏
                float swingY = _SwingYParams.x * sin(frac(_Time.z * _SwingYParams.y - color.g * _SwingYParams.z) * TWO_PI);
                vertex.y += swingY;
                // 处理顶点色
                float lightness = 1.0 + color.g * 1.0 + scale * 2.0;
                color = float3(lightness, lightness, lightness);
            }
            //TODO 顶点Shader
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                AnimGhost(v.vertex.xyz, v.color.rgb);
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
