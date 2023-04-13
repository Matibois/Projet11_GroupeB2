using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class NewBehaviourScript : MonoBehaviour
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
    }

    // Update is called once per frame
    void Update()
    {
        if (skinnedmaterials.Length > 0) 
        {
            float counter = 0;
            while (skinnedmaterials[0].GetFloat("_dissolve_amount") < 1)
            {
                counter += dissolveRate;
                for (int i =0; i < skinnedmaterials.Length; i++)
                {
                    skinnedmaterials[i].SetFloat("_dissolve_amount", counter);
                }
                //yield return new WaitForSeconds(refreshRate);
            }
        }
    }
}
