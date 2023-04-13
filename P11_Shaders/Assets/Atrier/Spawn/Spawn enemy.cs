using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

public class Spawnenemy : MonoBehaviour
{
    [SerializeField] GameObject enemy;
    float temps = 5f;
    public Vector3 spawnPos;
    // Start is called before the first frame update
    void Start()
    {
            enemy.transform.position = spawnPos;
        
    }

    // Update is called once per frame
    void Update()
    {
        if (Time.time > temps)
        {
            temps += 5f;
            Instantiate(enemy);
            
        }
    }
}
