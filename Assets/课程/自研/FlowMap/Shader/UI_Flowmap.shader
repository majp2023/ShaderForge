// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "VX/flowap"
{
	Properties
	{
		[PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
		_Color ("Tint", Color) = (1,1,1,1)
		
		_StencilComp ("Stencil Comparison", Float) = 8
		_Stencil ("Stencil ID", Float) = 0
		_StencilOp ("Stencil Operation", Float) = 0
		_StencilWriteMask ("Stencil Write Mask", Float) = 255
		_StencilReadMask ("Stencil Read Mask", Float) = 255

		_ColorMask ("Color Mask", Float) = 15

		[Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip ("Use Alpha Clip", Float) = 0
		_maintex("maintex", 2D) = "white" {}
		_flowmap("flowmap", 2D) = "white" {}
		_dissolvetex("dissolvetex", 2D) = "white" {}
		[Enum(on,0,off,1)]_UseDissOrCu("UseDissOrCu", Float) = 0
		_powerflow("powerflow", Range( 0 , 1)) = 0
		_powerdiss1("powerdiss1", Range( 0 , 1)) = 0
		_smooth("smooth", Range( 0.49 , 1)) = 0.7758426
		[HideInInspector] _texcoord( "", 2D ) = "white" {}

	}

	SubShader
	{
		LOD 0

		Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" "PreviewType"="Plane" "CanUseSpriteAtlas"="True" }
		
		Stencil
		{
			Ref [_Stencil]
			ReadMask [_StencilReadMask]
			WriteMask [_StencilWriteMask]
			CompFront [_StencilComp]
			PassFront [_StencilOp]
			FailFront Keep
			ZFailFront Keep
			CompBack Always
			PassBack Keep
			FailBack Keep
			ZFailBack Keep
		}


		Cull Off
		Lighting Off
		ZWrite Off
		ZTest [unity_GUIZTestMode]
		Blend SrcAlpha OneMinusSrcAlpha
		ColorMask [_ColorMask]

		
		Pass
		{
			Name "Default"
		CGPROGRAM
			
			#ifndef UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX
			#define UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input)
			#endif
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0

			#include "UnityCG.cginc"
			#include "UnityUI.cginc"

			#pragma multi_compile __ UNITY_UI_CLIP_RECT
			#pragma multi_compile __ UNITY_UI_ALPHACLIP
			
			#define ASE_NEEDS_FRAG_COLOR

			
			struct appdata_t
			{
				float4 vertex   : POSITION;
				float4 color    : COLOR;
				float2 texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				
			};

			struct v2f
			{
				float4 vertex   : SV_POSITION;
				fixed4 color    : COLOR;
				half2 texcoord  : TEXCOORD0;
				float4 worldPosition : TEXCOORD1;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				
			};
			
			uniform fixed4 _Color;
			uniform fixed4 _TextureSampleAdd;
			uniform float4 _ClipRect;
			uniform sampler2D _MainTex;
			uniform sampler2D _maintex;
			uniform sampler2D _flowmap;
			uniform float4 _flowmap_ST;
			uniform float _powerflow;
			uniform float _UseDissOrCu;
			uniform float _smooth;
			uniform sampler2D _dissolvetex;
			uniform float _powerdiss1;

			
			v2f vert( appdata_t IN  )
			{
				v2f OUT;
				UNITY_SETUP_INSTANCE_ID( IN );
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(OUT);
				UNITY_TRANSFER_INSTANCE_ID(IN, OUT);
				OUT.worldPosition = IN.vertex;
				
				
				OUT.worldPosition.xyz +=  float3( 0, 0, 0 ) ;
				OUT.vertex = UnityObjectToClipPos(OUT.worldPosition);

				OUT.texcoord = IN.texcoord;
				
				OUT.color = IN.color * _Color;
				return OUT;
			}

			fixed4 frag(v2f IN  ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				float2 texCoord246 = IN.texcoord.xy * float2( 1,1 ) + float2( 0,0 );
				float2 uv_flowmap = IN.texcoord.xy * _flowmap_ST.xy + _flowmap_ST.zw;
				float4 tex2DNode248 = tex2D( _flowmap, uv_flowmap );
				float2 appendResult251 = (float2(tex2DNode248.r , tex2DNode248.g));
				float3 texCoord267 = float3(IN.texcoord.xy,0);
				texCoord267.xy = float3(IN.texcoord.xy,0).xy * float2( 1,1 ) + float2( 0,0 );
				float lerpResult266 = lerp( _powerflow , texCoord267.z , _UseDissOrCu);
				float2 lerpResult247 = lerp( texCoord246 , appendResult251 , lerpResult266);
				float4 tex2DNode239 = tex2D( _maintex, lerpResult247 );
				float4 appendResult245 = (float4((( tex2DNode239 * IN.color )).rgba.rgb , ( IN.color.a * tex2DNode239.a )));
				float smoothstepResult260 = smoothstep( ( 1.0 - _smooth ) , _smooth , ( tex2D( _dissolvetex, lerpResult247 ).r + 1.0 + ( _powerdiss1 * -2.0 ) ));
				
				half4 color = ( appendResult245 * smoothstepResult260 );
				
				#ifdef UNITY_UI_CLIP_RECT
                color.a *= UnityGet2DClipping(IN.worldPosition.xy, _ClipRect);
                #endif
				
				#ifdef UNITY_UI_ALPHACLIP
				clip (color.a - 0.001);
				#endif

				return color;
			}
		ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=18800
326;150;1936.667;1021.667;1425.073;-430.3125;1.603423;True;True
Node;AmplifyShaderEditor.SamplerNode;248;-189.3518,719.2162;Inherit;True;Property;_flowmap;flowmap;1;0;Create;True;0;0;0;False;0;False;-1;4c293fbe1ecef9b478355da5cb5da81f;691823416bec3e447add36b9014d0a3c;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;268;-419.2585,1432.987;Inherit;False;Property;_UseDissOrCu;UseDissOrCu;3;1;[Enum];Create;True;0;2;on;0;off;1;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;267;-470.4497,1249.724;Inherit;False;0;-1;3;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;258;-508.9578,1135.221;Inherit;False;Property;_powerflow;powerflow;4;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;246;55.65723,258.1676;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;266;-42.64102,1174.159;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;251;155.9678,450.2973;Inherit;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;247;483.8963,378.7517;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.VertexColorNode;242;743.1375,747.6729;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;271;170.0482,1486.895;Inherit;False;Property;_powerdiss1;powerdiss1;5;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;257;509.9574,1687.467;Inherit;False;Constant;_Float2;Float 2;3;0;Create;True;0;0;0;False;0;False;-2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;239;736.13,237.0301;Inherit;True;Property;_maintex;maintex;0;0;Create;True;0;0;0;False;0;False;-1;825c020544d7ff84e9f17859ba84ced7;b40152083cb19d14a8708b7d9faa8124;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;256;830.1185,1447.383;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;255;927.5329,1211.084;Inherit;False;Constant;_Float1;Float 1;3;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;240;1235.814,280.2494;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;261;1438.126,1690.94;Inherit;False;Property;_smooth;smooth;6;0;Create;True;0;0;0;False;0;False;0.7758426;1;0.49;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;253;595.7244,1140.019;Inherit;True;Property;_dissolvetex;dissolvetex;2;0;Create;True;0;0;0;False;0;False;-1;99978fef7bde96343a0459c39d1bc7e5;e94a5985edd310942a9ddab29d0f4fc8;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;243;1516.814,326.2494;Inherit;False;True;True;True;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;254;1296.732,1144.54;Inherit;True;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;244;1348.719,632.7065;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;262;1650.474,1537.831;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;245;1870.534,691.0986;Inherit;True;FLOAT4;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SmoothstepOpNode;260;1799.267,1181.358;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;265;2146.577,922.6846;Inherit;True;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;169;324.4937,4670.614;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;270;2591.096,945.9656;Float;False;True;-1;2;ASEMaterialInspector;0;5;VX/flowap;5056123faa0c79b47ab6ad7e8bf059a4;True;Default;0;0;Default;2;True;2;5;False;-1;10;False;-1;0;1;False;-1;0;False;-1;False;False;False;False;False;False;False;False;True;2;False;-1;True;True;True;True;True;0;True;-9;False;False;False;True;True;0;True;-5;255;True;-8;255;True;-7;0;True;-4;0;True;-6;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;2;False;-1;True;0;True;-11;False;True;5;Queue=Transparent=Queue=0;IgnoreProjector=True;RenderType=Transparent=RenderType;PreviewType=Plane;CanUseSpriteAtlas=True;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;0;;0;0;Standard;0;0;1;True;False;;False;0
WireConnection;266;0;258;0
WireConnection;266;1;267;3
WireConnection;266;2;268;0
WireConnection;251;0;248;1
WireConnection;251;1;248;2
WireConnection;247;0;246;0
WireConnection;247;1;251;0
WireConnection;247;2;266;0
WireConnection;239;1;247;0
WireConnection;256;0;271;0
WireConnection;256;1;257;0
WireConnection;240;0;239;0
WireConnection;240;1;242;0
WireConnection;253;1;247;0
WireConnection;243;0;240;0
WireConnection;254;0;253;1
WireConnection;254;1;255;0
WireConnection;254;2;256;0
WireConnection;244;0;242;4
WireConnection;244;1;239;4
WireConnection;262;0;261;0
WireConnection;245;0;243;0
WireConnection;245;3;244;0
WireConnection;260;0;254;0
WireConnection;260;1;262;0
WireConnection;260;2;261;0
WireConnection;265;0;245;0
WireConnection;265;1;260;0
WireConnection;270;0;265;0
ASEEND*/
//CHKSM=1702E7073ACD18E649D7263D09A1F5E17E2054E8