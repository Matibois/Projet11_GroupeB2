using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BulletProjectile : MonoBehaviour
{
    private Rigidbody _bulletRb;

    private void Awake()
    {
        _bulletRb = GetComponent<Rigidbody>();
    }
    private void Start()
    {
        float speed = 40f;
        _bulletRb.velocity = transform.forward * speed;
    }
    private void OnTriggerEnter(Collider other)
    {
        if(other.GetComponent<BulletTarget>() != null)
        {
            //hit target
            Destroy(other.gameObject);
        }
        else
        {
            //hit something else
        }
        Destroy( gameObject );
    }
}
