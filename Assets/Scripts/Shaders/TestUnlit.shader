Shader "Custom/TestUnlit"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _VertexWarping ("VertexWarping", Range(0.0000001, 3.0)) = 0.0
        _FuckeryKind("FuckeryKind", Int) = 0
        _RandomSeed("RandSeed", Int) = 0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            float _VertexWarping;
            int _FuckeryKind;
            int _RandomSeed;

            #define FUCK_YOU_UNFLOATS_YOUR_POINTS 0
            #define OH_GOD_MY_GPU_IS_DYING 1
            #define AN_EXPLODED_VIEW 2
            #define WHAT_THE_FUCK 3

            float processUnfloatsPointsN(float inp)
            {
                float invvw = _VertexWarping;
                return floor(inp / invvw) * invvw;
            }

            float3 processUnfloatsPoints(float3 inp)
            {
                float3 pos;
                pos.x = processUnfloatsPointsN(inp.x);
                pos.y = processUnfloatsPointsN(inp.y);
                pos.z = processUnfloatsPointsN(inp.z);
                return pos;
            }

            float random(float2 uv)
            {
                uv.x += (uv.x - uv.y * _RandomSeed);
                return frac(sin(dot(uv, float2(12.9898, 78.233))) * 43758.5453123);
            }

            float random3(float3 uv)
            {
                return random(uv.xy) + random(float2(uv.z, uv.y * uv.x));
            }

            v2f vert (appdata v)
            {
                v2f o;

                float4 pos = v.vertex;
                
                if (_FuckeryKind == FUCK_YOU_UNFLOATS_YOUR_POINTS)
                {
                    pos.xyz = processUnfloatsPoints(pos.xyz);
                }
                else if (_FuckeryKind == OH_GOD_MY_GPU_IS_DYING)
                {
                    float randFactor = random3(v.normal.xyz);
                    pos.xyz = pos.xyz + (v.normal.xyz + randFactor) * _VertexWarping;
                }
                else if (_FuckeryKind == AN_EXPLODED_VIEW)
                {
                    pos.xyz = pos.xyz + (v.normal.xyz) * _VertexWarping;
                }
                else if (_FuckeryKind == WHAT_THE_FUCK)
                {
                    pos.xyz = pos.xyz * ((-(100 / 99)) * _VertexWarping);
                }

                o.vertex = UnityObjectToClipPos(pos);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);
                // apply fog
                UNITY_APPLY_FOG(i.fogCoord, col);
                return col;
            }
            ENDCG
        }
    }
}
