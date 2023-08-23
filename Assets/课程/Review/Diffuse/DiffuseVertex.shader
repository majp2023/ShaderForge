Shader "hxsd/DiffuseVertex"
{
	Properties
	{
		_DiffuseColor("漫反射颜色", Color) = (1, 1, 1, 1)
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

			//导入材质颜色
			fixed4 _DiffuseColor;

			//如果在Cg编程中，顶点或片元着色器接收多个数值的时候，一般会用结构体实现
			//从CPU接收到的数据
			struct c2v
			{
				float4 vertex : POSITION; //从CPU接收到的模型空间下的点的位置
				float3 normal : NORMAL; //从CPU接收到的当前点的模型空间下的法线向量
			};

			//因为在顶点着色器中，需要计算裁剪空间下点的位置和Phong着色计算出来的兰伯特定律计算后的颜色
			struct v2f
			{
				float4 pos : SV_POSITION; //经过顶点着色器计算后的，当前点的裁剪空间下的位置
				fixed3 color : COLOR; //经过兰伯特定律计算后的当前点的颜色
			};

			//注意朱老师会把场景的灯开关关掉（小心）
			//高洛徳着色（逐顶点光照），光照计算应该编写在顶点着色器中
			v2f vert(c2v data)
			{
				//顶点着色器传递给片元着色器的数据结构体声明
				v2f r;

				//必须做的：将点从模型空间下，转换到裁剪空间下
				//mul(UNITY_MATRIX_MVP, data.vertex)
				r.pos = UnityObjectToClipPos(data.vertex);

				//兰伯特定律计算
				//漫反射光照 = 光源的颜色 * 材质的漫反射颜色 * MAX（0, 标准化后物体表面法线向量 • 标准化后光源方向向量）

				//光照是在世界中发生，需要将所有的数值，变换到世界坐标系下，再运算
				//_Object2World矩阵是Unity提供的，用于转换模型空间下到世界空间下的转换矩阵
				//因为法线传递过来的是3x1的列矩阵，_Object2World是4x4的齐次矩阵，如果想做矩阵乘法，需要将齐次矩阵，变成3x3矩阵
				fixed3 worldNormal = normalize(mul((float3x3)unity_ObjectToWorld, data.normal));
				//获得直射光的光方向
				fixed3 worldLightDir = normalize(_WorldSpaceLightPos0.xyz);

				//公式运算
				fixed3 diffuse = _LightColor0.rgb * _DiffuseColor.rgb * max(0, dot(worldNormal, worldLightDir));

				//根据Phong光照模型，将环境光追加在最终计算后的颜色上
				r.color = UNITY_LIGHTMODEL_AMBIENT.xyz + diffuse;

				return r;
			}

			fixed4 frag(v2f data) : SV_Target
			{
				//将顶点着色器计算好的颜色，传递给GPU
				return fixed4(data.color, 1.0);
			}

			ENDCG
		}
	}

	Fallback "Diffuse"
}
