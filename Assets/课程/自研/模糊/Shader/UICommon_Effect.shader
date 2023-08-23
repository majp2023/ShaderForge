Shader "VX/UI/CommonEffect"
{

	Properties
	{
		[Header(_____________________Base____________________)]
		[HDR] _BaseColor("Base Color", Color) = (1, 1, 1,1)
		_BaseAlpha("Base Alpha", Range(0,1)) = 1
		_BaseMap("Base Map", 2D) = "white" {}
		_BaseIsPolarBlend("BaseIsPolarBlend", Range(0,1)) = 0
		_BaseTexRotation("BaseTexRotation", Float) = 0
		_SwirlIntensity("SwirlIntensity", Float) = 0
		_OccDeBlackBG("OccDeBlackBG", range(0,1)) = 0
		_BaseMapPannerX("BaseMapPannerX",Float) = 0
		_BaseMapPannerY("BaseMapPannerY",Float) = 0
		[Toggle]_CustomdataBaseTexUV("CustomdataBaseTexUV", Float) = 0
        [Toggle] _SCREENCOLOR("【SCREEN COLOR】", Float) = 0

		[Header(_____________________MASK____________________)]
		[Toggle] _MASKFEATURE("【MASK SWITCH】", Float) = 0
		_MaskTex("Mask Tex", 2D) = "white" {}
		_MaskIsPolarBlend("MaskIsPolarBlend", range(0,1)) = 0
		_MaskTexRotation("MaskTexRotation", Float) = 0
		_MaskFlowX("Flow X", Float) = 0
		_MaskFlowY("Flow Y", Float) = 0
		[Toggle]_CustomdataMaskUV("CustomdataMaskUV", Float) = 0

		[Header(_____________________MASK2____________________)]
		[Toggle] _MASKFEATURE2("【MASK2 SWITCH】", Float) = 0
		_MaskTex2("Mask Tex2", 2D) = "white" {}
		_MaskIsPolarBlend2("MaskIsPolarBlend2", range(0,1)) = 0
		_MaskTexRotation2("MaskTexRotation2", Float) = 0
		_MaskFlowX2("Flow X2", Float) = 0
		_MaskFlowY2("Flow Y2", Float) = 0
		[Toggle]_CustomdataMaskUV2("CustomdataMaskUV2", Float) = 0

		[Header(____________________Turbulence____________________)]
		[Toggle] _TURBEFEATURE("【TURBE SWITCH】", Float) = 0
		_TurbulenceTex("Turbulence Tex", 2D) = "black" {}
		_TurbulenceIsPolarBlend("TurbulenceIsPolarBlend", range(0,1)) = 0
		_TurbulenceTexRotation("TurbulenceTexRotation", Float) = 0
		_TurbulenceTexPannerX("Turbulence Tex Panner X", Float) = 0
		_TurbulenceTexPannerY("Turbulence Tex Panner Y", Float) = 0
		_TurbulenceX("TurbulenceX", Float) = 0
		_TurbulenceY("TurbulenceY", Float) = 0
		[Toggle]_CustomdataTurbulenceUV("CustomdataTurbulenceUV", Float) = 0

		[Header(__________________________Dissolve____________________________)]
		[Toggle] _DISSOLVEFEATURE("【DISSOLVE SWITCH】", Float) = 0
        [Toggle]_UseDissolveColor("Use Dissolve Color", Float) = 0
		[HDR] _DissolveColor("Dissolve Color", Color) = (1,1,0,1)
		_DissolveMask("Dissolve Mask", 2D) = "white" {}
		_DissolveIsPolarBlend("DissolveIsPolarBlend", Range(0,1)) = 0
		_DissolveTexRotation("DissolveTexRotation", Float) = 0
		_EdgeWidth("Edge Width", Range(-1, 1)) = 1
        _EdgeSharp("Edge Sharp", Range(0, 5)) = 1
		_Cutoff("Cut Off", Range(0, 1)) = 0
		[Toggle]_CustomdataDissolve("CustomdataDissolve", Float) = 0

		[Header(__________________________R G B____________________________)]
		[Toggle] _RGBFEATURE("【RGB SWITCH】", Float) = 0

		[HDR] _RGBLeftColor("RGB- Color", Color) = (0,0,1,1)
		[HDR] _RGBMidColor("RGB* Color", Color) = (0,1,0,1)
		[HDR] _RGBRightColor("RGB+ Color", Color) = (1,0,0,1)
		_RGBCutoff("RGB Cut Off", Range(-1, 1)) = 0

        [Header(__________________________BlackWhite____________________________)]
        [Toggle] _BLACKWHITE("【BLACKWHITE SWITCH】", Float) = 0
        _BlackWhiteCutoff("Black&&White Cut Off", Range(0, 1)) = 0

		[Space(30)]
		[Enum(UnityEngine.Rendering.BlendMode)] SrcBlend("SrcBlend", Float) = 5//SrcAlpha
		[Enum(UnityEngine.Rendering.BlendMode)] DstBlend("DstBlend", Float) = 10//One
		[Enum(UnityEngine.Rendering.CullMode)] _Cull("Cull Mode", Float) = 2
		[HDR] _FrontColor("Front Color", Color) = (1,1,1,1)
		[HDR] _BackColor("Back Color", Color) = (1,1,1,1)
		[Enum(off,0,On,1)] _ZWrite("ZWrite", float) = 0
		_ClipAlpha("Clip Alpha", Range(0, 1)) = 0
		
		_StencilComp ("Stencil Comparison", Float) = 8
		_Stencil ("Stencil ID", Float) = 0
		_StencilOp ("Stencil Operation", Float) = 0
		_StencilWriteMask ("Stencil Write Mask", Float) = 255
		_StencilReadMask ("Stencil Read Mask", Float) = 255

	}

	SubShader
	{
		Stencil
		{
			Ref [_Stencil]	
			Comp [_StencilComp]
			Pass [_StencilOp] 
			ReadMask [_StencilReadMask]
			WriteMask [_StencilWriteMask]
		}
		Tags{
			"RenderPipeline"="LightweightPipeline"
			"IgnoreProjector" = "True"
			"Queue" = "Transparent"
			"RenderType" = "Transparent"
		}

		Pass
		{
			Name "StandardUnlit"
            Tags{"LightMode" = "LightweightForward"}
			Blend[SrcBlend][DstBlend],One One
			Cull[_Cull]
			ZWrite[_ZWrite]
			//ZClip Off
			HLSLPROGRAM

			#pragma vertex vert
			#pragma fragment frag

			#pragma multi_compile __ _MASKFEATURE2_ON
			#pragma multi_compile __ _MASKFEATURE_ON
			#pragma multi_compile __ _TURBEFEATURE_ON
			#pragma multi_compile __ _DISSOLVEFEATURE_ON
			#pragma multi_compile __ _RGBFEATURE_ON
			#pragma multi_compile __ _SCREENCOLOR_ON
			//#pragma multi_compile_local __ _MASKFEATURE_ON
			//#pragma multi_compile_local __ _TURBEFEATURE_ON
			//#pragma multi_compile_local __ _DISSOLVEFEATURE_ON
			//#pragma multi_compile_local __ _RGBFEATURE_ON
			//#pragma multi_compile_local __ _SCREENCOLOR_ON
            #if defined(_SCREENCOLOR_ON)
                #define BASE_MAP _CameraOpaqueTexture
            #else
                #define BASE_MAP _BaseMap
            #endif


		

			#define TRANSFORM_TEX(tex, name) ((tex.xy) * name##_ST.xy + name##_ST.zw)
			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;
			float4 _Time;
			struct appdata
			{
				float4 vertex	: POSITION;
				half4  color	: COLOR;
				float4 uv		: TEXCOORD0;
				float4 custom1	: TEXCOORD1;
				float4 custom2	: TEXCOORD2;
			};

			struct v2f
			{
				float2 uv		: TEXCOORD0;
				float4 custom1	: TEXCOORD1;
				float4 custom2	: TEXCOORD2;
				float2 uv1		: TEXCOORD3;
				half4  color	: COLOR;
				float4 vertex	: SV_POSITION;
			};

#ifdef _MASKFEATURE_ON
			sampler2D _MaskTex;
			float4 _MaskTex_ST;
			half _MaskIsPolarBlend;
			half _MaskTexRotation;
			half _MaskFlowX;
			half _MaskFlowY;
			half _CustomdataMaskUV;
#endif

#ifdef _MASKFEATURE2_ON
			sampler2D _MaskTex2;
			float4 _MaskTex2_ST;
			half _MaskIsPolarBlend2;
			half _MaskTexRotation2;
			half _MaskFlowX2;
			half _MaskFlowY2;
			half _CustomdataMaskUV2;
#endif

#ifdef _DISSOLVEFEATURE_ON
			sampler2D _DissolveMask;
			float4 _DissolveMask_ST;
			half _DissolveIsPolarBlend;
			half _DissolveTexRotation;
			half _Cutoff;
			half4 _DissolveColor;
			half _EdgeWidth;
            half _EdgeSharp;
			half _CustomdataDissolve;
            half _UseDissolveColor;
#endif

			sampler2D BASE_MAP;
			float4 _BaseMap_ST;
			float4 _CameraOpaqueTexture_ST;

			half4 _BaseColor;
			half _BaseAlpha;
			half _BaseIsPolarBlend;
			half _BaseTexRotation;
			half _BaseMapPannerX;
			half _BaseMapPannerY;
			half _OccDeBlackBG;
			half _SwirlIntensity;
			half _CustomdataBaseTexUV;

#ifdef _TURBEFEATURE_ON
			sampler2D _TurbulenceTex;
			float4 _TurbulenceTex_ST;
			half _TurbulenceIsPolarBlend;
			half _TurbulenceTexRotation;
			half _TurbulenceTexPannerX;
			half _TurbulenceTexPannerY;
			half _TurbulenceX;
			half _TurbulenceY;
			half _CustomdataTurbulenceUV;
#endif

#ifdef _RGBFEATURE_ON
			half _RGBCutoff;
			half _RGBR;
			half _RGBG;
			half _RGBB;
			half4 _RGBRightColor;
			half4 _RGBLeftColor;
			half4 _RGBMidColor;
#endif

            half _BLACKWHITE;
            half _BlackWhiteCutoff;

			half _ClipAlpha;
			half3 _FrontColor;
			half3 _BackColor;

			//CBUFFER_START(UnityPerMaterial)
			//CBUFFER_END

            half GrayscaleDisappear(half inputGrayscale, half edgeSharp, half clip)
            {
                return saturate(inputGrayscale * edgeSharp - lerp(edgeSharp, -1.0, clip));
            }

			v2f vert(appdata v)
			{
				v2f o;
				//o.vertex = TransformObjectToHClip(v.vertex.xyz);
				o.vertex = mul(unity_MatrixVP, mul(unity_ObjectToWorld, float4(v.vertex.xyz, 1.0)));
				o.uv = v.uv.xy/* TRANSFORM_TEX(v.uv, _Diffuse)*/;
				o.uv1 = v.uv.zw;
				o.custom1 = v.custom1;
				o.custom2 = v.custom2;
				o.color = v.color;
				return o;
			}

			float2 polaruv(float2 uv)//Polar
			{
				float2 Puv;
				Puv = uv;
				Puv -= 0.5;
				Puv = float2(atan2(Puv.y, Puv.x) *0.159155/*/ 3.141593*0.5*/ + 0.5, length(Puv));
				return Puv;
			}

			float2 rotation(float2 uv, float angle) //Rotation uv
			{
				angle *= 0.01745f;
				float2 Ruv;
				//float Rangle;
				//Rangle = /*radians*/(angle);//角度转弧度
				Ruv = uv - 0.5;
				float s = sin(angle);
				float c = cos(angle);
				Ruv = float2(Ruv.x * c - Ruv.y * s, Ruv.x * s + Ruv.y * c) + 0.5;
				return Ruv;
			}

			float2 Swirl(float2 uv, float Intensity)//Swirl
			{
				uv -= 0.5;
				float dis = length(uv);
				float percent = 1 - dis;
				float theta = percent * percent * Intensity * 8;
				float s = sin(theta);
				float c = cos(theta);
				uv = float2(uv.x * c - uv.y * s, uv.x * s + uv.y * c);
				uv += 0.5;
				return uv;
			}

			half4 frag(v2f i, float face : VFACE) : SV_Target
			{
				float2 _UVTurbe = float2(0,0);

				float2 uvPolar = polaruv(i.uv.xy);
				//FEATURE:TURBE
				#ifdef _TURBEFEATURE_ON
					float2 uvTurbe = i.uv;
					uvTurbe = lerp(uvTurbe, uvPolar, _TurbulenceIsPolarBlend);
					uvTurbe = rotation(uvTurbe, _TurbulenceTexRotation);

					float currentTurbulenceTexPannerX = (_CustomdataTurbulenceUV == 0.0 ? _TurbulenceTexPannerX : i.custom2.z);
					float currentTurbulenceTexPannerY = (_CustomdataTurbulenceUV == 0.0 ? _TurbulenceTexPannerY : i.custom2.w);

					float2 _TurbulenceUV = (uvTurbe + float2(currentTurbulenceTexPannerX, currentTurbulenceTexPannerY) * _Time.g);
					float4 _TurbulenceTex_var = tex2D(_TurbulenceTex, TRANSFORM_TEX(_TurbulenceUV, _TurbulenceTex));

					float currentTurbulenceX = (_CustomdataTurbulenceUV == 0.0 ? _TurbulenceX : i.custom1.w);
					float currentTurbulenceY = (_CustomdataTurbulenceUV == 0.0 ? _TurbulenceY : i.custom1.w);

					float tuvoffsetx = currentTurbulenceX * _TurbulenceTex_var.r *_TurbulenceTex_var.a;
					float tuvoffsety = currentTurbulenceY * _TurbulenceTex_var.r *_TurbulenceTex_var.a;
					//float tuvoffsetx = _TurbulenceX * _TurbulenceTex_var.r *_TurbulenceTex_var.a;
					//float tuvoffsety = _TurbulenceY * _TurbulenceTex_var.r *_TurbulenceTex_var.a;
					_UVTurbe = float2 (tuvoffsetx, tuvoffsety);
				#endif

				//FEATURE:BASE
				float2 uvBase = i.uv.xy;
				uvBase = lerp(uvBase, uvPolar, _BaseIsPolarBlend);
				uvBase = rotation(uvBase, _BaseTexRotation);

				float currentBaseMapPannerX = (_CustomdataBaseTexUV == 0.0 ? _BaseMapPannerX * _Time.g: i.custom1.x);
				float currentBaseMapPannerY = (_CustomdataBaseTexUV == 0.0 ? _BaseMapPannerY * _Time.g: i.custom1.y);
				//float currentBaseMapPannerX = (_CustomdataBaseTexUV == 0.0 ? _BaseMapPannerX : i.custom1.x);
				//float currentBaseMapPannerY = (_CustomdataBaseTexUV == 0.0 ? _BaseMapPannerY : i.custom1.y);

				//uvBase += _UVTurbe + float2(currentBaseMapPannerX, currentBaseMapPannerY) * _Time.g;
				uvBase += _UVTurbe + float2(currentBaseMapPannerX, currentBaseMapPannerY);
				uvBase = Swirl(uvBase, _SwirlIntensity);

				half4 finalColor = tex2D(BASE_MAP, TRANSFORM_TEX(uvBase, BASE_MAP));
				finalColor.rgb *= _BaseColor.rgb;				


				//FEATURE:R -G -B SEPARATION
				#ifdef _RGBFEATURE_ON
					half4 finalColorL = tex2D(BASE_MAP, TRANSFORM_TEX(uvBase - float2(_RGBCutoff, 0), BASE_MAP));
					half4 finalColorR = tex2D(BASE_MAP, TRANSFORM_TEX(uvBase + float2(_RGBCutoff, 0), BASE_MAP));
					half4 rgbColor = finalColor;
					rgbColor.r = rgbColor.r*_RGBMidColor.r + finalColorL.r*_RGBLeftColor.r + finalColorR.r*_RGBRightColor.r;
					rgbColor.g = rgbColor.g*_RGBMidColor.g + finalColorL.g*_RGBLeftColor.g + finalColorR.g*_RGBRightColor.g;
					rgbColor.b = rgbColor.b*_RGBMidColor.b + finalColorL.b*_RGBLeftColor.b + finalColorR.b*_RGBRightColor.b;
					rgbColor.a = max(max(rgbColor.a, finalColorL.a), finalColorR.a);
					finalColor = rgbColor;
				#endif


				//BASE:MASK _MaskTex
				#ifdef _MASKFEATURE_ON
					float2 uvMask = i.uv;
					uvMask = lerp(uvMask, uvPolar, _MaskIsPolarBlend);
					uvMask = rotation(uvMask, _MaskTexRotation);
					
					float currentMaskFlowX = (_CustomdataMaskUV == 0.0 ? _MaskFlowX : i.custom2.x);
					float currentMaskFlowY = (_CustomdataMaskUV == 0.0 ? _MaskFlowY : i.custom2.y);

					uvMask += float2(currentMaskFlowX, currentMaskFlowY) * _Time.g;
					half4 mask = tex2D(_MaskTex, TRANSFORM_TEX(uvMask, _MaskTex)).rgba;

					finalColor *= mask;
				#endif

				#ifdef _MASKFEATURE2_ON
					float2 uvMask2 = i.uv;
					uvMask2 = lerp(uvMask2, uvPolar, _MaskIsPolarBlend2);
					uvMask2 = rotation(uvMask2, _MaskTexRotation2);
					
					float currentMaskFlowX2 = (_CustomdataMaskUV == 0.0 ? _MaskFlowX2 : i.custom2.x);
					float currentMaskFlowY2 = (_CustomdataMaskUV == 0.0 ? _MaskFlowY2 : i.custom2.y);

					uvMask2 += float2(currentMaskFlowX2, currentMaskFlowY2) * _Time.g;
					half4 mask2 = tex2D(_MaskTex2, TRANSFORM_TEX(uvMask2, _MaskTex2)).rgba;

					finalColor *= mask2;
				#endif

				#ifdef _DISSOLVEFEATURE_ON
					float2 uvDisslve = i.uv;
					uvDisslve = lerp(uvDisslve, uvPolar, _DissolveIsPolarBlend);
					uvDisslve = rotation(uvDisslve, _DissolveTexRotation);
					half dissolve = tex2D(_DissolveMask, TRANSFORM_TEX(uvDisslve, _DissolveMask)).r;

					//Dissolve CustomData
					float currentCutoff = (_CustomdataDissolve == 0.0 ? _Cutoff : i.custom1.z);

                    //half4 disTexCol = tex2D(_DisappearTex, uv_DisappearTex);
                    float outGrayscaleClamp = GrayscaleDisappear(dissolve, _EdgeSharp, currentCutoff);
                    float m = step(currentCutoff, dissolve);
                    //float softValue = lerp(m, outGrayscaleClamp, _EdgeSharp);

                    finalColor.a *= outGrayscaleClamp;
                    //disappearCache = outGrayscaleClamp;


					
					float dissoveAlpha = /*max(sign(m - _EdgeWidth), 0.0f)*/  m;
					float edge_area = saturate(1 - saturate((dissolve - currentCutoff + _EdgeWidth) *10))*pow(currentCutoff, 0.5f);
                    edge_area = saturate(1 - saturate((outGrayscaleClamp - _EdgeWidth) * 10)) * pow(outGrayscaleClamp, 0.5f);
                    edge_area = saturate(edge_area);

					//finalColor.a *= dissoveAlpha;
					finalColor.rgb = _UseDissolveColor == 0.0 ? finalColor.rgb : finalColor.rgb * (1 - edge_area) + _DissolveColor * edge_area;
				#endif

                //Black && White
                float grey = dot(finalColor.rgb, float3(0.22, 0.707, 0.071));
                float3 blackWhiteColor = lerp(finalColor.rgb, float3(grey, grey, grey), _BlackWhiteCutoff);
                //col.rgb = float3(grey, grey, grey);
                finalColor.rgb = (_BLACKWHITE == 0.0 ? finalColor.rgb : blackWhiteColor);


				finalColor.a = lerp(finalColor.a, finalColor.r*finalColor.a, _OccDeBlackBG)*_BaseColor.a;

				clip(finalColor.a - _ClipAlpha);
				finalColor.rgb *= (face >= 0 ? _FrontColor : _BackColor).rgb;
				finalColor.a *= _BaseAlpha;

				return half4(finalColor*i.color);
                //return half4(outGrayscaleClamp, outGrayscaleClamp, outGrayscaleClamp, 1);
                //return half4(m,m,m,1);
                //return half4(edge_area, edge_area, edge_area,1);
			}
			ENDHLSL
		}

	}
}
