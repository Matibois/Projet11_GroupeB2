using CodeMonkey.HealthSystemCM;
using StarterAssets;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.InputSystem;

public class TopDownShooterController : MonoBehaviour
{
    public float HP;
    public float Damage;
    [SerializeField] private LayerMask _aimColliderMask;
    [SerializeField] private Transform _pfBulletProjectile;
    [SerializeField] private Transform _spawnBulletPosition;
    private ThirdPersonController _thirdPersonController;
    private StarterAssetsInputs _starterAssetsInputs;
    private Animator _animator;
    private HealthSystem _healthSystem;

    void Start()
    {
        _thirdPersonController = GetComponent<ThirdPersonController>();
        _starterAssetsInputs = GetComponent<StarterAssetsInputs>();
        _thirdPersonController.SetRotationOnMove(false);
        _animator = GetComponent<Animator>();
        _healthSystem = new HealthSystem(HP);
        _healthSystem.OnDead += Die;
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
        Vector3 aimDirection = (mouseWorldPosition - _spawnBulletPosition.transform.position).normalized;
        Vector3 turn = new Vector3(aimDirection.x, 0, aimDirection.z);
        transform.forward = Vector3.Lerp(transform.forward, turn, Time.deltaTime * 10);

        if (_starterAssetsInputs.shoot)
        {
            Transform bullet = Instantiate(_pfBulletProjectile, _spawnBulletPosition.position, Quaternion.LookRotation(aimDirection, Vector3.up));
            bullet.GetComponent<ProjectileMoveScript>().damage = Damage;
            _starterAssetsInputs.shoot = false;
        }
    }
    public void Hurt(float damage)
    {
        _healthSystem.Damage(damage);
    }
    private void Die(object sender, System.EventArgs e) { Destroy(gameObject); }

    
}
