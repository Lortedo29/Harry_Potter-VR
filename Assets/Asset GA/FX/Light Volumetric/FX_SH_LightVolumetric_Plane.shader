// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "HarryPotter/FX_SH_LightVolumetric_Plane"
{
	Properties
	{
		_NoiseAndMask("Noise And Mask", 2D) = "white" {}
		_Color("Color", Color) = (1,1,1,0)
		_EmissivPower("Emissiv Power", Float) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull Off
		ZWrite Off
		Blend SrcAlpha One , SrcAlpha One
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float _EmissivPower;
		uniform float4 _Color;
		uniform sampler2D _NoiseAndMask;
		uniform float4 _NoiseAndMask_ST;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 panner2 = ( 1.0 * _Time.y * float2( 0.02,0.02 ) + i.uv_texcoord);
			float2 uv_TexCoord22 = i.uv_texcoord * float2( 0.3,0.3 ) + float2( 0.53,0 );
			float2 panner23 = ( 1.0 * _Time.y * float2( 0,0.005 ) + uv_TexCoord22);
			float2 uv_TexCoord29 = i.uv_texcoord * float2( 0.1,0.1 ) + float2( 0.19,0 );
			float2 panner28 = ( 1.0 * _Time.y * float2( 0.001,0.003 ) + uv_TexCoord29);
			float smoothstepResult33 = smoothstep( 0.47 , 0.87 , ( tex2D( _NoiseAndMask, panner2 ).r + tex2D( _NoiseAndMask, panner23 ).r + tex2D( _NoiseAndMask, panner28 ).r ));
			float2 uv_NoiseAndMask = i.uv_texcoord * _NoiseAndMask_ST.xy + _NoiseAndMask_ST.zw;
			float temp_output_12_0 = ( smoothstepResult33 * tex2D( _NoiseAndMask, uv_NoiseAndMask ).g * 0.25 );
			o.Emission = ( _EmissivPower * _Color * temp_output_12_0 ).rgb;
			o.Alpha = temp_output_12_0;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15401
979;92;941;926;-252.5389;173.8165;1.036249;True;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;29;-1332.917,431.4612;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;0.1,0.1;False;1;FLOAT2;0.19,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;3;-1353.879,23.77927;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;22;-1328.121,230.8975;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;0.3,0.3;False;1;FLOAT2;0.53,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;23;-1071.12,230.8975;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0.005;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;28;-1075.916,431.4612;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.001,0.003;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;2;-1055.877,22.77927;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.02,0.02;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;24;-845.9119,203.1228;Float;True;Property;_TextureSample0;Texture Sample 0;1;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Instance;25;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;25;-846.9783,-2.592576;Float;True;Property;_NoiseAndMask;Noise And Mask;1;0;Create;True;0;0;False;0;None;4de8a9ebaae203d41bd8904894ef6b60;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;27;-850.7077,403.6865;Float;True;Property;_TextureSample1;Texture Sample 1;1;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Instance;25;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;30;-397.481,197.826;Float;True;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;33;-153.7928,195.6572;Float;True;3;0;FLOAT;0;False;1;FLOAT;0.47;False;2;FLOAT;0.87;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;19;125.7254,269.9912;Float;True;Property;_Untitlecvcvd2;Untitlecvcvd-2;1;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Instance;25;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;21;342.9672,480.4956;Float;False;Constant;_Float0;Float 0;3;0;Create;True;0;0;False;0;0.25;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;542.8557,199.7377;Float;True;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;34;543.4009,18.57751;Float;False;Property;_Color;Color;2;0;Create;True;0;0;False;0;1,1,1,0;1,1,1,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;37;559.6786,-78.21417;Float;False;Property;_EmissivPower;Emissiv Power;3;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;36;791.1158,511.4214;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;35;840.397,189.7447;Float;True;3;3;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1189.09,149.7849;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;HarryPotter/FX_SH_LightVolumetric_Plane;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;Off;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;8;5;False;-1;1;False;-1;8;5;False;-1;1;False;-1;-1;False;-1;-1;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;23;0;22;0
WireConnection;28;0;29;0
WireConnection;2;0;3;0
WireConnection;24;1;23;0
WireConnection;25;1;2;0
WireConnection;27;1;28;0
WireConnection;30;0;25;1
WireConnection;30;1;24;1
WireConnection;30;2;27;1
WireConnection;33;0;30;0
WireConnection;12;0;33;0
WireConnection;12;1;19;2
WireConnection;12;2;21;0
WireConnection;36;0;12;0
WireConnection;35;0;37;0
WireConnection;35;1;34;0
WireConnection;35;2;12;0
WireConnection;0;2;35;0
WireConnection;0;9;36;0
ASEEND*/
//CHKSM=6875414F8D432F3500D2B3D4CBD1B93FFF56E8A7