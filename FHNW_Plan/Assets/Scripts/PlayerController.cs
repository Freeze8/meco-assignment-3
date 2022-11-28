using UnityEngine;

public class PlayerController : MonoBehaviour
{
    public CharacterController characterController;
    public float speed = 12f;
    public float gravity = -9.81f;

    public Transform groundCheck;
    public float groundDistance = 0.4f;
    public LayerMask groundMask;

    public Vector3 velocity;
    private bool _isGrounded;

    void Update()
    {
        _isGrounded = Physics.CheckSphere(groundCheck.position, groundDistance, groundMask);
        if (_isGrounded && velocity.y < 0)
            velocity.y = -2f;

        float x = Input.GetAxis("Horizontal");
        float z = Input.GetAxis("Vertical");

        Vector3 move = transform.right * x + transform.forward * z;
        characterController.Move(move * speed * Time.deltaTime);


        if (Input.GetKeyDown(KeyCode.Space) && _isGrounded)
        {
            velocity.y = Mathf.Sqrt(2f * -2f * gravity);
        }

        velocity.y += gravity * Time.deltaTime;
        // characterController.Move(velocity * Time.deltaTime);
    }
}