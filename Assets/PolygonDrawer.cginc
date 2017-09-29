#include "Common.cginc"

uint _VertexOnArc;

float _Radius;
float _RandomSize;
float _Roughness;

float2 _Extent;
float2 _Scroll;

struct Varyings
{
    float4 position : SV_POSITION;
    float4 color : COLOR;
};

Varyings Vertex(uint vertexID : SV_VertexID, uint instanceID : SV_InstanceID)
{
    uint triangleID = vertexID / 3;
    uint indexInTriangle = vertexID - triangleID * 3;
    uint indexOnArc = triangleID + (indexInTriangle == 2);

    float phi = UNITY_PI * 2 * indexOnArc / _VertexOnArc;
    float2 vp = float2(cos(phi), sin(phi));

    vp *= 1 + (Random(indexOnArc + instanceID * 1234) * 2 - 1) * _Roughness;
    vp *= _Radius * lerp(1 - _RandomSize, 1, Random(instanceID * 382394)) * (indexInTriangle > 0);
    vp += (frac(float2(Random(instanceID * 1282), Random(instanceID * 32189)) + _Scroll) - 0.5) * _Extent;

    Varyings o;
    o.position = UnityObjectToClipPos(float4(vp, 1, 1));
    o.color = float4(Random(instanceID * 182), Random(instanceID * 3980), Random(instanceID * 9999), 1);
    return o;
}

fixed4 Fragment(Varyings input) : SV_Target
{
    return input.color;
}
