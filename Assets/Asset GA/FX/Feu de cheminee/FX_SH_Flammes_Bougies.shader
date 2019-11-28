// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "HarryPotter/FX_SH_Feu_Cheminee"
{
	Properties
	{
		_FlammeTexture("Flamme Texture", 2D) = "white" {}
		_VoronoiNoise("Voronoi Noise", 2D) = "white" {}
		_PerlinNoise("Perlin Noise", 2D) = "white" {}
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
		#include "UnityCG.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			float2 uv_texcoord;
			float4 screenPos;
		};

		uniform sampler2D _FlammeTexture;
		uniform sampler2D _VoronoiNoise;
		uniform sampler2D _PerlinNoise;
		uniform float4 _FlammeTexture_ST;
		uniform sampler2D _CameraDepthTexture;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 panner4 = ( 1.0 * _Time.y * float2( -0.05,-0.05 ) + float2( 0,0 ));
			float2 uv_TexCoord2 = i.uv_texcoord * float2( 0.4,0.4 ) + panner4;
			float2 panner13 = ( 1.0 * _Time.y * float2( 0,-0.09 ) + float2( 0,0 ));
			float2 uv_TexCoord14 = i.uv_texcoord * float2( 0.6,0.6 ) + panner13;
			float2 panner63 = ( 1.0 * _Time.y * float2( 0.07,-0.2 ) + float2( 0,0 ));
			float2 uv_TexCoord64 = i.uv_texcoord * float2( 0.6,0.6 ) + panner63;
			float2 panner70 = ( 1.0 * _Time.y * float2( 0,-0.1 ) + float2( 0,0 ));
			float2 uv_TexCoord71 = i.uv_texcoord * float2( 0.4,0.4 ) + panner70;
			float2 uv_FlammeTexture = i.uv_texcoord * _FlammeTexture_ST.xy + _FlammeTexture_ST.zw;
			float4 tex2DNode1 = tex2D( _FlammeTexture, ( ( 10.0 * ( ( tex2D( _PerlinNoise, uv_TexCoord2 ) * tex2D( _VoronoiNoise, uv_TexCoord14 ) * tex2D( _PerlinNoise, uv_TexCoord64 ) ) + ( tex2D( _VoronoiNoise, uv_TexCoord71 ) * float4( 0.1226415,0.1226415,0.1226415,0 ) ) + -0.1 ) * tex2D( _FlammeTexture, uv_FlammeTexture ).a * ( i.uv_texcoord.y * 0.5 ) ) + float4( i.uv_texcoord, 0.0 , 0.0 ) ).rg );
			o.Emission = ( ( float4(1,0.2588235,0,0) * tex2DNode1.r ) + ( float4(1,0.2603306,0,0) * tex2DNode1.g ) + ( float4(1,0.8690518,0.5801887,0) * tex2DNode1.b ) ).rgb;
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float screenDepth46 = LinearEyeDepth(UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture,UNITY_PROJ_COORD(ase_screenPos))));
			float distanceDepth46 = abs( ( screenDepth46 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( 0.5 ) );
			float4 clampResult48 = clamp( ( tex2DNode1 * distanceDepth46 ) , float4( 0,0,0,0 ) , float4( 1,1,1,0 ) );
			o.Alpha = clampResult48.r;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15401
10;410;1906;1010;2169.895;353.48;1.3;True;True
Node;AmplifyShaderEditor.PannerNode;70;-2597.369,-971.5353;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,-0.1;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;63;-2601.023,-397.2276;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.07,-0.2;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;13;-2605.685,-156.3716;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,-0.09;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;4;-2588.544,-649.8056;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;-0.05,-0.05;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;14;-2417.24,-155.4285;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;0.6,0.6;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;64;-2421.78,-401.1245;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;0.6,0.6;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;71;-2415.219,-972.3464;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;0.4,0.4;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;2;-2412.564,-653.3273;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;0.4,0.4;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;65;-2124.564,-429.3273;Float;True;Property;_PerlinNoise;Perlin Noise;3;0;Create;True;0;0;False;0;6c381ba84883b0344923d05f72b4bdfe;6c381ba84883b0344923d05f72b4bdfe;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;72;-2139.244,-994.4212;Float;True;Property;_TextureSample1;Texture Sample 1;2;0;Create;True;0;0;False;0;3314e815d37f2bb43b39945a6a763a23;3314e815d37f2bb43b39945a6a763a23;True;0;False;white;Auto;False;Instance;61;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;62;-2092.564,-669.3275;Float;True;Property;_TextureSample0;Texture Sample 0;3;0;Create;True;0;0;False;0;6c381ba84883b0344923d05f72b4bdfe;6c381ba84883b0344923d05f72b4bdfe;True;0;False;white;Auto;False;Instance;65;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;61;-2124.564,-173.3271;Float;True;Property;_VoronoiNoise;Voronoi Noise;2;0;Create;True;0;0;False;0;3314e815d37f2bb43b39945a6a763a23;3314e815d37f2bb43b39945a6a763a23;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;7;-1511.727,304.5776;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;69;-1637.125,-992.7216;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0.1226415,0.1226415,0.1226415,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;73;-1444.802,-263.8067;Float;False;Constant;_Float0;Float 0;6;0;Create;True;0;0;False;0;-0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;-1628.562,-573.3273;Float;True;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;59;-1104.583,69.40796;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;35;-1460.521,-178.1122;Float;True;Property;_FEU;FEU;1;0;Create;True;0;0;False;0;c7b3ad7925347ca49b492c021997986c;c7b3ad7925347ca49b492c021997986c;True;0;False;white;Auto;False;Instance;1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;68;-1326.261,-676.3643;Float;True;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;38;-1176.075,-279.2741;Float;False;Constant;_PuissanceDeformation;Puissance Deformation;6;0;Create;True;0;0;False;0;10;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;37;-869.938,-134.2696;Float;True;4;4;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;47;98.9719,376.5027;Float;False;274;160;lamp;1;46;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;19;-669.8741,276.9849;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT2;0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.DepthFade;46;148.9719,426.5027;Float;False;True;1;0;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;27;-99.26952,-706.5636;Float;False;Constant;_Color1;Color 1;3;1;[HDR];Create;True;0;0;False;0;1,0.2588235,0,0;1,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;25;-108.2859,-397.4379;Float;False;Constant;_Color0;Color 0;2;1;[HDR];Create;True;0;0;False;0;1,0.2603306,0,0;1,0.1934569,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-324.7763,254.522;Float;True;Property;_FlammeTexture;Flamme Texture;1;0;Create;True;0;0;False;0;c7b3ad7925347ca49b492c021997986c;608ccff9f3b0fad4f86b638389e8f01e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;44;-127.2444,-149.4812;Float;False;Constant;_Color2;Color 2;2;1;[HDR];Create;True;0;0;False;0;1,0.8690518,0.5801887,0;1,0.1934569,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;45;336.172,266.6028;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;179.8589,-697.6982;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;43;215.0129,-147.8262;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;185.3548,-396.9643;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;28;506.3686,-418.8821;Float;True;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;48;520.5725,266.7535;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,1,1,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;830.7918,-467.2827;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;HarryPotter/FX_SH_Feu_Cheminee;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;Off;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;8;5;False;-1;1;False;-1;8;5;False;-1;1;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;14;1;13;0
WireConnection;64;1;63;0
WireConnection;71;1;70;0
WireConnection;2;1;4;0
WireConnection;65;1;64;0
WireConnection;72;1;71;0
WireConnection;62;1;2;0
WireConnection;61;1;14;0
WireConnection;69;0;72;0
WireConnection;17;0;62;0
WireConnection;17;1;61;0
WireConnection;17;2;65;0
WireConnection;59;0;7;2
WireConnection;68;0;17;0
WireConnection;68;1;69;0
WireConnection;68;2;73;0
WireConnection;37;0;38;0
WireConnection;37;1;68;0
WireConnection;37;2;35;4
WireConnection;37;3;59;0
WireConnection;19;0;37;0
WireConnection;19;1;7;0
WireConnection;1;1;19;0
WireConnection;45;0;1;0
WireConnection;45;1;46;0
WireConnection;26;0;27;0
WireConnection;26;1;1;1
WireConnection;43;0;44;0
WireConnection;43;1;1;3
WireConnection;22;0;25;0
WireConnection;22;1;1;2
WireConnection;28;0;26;0
WireConnection;28;1;22;0
WireConnection;28;2;43;0
WireConnection;48;0;45;0
WireConnection;0;2;28;0
WireConnection;0;9;48;0
ASEEND*/
//CHKSM=FF8559449DA5AB4A67CDF0D2DA96F19D3013CD1D