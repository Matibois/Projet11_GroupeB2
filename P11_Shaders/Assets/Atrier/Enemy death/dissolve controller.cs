using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DissolveController : MonoBehaviour
{
    public SkinnedMeshRenderer skinnedMesh;
    public float dissolveRate = 0.0125f;
    public float refreshRate = 0.025f;
    private Material[] skinnedmaterials;
    void Start()
    {
        if(skinnedMesh != null) 
        {
            skinnedmaterials = skinnedMesh.materials;
        }
        GetComponent<Enemy>().GetHealthSystem().OnDead += Dissolve;
    }

    private void Dissolve(object sender, EventArgs e)
    {
            StartCoroutine(DissolveCo());
    }

    

    public IEnumerator DissolveCo()
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
            Destroy(gameObject);
    }
}
