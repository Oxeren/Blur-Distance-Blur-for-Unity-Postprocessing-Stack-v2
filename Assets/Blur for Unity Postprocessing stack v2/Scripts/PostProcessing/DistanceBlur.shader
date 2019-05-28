Shader "Hidden/Custom/DistanceBlur"
{
	HLSLINCLUDE

	#include "Packages/com.unity.postprocessing/PostProcessing/Shaders/StdLib.hlsl"
	#include "Packages/com.unity.postprocessing/PostProcessing/Shaders/Sampling.hlsl"

	TEXTURE2D_SAMPLER2D(_MainTex, sampler_MainTex);
	TEXTURE2D_SAMPLER2D(_CameraDepthTexture, sampler_CameraDepthTexture);
	TEXTURE2D_SAMPLER2D(_DryTex, sampler_DryTex);
	float _StartDistance;
	float _EndDistance;
	float4 _MainTex_TexelSize;

	ENDHLSL

	SubShader 
	{
		Cull Off ZWrite Off ZTest Always

		Pass //0 Applying Box filtering
		{
			HLSLPROGRAM

			#pragma vertex VertDefault
			#pragma fragment Frag

			float4 Frag(VaryingsDefault i) : SV_Target
			{
				return DownsampleBox13Tap(TEXTURE2D_PARAM(_MainTex, sampler_MainTex), i.texcoord,  _MainTex_TexelSize.xy);
			}

			ENDHLSL 
		}

		Pass // 1 Mixing dry input with blurred texture by depth
		{
			
			HLSLPROGRAM

			#pragma vertex VertDefault
			#pragma fragment Frag

			float4 Frag(VaryingsDefault i) : SV_Target
			{
				float4 blurredColor = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoord);
				float4 dryColor = SAMPLE_TEXTURE2D(_DryTex, sampler_DryTex, i.texcoord);
				float depth = SAMPLE_DEPTH_TEXTURE(_CameraDepthTexture, sampler_CameraDepthTexture, i.texcoord);
				depth = Linear01Depth(depth);
				return lerp(dryColor, blurredColor, saturate((depth - _StartDistance) / (_EndDistance - _StartDistance)) );
			} 

			ENDHLSL 
		
		}
	}

}