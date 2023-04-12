using StarterAssets;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class Enemy : MonoBehaviour
{
    NavMeshAgent agent;
    Transform targetPlayer;
    private void Start()
    {
        targetPlayer = FindObjectOfType<ThirdPersonController>().transform;
        agent = GetComponent<NavMeshAgent>();
    }
    private void Update()
    {
        agent.SetDestination(targetPlayer.position);
    }
}