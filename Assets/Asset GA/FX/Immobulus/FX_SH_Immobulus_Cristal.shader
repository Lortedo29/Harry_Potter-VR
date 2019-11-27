// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "HarryPotter/FX_SH_Immobulus_Cristal"
{
	Properties
	{
		_SH_StandardShader_NoiseAndMask_01("SH_StandardShader_NoiseAndMask_01", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull Back
		ZWrite Off
		Blend SrcAlpha OneMinusSrcAlpha , SrcAlpha OneMinusSrcAlpha
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha noshadow exclude_path:deferred noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			float4 vertexColor : COLOR;
			float2 uv_texcoord;
		};

		uniform sampler2D _SH_StandardShader_NoiseAndMask_01;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 panner2 = ( 1.0 * _Time.y * float2( 0,0.1 ) + i.uv_texcoord);
			float4 tex2DNode1 = tex2D( _SH_StandardShader_NoiseAndMask_01, panner2 );
			o.Emission = ( i.vertexColor * tex2DNode1.g ).rgb;
			o.Alpha = ( i.vertexColor.a * tex2DNode1.g );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15401
-31;41;1918;1016;1720.667;215.4586;1.3;True;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;3;-531.1788,237.3491;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;2;-299.7848,234.2139;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0.1;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;1;-107.1527,205.6082;Float;True;Property;_SH_StandardShader_NoiseAndMask_01;SH_StandardShader_NoiseAndMask_01;1;0;Create;True;0;0;False;0;7d8de6af62ba61a4bac04f81042f3daa;7d8de6af62ba61a4bac04f81042f3daa;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;17;104.2392,41.74346;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;49;391.5405,60.59546;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;47;392.4123,201.9895;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;585.7993,12.33545;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;HarryPotter/FX_SH_Immobulus_Cristal;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;Back;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;5;True;False;0;True;Transparent;;Transparent;ForwardOnly;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;5;False;2;5;False;-1;10;False;-1;2;5;False;-1;10;False;-1;-1;False;-1;-1;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;3;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;2;0;3;0
WireConnection;1;1;2;0
WireConnection;49;0;17;0
WireConnection;49;1;1;2
WireConnection;47;0;17;4
WireConnection;47;1;1;2
WireConnection;0;2;49;0
WireConnection;0;9;47;0
ASEEND*/
//CHKSM=65DF1E11F9341420DED925A3273D5CBFAF1C292E