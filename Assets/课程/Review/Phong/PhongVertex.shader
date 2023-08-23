Shader "hxsd/PhongVertex"
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

			//导入漫反射材质颜色
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

			//因为在顶点着色器中，运算Phong光照模型运算
			struct v2f
			{
				float4 pos : SV_POSITION; //经过顶点着色器计算后的，当前点的裁剪空间下的位置
				fixed3 color : COLOR; //经过Phong光照模型运算后的当前点的颜色
			};

			//注意朱老师会把场景的灯开关关掉（小心）
			//高洛徳着色（逐顶点光照），光照计算应该编写在顶点着色器中
			v2f vert(c2v data)
			{
				//顶点着色器传递给片元着色器的数据结构体声明
				v2f r;

				//必须做的：将点从模型空间下，转换到裁剪空间下
				r.pos = UnityObjectToClipPos(data.vertex);

				//高光反射运算
				//高光光照 = 光源的颜色 * 材质高光反射颜色 * 〖MAX(0,标准化后的观察方向向量 • 标准化后的反射方向)〗^ 光晕系数
				//光反射方向：reflect（入射光的方向，当前点的法线方向）

				//光照是在世界中发生，需要将所有的数值，变换到世界坐标系下，再运算
				//_Object2World矩阵是Unity提供的，用于转换模型空间下到世界空间下的转换矩阵
				//因为法线传递过来的是3x1的列矩阵，_Object2World是4x4的齐次矩阵，如果想做矩阵乘法，需要将齐次矩阵，变成3x3矩阵
				fixed3 worldNormal = normalize(mul((float3x3)unity_ObjectToWorld, data.normal));

				//观察方向（相机的位置点 - 被渲染点的位置，在世界空间下）
				fixed3 viewDir = normalize(_WorldSpaceCameraPos.xyz - mul(unity_ObjectToWorld, data.vertex).xyz);

				//_WorldSpaceLightPos0是物体到光的方向
				//光线反射的方向
				fixed3 refDir = normalize(reflect(normalize(-_WorldSpaceLightPos0.xyz), worldNormal));

				//高光计算公式
				fixed3 specular = _LightColor0.rgb * _SpecularColor.rgb * pow(max(0, dot(viewDir, refDir)), _Gloss);

				//兰伯特定律计算
				//漫反射光照 = 光源的颜色 * 材质的漫反射颜色 * MAX（0, 标准化后物体表面法线向量 • 标准化后光源方向向量）
				fixed3 diffuse = _LightColor0.rgb * _DiffuseColor * max(0, dot(worldNormal, normalize(_WorldSpaceLightPos0.xyz)));

				//Phong光照模型，颜色的叠加
				r.color = UNITY_LIGHTMODEL_AMBIENT.xyz + diffuse + specular;

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
