Shader "Shader/100/FlowMap"
{
     Properties {
        //TODO 材质面板参数
        _MainTex("主贴图", 2d) = "white" {}
        _Flowmap("Flowmap_Try", 2d) = "white" {}
        _TimeSpeed ("时间速度", float) = 1
        _FlowSpeed ("流动速度", float) = 1
        _MipLevel ("环境球Mip", Range(0, 7)) = 0
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
            uniform sampler2D _MainTex; uniform sampler2D _MainTex_ST; 
            uniform sampler2D _Flowmap;
            uniform float _TimeSpeed;
            uniform float _FlowSpeed;
            uniform float _MipLevel;
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
                o.pos = UnityObjectToClipPos( v.vertex );
                o.uv = v.uv;
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                //TODO 像素Shader
                float2 flowDir = tex2D(_Flowmap, i.uv).rg;

                //创建两个周期函数
                float phase0 = frac(_Time.x * _TimeSpeed);
                float phase1 = frac(_Time.x * _TimeSpeed + 0.5);

                //依据上面两个周期函数对uv进行偏移后，采样两张贴图(这里使用了MipMap缓解走样锯齿问题)
                half3 tex0 = tex2Dlod(_MainTex, float4(i.uv - flowDir * phase0 * _FlowSpeed, 0 , _MipLevel));
                half3 tex1 = tex2Dlod(_MainTex, float4(i.uv - flowDir * phase1 * _FlowSpeed, 0 , _MipLevel));

                //计算线性插值权重
                float flowLerp = abs(0.5 - phase0) / 0.5;

                //最终结果
                half3 col = lerp(tex0, tex1, flowLerp);

                return float4(col, 1.0);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}
