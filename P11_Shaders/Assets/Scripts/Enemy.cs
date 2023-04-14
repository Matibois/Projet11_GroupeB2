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

    /*public SkinnedMeshRenderer skinnedMesh;
    public float dissolveRate = 0.0125f;
    public float refreshRate = 0.025f;
    private Material[] skinnedmaterials;*/

    private void Awake()
    {
        targetPlayer = FindObjectOfType<ThirdPersonController>().transform;
        agent = GetComponent<NavMeshAgent>();
        agent.speed = Speed;
        healthSystem = new HealthSystem(HP);
        healthSystem.OnDead += Die;
    }

    /*private void Start()
    {
        if (skinnedMesh != null)
        {
            skinnedmaterials = skinnedMesh.materials;
        }
    }*/

    private void Update()
    {
        agent.SetDestination(targetPlayer.position);

        /*if (Input.GetKeyDown(KeyCode.Space))
        {
            StartCoroutine(DissolveCo());
        }*/
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

    private void Die(object sender, System.EventArgs e) 
    {
        //StartCoroutine(DissolveCo());
        if(GetComponent<DissolveController>() == null)
        {
            Destroy(gameObject);
        }
    }

    public HealthSystem GetHealthSystem()
    {
        return healthSystem;
    }

    /*public IEnumerator DissolveCo()
    {
        if (skinnedmaterials.Length > 0)
        {
            float counter = 0;
            while (skinnedmaterials[0].GetFloat("_dissolve_amount") < 1)
            {
                counter += dissolveRate;
                for (int i = 0; i < skinnedmaterials.Length; i++)
                {
                    skinnedmaterials[i].SetFloat("_dissolve_amount", counter);
                }
                yield return new WaitForSeconds(refreshRate);
            }
        }
    }*/

}