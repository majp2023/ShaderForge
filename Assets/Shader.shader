//最简洁的Shader
Shader "Shader/Concise" {
    Properties{
        //TODO 材质面板参数
    }
    SubShader{
        Tags {
            "RenderType" = "Opaque"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode" = "ForwardBase"
            }


            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0
            struct VertexInput {
        //TODO 输入结构
        float4 vertex : POSITION; //顶点信息
    };
    struct VertexOutput {
        //TODO 输出结构
        float4 pos : SV_POSITION; //由模型顶点信息换算而来的顶点屏幕位置
    };
    VertexOutput vert(VertexInput v) {
        //TODO 顶点Shader
        VertexOutput o = (VertexOutput)0;             //新建一个输出结构
        o.pos = UnityObjectToClipPos(v.vertex);       //变换质点信息 并将其塞给输出结构
        return o;                                     //将输出结构输出
    }
    float4 frag(VertexOutput i) : COLOR{
        
        return float4(0, 0,0,1.0);
    }
    ENDCG
}
    }
        FallBack "Diffuse"
}
