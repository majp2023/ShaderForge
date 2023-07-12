Shader "Shader/18/Sequence"
{
     Properties {
        //TODO 材质面板参数
         _MainTex("RGB：颜色A：透贴",2d) = "gray"{}
         _Opacity ("透明度", range(0, 1)) = 0.5
         _Sequence   ("序列帧", 2d) = "gray"{}
         _RowCount   ("行数", int) = 1
         _ColCount   ("列数", int) = 1
         _Speed      ("速度", range(0.0, 15.0)) = 1
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
            struct VertexInput {
                //TODO 输入结构
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };
            struct VertexOutput {
                //TODO 输出结构
                float4 pos : SV_POSITION;
                float2 uv : TEXCOORD0;
            };
            VertexOutput vert (VertexInput v) {
                //TODO 顶点Shader
                VertexOutput o = (VertexOutput)0;
                o.pos = UnityObjectToClipPos( v.vertex);    // 顶点位置 OS>CS
                o.uv = v.uv;                                // UV信息 支持TilingOffset
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                //TODO 像素Shader
                half4 var_MainTex = tex2D(_MainTex, i.uv);      // 采样贴图 RGB颜色 A透贴
                half3 finalRGB = var_MainTex.rgb;
                half opacity = var_MainTex.a * _Opacity;
                return half4(finalRGB * opacity, opacity);                // 返回值
            }
            ENDCG
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
             uniform sampler2D _Sequence; uniform float4 _Sequence_ST;
            uniform half _Opacity;
            uniform half _RowCount;
            uniform half _ColCount;
            uniform half _Speed;
            struct VertexInput {
                //TODO 输入结构
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 uv : TEXCOORD0;
            };
            struct VertexOutput {
                //TODO 输出结构
                float4 pos : SV_POSITION;
                float2 uv : TEXCOORD0;
            };
            VertexOutput vert (VertexInput v) {
                //TODO 顶点Shader
                VertexOutput o = (VertexOutput)0;
                v.vertex.xyz += v.normal * 0.03;            // 顶点位置法向挤出
                o.pos = UnityObjectToClipPos( v.vertex);    // 顶点位置 OS>CS
                o.uv = TRANSFORM_TEX(v.uv, _Sequence);      // 前置UV ST操作
                float id = floor(_Time.z * _Speed);         // 计算序列id
                float idV = floor(id / _ColCount);          // 计算V轴id
                float idU = id - idV * _ColCount;           // 计算U轴id
                float stepU = 1.0 / _ColCount;              // 计算U轴步幅
                float stepV = 1.0 / _RowCount;              // 计算V轴步幅
                float2 initUV = o.uv * float2(stepU, stepV) + float2(0.0, stepV * (_ColCount - 1.0));   // 计算初始UV
                o.uv = initUV + float2(idU * stepU, idV * stepV);   // 计算序列帧UV
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                //TODO 像素Shader
                half4 var_Sequence = tex2D(_Sequence, i.uv);      // 采样贴图 RGB颜色 A透贴
                half3 finalRGB = var_Sequence.rgb;
                half opacity = var_Sequence.a * _Opacity;
                return half4(finalRGB * opacity, opacity);        // 返回值
            }
            ENDCG
        }
    }
}
