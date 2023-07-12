Shader "Shader/17/ScreenUV"
{
    Properties {
        //TODO 材质面板参数
         _MainTex("RGB：颜色A：透贴",2d) = "gray"{}
         _Opacity ("透明度", range(0, 1)) = 0.5
         _ScreenTex("屏幕纹理", 2d) = "black" {}
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
            Blend One OneMinusSrcAlpha //修改混合方式One/SrcAlphaOneMinusSrcAlpha

            //Zwrite Off  //可以稍微缓解一下排序的问题

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0
            uniform sampler2D _MainTex;
            uniform half _Opacity;
            uniform sampler2D _ScreenTex; uniform float4 _ScreenTex_ST;
            struct VertexInput {
                //TODO 输入结构
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };
            struct VertexOutput {
                //TODO 输出结构
                float4 pos : SV_POSITION;
                float2 uv : TEXCOORD0;
                float2 screenUV : TEXCOORD1;
            };
            VertexOutput vert (VertexInput v) {
                //TODO 顶点Shader
                VertexOutput o = (VertexOutput)0;
                o.pos = UnityObjectToClipPos( v.vertex );
                o.uv = v.uv;
                float3 posVS = UnityObjectToViewPos(v.vertex).xyz;
                float originDist = UnityObjectToViewPos(float3(0.0,0.0,0.0)).z;
                o.screenUV = posVS.xy / posVS.z;
                o.screenUV *= originDist;
                o.screenUV = o.screenUV * _ScreenTex_ST.xy -frac(_Time.x * _ScreenTex_ST.zw);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                //TODO 像素Shader
                half4 var_MainTex = tex2D(_MainTex, i.uv);//采样贴图RGB颜色A透贴
                half var_ScreenTex = tex2D(_ScreenTex, i.screenUV).r;

                half3 finalRGB = var_MainTex.rgb;
                float opacity = var_MainTex.a * _Opacity * var_ScreenTex;
                return float4(finalRGB * opacity, opacity);//返回值
            }
            ENDCG
        }
    }
}
