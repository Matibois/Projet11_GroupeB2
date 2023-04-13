using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

public class Spawnenemy : MonoBehaviour
{
    [SerializeField] private GameObject enemy;
    float temps = 5f;
    public Vector3 spawnPos;

    void Update()
    {
        enemy.transform.position = spawnPos;
        
        if (Time.time > temps)
        {
            temps += 5f;
            Instantiate(enemy);
            
        }
    }
}
