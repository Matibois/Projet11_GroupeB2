using StarterAssets;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.InputSystem;

public class TopDownShooterController : MonoBehaviour
{
    [SerializeField] private LayerMask _aimColliderMask;
    [SerializeField] private Transform _pfBulletProjectile;
    [SerializeField] private Transform _spawnBulletPosition;
    private ThirdPersonController _thirdPersonController;
    private StarterAssetsInputs _starterAssetsInputs;
    private Animator _animator;

    void Start()
    {
        _thirdPersonController = GetComponent<ThirdPersonController>();
        _starterAssetsInputs = GetComponent<StarterAssetsInputs>();
        _thirdPersonController.SetRotationOnMove(false);
        _animator = GetComponent<Animator>();
    }

    void Update()
    {
        Vector3 mouseWorldPosition = Vector3.zero;

        // Get the mouse position in screen space
        Vector3 mouseScreenPosition = Mouse.current.position.ReadValue();
        Ray ray = Camera.main.ScreenPointToRay(mouseScreenPosition);
        Transform hitTransform = null;

        if (Physics.Raycast(ray, out RaycastHit hitInfo, 999f, _aimColliderMask))
        {
            mouseWorldPosition = hitInfo.point;
            hitTransform = hitInfo.transform;
        }

        // Set the aim direction towards the mouse world position
        Vector3 aimDirection = (mouseWorldPosition - transform.position).normalized;
        transform.forward = Vector3.Lerp(transform.forward, aimDirection, Time.deltaTime * 10);

        if (_starterAssetsInputs.shoot)
        {
            Instantiate(_pfBulletProjectile, _spawnBulletPosition.position, Quaternion.LookRotation(aimDirection, Vector3.up));
            _starterAssetsInputs.shoot = false;
        }
    }
}
