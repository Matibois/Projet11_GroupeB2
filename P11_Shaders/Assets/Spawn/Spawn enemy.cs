using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

public class Spawnenemy : MonoBehaviour
{
    [SerializeField] private GameObject enemy;
    float temps = 5f;
    public Vector3 spawnPos;
    // Start is called before the first frame update
    void Start()
    {
    }

    // Update is called once per frame
    void Update()
    {
        if (Time.time > temps)
        {
            enemy.transform.position = spawnPos;
            temps += 5f;
            Instantiate(enemy);   
        }
    }
}
