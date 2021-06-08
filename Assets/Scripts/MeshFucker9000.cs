using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class MeshFucker9000 : MonoBehaviour
{
    public List<Material> MaterialsToFuck;
    public List<Spinner> Spinners;

    public Toggle Spin;
    public TMPro.TMP_Dropdown FuckSelect;

    public int RandomSeed = 0;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        var slider = GetComponent<Slider>();
        var value = slider.value;
        if (value == 0)
        {
            value = 0.000001f;
        }

        var speen = Spin.isOn;

        foreach (var v in MaterialsToFuck)
        {
            v.SetFloat("_VertexWarping", value);
            v.SetInt("_RandomSeed", RandomSeed);
            v.SetInt("_FuckeryKind", FuckSelect.value);
        }

        foreach (var v in Spinners)
        {
            v.Spin = speen;
        }
    }

    public void GenerateNewSeed()
    {
        RandomSeed = Random.Range(0, 1000000);
    }

    public void ZeroFucks()
    {
        var slider = GetComponent<Slider>();
        slider.value = 0;
    }
}
