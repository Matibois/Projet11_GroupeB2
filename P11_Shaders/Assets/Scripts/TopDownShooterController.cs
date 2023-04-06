using StarterAssets;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.InputSystem;
public class TopDownShooterController : MonoBehaviour
{
    [SerializeField] private LayerMask _aimColliderMask;
    //[SerializeField] private Transform _debugTransform;
    [SerializeField] private Transform _pfBulletProjectile;
    [SerializeField] private Transform _spawnBulletPosition;
    private ThirdPersonController _thirdPersonController;
    private StarterAssetsInputs _starterAssetsInputs;
    private Animator _animator;
    // Start is called before the first frame update
    void Start()
    {
        _thirdPersonController = GetComponent<ThirdPersonController>();
        _starterAssetsInputs = GetComponent<StarterAssetsInputs>();
        _thirdPersonController.SetRotationOnMove(false);
        _animator = GetComponent<Animator>();
    }

    // Update is called once per frame
    void Update()
    {
        Vector3 mouseWorldPosition = Vector3.zero;
        Ray ray = Camera.main.ScreenPointToRay(Mouse.current.position.ReadValue());
        Transform hitTransform = null;
        if (Physics.Raycast(ray, out RaycastHit hitInfo, 999f, _aimColliderMask))
        {
            //_debugTransform.position = hitInfo.point;
            mouseWorldPosition = hitInfo.point;
            hitTransform = hitInfo.transform;
        }


        Vector3 worldAimTarget = mouseWorldPosition;
        worldAimTarget.y = transform.position.y;
        Vector3 aimDirection = (worldAimTarget - transform.position).normalized;
        transform.forward = Vector3.Lerp(transform.forward, aimDirection, Time.deltaTime * 10);


        if (_starterAssetsInputs.shoot)
        {
            //hitscan methode
            //if (hitTransform != null)
            //{ // hit something
            //    if (hitTransform.GetComponent<BulletTarget>() != null)
            //    {
            //        //hit target 
            //        Instantiate(_pfBulletProjectile, _spawnBulletPosition.position, Quaternion.LookRotation(aimDirection, Vector3.up));
            //    }
            //    else
            //    {
            //        //hit something else
            //    }
            //}
            //projectile methode
            Instantiate(_pfBulletProjectile, _spawnBulletPosition.position, Quaternion.LookRotation(aimDirection,Vector3.up));
            _starterAssetsInputs.shoot = false;
        }
    }
}
