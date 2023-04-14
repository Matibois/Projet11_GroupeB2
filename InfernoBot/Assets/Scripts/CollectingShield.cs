using System.Collections;
using System.Collections.Generic;
using System.Threading;
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

            StartCoroutine(ShieldActivated(15f));
        }
    }

    public IEnumerator ShieldActivated (float TimeShield)
    {
        shield.gameObject.SetActive(true);
        yield return new WaitForSeconds(TimeShield);
        shield.gameObject.SetActive(false);
    }
}
