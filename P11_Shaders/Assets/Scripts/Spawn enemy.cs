using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Spawnenemy : MonoBehaviour
{
    [SerializeField] GameObject enemy;
    float temps = 5f;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        if (Time.time > temps)
        {
            temps += Time.time;
            Instantiate(enemy);
            
        }
    }
}
