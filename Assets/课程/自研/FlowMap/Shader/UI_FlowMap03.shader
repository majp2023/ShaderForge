Shader "VX/UI_FlowMap03"
{
     Properties {
        //TODO 材质面板参数
         [HDR] _MainCol("Tint", Color) = (1.0, 1.0, 1.0, 1.0)
         _MainTex("RGB：颜色A：透贴",2d) = "gray"{}
         _Flowmap("Flowmap", 2d) = "white" {}
         _FlowSpeed ("流动速度", Range(0, 1)) = 0
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
            uniform half3 _MainCol;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform sampler2D _Flowmap;
            uniform float _FlowSpeed;
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
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);//UV信息支持TilingOffset
                return o;
            }
            //TODO 像素Shader
            float4 frag(VertexOutput i) : COLOR {
                //采样FlowMap贴图
                float2 flowDir = tex2D(_Flowmap, i.uv).rg;
                flowDir = (flowDir - 0.5) * 2;

                float phase0 = frac(_Time.y * _FlowSpeed * 0.1);
                float phase1 = frac(_Time.y * _FlowSpeed * 0.1 + 0.5);

                half3 tex0 = tex2D(_MainTex, i.uv - flowDir * _FlowSpeed).xyz;
                half3 tex1 = tex2D(_MainTex, i.uv - flowDir * phase1 * _FlowSpeed).xyz;

                float lerpflow = abs((phase0 - 0.5) * 2);

                fixed3 col2 = lerp(tex0, tex1,lerpflow);

                //最终结果
                half3 col = tex0 * _MainCol;

                return float4(col, 1.0);//返回值
            }
            ENDCG
        }
    }
}
