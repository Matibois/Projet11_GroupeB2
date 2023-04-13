using CodeMonkey.HealthSystemCM;
using StarterAssets;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class Enemy : MonoBehaviour, IGetHealthSystem
{
    public float HP;
    public float Speed;
    public float Damage;
    NavMeshAgent agent;
    Transform targetPlayer;
    HealthSystem healthSystem;

    private void Awake()
    {
        targetPlayer = FindObjectOfType<ThirdPersonController>().transform;
        agent = GetComponent<NavMeshAgent>();
        agent.speed = Speed;
        healthSystem = new HealthSystem(HP);
        healthSystem.OnDead += Die;
    }

    private void Update()
    {
        agent.SetDestination(targetPlayer.position);
    }

    private void OnCollisionEnter(Collision collision)
    {
        if (collision.gameObject.GetComponent<ThirdPersonController>() != null)
        {
            //hit player
            collision.gameObject.GetComponent<TopDownShooterController>().Hurt(Damage);
        }
    }

    public void Hurt(float damage)
    {
        healthSystem.Damage(damage);
    }

    private void Die(object sender, System.EventArgs e) { Destroy(gameObject); }

    public HealthSystem GetHealthSystem()
    {
        return healthSystem;
    }
}
