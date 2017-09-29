using UnityEngine;

[ExecuteInEditMode]
public class PolygonDrawer : MonoBehaviour
{
    [SerializeField] int _vertexOnArc = 10;
    [SerializeField] int _instanceCount = 10;
    [Space]
    [SerializeField] float _radius = 3;
    [SerializeField, Range(0, 1)] float _sizeRandomness = 0;
    [SerializeField, Range(0, 1)] float _roughness = 0.5f;
    [Space]
    [SerializeField] Vector2 _extent = Vector2.one * 2;
    [SerializeField] Vector2 _scroll = Vector2.zero;

    [SerializeField, HideInInspector] Shader _shader;

    Material _material;

    void OnValidate()
    {
        _vertexOnArc = Mathf.Clamp(_vertexOnArc, 3, 128);
        _instanceCount = Mathf.Clamp(_instanceCount, 1, 100000);
    }

    void OnRenderObject()
    {
        if (_material == null)
        {
            _material = new Material(_shader);
            _material.hideFlags = HideFlags.DontSave;
        }

        _material.SetInt("_VertexOnArc", _vertexOnArc);
        _material.SetFloat("_Radius", _radius);
        _material.SetFloat("_RandomSize", _sizeRandomness);
        _material.SetFloat("_Roughness", _roughness);
        _material.SetVector("_Extent", _extent);
        _material.SetVector("_Scroll", _scroll);
        _material.SetPass(0);
        Graphics.DrawProcedural(MeshTopology.Triangles, 3 * _vertexOnArc, _instanceCount);
    }
}
