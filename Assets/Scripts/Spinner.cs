using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Spinner : MonoBehaviour
{
    public bool Spin = true;
    public float Speed = 40.0f;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        if (Spin)
        {
            transform.Rotate(new Vector3(0, Time.deltaTime * Speed, 0));
        }
    }
}
