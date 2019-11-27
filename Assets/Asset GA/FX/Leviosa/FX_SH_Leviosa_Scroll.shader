// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "HarryPotter/SH_Leviosa_Scroll"
{
	Properties
	{
		_RibbonTextureAndMask("Ribbon Texture And Mask", 2D) = "white" {}
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
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
		};

		uniform sampler2D _RibbonTextureAndMask;
		uniform float4 _RibbonTextureAndMask_ST;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 panner5 = ( 1.0 * _Time.y * float2( 0,0.25 ) + float2( 0,0 ));
			float2 uv_TexCoord4 = i.uv_texcoord + panner5;
			float2 panner50 = ( 1.0 * _Time.y * float2( 0,-0.15 ) + float2( 0,0 ));
			float2 uv_TexCoord51 = i.uv_texcoord * float2( -1,-1 ) + panner50;
			float2 uv_RibbonTextureAndMask = i.uv_texcoord * _RibbonTextureAndMask_ST.xy + _RibbonTextureAndMask_ST.zw;
			float temp_output_47_0 = ( ( tex2D( _RibbonTextureAndMask, uv_TexCoord4 ).r + tex2D( _RibbonTextureAndMask, uv_TexCoord51 ).r ) * tex2D( _RibbonTextureAndMask, uv_RibbonTextureAndMask ).g );
			o.Emission = ( temp_output_47_0 * i.vertexColor * 2.0 ).rgb;
			o.Alpha = ( temp_output_47_0 * i.vertexColor.a );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15401
1419;92;501;926;318.2029;310.6636;1.6;False;False
Node;AmplifyShaderEditor.Vector2Node;10;-1799.763,139.1845;Float;False;Constant;_ScrollingSpeed;Scrolling Speed;2;0;Create;True;0;0;False;0;0,0.25;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;49;-1854.875,581.366;Float;False;Constant;_Vector1;Vector 1;2;0;Create;True;0;0;False;0;0,-0.15;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.PannerNode;5;-1598.416,141.6808;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,1;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;50;-1653.528,583.8622;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,1;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;51;-1465.97,581.2086;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;-1,-1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;4;-1410.858,139.0271;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;52;-1181.141,553.2645;Float;True;Property;_TextureSample1;Texture Sample 1;1;0;Create;True;0;0;False;0;None;9bea4cd0793b9624a804223bdb115a4e;True;0;False;white;Auto;False;Instance;1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-1158.522,117.1841;Float;True;Property;_RibbonTextureAndMask;Ribbon Texture And Mask;1;0;Create;True;0;0;False;0;None;9bea4cd0793b9624a804223bdb115a4e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;53;-804.8789,452.9254;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;54;-796.8789,713.9254;Float;True;Property;_TextureSample2;Texture Sample 2;1;0;Create;True;0;0;False;0;None;9bea4cd0793b9624a804223bdb115a4e;True;0;False;white;Auto;False;Instance;1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;47;-443.5231,449.389;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;36;-414.7986,754.1744;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;55;-286.2032,209.3361;Float;False;Constant;_Float0;Float 0;2;0;Create;True;0;0;False;0;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;44;-82.72569,617.8273;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;38;-91.79869,295.7899;Float;True;3;3;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;3;219.4,-27.3;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;HarryPotter/SH_Leviosa_Scroll;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;Back;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;8;5;False;-1;1;False;-1;8;5;False;-1;1;False;-1;-1;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;5;2;10;0
WireConnection;50;2;49;0
WireConnection;51;1;50;0
WireConnection;4;1;5;0
WireConnection;52;1;51;0
WireConnection;1;1;4;0
WireConnection;53;0;1;1
WireConnection;53;1;52;1
WireConnection;47;0;53;0
WireConnection;47;1;54;2
WireConnection;44;0;47;0
WireConnection;44;1;36;4
WireConnection;38;0;47;0
WireConnection;38;1;36;0
WireConnection;38;2;55;0
WireConnection;3;2;38;0
WireConnection;3;9;44;0
ASEEND*/
//CHKSM=003AB1DDFA5FB21C5AA7651FF149767ABC7C36D6