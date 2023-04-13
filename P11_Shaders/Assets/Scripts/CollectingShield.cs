using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CollectingShield : MonoBehaviour
{
    public GameObject shield;

    public void OnTriggerEnter(Collider Col)
    {
        if(Col.gameObject.tag == "Shield")
        {
            Debug.Log("Shield activated!");
            Col.gameObject.SetActive(false);
            shield.gameObject.SetActive(true);
        }
    }
}
