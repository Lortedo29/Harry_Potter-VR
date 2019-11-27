// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "HarryPotter/FX_SH_Cartes_Spells"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_StepValue("Step Value", Range( 0 , 1)) = 0.31
		_DivideValue("Divide Value", Float) = 0.31
		_EmissivPower("Emissiv Power", Float) = 1.5
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_TextureSample1("Texture Sample 1", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull Back
		Blend SrcAlpha OneMinusSrcAlpha
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float _EmissivPower;
		uniform sampler2D _TextureSample1;
		uniform float4 _TextureSample1_ST;
		uniform sampler2D _TextureSample0;
		uniform float _StepValue;
		uniform float _DivideValue;
		uniform float _Cutoff = 0.5;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_TextureSample1 = i.uv_texcoord * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
			float2 uv_TexCoord48 = i.uv_texcoord * float2( 0.2,0.2 );
			float4 tex2DNode49 = tex2D( _TextureSample0, uv_TexCoord48 );
			float temp_output_55_0 = step( tex2DNode49.r , _StepValue );
			o.Emission = ( ( _EmissivPower * tex2D( _TextureSample1, uv_TextureSample1 ) ) + ( temp_output_55_0 - step( tex2DNode49.r , ( _StepValue / _DivideValue ) ) ) ).rgb;
			o.Alpha = 1;
			clip( temp_output_55_0 - _Cutoff );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15401
-24;317;1906;367;1640.562;-1676.767;2.649843;True;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;48;-818.2751,2192.455;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;0.2,0.2;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;49;-575.6536,2170.466;Float;True;Property;_TextureSample0;Texture Sample 0;4;0;Create;True;0;0;False;0;6a182d737ddd7344681a13cb2df7f0ac;6a182d737ddd7344681a13cb2df7f0ac;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;50;-73.5844,2672.793;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;52;-173.9587,2342.021;Float;False;Property;_StepValue;Step Value;1;0;Create;True;0;0;False;0;0.31;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;51;-69.5844,2449.793;Float;False;Property;_DivideValue;Divide Value;2;0;Create;True;0;0;False;0;0.31;1.02;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;53;168.4156,2433.793;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;54;381.4156,2673.793;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;56;427.0772,1691.77;Float;False;Property;_EmissivPower;Emissiv Power;3;0;Create;True;0;0;False;0;1.5;1.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;55;171.4156,2197.794;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;57;490.4155,2404.794;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;58;358.5871,1765.87;Float;True;Property;_TextureSample1;Texture Sample 1;5;0;Create;True;0;0;False;0;None;69ac176b9dbe83f449eb63af1a80d43c;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;59;703.9515,1758.043;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;60;709.9221,1992.66;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;62;984.8395,1765.814;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1452.553,1971.744;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;HarryPotter/FX_SH_Cartes_Spells;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;TransparentCutout;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;-1;False;-1;-1;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;49;1;48;0
WireConnection;50;0;49;1
WireConnection;53;0;52;0
WireConnection;53;1;51;0
WireConnection;54;0;50;0
WireConnection;55;0;49;1
WireConnection;55;1;52;0
WireConnection;57;0;54;0
WireConnection;57;1;53;0
WireConnection;59;0;56;0
WireConnection;59;1;58;0
WireConnection;60;0;55;0
WireConnection;60;1;57;0
WireConnection;62;0;59;0
WireConnection;62;1;60;0
WireConnection;0;2;62;0
WireConnection;0;10;55;0
ASEEND*/
//CHKSM=16EADF8D22878A324AFE4F19E4F73B8EDEF675F7