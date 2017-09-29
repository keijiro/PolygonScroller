Shader "PolygonDrawer"
{
    SubShader
    {
        Pass
        {
            Cull off
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment
            #include "PolygonDrawer.cginc"
            ENDCG
        }
    }
}
