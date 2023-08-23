Shader "hxsd/PhongPixel"
{
	Properties
	{
		_DiffuseColor("漫反射材质颜色", Color) = (1, 1, 1, 1)
		_SpecularColor("高光反射材质颜色", Color) = (1, 1, 1, 1)
		_Gloss("光晕系数", Range(4, 256)) = 10
	}

	SubShader
	{
		Pass
		{
			//设定光照模式为前向模式（才能正常获取光的颜色和光的方向）
			Tags { "LightMode" = "ForwardBase" }

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			//加载Cg语言的脚本，用来处理光照参数
			//处理光照的Cg库文件（cginc扩展名），目录在Unity的安装目录下Editor/Data/CGIncludes/Lighting.cginc
			#include "Lighting.cginc"

			//漫反射材质颜色
			fixed4 _DiffuseColor;
			//导入高光材质颜色
			fixed4 _SpecularColor;
			//导入高光光晕大小系数
			float _Gloss;

			//如果在Cg编程中，顶点或片元着色器接收多个数值的时候，一般会用结构体实现
			//从CPU接收到的数据
			struct c2v
			{
				float4 vertex : POSITION; //从CPU接收到的模型空间下的点的位置
				float3 normal : NORMAL; //从CPU接收到的当前点的模型空间下的法线向量
			};

			//因为在顶点着色器中，运算高光反射颜色
			struct v2f
			{
				float4 pos : SV_POSITION; //经过顶点着色器计算后的，当前点的裁剪空间下的位置
				float4 worldPos : TEXCOORD0; //借用纹理的语义，实现世界空间下，点的位置传递
				float3 normal : NORMAL; //世界空间下，法线的方向
			};

			//注意朱老师会把场景的灯开关关掉（小心）
			//高洛徳着色（逐顶点光照），光照计算应该编写在顶点着色器中
			v2f vert(c2v data)
			{
				//顶点着色器传递给片元着色器的数据结构体声明
				v2f r;

				//必须做的：将点从模型空间下，转换到裁剪空间下
				r.pos = UnityObjectToClipPos(data.vertex);

				//世界空间下，点的位置
				r.worldPos = mul(unity_ObjectToWorld, data.vertex);

				//世界空间下，法线的方向向量
				r.normal = mul((float3x3)unity_ObjectToWorld, data.normal);

				return r;
			}

			fixed4 frag(v2f data) : SV_Target
			{
				//将顶点着色器传递过来的法线向量，标准化
				fixed3 worldNormal = normalize(data.normal);
				//使用相机位置减去顶点着色器计算的世界坐标系下的点的位置，并标准化
				fixed3 viewDir = normalize(_WorldSpaceCameraPos.xyz - data.worldPos.xyz);
				//计算光线反射方向
				fixed3 refDir = normalize(reflect(normalize(-_WorldSpaceLightPos0.xyz), worldNormal));
				//高光计算公式
				fixed3 specular = _LightColor0.rgb * _SpecularColor.rgb * pow(max(0, dot(viewDir, refDir)), _Gloss);

				//漫反射计算
				fixed3 diffuse = _LightColor0.rgb * _DiffuseColor * max(0, dot(worldNormal, normalize(_WorldSpaceLightPos0.xyz)));

				fixed3 color = UNITY_LIGHTMODEL_AMBIENT.xyz + diffuse + specular;

				//将顶点着色器计算好的颜色，传递给GPU
				return fixed4(color, 1.0);
			}

			ENDCG
		}
	}

	Fallback "Diffuse"
}
