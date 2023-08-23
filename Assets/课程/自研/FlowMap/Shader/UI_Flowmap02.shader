// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "VX/flowap02"
{
	Properties
	{
		[PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
		_Color ("Tint", Color) = (1,1,1,1)
		
		[HideInInspector] _ColorMask ("Color Mask", Float) = 15

		[Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip ("Use Alpha Clip", Float) = 0
		_maintex("maintex", 2D) = "white" {}
		_flowmap("flowmap", 2D) = "white" {}
		_dissolvetex("dissolvetex", 2D) = "white" {}
		[Enum(on,0,off,1)]_UseDissOrCu("UseDissOrCu", Float) = 0
		_powerflow("powerflow", Range( 0 , 1)) = 0
		_powerdiss1("powerdiss1", Range( 0 , 1)) = 0
		_smooth("smooth", Range( 0.49 , 1)) = 0.7758426
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
