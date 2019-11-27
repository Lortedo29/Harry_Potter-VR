// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "HarryPotter/FX_SH_Flammes_Bougie"
{
	Properties
	{
		_FlammeTexture("Flamme Texture", 2D) = "white" {}
		_FX_SM_LightVolumetric_Mask_Noise("FX_SM_LightVolumetric_Mask_Noise", 2D) = "white" {}
		[HDR]_Color0("Color 0", Color) = (0,0,0,0)
		[HDR]_Color1("Color 1", Color) = (0,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull Off
		ZWrite Off
		Blend SrcAlpha One , SrcAlpha One
		BlendOp Add , Add
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float4 _Color1;
		uniform sampler2D _FlammeTexture;
		uniform sampler2D _FX_SM_LightVolumetric_Mask_Noise;
		uniform float4 _FlammeTexture_ST;
		uniform float4 _Color0;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 panner4 = ( 1.0 * _Time.y * float2( 0,-0.2 ) + float2( 0,0 ));
			float2 uv_TexCoord2 = i.uv_texcoord * float2( 0.2,0.2 ) + panner4;
			float2 panner13 = ( 1.0 * _Time.y * float2( 0,-0.1 ) + float2( 0,0 ));
			float2 uv_TexCoord14 = i.uv_texcoord * float2( 0.1,0.1 ) + panner13;
			float2 uv_FlammeTexture = i.uv_texcoord * _FlammeTexture_ST.xy + _FlammeTexture_ST.zw;
			float4 tex2DNode9 = tex2D( _FlammeTexture, uv_FlammeTexture );
			float4 tex2DNode1 = tex2D( _FlammeTexture, ( ( ( tex2D( _FX_SM_LightVolumetric_Mask_Noise, uv_TexCoord2 ).r * tex2D( _FX_SM_LightVolumetric_Mask_Noise, uv_TexCoord14 ).r ) * tex2DNode9.g * tex2DNode9.b ) + i.uv_texcoord ) );
			o.Emission = ( ( _Color1 * tex2DNode1.r ) + ( _Color0 * tex2DNode1.a ) ).rgb;
			float smoothstepResult32 = smoothstep( 0.0 , 0.42 , tex2DNode1.r);
			o.Alpha = smoothstepResult32;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15401
56.8;621.6;2035;626;2507.459;-53.35997;1.483917;True;False
Node;AmplifyShaderEditor.PannerNode;4;-2469.609,-363.6118;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,-0.2;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;13;-2496.257,-76.72185;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,-0.1;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;14;-2299.674,-97.50342;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;0.1,0.1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;2;-2225.026,-386.4019;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;0.2,0.2;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;15;-2070.258,-133.7134;Float;True;Property;_TextureSample1;Texture Sample 1;2;0;Create;True;0;0;False;0;4de8a9ebaae203d41bd8904894ef6b60;4de8a9ebaae203d41bd8904894ef6b60;True;0;False;white;Auto;False;Instance;3;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;3;-1995.61,-422.6118;Float;True;Property;_FX_SM_LightVolumetric_Mask_Noise;FX_SM_LightVolumetric_Mask_Noise;2;0;Create;True;0;0;False;0;4de8a9ebaae203d41bd8904894ef6b60;4de8a9ebaae203d41bd8904894ef6b60;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;9;-1465.354,26.58486;Float;True;Property;_TextureSample0;Texture Sample 0;1;0;Create;True;0;0;False;0;796969597138c0442b991e701318a0b0;796969597138c0442b991e701318a0b0;True;0;False;white;Auto;False;Instance;1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;-1319.194,-258.9762;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-1057.839,41.91166;Float;True;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;7;-1052.44,311.9246;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;19;-758.5038,97.16026;Float;True;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ColorNode;25;-372.4144,-277.0816;Float;False;Property;_Color0;Color 0;3;1;[HDR];Create;True;0;0;False;0;0,0,0,0;0.9254902,0.593455,0.0901961,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;27;-352.6143,-537.6815;Float;False;Property;_Color1;Color 1;4;1;[HDR];Create;True;0;0;False;0;0,0,0,0;0.9254902,0.2437109,0.0901961,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-462.6307,86.66076;Float;True;Property;_FlammeTexture;Flamme Texture;1;0;Create;True;0;0;False;0;796969597138c0442b991e701318a0b0;130fef6a404badf4f8d4d318197c874e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;-51.81453,-228.0817;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;-54.61448,-485.6816;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;28;212.5857,-328.1813;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SmoothstepOpNode;32;174.6481,115.5243;Float;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0.42;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;628.2276,-373.9402;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;HarryPotter/FX_SH_Flammes_Bougie;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;Off;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;8;5;False;-1;1;False;-1;8;5;False;-1;1;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;14;1;13;0
WireConnection;2;1;4;0
WireConnection;15;1;14;0
WireConnection;3;1;2;0
WireConnection;17;0;3;1
WireConnection;17;1;15;1
WireConnection;12;0;17;0
WireConnection;12;1;9;2
WireConnection;12;2;9;3
WireConnection;19;0;12;0
WireConnection;19;1;7;0
WireConnection;1;1;19;0
WireConnection;22;0;25;0
WireConnection;22;1;1;4
WireConnection;26;0;27;0
WireConnection;26;1;1;1
WireConnection;28;0;26;0
WireConnection;28;1;22;0
WireConnection;32;0;1;1
WireConnection;0;2;28;0
WireConnection;0;9;32;0
ASEEND*/
//CHKSM=296BA6E90780D692E4604613FD1526E456D14B01