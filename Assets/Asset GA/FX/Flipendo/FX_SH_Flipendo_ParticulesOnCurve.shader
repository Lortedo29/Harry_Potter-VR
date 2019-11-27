// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "HarryPotter/FX_SH_Flipendo_ParticulesOnCurve"
{
	Properties
	{
		_FX_TX_Flipendo_ParticulesOnCurve("FX_TX_Flipendo_ParticulesOnCurve", 2D) = "white" {}
		_EmissivPower("Emissiv Power", Float) = 1
		_ColorParticules("Color Particules", Color) = (1,0.1254902,0.5610116,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull Back
		ZWrite Off
		Blend SrcAlpha One , SrcAlpha One
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			float4 vertexColor : COLOR;
			float2 uv_texcoord;
		};

		uniform float _EmissivPower;
		uniform float4 _ColorParticules;
		uniform sampler2D _FX_TX_Flipendo_ParticulesOnCurve;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 appendResult14 = (float2(0.0 , (float4( 0.24,0,0,0 ) + (i.vertexColor - float4( 0,0,0,0 )) * (float4( -0.7,0,0,0 ) - float4( 0.24,0,0,0 )) / (float4( 1,0,0,0 ) - float4( 0,0,0,0 ))).r));
			float2 uv_TexCoord3 = i.uv_texcoord + appendResult14;
			float4 tex2DNode1 = tex2D( _FX_TX_Flipendo_ParticulesOnCurve, uv_TexCoord3 );
			o.Emission = ( _EmissivPower * _ColorParticules * tex2DNode1 ).rgb;
			o.Alpha = ( tex2DNode1.a * i.vertexColor.a );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15401
2055;29;1906;1004;2071.368;258.1732;1.455663;True;False
Node;AmplifyShaderEditor.VertexColorNode;16;-1688.633,339.4313;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;17;-1491.48,347.4249;Float;False;5;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,0,0,0;False;3;COLOR;0.24,0,0,0;False;4;COLOR;-0.7,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;15;-1471.783,261.1266;Float;False;Constant;_Float0;Float 0;3;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;14;-1279.029,266.88;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;3;-1122.29,50.25569;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,-0.69;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;11;-627.9371,-401.9835;Float;False;Property;_ColorParticules;Color Particules;3;0;Create;True;0;0;False;0;1,0.1254902,0.5610116,0;1,0.12549,0.4663331,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;6;-704.1365,-211.7028;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;5;-335.0353,-139.1024;Float;False;Property;_EmissivPower;Emissiv Power;2;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-872.8361,-2.603032;Float;True;Property;_FX_TX_Flipendo_ParticulesOnCurve;FX_TX_Flipendo_ParticulesOnCurve;1;0;Create;True;0;0;False;0;f258c431317bca74782a5dc941ede421;f258c431317bca74782a5dc941ede421;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;-172.6357,337.1973;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;-88.13556,-24.20258;Float;False;3;3;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;119.6,0;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;HarryPotter/FX_SH_Flipendo_ParticulesOnCurve;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;Back;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;8;5;False;-1;1;False;-1;8;5;False;-1;1;False;-1;-1;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;17;0;16;0
WireConnection;14;0;15;0
WireConnection;14;1;17;0
WireConnection;3;1;14;0
WireConnection;1;1;3;0
WireConnection;7;0;1;4
WireConnection;7;1;6;4
WireConnection;4;0;5;0
WireConnection;4;1;11;0
WireConnection;4;2;1;0
WireConnection;0;2;4;0
WireConnection;0;9;7;0
ASEEND*/
//CHKSM=6A93C1E8F43A1377A5F0988C31C6DBDC489FF831