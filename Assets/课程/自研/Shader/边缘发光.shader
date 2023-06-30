Shader "Shader/边缘发光"
{
   Properties {
        //TODO 材质面板参数
        //主颜色 || Main Color
		_MainColor("【主颜色】Main Color", Color) = (0.5,0.5,0.5,1)
		//漫反射纹理 || Diffuse Texture
		_TextureDiffuse("【漫反射纹理】Texture Diffuse", 2D) = "white" {}	
		//边缘发光颜色 || Rim Color
		_RimColor("【边缘发光颜色】Rim Color", Color) = (0.5,0.5,0.5,1)
		//边缘发光强度 ||Rim Power
		_RimPower("【边缘发光强度】Rim Power", Range(0.0, 36)) = 0.1
		//边缘发光强度系数 || Rim Intensity Factor
		_RimIntensity("【边缘发光强度系数】Rim Intensity", Range(0.0, 100)) = 3
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
             #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0
			//主颜色
			uniform float4 _MainColor;
			//漫反射纹理
			uniform sampler2D _TextureDiffuse; 
			//漫反射纹理_ST后缀版
			uniform float4 _TextureDiffuse_ST;
			//边缘光颜色
			uniform float4 _RimColor;
			//边缘光强度
			uniform float _RimPower;
			//边缘光强度系数
			uniform float _RimIntensity;
            struct VertexInput {
                //TODO 输入结构
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 uv0 : TEXCOORD0;
            };
            struct VertexOutput {
                //TODO 输出结构
                float4 pos : SV_POSITION;
                float4 uv0 : TEXCOORD0;
                float3 normal : NORMAL;
                float4 posWS : TEXCOORD1;
				float3 nDirWS : TEXCOORD2;//世界空间法线方向
                LIGHTING_COORDS(3,4)
            };
            VertexOutput vert (VertexInput v) {
                //TODO 顶点Shader
                VertexOutput o = (VertexOutput)0;
				o.pos = UnityObjectToClipPos( v.vertex );
				o.uv0 = v.uv0;
				o.posWS = mul(unity_ObjectToWorld, v.vertex);
				o.nDirWS = UnityObjectToWorldNormal(v.normal);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                //TODO 像素Shader
                //【8.1】方向参数准备 || Direction
				//视角方向
				float3 vDir = normalize(_WorldSpaceCameraPos.xyz - i.posWS.xyz);
				//法线方向
				float3 nDir = normalize(i.nDirWS);
				//光照方向
				float3 lDir = _WorldSpaceLightPos0.xyz;
 
				//【8.2】计算光照的衰减 || Lighting attenuation
				//阴影
				float Attenuation = LIGHT_ATTENUATION(i);
				//衰减后颜色值
				float3 AttenColor = Attenuation * _LightColor0.xyz;
 
				//float backMask = max(0.0, lDir.r) * AttenColor;

				//【8.3】计算漫反射 || Diffuse
				float nDotl = dot(nDir, lDir);
				float3 diffuse = max(0.0, nDotl) * AttenColor + UNITY_LIGHTMODEL_AMBIENT.xyz;

				//【8.4】准备自发光参数 || Emissive
				//计算边缘强度
				half Rim = 1.0 - max(0, dot(nDir, vDir));
				//计算出边缘自发光强度
				float3 emissive = _RimColor.rgb * pow(Rim,_RimPower) *_RimIntensity;
 
				//【8.5】计在最终颜色中加入自发光颜色 || Calculate the final color
				//最终颜色 = （漫反射系数 x 纹理颜色 x rgb颜色）+自发光颜色 || Final Color=(Diffuse x Texture x rgbColor)+Emissive
				float3 finalColor = diffuse * (tex2D(_TextureDiffuse, TRANSFORM_TEX(i.uv0.rg, _TextureDiffuse)).rgb * _MainColor.rgb) + emissive;
				
				//【8.6】返回最终颜色 || Return final color
				return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}
