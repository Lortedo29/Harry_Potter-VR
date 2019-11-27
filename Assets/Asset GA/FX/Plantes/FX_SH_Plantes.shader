// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "HarryPotter/FX_SH_Plantes"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_Test_01_Plantes_Opacity("Test_01_Plantes_Opacity", 2D) = "white" {}
		_Test_01_Plantes_Color("Test_01_Plantes_Color", 2D) = "white" {}
		_FX_TX_Feu_Cheminee_PerlinNoise("FX_TX_Feu_Cheminee_PerlinNoise", 2D) = "white" {}
		_FX_TX_Feu_Cheminee_VoronoiNoise("FX_TX_Feu_Cheminee_VoronoiNoise", 2D) = "white" {}
		_WindForce("Wind Force", Float) = 0.03
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Transparent+0" }
		Cull Off
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float3 worldPos;
			float2 uv_texcoord;
		};

		uniform sampler2D _FX_TX_Feu_Cheminee_PerlinNoise;
		uniform sampler2D _FX_TX_Feu_Cheminee_VoronoiNoise;
		uniform float _WindForce;
		uniform sampler2D _Test_01_Plantes_Color;
		uniform float4 _Test_01_Plantes_Color_ST;
		uniform sampler2D _Test_01_Plantes_Opacity;
		uniform float4 _Test_01_Plantes_Opacity_ST;
		uniform float _Cutoff = 0.5;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float2 panner7 = ( 1.0 * _Time.y * float2( 0.1,0.1 ) + float2( 0,0 ));
			float2 uv_TexCoord6 = v.texcoord.xy + panner7;
			float2 panner9 = ( 1.0 * _Time.y * float2( 0.1,0.1 ) + float2( 0,0 ));
			float2 uv_TexCoord8 = v.texcoord.xy + panner9;
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float2 appendResult14 = (float2(ase_worldPos.x , ase_worldPos.y));
			v.vertex.xyz += ( ( tex2Dlod( _FX_TX_Feu_Cheminee_PerlinNoise, float4( uv_TexCoord6, 0, 0.0) ) + tex2Dlod( _FX_TX_Feu_Cheminee_VoronoiNoise, float4( uv_TexCoord8, 0, 0.0) ) ) * float4( appendResult14, 0.0 , 0.0 ) * _WindForce ).rgb;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Test_01_Plantes_Color = i.uv_texcoord * _Test_01_Plantes_Color_ST.xy + _Test_01_Plantes_Color_ST.zw;
			o.Albedo = tex2D( _Test_01_Plantes_Color, uv_Test_01_Plantes_Color ).rgb;
			o.Alpha = 1;
			float2 uv_Test_01_Plantes_Opacity = i.uv_texcoord * _Test_01_Plantes_Opacity_ST.xy + _Test_01_Plantes_Opacity_ST.zw;
			clip( tex2D( _Test_01_Plantes_Opacity, uv_Test_01_Plantes_Opacity ).r - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15401
375;412;1906;645;1613.852;367.5715;1;True;False
Node;AmplifyShaderEditor.PannerNode;7;-1649.547,-106.968;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.1,0.1;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;9;-1654.997,94.53203;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.1,0.1;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;6;-1461.246,-122.5681;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;8;-1466.696,78.93193;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;4;-1223.344,-131.6679;Float;True;Property;_FX_TX_Feu_Cheminee_PerlinNoise;FX_TX_Feu_Cheminee_PerlinNoise;3;0;Create;True;0;0;False;0;6c381ba84883b0344923d05f72b4bdfe;6c381ba84883b0344923d05f72b4bdfe;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;5;-1244.146,72.43193;Float;True;Property;_FX_TX_Feu_Cheminee_VoronoiNoise;FX_TX_Feu_Cheminee_VoronoiNoise;4;0;Create;True;0;0;False;0;3314e815d37f2bb43b39945a6a763a23;3314e815d37f2bb43b39945a6a763a23;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WorldPosInputsNode;12;-1482.044,347.632;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleAddOpNode;10;-818.545,-12.06799;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;14;-1239.852,369.9285;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-882.8516,397.9285;Float;False;Property;_WindForce;Wind Force;5;0;Create;True;0;0;False;0;0.03;0.0015;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-588.9438,-118.6679;Float;True;Property;_Test_01_Plantes_Opacity;Test_01_Plantes_Opacity;1;0;Create;True;0;0;False;0;538a094633b614241a8324a7076f9af8;538a094633b614241a8324a7076f9af8;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;-679.4449,203.732;Float;False;3;3;0;COLOR;0,0,0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;3;-594.1434,-307.1681;Float;True;Property;_Test_01_Plantes_Color;Test_01_Plantes_Color;2;0;Create;True;0;0;False;0;9f50643710f231a48a58c499d783b394;9f50643710f231a48a58c499d783b394;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-201.5002,-306.7998;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;HarryPotter/FX_SH_Plantes;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;TransparentCutout;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;-1;False;-1;-1;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;6;1;7;0
WireConnection;8;1;9;0
WireConnection;4;1;6;0
WireConnection;5;1;8;0
WireConnection;10;0;4;0
WireConnection;10;1;5;0
WireConnection;14;0;12;1
WireConnection;14;1;12;2
WireConnection;11;0;10;0
WireConnection;11;1;14;0
WireConnection;11;2;13;0
WireConnection;0;0;3;0
WireConnection;0;10;1;0
WireConnection;0;11;11;0
ASEEND*/
//CHKSM=3DB75D67DF09FF4864527788D297908628D6DA16