Shader "Shader/17/ScreenWarp"
{
    Properties {
        //TODO 材质面板参数
         _MainTex("RGB：颜色A：透贴",2d) = "gray"{}
         _Opacity ("透明度", range(0, 1)) = 0.5
         _WarpMidVal("扰动中间值", range(0, 1)) = 0.5
         _WarpInt("扰动强度", range(0, 5 )) = 1
    }
    SubShader {
        Tags {
                "Queue"="Transparent"//调整渲染顺序
                "RenderType"="Transparent"//对应改为Cutout
                "ForceNoShadowCasting"="True"//关闭阴影投射
                "IgnoreProjector"="True"//不响应投射器
        }

        //获取背景纹理
        GrabPass{
            "_BGTex"
        }

        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Blend One OneMinusSrcAlpha //修改混合方式One/SrcAlphaOneMinusSrcAlpha

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0
            uniform sampler2D _MainTex;
            uniform half _Opacity;
            uniform half _WarpMidVal;
            uniform half _WarpInt;
            uniform sampler2D _BGTex;
            struct VertexInput {
                //TODO 输入结构
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };
            struct VertexOutput {
                //TODO 输出结构
                float4 pos : SV_POSITION;
                float2 uv : TEXCOORD0;
                float4 grabPos : TEXCOORD1;
            };
            VertexOutput vert (VertexInput v) {
                //TODO 顶点Shader
                VertexOutput o = (VertexOutput)0;
                o.pos = UnityObjectToClipPos( v.vertex );
                o.uv = v.uv;
                o.grabPos = ComputeGrabScreenPos(o.pos);
                 return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                //TODO 像素Shader
                //采样基本纹理RGB颜色A透贴
                half4 var_MainTex = tex2D(_MainTex, i.uv);
                //扰动背景纹理采样UV
                i.grabPos.xy += (var_MainTex.r - _WarpMidVal) * _WarpInt;
                //采样背景
                half3 var_BGTex = tex2Dproj(_BGTex, i.grabPos).rgb;
                 //FinalRGB不透明度
                half3 finalRGB = lerp(1.0, var_MainTex.rgb, _Opacity) * var_BGTex;
                half opacity = var_MainTex.a;
                //返回值
                return half4(finalRGB * opacity, opacity);
            }
            ENDCG
        }
    }
}
